package com.ms.service.impl;

import com.ms.dto.AssignRoleDto;
import com.ms.entity.Result;
import com.ms.entity.User;
import com.ms.entity.UserRole;
import com.ms.mapper.RoleMapper;
import com.ms.mapper.UserMapper;
import com.ms.mapper.UserRoleMapper;
import com.ms.page.Page;
import com.ms.service.UserService;
import com.ms.utils.DigestUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import javax.annotation.Resource;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    //注入UserMapper
    @Resource
    private UserMapper userMapper;

    //根据账号查询用户的业务方法
    @Override
    public User queryUserByCode(String userCode) {
        return userMapper.findUserByCode(userCode);
    }

    //分页查询用户的业务方法
    @Override
    public Page queryUserByPage(Page page, User user) {
        //查询用户行数
        Integer count = userMapper.findUserRowCount(user);
        //分页查询用户
        List<User> userList = userMapper.findUserByPage(page, user);
		//组装所有分页信息
        page.setTotalNum(count);
        page.setResultList(userList);
        return page;
    }


    //添加用户的业务方法
    @Override
    public Result saveUser(User user) {
        //判断账号是否已经存在
        User userByCode = userMapper.findUserByCode(user.getUserCode());
        if (userByCode != null) { //账号已经存在
            return Result.err(Result.CODE_ERR_BUSINESS, "账号已存在！");
        }
        //对密码进行加密
        String password = DigestUtil.hmacSign(user.getUserPwd());
        user.setUserPwd(password);

        //执行添加
        int i = userMapper.insertUser(user);
        if (i > 0) {
            return Result.ok("用户添加成功！");
        }
        return Result.err(Result.CODE_ERR_BUSINESS, "用户添加失败！");
    }

    //启用或禁用用户状态的业务方法
    @Override
    public Result setUserState(User user) {
        int i = userMapper.setStateByUid(user.getUserId(), user.getUserState());
        if (i > 0) {
            return Result.ok("启用或禁用用户成功！");
        }
        return Result.err(Result.CODE_ERR_BUSINESS, "启用或禁用用户失败！");
    }

    @Autowired
    private UserRoleMapper userRoleMapper;

    @Autowired
    private RoleMapper roleMapper;

    //事务处理
    @Transactional
    @Override
    public void assignRole(AssignRoleDto assignRoleDto) {

        userRoleMapper.removeUserRoleByUid(assignRoleDto.getUserId());

        List<String> roleNameList = assignRoleDto.getRoleCheckList();
        for (String roleName : roleNameList) {
            Integer roleId = roleMapper.findRoleIdByName(roleName);
            UserRole userRole = new UserRole();
            userRole.setRoleId(roleId);
			userRole.setUserId(assignRoleDto.getUserId());
            userRoleMapper.insertUserRole(userRole);
        }

    }


    //删除用户的业务方法
    @Override
    public Result deleteUserByIds(List<Integer> userList) {
        int i = userMapper.setIsDeleteByUids(userList);
        if (i > 0) {
            return Result.ok("用户删除成功！");
        }
        return Result.err(Result.CODE_ERR_BUSINESS, "用户删除失败！");
    }

    @Override
    public Result setUserById(User user) {
        int i = userMapper.setUserNameByUid(user);
        if (i > 0) {
            return Result.ok("用户修改成功!");
        }
        return Result.err(Result.CODE_ERR_BUSINESS,"用户修改失败！");
    }

    @Override
    public Result resetUserPwdById(Integer userId) {

        //给定初始密码123456并加密
        String password = DigestUtil.hmacSign("123456");

        //根据用户id修改密码
        int i = userMapper.resetUserPwdById(userId, password);
        if (i > 0) {
            return Result.ok("密码重置成功！");
        }
		return Result.err(Result.CODE_ERR_BUSINESS, "密码重置失败!");
    }

}
