package com.ms.service.impl;

import com.ms.entity.Unit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import com.ms.mapper.UnitMapper;
import com.ms.service.UnitService;
import java.util.List;

@CacheConfig(cacheNames = "com.ms.service.impl.UnitServiceImpl")
@Service
public class UnitServiceImpl implements UnitService{

    @Autowired
    private UnitMapper unitMapper;

    @Cacheable(key = "'all:unit'")
    @Override
    public List<Unit> queryAllUnit() {
        return unitMapper.findAllUnit();
    }
}
