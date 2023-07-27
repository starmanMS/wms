package com.ms.mapper;

import com.ms.entity.Unit;
import java.util.List;

public interface UnitMapper {

    //查询所有单位的方法
    public List<Unit> findAllUnit();
}