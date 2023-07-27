package com.ms.controller;

import com.ms.entity.CurrentUser;
import com.ms.entity.OutStore;
import com.ms.entity.Result;
import com.ms.entity.Store;
import com.ms.page.Page;
import com.ms.service.OutStoreService;
import com.ms.service.StoreService;
import com.ms.utils.TokenUtils;
import com.ms.utils.WarehouseConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@RequestMapping("/outstore")
@RestController
public class OutStoreController {

    //注入OutStoreService
    @Autowired
    private OutStoreService outStoreService;

    //注入TokenUtils
    @Autowired
    private TokenUtils tokenUtils;

    //注入StoreService
    @Autowired
    private StoreService storeService;

    //添加出库单的url接口/outstore/outstore-add
    @RequestMapping("/outstore-add")
    public Result addOutStore(@RequestBody OutStore outStore, @RequestHeader(WarehouseConstants.HEADER_TOKEN_NAME) String token) {

        //拿到当前登录的用户id
        CurrentUser currentUser = tokenUtils.getCurrentUser(token);

        int createBy = currentUser.getUserId();
        outStore.setCreateBy(createBy);

        //执行业务
        Result result = outStoreService.addOutStore(outStore);

        //响应
        return result;

    }

    //查询所有仓库的 url接口/outstore/outstore-list
    @RequestMapping("/store-list")
    public Result storeList() {
        //执行业务
        List<Store> storeList = storeService.queryAllStore();
        //响应
        return Result.ok(storeList);
    }

    //分页查询出库单的url/outstore/outstore-page-list
    @RequestMapping("/outstore-page-list")
    public Result outStoreListPage(Page page, OutStore outStore) {
        //执行业务
        page = outStoreService.queryOutStorePage(page, outStore);
        //响应
        return Result.ok(page);
    }

    //确认出库的url/outstore/outstore-confirm
    @RequestMapping("/outstore-confirm")
    public Result confirmOutStore(@RequestBody OutStore outStore) {
        //执行业务
        Result result = outStoreService.outStoreConfirm(outStore);
        //响应
        return result;
    }
}
