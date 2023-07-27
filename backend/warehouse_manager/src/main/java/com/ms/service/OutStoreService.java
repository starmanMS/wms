package com.ms.service;

import com.ms.entity.OutStore;
import com.ms.entity.Result;
import com.ms.mapper.OutStoreMapper;
import com.ms.page.Page;

public interface OutStoreService{

    //添加出库单的业务方法
    public Result addOutStore(OutStore outStore);

    //分页查询出库单的业务方法
    public Page queryOutStorePage(Page page, OutStore outStore);

    //确认出库的业务方法
    public Result outStoreConfirm(OutStore outStore);

}
