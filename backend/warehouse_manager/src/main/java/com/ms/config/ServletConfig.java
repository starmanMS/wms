package com.ms.config;

import com.ms.filter.LoginCheckFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.StringRedisTemplate;


/*
* 原生Servlet的配置类
* */
@Configuration
public class ServletConfig {

    @Autowired
    private StringRedisTemplate redisTemplate;

    /*
    * 配置FilterRegistrationBean的bean对象 -- 注册原生Servlet中的过滤器
    * */

    @Bean
    public FilterRegistrationBean filterRegistrationBean() {
        //创建FilterRegistrationBean的bean对象
        FilterRegistrationBean filterRegistrationBean = new FilterRegistrationBean();
        //创建自定义的过滤器
        LoginCheckFilter loginCheckFilter = new LoginCheckFilter();
        //将自定义的过滤器注册到FilterRegistrationBean
        filterRegistrationBean.setFilter(loginCheckFilter);
        //手动注入redis模板
        loginCheckFilter.setRedisTemplate(redisTemplate);
        //给过滤器指定拦截的请求
        filterRegistrationBean.addUrlPatterns("/*");
        return filterRegistrationBean;
    }
}
