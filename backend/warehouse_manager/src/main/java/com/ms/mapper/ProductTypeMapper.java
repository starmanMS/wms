package com.ms.mapper;

import com.ms.entity.ProductType;
import java.util.List;

public interface ProductTypeMapper {

    //查询商品分类树的方法
    public List<ProductType> findAllProductType();

    //根据分类编码或分类名称查询商品分类的方法
    public ProductType findTypeByNameOrCode(ProductType productType);

    //添加商品分类的方法
    public int insertProductType(ProductType productType);

    //根据分类id删除商品分类的方法
    public int removeProductTypeById(Integer typeId);

    //根据分类id修改商品分类的方法
    public int modifyProductTypeById(ProductType productType);
}