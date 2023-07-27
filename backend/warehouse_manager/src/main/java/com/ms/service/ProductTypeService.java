package com.ms.service;

import com.ms.entity.ProductType;
import com.ms.entity.Result;
import org.apache.ibatis.executor.ResultExtractor;

import java.util.List;

public interface ProductTypeService{

    //查询商品分类树的业务方法
    public List<ProductType> productTypeTree();

    //校验分类编码是否存在的业务方法
    public Result checkTypeCode(String typeCode);


    //添加商品分类的业务方法
    public Result addProductType(ProductType productType);

    //删除商品分类的业务方法
    public Result deleteProductType(Integer typeId);

    //修改商品分类的方法
    public Result modifyProductType(ProductType productType);
}
