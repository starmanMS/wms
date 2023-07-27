package com.ms.mapper;

import com.ms.entity.Product;
import com.ms.page.Page;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface ProductMapper {

    //查询商品行数的方法
    public Integer findProductRowCount(Product product);

    //分页查询商品的方法
    public List<Product> findProductPage(@Param("page") Page page, @Param("product") Product product);

    //根据型号查询商品的方法
    public Product findProductByNum(String productNum);

    //添加商品的方法
    public int insertProduct(Product product);

    //根据商品id修改商品上下架状态的方法
    public int setProductState(Integer productId, String upDownState);

    //根据商品id删除商品的方法
    public int removeProductByIds(List<Integer> productIdList);

    //根据商品id修改商品的方法
    public int setProductById(Product product);

    //根据商品id修改商品库存的方法
    public int setInventById(Integer productId, Integer invent);

    //根据商品id查询库存的方法
    public int findInventById(Integer productId);
}