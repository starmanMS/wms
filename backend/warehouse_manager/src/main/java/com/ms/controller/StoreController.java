package com.ms.controller;

import com.ms.entity.Result;
import com.ms.entity.Store;
import com.ms.service.StoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@RequestMapping("/store")
@RestController
public class StoreController {

    //注入StoreService
    @Autowired
    private StoreService storeService;

    //查询所有仓库列表的url接口/store/store-page-list
    @RequestMapping("/store-page-list")
    public Result storeListCount() {
        List<Store> storeList = storeService.queryAllStore();
        return Result.ok(storeList);
    }

}
