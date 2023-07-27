package com.ms.controller;

import com.ms.entity.Auth;
import com.ms.entity.Result;
import com.ms.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@RestController
@RequestMapping("/auth")
public class AuthController {

    //注入AuthService
    @Autowired
    private AuthService authService;

    @RequestMapping("/auth-tree")
    public Result loadAllAuthTree() {
        //执行业务
        List<Auth> allAuthTree = authService.allAuthTree();
        //响应
        return Result.ok(allAuthTree);
    }

}
