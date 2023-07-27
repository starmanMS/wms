package com.ms.service;

import com.ms.entity.Store;
import com.ms.vo.StoreCountVo;

import java.util.List;

public interface StoreService{

    //查询所有仓库的业务方法
    public List<Store> queryAllStore();

    //查询每个仓库数量的业务方法
    public List<StoreCountVo> queryStoreCount();

}
