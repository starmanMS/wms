package com.ms.controller;

import com.ms.dto.AssignRoleDto;
import com.ms.entity.*;
import com.ms.page.Page;
import com.ms.service.RoleService;
import com.ms.service.UserService;
import com.ms.utils.TokenUtils;
import com.ms.utils.WarehouseConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.Arrays;
import java.util.List;


@RequestMapping("/user")
@RestController
public class UserController {

    //注入UserService
    @Autowired
    private UserService userService;

    //分页查询用户的url接口/user/user-list
    @RequestMapping("/user-list")
    public Result userList(Page page, User user) {

        //执行业务
        page = userService.queryUserByPage(page, user);
        //响应
        return  Result.ok(page);
    }

    //注入TokenUtils
    @Autowired
    private TokenUtils tokenUtils;

    //添加用户的url接口/user/addUser
    @RequestMapping("/addUser")
    public Result addUser(@RequestBody User user, @RequestHeader(WarehouseConstants.HEADER_TOKEN_NAME) String token) {
		//拿到当前登录的用户id
        CurrentUser currentUser = tokenUtils.getCurrentUser(token);
        int createBy = currentUser.getUserId();
		user.setCreateBy(createBy);

		//执行业务
        Result result = userService.saveUser(user);

        //响应
        return result;
    }

    //启用或禁用用户的ur接口/user/updateState
    @RequestMapping("/updateState")
    public Result updateUserState(@RequestBody User user) {
        //执行业务
        Result result = userService.setUserState(user);

        //响应
        return result;
    }

    @Autowired
    private RoleService roleService;

    @RequestMapping("/user-role-list/{userId}")
    public Result userRoleList(@PathVariable Integer userId) {
        //执行业务
       	List<Role> roleList = roleService.queryUserRoleByUid(userId);

        //响应
        return Result.ok(roleList);
    }

    //给用户分配角色的url接口/user/assignRole
    @RequestMapping("/assignRole")
    public Result assignRole(@RequestBody AssignRoleDto assignRoleDto) {

        //执行业务
		userService.assignRole(assignRoleDto);
        //响应
        return Result.ok("分配角色成功！");
    }


    //根据用户id删除单个用户的url接口/user/deleteUser/#{userId}
    @RequestMapping("/deleteUser/{userId}")
    public Result deleteUserById(@PathVariable Integer userId) {
        //执行业务
        Result result = userService.deleteUserByIds(Arrays.asList(userId));
        //响应
        return result;
    }

    //根据用户id删除单个用户的url接口/user/deleteUser/#{userId}
    @RequestMapping("/deleteUserList")
    public Result deleteUserByIds(@RequestBody List<Integer> userIdList) {
        //执行业务
        Result result = userService.deleteUserByIds(userIdList);
        //响应
        return result;
    }

    //修改用户昵称的url接口/user/updateUser
    @RequestMapping("/updateUser")
    public Result updateUser(@RequestBody User user, @RequestHeader(WarehouseConstants.HEADER_TOKEN_NAME) String token) {
        //拿到当前登录用户的id
        CurrentUser currentUser = tokenUtils.getCurrentUser(token);
        int updateBy = currentUser.getUserId();

        user.setUpdateBy(updateBy);

        //执行业务
        Result result = userService.setUserById(user);

        //响应
        return result;
    }

    //重置密码的url接口/user/updatePwd/{userId}
    @RequestMapping("/updatePwd/{userId}")
	public Result resetPassword(@PathVariable Integer userId) {
        //执行业务
        Result result = userService.resetUserPwdById(userId);
        //响应
        return result;
    }
}
