package com.ms.entity;

import java.io.Serializable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
    * 用户角色表
    */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserRole implements Serializable {
    private Integer userRoleId;

    private Integer roleId;

    private Integer userId;

    private static final long serialVersionUID = 1L;
}