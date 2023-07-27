package com.ms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ms.mapper.RoleAuthMapper;
import com.ms.service.RoleAuthService;

@Service
public class RoleAuthServiceImpl implements RoleAuthService{

    @Autowired
    private RoleAuthMapper roleAuthMapper;

}
