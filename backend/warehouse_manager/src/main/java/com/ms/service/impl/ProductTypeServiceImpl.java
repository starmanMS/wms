package com.ms.service.impl;

import com.ms.entity.ProductType;
import com.ms.entity.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import com.ms.mapper.ProductTypeMapper;
import com.ms.service.ProductTypeService;
import java.util.ArrayList;
import java.util.List;


@CacheConfig(cacheNames = "com.ms.service.impl.ProductTypeServiceImpl")
@Service
public class ProductTypeServiceImpl implements ProductTypeService{

    //注入ProductTypeMapper
    @Autowired
    private ProductTypeMapper productTypeMapper;

    @Cacheable(key = "'all:typeTree'")
    @Override
    public List<ProductType> productTypeTree() {

        //查出所有商品分类
        List<ProductType> allProductTypeList = productTypeMapper.findAllProductType();
        //将所有商品分类转换成商品分类树
        List<ProductType> typeTreeList = allProductTypeTree(allProductTypeList, 0);
        return typeTreeList;
    }

    private List<ProductType> allProductTypeTree(List<ProductType> typeList, Integer pid) {
        //拿到所有一级分类
        List<ProductType> firstLevelType = new ArrayList<>();
        for (ProductType productType : typeList) {
            if (productType.getParentId().equals(pid)) {
                firstLevelType.add(productType);
            }
        }

        //查询出每个一级分类下的所有二级分类
        for (ProductType productType : firstLevelType) {
            List<ProductType> secondLevelType = allProductTypeTree(typeList, productType.getTypeId());
            productType.setChildProductCategory(secondLevelType);
        }
		return firstLevelType;
    }

    //校验分类编码是否存在的业务方法
    @Override
    public Result checkTypeCode(String typeCode) {

        //根据分类编码查询分类，判断是否存在
        ProductType productType = new ProductType();
        productType.setTypeCode(typeCode);
        ProductType prodtype = productTypeMapper.findTypeByNameOrCode(productType);

        //返回值
        return Result.ok(prodtype == null);
    }


    //添加商品分类的业务方法
    @CacheEvict(key = "'all:typeTree'")
    @Override
    public Result addProductType(ProductType productType) {

        //检查分类名称是否已存在
        ProductType prodType = new ProductType();
        prodType.setTypeName(productType.getTypeName());
        ProductType prodCategory = productTypeMapper.findTypeByNameOrCode(productType);
        if (prodCategory != null) {
            return Result.err(Result.CODE_ERR_BUSINESS, "分类名称已存在！");
        }

        //添加分类
        int i = productTypeMapper.insertProductType(productType);
        if (i > 0) {
            return Result.ok("商品分类添加成功！");
        }
        return Result.err(Result.CODE_ERR_BUSINESS, "商品分类添加失败！");
    }


    //删除商品分类的方法
    @CacheEvict(key = "'all:typeTree'")
    @Override
    public Result deleteProductType(Integer typeId) {
        int i = productTypeMapper.removeProductTypeById(typeId);
        if (i > 0) {
            return Result.ok("商品分类删除成功！");
        }
        return Result.err(Result.CODE_ERR_BUSINESS, "商品分类删除失败！");
    }

    //修改商品分类的方法
    @CacheEvict(key = "'all:typeTree'")
    @Override
    public Result modifyProductType(ProductType productType) {

        //修改的分类名称是否已经存在
        ProductType prodType = new ProductType();
        prodType.setTypeName(productType.getTypeName());
        ProductType prodCategory = productTypeMapper.findTypeByNameOrCode(prodType);
        if (prodCategory != null && !prodCategory.getParentId().equals(productType.getTypeId())) {
            return Result.err(Result.CODE_ERR_BUSINESS, "商品分类名称已存在！");
        }
        //修改
        int i = productTypeMapper.modifyProductTypeById(productType);
        if (i > 0) {
            return Result.ok("商品分类修改成功!");
        }
        return Result.err(Result.CODE_ERR_BUSINESS, "商品分类修改失败！");
    }
}
