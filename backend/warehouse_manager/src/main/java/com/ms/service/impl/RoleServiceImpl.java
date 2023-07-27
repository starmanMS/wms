package com.ms.service.impl;

import com.ms.dto.AssignAuthDto;
import com.ms.entity.Result;
import com.ms.entity.Role;
import com.ms.entity.RoleAuth;
import com.ms.mapper.AuthMapper;
import com.ms.mapper.RoleAuthMapper;
import com.ms.page.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import com.ms.mapper.RoleMapper;
import com.ms.service.RoleService;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

//2 -> 指定缓存的路径(数据保存到redis中的键的前缀，一般值给标注@CacheConfig注解的类的全路径)
@CacheConfig( cacheNames = "com.ms.service.impl.RoleServiceImpl")
@Service
public class RoleServiceImpl implements RoleService{

    //注入RoleMapper
    @Autowired
    private RoleMapper roleMapper;

    //注入RoleAuthMapper
    @Autowired
    private RoleAuthMapper roleAuthMapper;

    //注入AuthMapper
    @Autowired
    private AuthMapper authMapper;

    //3 ->查询方法上标注@Cacheable指定缓存的键
    @Cacheable(key = "'all:role'")
    @Override
    public List<Role> queryAllRole() {
        return roleMapper.findAllRole();
    }

    //根据用户id查询用户已分配角色的用户业务方法
    @Override
    public List<Role> queryUserRoleByUid(Integer userId) {
        return roleMapper.findUserRoleByUid(userId);
    }


    //分页查询角色的业务方法
    @Override
    public Page queryRolePage(Page page, Role role) {

        //查询角色行数
        Integer count = roleMapper.findRoleRowCount(role);

        //分页查询角色
        List<Role> roleList = roleMapper.findRolePage(page, role);

        //组装分页信息
        page.setTotalNum(count);
        page.setResultList(roleList);
        return page;
    }

    //添加角色的业务方法
    @CacheEvict(key = "'all:role'") //清除角色缓存信息
    @Override
    public Result addRole(Role role) {

        //判断角色是否存在
        Role r = roleMapper.findRoleByNameOrCode(role.getRoleName(), role.getRoleCode());
        if (r != null) {
            //角色已存在
            return Result.err(Result.CODE_ERR_BUSINESS, "角色已存在！");
        }

        int i = roleMapper.insertRole(role);
        if (i > 0) {
            return Result.ok("角色添加成功！");
        }
        return Result.err(Result.CODE_ERR_BUSINESS, "角色添加失败！");
    }

    //启用或禁用的业务方法
    @Override
    public Result setRoleState(Role role) {
        int i = roleMapper.setRoleStateByRid(role.getRoleId(), role.getRoleState());
        if (i > 0) {
            return Result.ok("角色启用或禁用成功！");
        }
        return Result.err(Result.CODE_ERR_BUSINESS, "角色启用或禁用失败！");
    }

    //删除角色的业务方法

    @CacheEvict(key = "'all:role'")
    @Override
    public Result deleteRoleById(Integer roleId) {
        int i = roleMapper.removeRoleById(roleId);
        if (i > 0) {
            //删除角色权限关系
            roleAuthMapper.removeRoleAuthById(roleId);
            //返回执行成功的对象
            return Result.ok("角色删除成功！");
        }
        //返回执行失败的对象
        return Result.err(Result.CODE_ERR_BUSINESS, "角色删除失败!");

    }

    @Override
    public List<Integer> queryRoleAuthIds(Integer roleId) {
		return roleAuthMapper.findAuthIdsByRid(roleId);
    }


    //给角色分配权限的业务方法
    @Transactional
    @Override
    public void saveRoleAuth(AssignAuthDto assignAuthDto) {

        //删除之前分配的所有权限
        roleAuthMapper.removeRoleAuthById(assignAuthDto.getRoleId());

        //添加角色关系
        List<Integer> authIdsList = assignAuthDto.getAuthIds();
        for (Integer authId : authIdsList) {
            RoleAuth roleAuth = new RoleAuth();
            roleAuth.setRoleId(assignAuthDto.getRoleId());
            roleAuth.setAuthId(authId);
            roleAuthMapper.insertRoleAuth(roleAuth);
        }
    }

    //修改角色的业务方法
    @CacheEvict(key = "'all:role'")
    @Override
    public Result setRoleByRid(Role role) {
        int i = roleMapper.setDescByRid(role);
        if (i > 0) {
            return Result.ok("角色修改成功！");
        }
        return Result.err(Result.CODE_ERR_BUSINESS, "角色修改失败！");
    }
}
