package com.ms.controller;

import com.google.code.kaptcha.Producer;
import com.ms.entity.*;
import com.ms.service.AuthService;
import com.ms.service.UserService;
import com.ms.utils.DigestUtil;
import com.ms.utils.TokenUtils;
import com.ms.utils.WarehouseConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.List;
import java.util.concurrent.TimeUnit;


@RestController
public class LoginController {

    //注入验证码工具类
    @Resource(name = "captchaProducer")
    private Producer producer;

    //注入redis模板
    @Autowired
    private StringRedisTemplate redisTemplate;

    //获取验证码的url接口
    @RequestMapping("/captcha/captchaImage")
    public void captchaImage(HttpServletResponse response) {

        ServletOutputStream out = null;
        try {
            //生成验证码图片的文件
            String text = producer.createText();
            //使用验证码文本生成验证码图片 -- BufferedImage对象就代表生成的验证码图片在内存中
            BufferedImage image = producer.createImage(text);
            //将验证码文件保存到redis中 -- 设置过期时间为5分钟
            redisTemplate.opsForValue().set(text, "", 60*5, TimeUnit.SECONDS);

            /*
             * 将验证码图片响应给前端
             * */
            //设置响应正文image/jpeg
            response.setContentType("image/jpeg");
            //将验证码图片给前端
            out = response.getOutputStream();
            ImageIO.write(image, "jpg", out);
            //刷新
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (out != null) {
                //关闭字节输出流
                try {
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    //注入UserService
    @Resource
    private UserService userService;

    //注入TokenUtils的bean对象
    @Autowired
    private TokenUtils tokenUtils;

    //登录的url接口
    @RequestMapping("/login")
    public Result login(@RequestBody LoginUser loginUser) {

        //拿到客户录入的验证码
        String code = loginUser.getVerificationCode();
        if (Boolean.FALSE.equals(redisTemplate.hasKey(code))) {
            return Result.err(Result.CODE_ERR_BUSINESS, "验证码错误！");
        }

        //根据账号查询用户
        User user = userService.queryUserByCode(loginUser.getUserCode());
        if (user != null) {
            if (user.getUserState().equals(WarehouseConstants.USER_STATE_PASS)) { //用户已审核
                //拿到用户录入的密码
                String userPwd = loginUser.getUserPwd();
                //进行md5加密
                userPwd = DigestUtil.hmacSign(userPwd);
                if (userPwd.equals(user.getUserPwd())) { //密码合法
                    //生成jwt token并存储到redis中
                    CurrentUser currentUser = new CurrentUser(user.getUserId(), user.getUserCode(), user.getUserName());
                    String token = tokenUtils.loginSign(currentUser, userPwd);

                    //向客户端相应jwt token
                    return Result.ok("登录成功！", token);
                } else { //密码错误
                    return Result.err(Result.CODE_ERR_BUSINESS, "密码错误！");
                }
            } else { //用户未审核
                return Result.err(Result.CODE_ERR_BUSINESS, "用户未审核！");
            }

        } else { //账号不存在
            return Result.err(Result.CODE_ERR_BUSINESS, "账号不存在！");
        }
    }

    /*
    * 获取当前登录的用户信息url接口/curr-user
    * 参数@RequestHeader(WarehouseConstants.HEADER_TOKEN_NAME) String token
    * =>表示将请求头Token的值（前端归还的token赋值给请求处理方法入参变量token）
    * */
    @RequestMapping("/curr-user")
    public Result currentUser(@RequestHeader(WarehouseConstants.HEADER_TOKEN_NAME) String token) {
        //解析token拿到封装了当前登录用户信息的CurrenUser对象
        CurrentUser currentUser = tokenUtils.getCurrentUser(token);
        //响应
        return Result.ok(currentUser);
    }

    /*
    * 加载用户权限菜单树的url接口/user/auth-list
    * */
    //注入AuthService
    @Autowired
    private AuthService authService;

    @RequestMapping("/user/auth-list")
    public Result loadAuthTree(@RequestHeader(WarehouseConstants.HEADER_TOKEN_NAME) String token) {
        //拿到当前登录用户的id
        CurrentUser currentUser = tokenUtils.getCurrentUser(token);
        int userId = currentUser.getUserId();

        //执行业务
        List<Auth> authTreeList = authService.authTreeByUid(userId);

        //响应
        return Result.ok(authTreeList);
    }

    /*
    *登出的url接口/logout
    **/

    @RequestMapping("/logout")
	public Result logout(@RequestHeader(WarehouseConstants.HEADER_TOKEN_NAME) String token) {

        //从redis中删除token键
        redisTemplate.delete(token);
        //响应
        return Result.ok("您已退出系统！");
    }
}
