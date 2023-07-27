package com.ms.service.impl;

import com.ms.entity.Purchase;
import com.ms.entity.Result;
import com.ms.page.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ms.mapper.PurchaseMapper;
import com.ms.service.PurchaseService;
import java.util.List;

@Service
public class PurchaseServiceImpl implements PurchaseService{

    @Autowired
    private PurchaseMapper purchaseMapper;


    //添加采购单的业务方法
    @Override
    public Result addPurchase(Purchase purchase) {

        //补充字段 -- 给fact_buy_num字段实际采购数量赋值为buy_num字段的预采购数量
        purchase.setFactBuyNum(purchase.getBuyNum());

        //添加采购单
        int i = purchaseMapper.insertPurchase(purchase);
        if (i > 0) {
            return Result.ok("采购单添加成功！");
        }
        return Result.err(Result.CODE_ERR_BUSINESS, "采购单添加失败！");
    }

    //分页查询采购单的业务方法
    @Override
    public Page queryPurchasePage(Page page, Purchase purchase) {
        //查询采购单行数
        Integer count = purchaseMapper.findPurchaseCount(purchase);
        //分页查询采购单
        List<Purchase> purchasePageList = purchaseMapper.findPurchasePage(page, purchase);

        //组装分页信息
        page.setTotalNum(count);
        page.setResultList(purchasePageList);

        return page;
    }

    //删除采购单的业务方法
    @Override
    public Result deletePurchaseById(Integer buyId) {
        int i = purchaseMapper.removePurchaseById(buyId);

        if (i > 0) {
            return Result.ok("采购单删除成功！");
        }
        return Result.err(Result.CODE_ERR_BUSINESS, "采购单删除失败！");
    }


    //修改采购单的业务方法
    @Override
    public Result modifyPurchase(Purchase purchase) {

        int i = purchaseMapper.modifyNumById(purchase);

        if (i > 0) {
            return Result.ok("采购单修改成功！");
        }
        return Result.err(Result.CODE_ERR_BUSINESS, "采购单修改失败！");
    }

}
