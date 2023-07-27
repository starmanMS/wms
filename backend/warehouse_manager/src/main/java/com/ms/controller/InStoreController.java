package com.ms.controller;

import com.ms.entity.InStore;
import com.ms.entity.Result;
import com.ms.entity.Store;
import com.ms.page.Page;
import com.ms.service.InStoreService;
import com.ms.service.StoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@RequestMapping("/instore")
@RestController
public class InStoreController {

    //注入InStoreService
    @Autowired
    private InStoreService inStoreService;

    //注入StoreService
    @Autowired
    private StoreService storeService;

    //查询所有仓库的url接口/instore/store-list
    @RequestMapping("/store-list")
    public Result storeList() {
        //执行业务
        List<Store> storesList = storeService.queryAllStore();
        //响应
        return Result.ok(storesList);
    }

    //分页查询入库单的url接口/instore/instore-page-list
    @RequestMapping("/instore-page-list")
    public Result inStoreListPage(Page page, InStore inStore) {
        //执行业务
        page = inStoreService.queryInStorePage(page, inStore);
        //响应
        return Result.ok(page);
    }

    //确认入库的url接口/instore/instore-confirm
    @RequestMapping("/instore-confirm")
    public Result confirmInStore(@RequestBody InStore inStore) {
        //执行业务
        Result result = inStoreService.inStoreConfirm(inStore);
        //响应
        return result;
    }
}
