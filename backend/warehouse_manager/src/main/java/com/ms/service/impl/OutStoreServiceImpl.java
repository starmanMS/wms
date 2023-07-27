package com.ms.service.impl;

import com.ms.entity.OutStore;
import com.ms.entity.Result;
import com.ms.mapper.ProductMapper;
import com.ms.page.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ms.mapper.OutStoreMapper;
import com.ms.service.OutStoreService;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class OutStoreServiceImpl implements OutStoreService{

    //注入OutStoreMapper
    @Autowired
    private OutStoreMapper outStoreMapper;

    //注入ProductMapper
    @Autowired
    private ProductMapper productMapper;

    //添加出库单的业务方法
    @Override
    public Result addOutStore(OutStore outStore) {
        //添加
        int i = outStoreMapper.insertOutStore(outStore);
        if (i > 0) {
            return Result.ok("出库单添加成功！");
        }
        return Result.err(Result.CODE_ERR_BUSINESS, "出库单添加失败!");
    }


    //分页查询出库单的业务方法
    @Override
    public Page queryOutStorePage(Page page, OutStore outStore) {
        //查询出库单行数
        Integer outStoreCount = outStoreMapper.findOutStoreCount(outStore);

        //分页查询出库单
        List<OutStore> outStoreList = outStoreMapper.findOutStorePage(page, outStore);

        //封装分页信息
        page.setTotalNum(outStoreCount);
        page.setResultList(outStoreList);
        return page;
    }

    //确认出库的业务方法
    @Transactional//事务处理
    @Override
    public Result outStoreConfirm(OutStore outStore) {

        //判断商品库存是否充足
        int invent = productMapper.findInventById(outStore.getProductId());
        if (invent < outStore.getOutNum()) {
            return Result.err(Result.CODE_ERR_BUSINESS, "商品库存不足！");
        }

        //修改出库单状态
        int i = outStoreMapper.setIsOutById(outStore.getOutsId());
        if (i > 0) {
            //修改出库单状态
            int j = productMapper.setInventById(outStore.getProductId(), -outStore.getOutNum());
            if (j > 0) {
                return Result.ok("确认入库成功!");
            }
            return Result.err(Result.CODE_ERR_BUSINESS, "确认入库失败！");
        }
        return Result.err(Result.CODE_ERR_BUSINESS, "确认入库失败！");
    }
}
