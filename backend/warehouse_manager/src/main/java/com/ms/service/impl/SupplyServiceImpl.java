package com.ms.service.impl;

import com.ms.entity.Supply;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import com.ms.mapper.SupplyMapper;
import com.ms.service.SupplyService;
import java.util.List;

@CacheConfig(cacheNames = "com.ms.service.impl.SupplyServiceImpl")
@Service
public class SupplyServiceImpl implements SupplyService{

    @Autowired
    private SupplyMapper supplyMapper;

    @Cacheable(key = "'all:supply'")
    @Override
    public List<Supply> queryAllSupply() {
        return supplyMapper.findAllSupply();
    }
}
