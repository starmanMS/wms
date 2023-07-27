package com.ms.controller;


import com.ms.entity.Result;
import com.ms.service.StoreService;
import com.ms.vo.StoreCountVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@RequestMapping("/statistics")
@RestController
public class StatisticsController {

    @Autowired
    private StoreService storeService;

    @RequestMapping("/store-invent")
    public Result storeInvent() {
        //执行业务
        List<StoreCountVo> storeCountVoList = storeService.queryStoreCount();
        //响应
        return Result.ok(storeCountVoList);
    }
}
