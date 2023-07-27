package com.ms.controller;

import com.ms.entity.ProductType;
import com.ms.entity.Result;
import com.ms.service.ProductTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RequestMapping("/productCategory")
@RestController
public class ProductTypeController {

    //注入ProductTypeService
    @Autowired
    private ProductTypeService productTypeService;

    //查询商品分类的url接口/productCategory/product-category-tree
    @RequestMapping("/product-category-tree")
    public Result productCategoryTree() {
        //执行业务
        List<ProductType> typeTreeList = productTypeService.productTypeTree();

        //响应
        return Result.ok(typeTreeList);
    }

    //校验分类编码是否存在的url接口/productCategory/verify-type-code
    @RequestMapping("/verify-type-code")
    public Result checkTypeCode(String typeCode) {
        //执行业务
        Result result = productTypeService.checkTypeCode(typeCode);

        //响应
        return result;
    }

    //添加商品分类的url接口/productCategory/type-add
    @RequestMapping("/type-add")
    public Result addProductType(@RequestBody ProductType productType) {
        //执行业务
        Result result = productTypeService.addProductType(productType);
        //响应
        return result;
    }

    //删除商品分类的url接口/productCategory/type-delete/{typeId}
    @RequestMapping("/type-delete/{typeId}")
    public Result deleteProductType(@PathVariable Integer typeId) {
        //执行业务
        Result result = productTypeService.deleteProductType(typeId);
        //响应
        return result;
    }

    //修改商品分类的url接口/productCategory/type-update
    @RequestMapping("/type-update")
    public Result updateProductType(@RequestBody ProductType productType) {
        //执行业务
        Result result = productTypeService.modifyProductType(productType);
        //响应
        return result;
    }
}
