package com.ms.mapper;

import com.ms.entity.Place;
import java.util.List;

public interface PlaceMapper {

    //查询所有产地的方法
    public List<Place> findAllPlace();
}