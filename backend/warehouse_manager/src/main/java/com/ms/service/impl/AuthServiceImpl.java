package com.ms.service.impl;

import com.alibaba.fastjson.JSON;
import com.ms.entity.Auth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import com.ms.mapper.AuthMapper;
import com.ms.service.AuthService;
import org.springframework.util.StringUtils;
import java.util.ArrayList;
import java.util.List;

@CacheConfig(cacheNames = "com.ms.service.impl.AuthServiceImpl")
@Service
public class AuthServiceImpl implements AuthService{

    @Autowired
    private AuthMapper authMapper;

    @Autowired
    private StringRedisTemplate  redisTemplate;

    @Override
    public List<Auth> authTreeByUid(Integer userId) {
        //先从redis中查询缓存的用户菜单树
        String authTreeJson = redisTemplate.opsForValue().get("authTree" + userId);
        if (StringUtils.hasText(authTreeJson)) { //说明redis中有用户菜单树的缓存
			//将菜单树List<Auth>转的json串转回菜单树List<Auth>并返回
            List<Auth> authTreeList = JSON.parseArray(authTreeJson, Auth.class);
            return authTreeList;
        }

        /*
        * 说明redis中没有用户菜单树的缓存
        * */
        //查询用户权限下的所有菜单
        List<Auth> allAuthList = authMapper.findAuthByUid(userId);
        //将所有List<Auth>转换成菜单树List<Auth>
        List<Auth> authTreeList = allAuthToAuthTree(allAuthList, 0);
        //向redis中缓存菜单树List<Auth>
        redisTemplate.opsForValue().set("authTree" + userId, JSON.toJSONString(authTreeList));
        return authTreeList;
    }


    //将所有List<Auth>转换成菜单树List<Auth>的递归算法
    private List<Auth> allAuthToAuthTree(List<Auth> allAuthList, Integer pid) {

        //查询所有一级菜单
        List<Auth> firstLevelAuthList = new ArrayList<>();
        for (Auth auth : allAuthList) {
            if (auth.getParentId().equals(pid)) {
                firstLevelAuthList.add(auth);
            }
        }

		//查询每一个一级菜单的所有二级菜单
        for (Auth firstAuth : firstLevelAuthList) {
            List<Auth> secondLevelAuthList = allAuthToAuthTree(allAuthList, firstAuth.getAuthId());
            firstAuth.setChildAuth(secondLevelAuthList);
        }

        return firstLevelAuthList;
    }

    //查询所有权限菜单树的业务方法
    @Cacheable(key = "'all:authTree'")
    @Override
    public List<Auth> allAuthTree() {

        //查询所有权限菜单
        List<Auth> allAuthList = authMapper.findAllAuth();
        //将所有权限菜单List<Auth>转换成权限菜单树List<Auth>
        List<Auth> authTreeList = allAuthToAuthTree(allAuthList, 0);
        return authTreeList;
    }

}
