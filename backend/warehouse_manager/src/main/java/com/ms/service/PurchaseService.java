package com.ms.service;

import com.ms.entity.Purchase;
import com.ms.entity.Result;
import com.ms.page.Page;

public interface PurchaseService{
    //添加采购单的业务方法
    public Result addPurchase(Purchase purchase);

    //分页查询采购单的业务方法
    public Page queryPurchasePage(Page page, Purchase purchase);

    //删除采购单的业务方法
    public Result deletePurchaseById(Integer buyId);

    //修改采购单的业务方法
    public Result modifyPurchase(Purchase purchase);

}
