## Warehouse Management System（仓库管理系统）

### 问题加QQ群： 642606174

### 前言

- **项目为前后端分离项目，采用的技术包括SpringBoot + MyBatis + MySql + Redis + Vue + Axios + Element-Plus + Echarts等。**


### 项目启动

- （Notice）项目启动前请检查MySQL配置和Redis配置并启动服务

#### 前端项目启动

- 进入fronted/warehouse_boot_pc/路径在文件夹的地址栏中输入cmd命令
  
  ![](https://cdn.jsdelivr.net/gh/starmanMS/blog-images@main/img/wh_input_cmd.jpg)

- 在cmd界面输入npm install安装依赖
  
  ![](https://cdn.jsdelivr.net/gh/starmanMS/blog-images@main/img/wh-npm_install.jpg)

- 依赖安装完成后输入yarn dev启动项目 如下图所示：
  
  ![](https://cdn.jsdelivr.net/gh/starmanMS/blog-images@main/img/wh-yarn_dev.jpg)

#### 后端项目启动

- 创建db_warehouse数据库 导入数据库脚本文件(/db_script/db_warehouse.sql)

- 导入数据成功截图
  
  ![](https://cdn.jsdelivr.net/gh/starmanMS/blog-images@main/img/wh-db-design.jpg)

- 修改配置文件application.properties(数据库账号密码及端口)

- 启动项目

### 项目介绍

#### 1.用户管理(查询用户、添加用户、修改用户、删除用户、导出数据、批量删除、禁用/启用用户、重置密码、分配角色、更改权限)

![](https://cdn.jsdelivr.net/gh/starmanMS/blog-images@main/img/wh-user-list.jpg)

#### 2.角色管理(查询角色、添加角色、修改角色、删除角色、导出数据、禁用/启用角色、更改权限)

![](https://cdn.jsdelivr.net/gh/starmanMS/blog-images@main/img/wh-role-list.jpg)

#### 3.权限管理(查询权限、添加权限、修改权限、删除角色、禁用/启用权限)

![](https://cdn.jsdelivr.net/gh/starmanMS/blog-images@main/img/wh-auth-list.jpg)

#### 4.商品管理(查询商品、添加商品、修改商品、商品审核等)

![](https://cdn.jsdelivr.net/gh/starmanMS/blog-images@main/img/wh-product-list.jpg)

#### 5.商品分类管理(商品分类的添加、商品分类的查询、商品分类的修改、商品分类的删除等)

![](https://cdn.jsdelivr.net/gh/starmanMS/blog-images@main/img/wh-product-category.jpg)

#### 6.采购管理(我的采购单、添加采购单、采购单的审核等)

![](https://cdn.jsdelivr.net/gh/starmanMS/blog-images@main/img/wh-pruchase-list.jpg)

#### 7.入库管理(入库单、保存入库单、确认入库等)

![](https://cdn.jsdelivr.net/gh/starmanMS/blog-images@main/img/wh-instore-list.jpg)

#### 8.出库管理(出库单、保存出库单、审核出库单等)

![](https://cdn.jsdelivr.net/gh/starmanMS/blog-images@main/img/wh-outstore-list.jpg)

#### 9.统计管理(各个仓库库存信息、仓库占有比、仓库存储走势、出入库信息统计、采购量占比、实时数据监测)

![](https://cdn.jsdelivr.net/gh/starmanMS/blog-images@main/img/wh-total-chart.jpg)
