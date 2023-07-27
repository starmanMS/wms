package com.ms.entity;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
    * 角色表
    */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Role implements Serializable {
    private Integer roleId;

    private String roleName;

    private String roleDesc;

    private String roleCode;

    /**
    * 1 启用 0 禁用
    */
    private String roleState;

    private Integer createBy;

    @JsonFormat(pattern = "yyyy-mm-dd HH:mm:ss")
    private Date createTime;

    private Integer updateBy;

    private Date updateTime;

    //----------------追加的属性----------------
    private String getCode;
}