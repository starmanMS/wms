package com.ms.mapper;

import com.ms.entity.Purchase;
import com.ms.page.Page;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface PurchaseMapper {

    //添加采购单的方法
    public int insertPurchase(Purchase purchase);

    //查询采购单行数的方法
    public Integer findPurchaseCount(Purchase purchase);

    //分页查询采购单的方法
    public List<Purchase> findPurchasePage(@Param("page") Page page, @Param("purchase") Purchase purchase);

    //根据id删除采购单的方法
    public int removePurchaseById(Integer buyId);

    //根据id修改预计采购数量和实际采购数量的方法
    public int modifyNumById(Purchase purchase);

    //根据id修改采购单状态为已入库的方法
    public int setIsiInById(Integer buyId);

}