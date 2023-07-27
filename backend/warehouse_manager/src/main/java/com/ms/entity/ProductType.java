package com.ms.entity;

import java.io.Serializable;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
    * 商品分类表
    */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductType implements Serializable {
    private Integer typeId;

    private Integer parentId;

    private String typeCode;

    private String typeName;

    private String typeDesc;

    //--------------------追加属性---------------------------
    //存放的是当前分类下的所有子级分类
    private List<ProductType> childProductCategory;
}