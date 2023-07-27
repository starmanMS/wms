package com.ms.service.impl;

import com.ms.entity.Brand;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import com.ms.mapper.BrandMapper;
import com.ms.service.BrandService;
import java.util.List;

@CacheConfig(cacheNames = "com.ms.service.impl.BrandServiceImpl")
@Service
public class BrandServiceImpl implements BrandService{

    @Autowired
    private BrandMapper brandMapper;

    //查询所有品牌的业务方法
    @Cacheable(key = "'all:brand'")
    @Override
    public List<Brand> queryAllBrand() {
        return brandMapper.findAllBrand();
    }
}
