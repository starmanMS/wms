package com.ms.entity;

import java.io.Serializable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
    * 角色权限表
    */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class RoleAuth implements Serializable {
    private Integer roleAuthId;

    private Integer roleId;

    private Integer authId;

    private static final long serialVersionUID = 1L;
}