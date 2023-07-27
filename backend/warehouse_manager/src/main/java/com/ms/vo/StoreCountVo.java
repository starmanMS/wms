package com.ms.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class StoreCountVo {

    private Integer storeId;//仓库id

    private String storeName;//仓库名称

    private String totalInvent;//仓库的商品数量
}
