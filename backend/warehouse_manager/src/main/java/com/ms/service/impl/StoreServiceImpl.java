package com.ms.service.impl;

import com.ms.entity.Store;
import com.ms.vo.StoreCountVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import com.ms.mapper.StoreMapper;
import com.ms.service.StoreService;
import java.util.List;

@CacheConfig(cacheNames = "com.ms.service.impl.StoreServiceImpl")
@Service
public class StoreServiceImpl implements StoreService{

    @Autowired
    private StoreMapper storeMapper;

    //查询所有仓库的业务方法
    @Cacheable(key = "'all:store'")
    @Override
    public List<Store> queryAllStore() {
        return storeMapper.findAllStore();
    }

    //查询每个仓库数量的业务方法
    @Override
    public List<StoreCountVo> queryStoreCount() {
        return storeMapper.findStoreCount();
    }
}
