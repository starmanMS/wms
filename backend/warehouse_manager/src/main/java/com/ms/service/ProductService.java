package com.ms.service;

import com.ms.entity.Product;
import com.ms.entity.Result;
import com.ms.page.Page;
import jdk.dynalink.linker.LinkerServices;

import java.util.List;

public interface ProductService{

	//分页查询商品的业务方法
    public Page queryProductPage(Page page, Product product);

    //添加商品的业务方法
    public Result addProduct(Product product);

    //修改商品上下架状态的业务方法
    public Result updateStateByPid(Product product);

    //删除商品的业务方法
    public Result deleteProductByIds(List<Integer> productList);

    //修改商品的业务方法
    public Result setProductById(Product product);
}
