package com.ms.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
    * 商品表
    */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Product implements Serializable {
    private Integer productId;

    private Integer storeId;

    private Integer brandId;

    private String productName;

    private String productNum;

    private Integer productInvent;

    private Integer typeId;

    private Integer supplyId;

    private Integer placeId;

    private Integer unitId;

    private String introduce;

    /**
    * 0 下架 1 上架
    */
    private String upDownState;

    private BigDecimal inPrice;

    private BigDecimal salePrice;

    private BigDecimal memPrice;

    private Date createTime;

    private Date updateTime;

    private Integer createBy;

    private Integer updateBy;

    private String imgs;

    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date productDate;

    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date suppDate;

    //----------------------追加的属性----------------------
    private String brandName;//品牌名称

    private String supplyName;//供应商名称

    private String placeName;//产地名

    private String typeName;//分类名称

    private Integer isOverDate;//是否过期

    private String storeName;//仓库名称

    private String unitName;//单位
}