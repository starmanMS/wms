package com.ms.service;

import com.ms.entity.Unit;
import org.springframework.aop.target.LazyInitTargetSource;

import java.security.PublicKey;
import java.util.List;

public interface UnitService{
    //查询所有单位的业务方法
    public List<Unit> queryAllUnit();


}
