package com.ms.controller;

import com.ms.entity.*;
import com.ms.page.Page;
import com.ms.service.*;
import com.ms.utils.TokenUtils;
import com.ms.utils.WarehouseConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.util.Collections;
import java.util.List;

@RequestMapping("/product")
@RestController
public class ProductController {

    //注入StoreService
    @Autowired
    private StoreService storeService;

    //注入BrandService
    @Autowired
    private BrandService brandService;

    //注入ProductService
    @Autowired
    private ProductService productService;

    //注入ProductTypeService
	@Autowired
    private ProductTypeService productTypeService;

    //注入SupplyService
    @Autowired
    private SupplyService supplyService;

    //注入PlaceService
    @Autowired
    private PlaceService placeService;


    //注入UnitService
    @Autowired
    private UnitService unitService;

    //查询所有仓库的url接口/product/store-list
    @RequestMapping("/store-list")
    public Result storeList() {
        //执行业务
        List<Store> storeList = storeService.queryAllStore();
        //响应
        return Result.ok(storeList);
    }

    //差选所有品牌的url接口/product/brand-list
    @RequestMapping("/brand-list")
    public Result brandList() {
        //执行业务
        List<Brand> brandList = brandService.queryAllBrand();
        //响应
        return Result.ok(brandList);
    }

    //分页查询商品的url接口/product/product-page-list
    @RequestMapping("/product-page-list")
    public Result productPageList(Page page, Product product) {
        //执行业务
        page = productService.queryProductPage(page, product);
        //响应
        return Result.ok(page);
    }

    //查询所有商品分类树的url接口/product/category-tree
    @RequestMapping("/category-tree")
    public Result loadTypeTree() {
        //执行业务
        List<ProductType> typeTreeList = productTypeService.productTypeTree();
        //响应
        return Result.ok(typeTreeList);
    }

    //查询所有供应商的url接口/product/supply-list
    @RequestMapping("/supply-list")
    public Result supplyList() {
        //执行业务
        List<Supply> supplyList = supplyService.queryAllSupply();
        //响应
        return Result.ok(supplyList);
    }

    //查询所有产地的url接口/product/place-list
    @RequestMapping("/place-list")
    public Result placeList() {
        //执行业务
        List<Place> placeList = placeService.queryAllPlace();
        //响应
        return Result.ok(placeList);
    }

    //查询所有单位的url接口/product/unit-list
    @RequestMapping("/unit-list")
    public Result unitList() {
        //执行业务
        List<Unit> unitList = unitService.queryAllUnit();
        //响应
        return Result.ok(unitList);
    }

    @Value("${file.upload-path}")
    private String uploadPath;

    @CrossOrigin
    @RequestMapping("/img-upload")
    public Result uploadImage(MultipartFile file) {

        try {
            File uploadDirFile = ResourceUtils.getFile(uploadPath);
            String uploadDirPath = uploadDirFile.getAbsolutePath();
            String filename = file.getOriginalFilename();
            String uploadFilePath = uploadDirPath + "\\" + filename;
            file.transferTo(new File(uploadFilePath));

            //成功响应
            return Result.ok("图片上传成功！");


        } catch (Exception e) {

            return Result.err(Result.CODE_ERR_BUSINESS, "图片上传失败!");
        }
    }

    //添加商品的url接口/product/product-add
    @Autowired
    private TokenUtils tokenUtils;

    @RequestMapping("/product-add")
    public Result addProduct(@RequestBody Product product, @RequestHeader(WarehouseConstants.HEADER_TOKEN_NAME) String token) {
        //拿到当前登录的用户id
        CurrentUser currentUser = tokenUtils.getCurrentUser(token);
        int createBy = currentUser.getUserId();

        product.setCreateBy(createBy);

        //执行业务
        Result result = productService.addProduct(product);
        //响应
        return result;
    }

    //修改商品上下架状态的url接口/product/state-change
    @RequestMapping("/state-change")
    public Result changeProductState(@RequestBody Product product) {
        //执行业务
        Result result = productService.updateStateByPid(product);
        //响应
        return result;
    }

    //删除单个商品的url接口/product/product-delete/{productId}
    @RequestMapping("/product-delete/{productId}")
    public Result deleteProduct(@PathVariable Integer productId) {
        //执行业务
        Result result = productService.deleteProductByIds(Collections.singletonList(productId));
        //响应
        return result;
    }

    //批量删除商品的url接口/product/product-list-delete
    @RequestMapping("/product-list-delete")
    public Result deleteProductList(@RequestBody List<Integer> productIdList) {
        //执行业务
        Result result = productService.deleteProductByIds(productIdList);
        //响应
        return result;
    }

    //修改商品的url接口/product/product-update
    @RequestMapping("/product-update")
    public Result updateProduct(@RequestBody Product product, @RequestHeader(WarehouseConstants.HEADER_TOKEN_NAME) String token) {
        //拿到当前登录用户的id
        CurrentUser currentUser = tokenUtils.getCurrentUser(token);
        int updateBy = currentUser.getUserId();
        product.setUpdateBy(updateBy);

        //执行业务
        Result result = productService.setProductById(product);
        //响应
        return result;
    }
}
