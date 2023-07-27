## Warehouse Management System（仓库管理系统）

### 开发环境

- **项目为前后端分离项目，采用的技术包括SpringBoot + MyBatis + MySql + Redis + Vue + Axios + Element-Plus + Echarts等.。**

### 项目启动

- （Notice）项目启动前请检查MySQL配置和Redis配置并启动服务

#### 前端项目启动

- 进入fronted/warehouse_boot_pc/路径在文件夹的地址栏中输入cmd命令

- <img title="" src="file:///G:/Program%20Files/MD%20Editor/MarkText/images/2023-07-27-21-40-14-image.png" alt="" data-align="center">

- 在cmd界面输入npm install安装依赖
  
  <img src="file:///G:/Program%20Files/MD%20Editor/MarkText/images/2023-07-27-21-42-55-image.png" title="" alt="" data-align="center">

- 依赖安装完成后输入yarn dev启动项目 如下图所示：
  
  <img title="" src="file:///G:/Program%20Files/MD%20Editor/MarkText/images/2023-07-27-21-45-36-image.png" alt="" data-align="center">

#### 后端项目启动

- 创建db_warehouse数据库 导入数据库脚本文件(/db_script/db_warehouse.sql)

- 修改配置文件application.properties(数据库账号密码及端口)

- 启动项目

- 项目启动成功截图

- ![](G:\Program%20Files\MD%20Editor\MarkText\images\2023-07-27-21-53-49-image.png)

### 项目介绍

#### 1.用户管理(查询用户、添加用户、修改用户、删除用户、导出数据、批量删除、禁用/启用用户、重置密码、分配角色、更改权限)

![](E:\warehouse\screenshot\wh-user-list.jpg)

#### 2.角色管理(查询角色、添加角色、修改角色、删除角色、导出数据、禁用/启用角色、更改权限)

![](E:\warehouse\screenshot\wh-role-list.jpg)

#### 3.权限管理(查询权限、添加权限、修改权限、删除角色、禁用/启用权限)

![](E:\warehouse\screenshot\wh-auth-list.jpg)

#### 4.商品管理(查询商品、添加商品、修改商品、商品审核等)

![](E:\warehouse\screenshot\wh-product-list.jpg)

#### 5.商品分类管理(商品分类的添加、商品分类的查询、商品分类的修改、商品分类的删除等)

![](E:\warehouse\screenshot\wh-product-category.jpg)

#### 6.采购管理(我的采购单、添加采购单、采购单的审核等)

![](E:\warehouse\screenshot\wh-pruchase-list.jpg)

#### 7.入库管理(入库单、保存入库单、确认入库等)

![](E:\warehouse\screenshot\wh-instore-list.jpg)

#### 8.出库管理(出库单、保存出库单、审核出库单等)

![](E:\warehouse\screenshot\wh-outstore-list.jpg)

#### 9.统计管理(各个仓库库存信息、仓库占有比、仓库存储走势、出入库信息统计、采购量占比、实时数据监测)

![](E:\warehouse\screenshot\wh-total-chart.jpg)
