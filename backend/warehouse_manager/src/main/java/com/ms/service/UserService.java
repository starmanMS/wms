package com.ms.service;

import com.ms.dto.AssignRoleDto;
import com.ms.entity.Result;
import com.ms.entity.Role;
import com.ms.entity.User;
import com.ms.page.Page;

import javax.management.relation.RelationSupport;
import java.util.List;

public interface UserService {


	//根据账号查询用户的业务方法
    public User queryUserByCode(String userCode);

    //分页查询用户的业务方法
    public Page queryUserByPage(Page page, User user);

    //添加用户的业务方法
    public Result saveUser(User user);

    //启用或禁用用户状态的业务方法
    public Result setUserState(User user);

    //给用户分配角色的业务方法
    public void assignRole(AssignRoleDto assignRoleDto);

    //删除用户的业务方法
    public Result deleteUserByIds(List<Integer> userList);

    //修改用户的业务方法
    public Result setUserById(User user);

    //根据用户id修改用户密码的业务方法
    public Result resetUserPwdById(Integer userId);

}
