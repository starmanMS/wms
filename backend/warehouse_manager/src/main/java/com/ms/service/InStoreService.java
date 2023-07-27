package com.ms.service;

import com.ms.entity.InStore;
import com.ms.entity.Result;
import com.ms.page.Page;
import org.apache.ibatis.executor.ResultExtractor;

import java.util.List;

public interface InStoreService{

    //添加入库单的业务方法
    public Result addStore(InStore inStore, Integer buyId);

    //分页查询入库单的业务方法
    public Page queryInStorePage(Page page, InStore inStore);

    //确认入库的业务方法
    public Result inStoreConfirm(InStore inStore);

}
