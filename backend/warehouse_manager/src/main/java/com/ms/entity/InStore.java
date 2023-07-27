package com.ms.entity;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
    * 入库单
    */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class InStore implements Serializable {
    private Integer insId;

    private Integer storeId;

    private Integer productId;

    private Integer inNum;

    private Integer createBy;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    /**
    * 0 否 1 是
    */
    private String isIn;

    //------------------追加的属性--------------------

    private String productName;//商品名称

    private String startTime;//起始时间

    private String endTime;//结束时间

    private String storeName;//仓库名称

    private String inPrice;//入库价格

    private String userCode;//创建人
}