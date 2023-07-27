package com.ms.filter;

import com.alibaba.fastjson.JSON;
import com.ms.entity.Result;
import com.ms.utils.WarehouseConstants;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.util.StringUtils;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
* 自定义的登录限制过滤器
* */
public class LoginCheckFilter implements Filter {
    private StringRedisTemplate redisTemplate;

    public void setRedisTemplate(StringRedisTemplate redisTemplate) {
        this.redisTemplate = redisTemplate;
    }


    public StringRedisTemplate getRedisTemplate() {
        return redisTemplate;
    }

    //过滤器拦截到请求的执行方法
    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;

        /*
        * 1.白名单请求直接放行
        * */
        //创建List<String>放行白名单url接口
        List<String> urlList = new ArrayList<>();
        urlList.add("/captcha/captchaImage");
        urlList.add("/login");
        urlList.add("/logout");
        urlList.add("/product/img-upload");
        //过滤器拦截到的当前请求的url接口
        String url = request.getServletPath();
        if (urlList.contains(url) || url.contains("img/upload")) { //白名单请求
            chain.doFilter(request, response);
            return;
        }

        /*
        * 2.其他请求都校验是否携带token，以及判断redis存在token的键
        * */
        String token = request.getHeader(WarehouseConstants.HEADER_TOKEN_NAME);
        //1=>有，说明已登录，请求放行
        if (StringUtils.hasText(token) && Boolean.TRUE.equals(redisTemplate.hasKey(token))) {
            chain.doFilter(request, response);
            return;
        }
        //2=>没有，说明未登录或token已过期，请求不放行，并给前端做出响应
        Map<String, Object> data = new HashMap<>();
        data.put("code", 401);
        data.put("message", "您尚未登录！");
        Result result = Result.err(Result.CODE_ERR_UNLOGINED, "您尚未登录！");
        String jsonStr = JSON.toJSONString(result);
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.write(jsonStr);
        out.flush();
        out.close();
    }

}
