package com.ms.mapper;

import com.ms.entity.InStore;
import com.ms.page.Page;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface InStoreMapper {

    //添加入库单的方法
    public int insertInStore(InStore inStore);

    //查询入库单行数的方法
    public Integer findInStoreCount(InStore inStore);

    //分页查询入库单的方法
    public List<InStore> findInStorePage(@Param("page") Page page, @Param("inStore") InStore inStore);

    //根据id修改入库单状态为已入库的方法
    public int setIsInById(Integer isStoreId);


}