package com.ms.mapper;

import com.ms.entity.Role;
import com.ms.page.Page;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface RoleMapper {
    //查询所有用户角色的方法
    public List<Role> findAllRole();

    //根据用户id查询用户分配的所有角色
    public List<Role> findUserRoleByUid(Integer userId);

    //根据角色名查询角色id的方法
    public Integer findRoleIdByName(String roleName);

    //查询角色行数的方法
    public Integer findRoleRowCount(Role role);

    //分页查询角色的方法
    public List<Role> findRolePage(@Param("page") Page page, @Param("role") Role role);

    //根据角色名称或角色代码查询角色的方法
    public Role findRoleByNameOrCode(String roleName, String roleCode);

    //添加角色的方法
    public int insertRole(Role role);

    //根据角色id修改角色状态的方法
    public int setRoleStateByRid(Integer roleId, String roleState);


    //根据角色id删除角色的方法
    public int removeRoleById(Integer roleId);

    //根据角色id修改角色描述的方法
    public int setDescByRid(Role role);
}