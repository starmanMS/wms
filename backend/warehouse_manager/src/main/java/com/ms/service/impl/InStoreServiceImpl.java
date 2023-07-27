package com.ms.service.impl;

import com.ms.entity.InStore;
import com.ms.entity.Result;
import com.ms.mapper.ProductMapper;
import com.ms.mapper.PurchaseMapper;
import com.ms.page.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ms.mapper.InStoreMapper;
import com.ms.service.InStoreService;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class InStoreServiceImpl implements InStoreService{

    @Autowired
    private InStoreMapper inStoreMapper;

    @Autowired
    private PurchaseMapper purchaseMapper;

    //注入ProductMapper
    @Autowired
    private ProductMapper productMapper;

    @Transactional//事务处理
    @Override
    public Result addStore(InStore inStore, Integer buyId) {

        //添加入库单的业务方法
        int i = inStoreMapper.insertInStore(inStore);
        if (i > 0) {
            //修改采购单状态为已入库
            int j = purchaseMapper.setIsiInById(buyId);
            if (j > 0) {
                return Result.ok("入库单添加成功！");
            }
            return Result.err(Result.CODE_ERR_BUSINESS, "入库单添加失败!");

        }
        return Result.err(Result.CODE_ERR_BUSINESS, "入库单添加失败！");
    }


    //分页查询入库单的业务方法
    @Override
    public Page queryInStorePage(Page page, InStore inStore) {

        //查询入库单行数
        Integer inStoreCount = inStoreMapper.findInStoreCount(inStore);

        //分页查询入库单
        List<InStore> inStorePageList = inStoreMapper.findInStorePage(page, inStore);

        //封装分页信息
        page.setTotalNum(inStoreCount);
        page.setResultList(inStorePageList);
        return page;
    }

    //确认入库的业务方法
    @Transactional//事务处理
    @Override
    public Result inStoreConfirm(InStore inStore) {
        //修改入库单状态
        int i = inStoreMapper.setIsInById(inStore.getInsId());
        if (i > 0) {
            int j = productMapper.setInventById(inStore.getProductId(), inStore.getInNum());
            if (j > 0) {
                return Result.ok("入库单确认成功！");
            }
            return Result.err(Result.CODE_ERR_BUSINESS, "入库单状态修改失败！");
        }
        return Result.err(Result.CODE_ERR_BUSINESS, "入库单状态修改失败！");

    }

}
