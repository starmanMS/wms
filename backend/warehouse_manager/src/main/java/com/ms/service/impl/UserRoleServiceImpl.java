package com.ms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ms.mapper.UserRoleMapper;
import com.ms.service.UserRoleService;

@Service
public class UserRoleServiceImpl implements UserRoleService{

    @Autowired
    private UserRoleMapper userRoleMapper;


}
