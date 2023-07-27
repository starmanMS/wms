package com.ms.service;

import com.ms.dto.AssignAuthDto;
import com.ms.entity.Result;
import com.ms.entity.Role;
import com.ms.page.Page;
import java.util.List;

public interface RoleService{

    //查询所有角色的业务方法
    public List<Role> queryAllRole();

    //根据用户id查询用户已分配角色的用户业务方法
    public List<Role> queryUserRoleByUid(Integer userId);

    //分页查询角色的业务方法
    public Page queryRolePage(Page page, Role role);

    //添加角色的业务方法
    public Result addRole(Role role);

    //启用或禁用角色的业务方法
    public Result setRoleState(Role role);

    //删除角色的业务方法
    public Result deleteRoleById(Integer roleId);

    //查询角色分配的所有权限菜单的id业务方法
   	public List<Integer> queryRoleAuthIds(Integer roleId);

	//给角色分配权限的业务方法
    public void saveRoleAuth(AssignAuthDto assignAuthDto);

    //修改角色的业务方法
    public Result setRoleByRid(Role role);

}
