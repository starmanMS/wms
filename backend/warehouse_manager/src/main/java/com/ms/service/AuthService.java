package com.ms.service;

import com.ms.entity.Auth;
import java.util.List;

public interface AuthService{

    //查询用户菜单树的业务方法
    public List<Auth> authTreeByUid(Integer userId);

    //查询所有权限菜单树的业务方法
    public List<Auth> allAuthTree();

}
