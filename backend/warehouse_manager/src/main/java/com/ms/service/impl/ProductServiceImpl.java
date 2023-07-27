package com.ms.service.impl;

import com.ms.entity.Product;
import com.ms.entity.Result;
import com.ms.page.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import com.ms.mapper.ProductMapper;
import com.ms.service.ProductService;
import java.util.List;

@Service
public class ProductServiceImpl implements ProductService{

    //注入ProductMapper
    @Autowired
    private ProductMapper productMapper;

    @Override
    public Page queryProductPage(Page page, Product product) {
        //查询商品行数
        Integer productRowCount = productMapper.findProductRowCount(product);
        //分页查询商品
        List<Product> productPage = productMapper.findProductPage(page, product);
        //组装分页信息
        page.setTotalNum(productRowCount);
        page.setResultList(productPage);
        return page;
    }


    //添加商品的业务方法
    @Value("${file.access-path}")
    private String fileAccessPath;

    @Override
    public Result addProduct(Product product) {
		//判断商品的型号是否存在
        Product productByNum = productMapper.findProductByNum(product.getProductNum());

        if (productByNum != null) {
            return Result.err(Result.CODE_ERR_BUSINESS, "该型号商品存在！");
        }
        //处理上传图片的访问路径
        product.setImgs(fileAccessPath + product.getImgs());
        //添加商品
        int i = productMapper.insertProduct(product);

        if (i > 0) {
            return Result.ok("商品添加成功!");
        }
        return Result.err(Result.CODE_ERR_BUSINESS, "商品添加失败！");
    }


    //修改商品上下架状态的业务方法
    @Override
    public Result updateStateByPid(Product product) {
        int i = productMapper.setProductState(product.getProductId(), product.getUpDownState());

        if (i > 0) {
            return Result.ok("商品上下架状态设置成功！");
        }
        return Result.err(Result.CODE_ERR_BUSINESS, "商品上下架状态设置失败!");
    }



    //删除商品的业务方法
    @Override
    public Result deleteProductByIds(List<Integer> productList) {
        int i = productMapper.removeProductByIds(productList);
        if (i > 0) {
            return Result.ok("商品删除成功！");
        }

        return Result.err(Result.CODE_ERR_BUSINESS, "商品删除失败！");
    }


    //修改商品的业务方法
    @Override
    public Result setProductById(Product product) {

        //判断修改后的型号是否存在
        Product prod = productMapper.findProductByNum(product.getProductNum());
        if (prod != null && !prod.getProductId().equals(product.getProductId())) {
            return Result.err(Result.CODE_ERR_BUSINESS, "修改的型号已存在！");
        }

        //判断上传的图片是否被修改，如果修改了处理访问路径
        if (!product.getImgs().contains(fileAccessPath)) {
            product.setImgs(fileAccessPath + product.getImgs());
        }

        //修改商品
        int i = productMapper.setProductById(product);
        if (i > 0) {
            return Result.ok("商品修改成功！");
        }
        return Result.err(Result.CODE_ERR_BUSINESS, "商品修改失败！");
    }

}
