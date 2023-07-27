package com.ms.mapper;

import com.ms.entity.Store;
import com.ms.vo.StoreCountVo;

import java.util.List;

public interface StoreMapper {

    //查询所有仓库的方法
    public List<Store> findAllStore();

    //查询每个仓库的商品数量
    public List<StoreCountVo> findStoreCount();

}