package com.ms.entity;

import java.io.Serializable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
    * 品牌
    */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Brand implements Serializable {
    private Integer brandId;

    private String brandName;

    private String brandLeter;

    private String brandDesc;

    private static final long serialVersionUID = 1L;
}