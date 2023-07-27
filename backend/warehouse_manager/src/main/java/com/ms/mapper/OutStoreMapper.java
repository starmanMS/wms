package com.ms.mapper;

import com.ms.entity.OutStore;
import com.ms.page.Page;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface OutStoreMapper {

    //添加出库单的方法
    public int insertOutStore(OutStore outStore);

    //查询出库单行数的方法
    public Integer findOutStoreCount(OutStore outStore);

    //分页查询出库单的方法
    public List<OutStore> findOutStorePage(@Param("page") Page page, @Param("outStore") OutStore outStore);

    //根据id修改出库单状态的方法
    public int setIsOutById(Integer outStoreId);
}