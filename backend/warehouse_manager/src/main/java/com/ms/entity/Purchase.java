package com.ms.entity;

import java.io.Serializable;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
    * 采购单
    */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Purchase implements Serializable {
    private Integer buyId;

    private Integer productId;

    private Integer storeId;

    private Integer buyNum;

    private Integer factBuyNum;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date buyTime;

    private Integer supplyId;

    private Integer placeId;

    private String buyUser;

    private String phone;

    /**
    * 0 否 1 是
    */
    private String isIn;


    //-------------追加的属性-------------

    private String startTime;//起始时间

    private String endTime;//结束时间

    private String storeName;//仓库名称

    private String productName;//商品名称
}