package com.ms.service.impl;

import com.ms.entity.Place;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import com.ms.mapper.PlaceMapper;
import com.ms.service.PlaceService;
import java.util.List;


@CacheConfig(cacheNames = "com.ms.service.impl.PlaceServiceImpl")
@Service
public class PlaceServiceImpl implements PlaceService{

    @Autowired
    private PlaceMapper placeMapper;

    //查询所有产地的业务方法
    @Cacheable(key = "'all:place'")
    @Override
    public List<Place> queryAllPlace() {
        return placeMapper.findAllPlace();
    }
}
