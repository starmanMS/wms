package com.ms.mapper;

import com.ms.entity.Auth;

import java.util.List;

/*
* 根据userId查询用户权限下的所有菜单的方法
* public List<Auth> findAuthByUid(Integer userId)
* */
public interface AuthMapper {
    public List<Auth> findAuthByUid(Integer userId);

    //查询所有角色权限的方法
    public List<Auth> findAllAuth();

}