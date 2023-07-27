package com.ms.mapper;

import com.ms.entity.User;
import com.ms.page.Page;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface UserMapper {

    //根据账号查询用户信息的方法
    public User findUserByCode(String userCode);

    //查询用户行数的方法
    public Integer findUserRowCount(User user);

    //分页查询用户的方法
    public List<User> findUserByPage(@Param("page") Page page, @Param("user") User user);

    //添加用户的方法
    public int insertUser(User user);

    //根据用户id修改用户状态的方法
    public int setStateByUid(Integer userId, String userState);

    //根据用户ids修改用户为删除状态的方法
    public int setIsDeleteByUids(List<Integer> userList);

    //根据用户id修改用户名的方法
    public int setUserNameByUid(User user);

    //根据用户id修改密码的方法
    public int resetUserPwdById(Integer userId, String password);
}
