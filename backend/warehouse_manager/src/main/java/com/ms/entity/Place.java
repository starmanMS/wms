package com.ms.entity;

import java.io.Serializable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
    * 产地
    */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Place implements Serializable {
    private Integer placeId;

    private String placeName;

    private String placeNum;

    private String introduce;

    /**
    * 0:可用  1:不可用
    */
    private String isDelete;

    private static final long serialVersionUID = 1L;
}