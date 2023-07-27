package com.ms.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AssignAuthDto {

    //接收角色id
    private Integer roleId;

	//接收给角色分配的所有权限的id
    private List<Integer> authIds;
}
