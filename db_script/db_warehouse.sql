/*
 Navicat Premium Data Transfer

 Source Server         : Local Database - 5.7.42
 Source Server Type    : MySQL
 Source Server Version : 50742 (5.7.42)
 Source Host           : localhost:3306
 Source Schema         : db_warehouse

 Target Server Type    : MySQL
 Target Server Version : 50742 (5.7.42)
 File Encoding         : 65001

 Date: 29/10/2023 20:13:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_info
-- ----------------------------
DROP TABLE IF EXISTS `auth_info`;
CREATE TABLE `auth_info`  (
  `auth_id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NULL DEFAULT NULL COMMENT '父id为空或为0，表示一级权限',
  `auth_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `auth_desc` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `auth_grade` int(11) NULL DEFAULT NULL,
  `auth_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '1 模块 、2  列表、 3  按钮',
  `auth_url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `auth_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `auth_order` int(11) NULL DEFAULT NULL,
  `auth_state` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '1 启用 、0 禁用',
  `create_by` int(11) NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` int(11) NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`auth_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 98 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_info
-- ----------------------------
INSERT INTO `auth_info` VALUES (1, 0, '用户管理', '用户管理', 1, '1', NULL, NULL, 0, '1', 1, '2017-11-14 16:54:13', 1, '2017-11-14 16:54:17');
INSERT INTO `auth_info` VALUES (2, 1, '用户列表', '用户列表', 2, '2', '/user/index', NULL, 0, '1', 1, '2017-11-14 16:56:11', 1, '2017-11-14 16:56:15');
INSERT INTO `auth_info` VALUES (3, 2, '添加用户', '添加用户', 3, '3', NULL, 'user-addUser', 0, '1', 1, '2017-11-14 16:56:59', 1, '2017-11-14 16:57:02');
INSERT INTO `auth_info` VALUES (4, 0, '角色管理', '角色管理', 1, '1', NULL, NULL, 0, '1', 1, '2017-11-14 16:57:48', 1, '2017-11-14 16:57:52');
INSERT INTO `auth_info` VALUES (5, 4, '角色列表', '角色列表', 2, '2', '/role/index', NULL, 0, '1', 1, '2017-11-14 16:58:47', 1, '2017-11-14 16:58:50');
INSERT INTO `auth_info` VALUES (6, 5, '添加角色', '添加角色', 3, '3', NULL, 'role-addRole', 0, '1', 1, '2017-11-14 16:59:25', 1, '2017-11-14 16:59:29');
INSERT INTO `auth_info` VALUES (7, 0, '权限管理', '权限管理', 1, '1', NULL, NULL, 0, '0', 1, '2017-11-14 17:00:13', 1, '2017-11-14 17:00:18');
INSERT INTO `auth_info` VALUES (8, 7, '权限树', '权限树', 2, '2', '/auth/index', NULL, 0, '1', 1, '2017-11-14 17:02:11', 1, '2017-11-14 17:02:14');
INSERT INTO `auth_info` VALUES (9, 8, '添加权限', '添加权限', 3, '3', NULL, 'auth-addAuth', 0, '1', 1, '2017-11-14 17:03:48', 1, '2017-11-14 17:03:52');
INSERT INTO `auth_info` VALUES (10, 2, '删除用户', '删除用户', 3, '3', '', 'user-deleteUser', 0, '1', 1, '2017-11-23 11:56:17', NULL, NULL);
INSERT INTO `auth_info` VALUES (19, 0, '订单管理', '订单管理', 1, '1', '', '', 0, '0', 1, '2017-11-23 17:31:08', NULL, NULL);
INSERT INTO `auth_info` VALUES (20, 19, '订单列表', '订单列表', 2, '2', '', '', 0, '0', 1, '2017-11-23 17:31:42', NULL, NULL);
INSERT INTO `auth_info` VALUES (21, 20, '修改订单', '修改订单', 3, '3', '', 'updateOrder', 0, '0', 0, '2017-11-24 14:33:23', NULL, NULL);
INSERT INTO `auth_info` VALUES (22, 20, '删除订单', '删除订单', 3, '3', '', 'auth-delete', 0, '0', 0, '2017-11-24 14:34:32', NULL, NULL);
INSERT INTO `auth_info` VALUES (23, 2, '查询用户', '查询用户', 3, '3', '', 'user-findUser', 0, '1', 1, '2017-11-28 10:10:53', NULL, NULL);
INSERT INTO `auth_info` VALUES (24, 2, '修改用户', '修改用户信息', 3, '3', '', 'user-updateUser', 0, '1', 0, '2017-11-28 10:12:51', NULL, NULL);
INSERT INTO `auth_info` VALUES (25, 2, '分配角色', '分配角色', 3, '3', '', 'user-assignRole', 0, '1', 1, '2017-11-28 10:15:27', NULL, NULL);
INSERT INTO `auth_info` VALUES (26, 2, '更改权限', '更改权限', 3, '3', '', 'user-updateAuth', 0, '1', 1, '2017-11-28 10:16:07', NULL, NULL);
INSERT INTO `auth_info` VALUES (27, 5, '修改角色', '修改角色', 3, '3', '', 'role-updateRole', 0, '1', 1, '2017-11-28 10:16:40', NULL, NULL);
INSERT INTO `auth_info` VALUES (28, 5, '查询角色', '查询角色', 3, '3', '', 'role-findRole', 0, '1', 1, '2017-11-28 10:17:12', NULL, NULL);
INSERT INTO `auth_info` VALUES (30, 5, '删除角色', '删除角色', 3, '3', '', 'role-deleteRole', 0, '1', 1, '2017-11-28 10:23:14', NULL, NULL);
INSERT INTO `auth_info` VALUES (31, 5, '更改权限', '更改权限', 3, '3', '', 'role-updateAuth', 0, '1', 1, '2017-11-28 10:24:35', NULL, NULL);
INSERT INTO `auth_info` VALUES (32, 8, '修改权限', '修改权限', 3, '3', '', 'auth-updateAuth', 0, '1', 1, '2017-11-28 10:25:08', NULL, NULL);
INSERT INTO `auth_info` VALUES (33, 8, '删除权限', '删除权限', 3, '3', NULL, 'auth-deleteAuth', 0, '1', 0, '2022-03-29 10:10:03', NULL, NULL);
INSERT INTO `auth_info` VALUES (34, 8, '恢复权限', '恢复权限', 3, '3', NULL, 'auth-restartAuth', 0, '1', 0, '2022-03-29 10:10:50', NULL, NULL);
INSERT INTO `auth_info` VALUES (35, 2, '修改状态', '修改状态', 3, '3', '', 'user-updateState', 0, '1', 1, '2017-11-28 10:49:40', NULL, NULL);
INSERT INTO `auth_info` VALUES (36, 2, '重置密码', '重置密码', 3, '3', '', 'user-resetPwd', 0, '1', 1, '2017-11-28 10:53:27', NULL, NULL);
INSERT INTO `auth_info` VALUES (37, 5, '修改角色状态', '修改角色状态', 3, '3', '', 'role-updateState', 0, '1', 1, '2017-11-28 11:12:23', NULL, NULL);
INSERT INTO `auth_info` VALUES (38, 19, '订单详情', '订单详情', 2, '2', '', '', 1, '0', 1, '2017-11-29 11:35:57', NULL, NULL);
INSERT INTO `auth_info` VALUES (41, 19, '订单分类', '订单分类', 2, '2', '', '', 1, '0', 1, '2017-11-29 11:56:04', NULL, NULL);
INSERT INTO `auth_info` VALUES (42, 0, '商品管理', '商品管理', 1, '1', '', '', 1, '1', 1, '2017-11-29 11:56:44', NULL, NULL);
INSERT INTO `auth_info` VALUES (43, 38, '查看详情', '查看详情', 3, '3', '', 'order-selectDetils', 1, '0', 1, '2017-11-29 11:57:29', NULL, NULL);
INSERT INTO `auth_info` VALUES (44, 38, '修改详情', '修改详情', 3, '3', '', 'order-updateDetils', 1, '0', 1, '2017-11-29 11:58:36', NULL, NULL);
INSERT INTO `auth_info` VALUES (46, 41, '分类', '分类', 3, '3', '', 'auth-flAuth', 1, '0', 1, '2017-11-30 15:16:02', NULL, NULL);
INSERT INTO `auth_info` VALUES (50, 42, '商品列表', '商品列表', 2, '2', '/commodity/index', '', 1, '1', 1, '2017-12-07 08:47:50', NULL, NULL);
INSERT INTO `auth_info` VALUES (53, 0, '采购管理', '采购管理', 1, '1', '', '', 1, '1', 1, '2017-12-11 14:53:02', NULL, NULL);
INSERT INTO `auth_info` VALUES (54, 0, '入库管理', '入库管理', 1, '1', '', '', 1, '1', 1, '2017-12-11 14:53:20', NULL, NULL);
INSERT INTO `auth_info` VALUES (55, 0, '出库管理', '出库管理', 1, '1', '', '', 1, '1', 1, '2017-12-11 14:53:31', NULL, NULL);
INSERT INTO `auth_info` VALUES (56, 53, '采购列表', '采购列表', 2, '2', '/purchase/index', '', 1, '1', 1, '2017-12-11 14:59:11', NULL, NULL);
INSERT INTO `auth_info` VALUES (57, 54, '入库列表', '入库列表', 2, '2', '/instore/index', '', 1, '1', 1, '2017-12-11 15:01:27', NULL, NULL);
INSERT INTO `auth_info` VALUES (58, 55, '出库列表', '出库列表', 2, '2', '/outstore/index', '', 1, '1', 1, '2017-12-11 15:02:03', NULL, NULL);
INSERT INTO `auth_info` VALUES (61, 0, '盘点管理', '盘点管理', 1, '1', '', '', 1, '1', 1, '2017-12-11 18:04:38', NULL, NULL);
INSERT INTO `auth_info` VALUES (62, 61, '盘点列表', '盘点列表', 2, '2', '', '', 1, '1', 1, '2017-12-11 18:05:05', NULL, NULL);
INSERT INTO `auth_info` VALUES (63, 0, '统计查询', '统计查询', 1, '1', '', '', 1, '1', 1, '2017-12-12 14:17:13', NULL, NULL);
INSERT INTO `auth_info` VALUES (64, 63, '统计报表', '统计报表', 2, '2', '/statistics/index', '', 1, '1', 1, '2017-12-12 14:17:43', NULL, NULL);
INSERT INTO `auth_info` VALUES (68, 0, '调货管理', '调货管理', 1, '1', '', '', 1, '0', 1, '2017-12-13 14:34:21', NULL, NULL);
INSERT INTO `auth_info` VALUES (69, 0, '仓库管理', '仓库管理', 1, '1', '', '', 1, '1', 1, '2017-12-13 14:34:48', NULL, NULL);
INSERT INTO `auth_info` VALUES (70, 69, '仓库列表', '仓库列表', 2, '2', '/store/index', '', 1, '1', 1, '2017-12-13 14:36:32', NULL, NULL);
INSERT INTO `auth_info` VALUES (71, 68, '调货单列表', '调货单列表', 2, '2', '/transshipment/index', NULL, NULL, '1', NULL, NULL, NULL, NULL);
INSERT INTO `auth_info` VALUES (72, 0, '供货商管理', '供货商管理', 1, '1', '', '', 1, '1', 1, '2017-12-13 17:09:36', NULL, NULL);
INSERT INTO `auth_info` VALUES (74, 72, '供货商列表', '供货商列表', 2, '2', '', '', 1, '1', 1, '2017-12-13 17:10:14', NULL, NULL);
INSERT INTO `auth_info` VALUES (76, 42, '商品分类', '商品分类', 2, '2', '/commodity/category', '', 1, '1', 1, '2017-12-14 11:16:38', NULL, NULL);
INSERT INTO `auth_info` VALUES (92, 50, '调货', '调货', 3, '3', '/transshipment/transfer', 'transfer_commodity', 0, '1', 1, '2022-04-22 12:17:19', NULL, NULL);
INSERT INTO `auth_info` VALUES (93, 50, '商品查询', '商品查询', 3, '3', '/product/product-page-list', 'select_product', 0, '1', 1, '2022-04-22 12:21:37', NULL, NULL);
INSERT INTO `auth_info` VALUES (94, 50, '添加商品', '添加商品', 3, '3', '/product/product-add', 'product-add', 0, '1', 1, '2022-04-22 12:23:17', NULL, NULL);
INSERT INTO `auth_info` VALUES (95, 57, '确定入库', '确定入库', 3, '3', '/instore/instore-confirm', 'instore-confirm', 0, '1', 1, '2022-04-22 12:25:36', NULL, NULL);
INSERT INTO `auth_info` VALUES (96, 71, '确认调货', '确认调货', 3, '3', '/transshipment/transshipment-confirm', 'transshipment-confirm', 0, '1', 1, '2022-04-22 12:26:59', NULL, NULL);
INSERT INTO `auth_info` VALUES (97, 50, '采购', '采购', 3, '3', '/purchase/purchase-add', 'purchase-add', 0, '1', 1, '2022-04-22 12:30:42', NULL, NULL);

-- ----------------------------
-- Table structure for brand
-- ----------------------------
DROP TABLE IF EXISTS `brand`;
CREATE TABLE `brand`  (
  `brand_id` int(11) NOT NULL AUTO_INCREMENT,
  `brand_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `brand_leter` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `brand_desc` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`brand_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '品牌' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of brand
-- ----------------------------
INSERT INTO `brand` VALUES (1, '东东果蔬', 'D', '别买了，不能吃...');
INSERT INTO `brand` VALUES (2, '美的', 'M', '还可以');
INSERT INTO `brand` VALUES (3, '海尔', 'H', '我家洗衣机就是海尔啊');
INSERT INTO `brand` VALUES (4, '华为', 'H', '中华有为');

-- ----------------------------
-- Table structure for buy_list
-- ----------------------------
DROP TABLE IF EXISTS `buy_list`;
CREATE TABLE `buy_list`  (
  `buy_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NULL DEFAULT NULL,
  `store_id` int(11) NULL DEFAULT NULL,
  `buy_num` int(11) NULL DEFAULT NULL,
  `fact_buy_num` int(11) NULL DEFAULT NULL,
  `buy_time` datetime NULL DEFAULT NULL,
  `supply_id` int(11) NULL DEFAULT NULL,
  `place_id` int(11) NULL DEFAULT NULL,
  `buy_user` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_in` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '0 否 1 是',
  PRIMARY KEY (`buy_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '采购单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of buy_list
-- ----------------------------
INSERT INTO `buy_list` VALUES (1, 1, 1, 200, 198, '2017-12-19 09:45:49', 1, 2, 'rose', '13474421775', '1');
INSERT INTO `buy_list` VALUES (2, 5, 2, 366, 299, '2018-12-11 09:47:55', 2, 3, 'Jack', '13425431443', '0');
INSERT INTO `buy_list` VALUES (3, 6, 3, 499, 0, '2019-12-26 08:14:54', 3, 5, 'json', '12435642334', '0');
INSERT INTO `buy_list` VALUES (4, 7, 2, 899, 400, '2020-12-18 08:21:12', 3, 4, 'Abby', '13657867789', '0');
INSERT INTO `buy_list` VALUES (5, 11, 1, 299, 123, '2021-12-07 21:27:53', 1, 1, '杨洋', '13567589887', '1');
INSERT INTO `buy_list` VALUES (6, 12, 1, 299, 200, '2022-02-07 21:28:43', 1, 1, '杨洋', '13567589887', '1');
INSERT INTO `buy_list` VALUES (7, 13, 1, 3666, 399, '2018-12-07 21:29:24', 1, 1, '赵丽颖', '15757483376', '1');
INSERT INTO `buy_list` VALUES (8, 14, 1, 8, 0, '2019-12-07 21:54:16', 1, 1, '张三', '12455546785', '0');
INSERT INTO `buy_list` VALUES (9, 1, 1, 234, 33, '2020-12-07 22:10:22', 1, 1, '李四', '15647864467', '1');
INSERT INTO `buy_list` VALUES (10, 1, 1, 235, 0, '2021-12-07 22:14:02', 1, 1, '王麻子', '18349274483', '0');
INSERT INTO `buy_list` VALUES (11, 5, 1, 600, 600, '2022-04-11 15:37:10', 2, 2, 'zhang', '14647386684', '1');
INSERT INTO `buy_list` VALUES (12, 5, 1, 555, 550, '2019-12-11 15:39:51', 2, 3, 'liu', '46462275758', '0');
INSERT INTO `buy_list` VALUES (13, 5, 1, 666, 600, '2020-12-11 15:40:43', 2, 3, 'james', '35436375757', '0');
INSERT INTO `buy_list` VALUES (14, 5, 1, 666, 0, '2021-12-11 17:27:13', 2, 3, 'kobe', '35436375757', '0');
INSERT INTO `buy_list` VALUES (15, 6, 2, 33, 33, '2021-12-12 10:19:32', 2, 2, 'tom', NULL, '0');
INSERT INTO `buy_list` VALUES (16, 6, 3, 44, 44, '2020-12-12 10:19:44', 2, 2, 'frank', NULL, '0');
INSERT INTO `buy_list` VALUES (17, 6, 2, 55, 53, '2021-12-12 10:20:09', 1, 3, 'hello', NULL, '0');
INSERT INTO `buy_list` VALUES (18, 7, 1, 66, 1, '2022-04-12 10:20:26', 1, 2, 'mary', NULL, '1');
INSERT INTO `buy_list` VALUES (19, 14, 1, 22, 10, '2022-04-13 10:20:38', 2, 1, 'alise', NULL, '1');
INSERT INTO `buy_list` VALUES (20, 19, 1, 499, 4, '2022-04-13 10:28:39', 2, 2, 'mark', '46462275758', '0');
INSERT INTO `buy_list` VALUES (21, 22, 1, 700, 666, '2022-04-14 10:29:49', 2, 2, 'scott', '14647386684', '1');
INSERT INTO `buy_list` VALUES (22, 23, 1, 388, 300, '2022-03-12 10:31:06', 2, 3, 'jerry', '14647386684', '1');
INSERT INTO `buy_list` VALUES (23, 21, 1, 700, 400, '2021-04-12 10:32:17', 2, 2, 'john', '46462275758', '1');
INSERT INTO `buy_list` VALUES (25, 19, 1, 700, 700, '2019-04-12 10:43:45', 2, 2, 'zhang', '14647386684', '1');
INSERT INTO `buy_list` VALUES (26, 14, 1, 389, 300, '2022-01-14 11:10:47', 2, 2, 'messi', '12412412412', '1');
INSERT INTO `buy_list` VALUES (27, 21, NULL, NULL, NULL, '2022-04-19 11:42:19', NULL, NULL, NULL, NULL, '0');
INSERT INTO `buy_list` VALUES (28, 22, 1, 100, 50, '2022-04-19 11:58:05', 5, 6, 'wk', '12345678987', '1');
INSERT INTO `buy_list` VALUES (29, 21, 1, 2, 10, '2022-04-19 12:06:14', 2, 4, 'vick', '1234565432354', '0');
INSERT INTO `buy_list` VALUES (32, 21, 1, 8, 6, '2022-04-19 12:17:53', 2, 4, 'wr', '55555555555', '1');
INSERT INTO `buy_list` VALUES (35, 21, 1, 34, 20, '2022-04-19 18:00:09', 2, 4, 'href', '12345678234', '1');
INSERT INTO `buy_list` VALUES (36, 21, 1, 50, 10, '2022-04-19 18:01:15', 2, 4, 'alise', '12345678932', '1');
INSERT INTO `buy_list` VALUES (37, 22, 1, 500, 50, '2022-04-19 18:02:48', 5, 6, 'sam', '17654895432', '1');
INSERT INTO `buy_list` VALUES (38, 23, 2, 100, NULL, '2022-04-19 18:21:04', 5, 6, 'butt', '12345654327', '0');
INSERT INTO `buy_list` VALUES (39, 23, 2, 188, NULL, '2022-04-19 18:27:00', 5, 6, 'berne', '12345678742', '0');
INSERT INTO `buy_list` VALUES (40, 21, 1, 100, NULL, '2022-04-19 18:39:30', 2, 4, 'justin', '19875673733', '0');
INSERT INTO `buy_list` VALUES (41, 19, 2, 100, NULL, '2022-04-19 18:41:17', 2, 3, 'messi2', '16274987263', '0');
INSERT INTO `buy_list` VALUES (42, 6, 2, 40, NULL, '2022-04-19 18:43:17', 2, 4, 'kate', '12876543216', '0');
INSERT INTO `buy_list` VALUES (43, 6, 2, 20, NULL, '2022-04-19 18:45:54', 2, 4, 'zhang', '17654328765', '0');
INSERT INTO `buy_list` VALUES (44, 7, 1, 20, 15, '2022-04-21 08:53:20', 4, 5, 'jerry', '12345678652', '1');
INSERT INTO `buy_list` VALUES (45, 22, 1, 23, 20, '2022-04-22 08:48:22', 5, 6, 'ww', '12345678921', '1');
INSERT INTO `buy_list` VALUES (46, 25, 1, 20, 15, '2022-04-22 11:53:08', 5, 6, 'lisi', '12345678954', '1');
INSERT INTO `buy_list` VALUES (47, 25, 1, 100, 80, '2022-04-24 15:50:33', 5, 6, 'h5', '19893748542', '1');
INSERT INTO `buy_list` VALUES (48, 33, 1, 100, 100, '2023-07-26 10:45:28', 4, 2, '李四', '11111111111', '1');
INSERT INTO `buy_list` VALUES (49, 30, 1, 1000, 1000, '2023-07-27 14:58:03', 5, 6, '1', '11111111111', '1');
INSERT INTO `buy_list` VALUES (50, 33, 1, 10, 10, '2023-08-10 09:27:55', 4, 2, 'xiaoli', '11111111111', '1');
INSERT INTO `buy_list` VALUES (51, 33, 1, 10, 10, '2023-08-24 15:59:01', 4, 2, '张', '11111111111', '1');

-- ----------------------------
-- Table structure for in_store
-- ----------------------------
DROP TABLE IF EXISTS `in_store`;
CREATE TABLE `in_store`  (
  `ins_id` int(11) NOT NULL AUTO_INCREMENT,
  `store_id` int(11) NULL DEFAULT NULL,
  `product_id` int(11) NULL DEFAULT NULL,
  `in_num` int(11) NULL DEFAULT NULL,
  `create_by` int(11) NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `is_in` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '0 否 1 是',
  PRIMARY KEY (`ins_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '入库单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of in_store
-- ----------------------------
INSERT INTO `in_store` VALUES (1, 1, 1, 150, 1, '2017-12-08 14:17:02', '1');
INSERT INTO `in_store` VALUES (2, 2, 5, 150, 1, '2017-12-08 14:17:31', '1');
INSERT INTO `in_store` VALUES (3, 1, 1, 198, NULL, '2017-12-11 13:16:20', '1');
INSERT INTO `in_store` VALUES (4, 1, 1, 198, NULL, '2017-12-11 13:25:32', '0');
INSERT INTO `in_store` VALUES (5, 1, 1, 198, NULL, '2017-12-11 13:28:30', '1');
INSERT INTO `in_store` VALUES (6, 1, 1, 198, NULL, '2017-12-11 13:36:04', '0');
INSERT INTO `in_store` VALUES (7, 1, 1, 198, NULL, '2017-12-11 13:48:12', '0');
INSERT INTO `in_store` VALUES (8, 1, 1, 198, 1, '2017-12-11 13:52:14', '0');
INSERT INTO `in_store` VALUES (9, 1, 1, 198, 1, '2017-12-11 13:57:52', '0');
INSERT INTO `in_store` VALUES (10, 1, 1, 198, 1, '2017-12-11 14:00:03', '0');
INSERT INTO `in_store` VALUES (11, 1, 1, 198, 1, '2017-12-11 14:00:42', '0');
INSERT INTO `in_store` VALUES (12, 1, 1, 198, 1, '2017-12-11 14:02:27', '0');
INSERT INTO `in_store` VALUES (13, 1, 1, 198, 1, '2017-12-11 14:32:05', '0');
INSERT INTO `in_store` VALUES (14, 1, 1, 198, 1, '2017-12-11 14:35:35', '0');
INSERT INTO `in_store` VALUES (15, 1, 1, 198, 1, '2017-12-11 14:36:09', '0');
INSERT INTO `in_store` VALUES (16, 1, 1, 123, 1, '2017-12-11 15:04:01', '1');
INSERT INTO `in_store` VALUES (17, 1, 1, 200, 1, '2017-12-12 10:32:37', '0');
INSERT INTO `in_store` VALUES (18, 1, 2, 700, 1, '2017-12-12 10:43:06', '0');
INSERT INTO `in_store` VALUES (19, 1, 1, 700, 1, '2017-12-12 10:44:07', '1');
INSERT INTO `in_store` VALUES (20, 1, 9, 100, 1, '2017-12-13 14:42:11', '1');
INSERT INTO `in_store` VALUES (21, 1, 10, 21, 1, '2017-12-13 14:46:18', '1');
INSERT INTO `in_store` VALUES (22, 1, 11, 32, 1, '2017-12-13 15:22:12', '1');
INSERT INTO `in_store` VALUES (23, 1, 12, 11, 1, '2017-12-13 15:33:10', '1');
INSERT INTO `in_store` VALUES (24, 1, 13, 100, 1, '2017-12-13 15:37:11', '1');
INSERT INTO `in_store` VALUES (25, 1, 14, 222, 1, '2017-12-13 18:57:06', '0');
INSERT INTO `in_store` VALUES (26, 1, 15, 78, 1, '2017-12-13 19:18:12', '1');
INSERT INTO `in_store` VALUES (27, 1, 16, 100, 1, '2017-12-13 19:27:14', '1');
INSERT INTO `in_store` VALUES (28, 1, 1, 400, 1, '2017-12-14 11:08:55', '0');
INSERT INTO `in_store` VALUES (29, 1, 13, 300, 1, '2017-12-14 11:37:53', '1');
INSERT INTO `in_store` VALUES (30, 1, 3, 300, 1, '2017-12-14 11:40:15', '1');
INSERT INTO `in_store` VALUES (31, 2, 18, 43, 1, '2017-12-14 15:39:13', '1');
INSERT INTO `in_store` VALUES (32, 1, 22, 666, 1, '2022-04-20 12:00:02', '1');
INSERT INTO `in_store` VALUES (33, 1, 14, 10, 1, '2022-04-20 12:03:15', '1');
INSERT INTO `in_store` VALUES (34, 1, 7, 1, 1, '2022-04-20 17:19:36', '1');
INSERT INTO `in_store` VALUES (35, 1, 22, 50, 1, '2022-04-20 17:30:25', '0');
INSERT INTO `in_store` VALUES (36, 1, 13, 399, 1, '2022-04-20 17:38:22', '0');
INSERT INTO `in_store` VALUES (37, 1, 21, 6, 1, '2022-04-20 17:44:24', '0');
INSERT INTO `in_store` VALUES (38, 1, 7, 15, 1, '2022-04-21 08:56:47', '1');
INSERT INTO `in_store` VALUES (39, 1, 22, 50, 1, '2022-04-21 09:15:07', '1');
INSERT INTO `in_store` VALUES (40, 1, 5, 600, 1, '2022-04-21 09:35:35', '1');
INSERT INTO `in_store` VALUES (41, 1, 1, 33, 1, '2022-04-21 09:37:09', '1');
INSERT INTO `in_store` VALUES (42, 1, 28, 20, 1, '2022-04-22 11:25:20', '1');
INSERT INTO `in_store` VALUES (43, 1, 25, 15, 1, '2022-04-22 11:55:01', '1');
INSERT INTO `in_store` VALUES (44, 1, 22, 20, 28, '2022-04-22 13:54:56', '1');
INSERT INTO `in_store` VALUES (45, 1, 25, 80, 28, '2022-04-24 15:50:54', '1');
INSERT INTO `in_store` VALUES (46, 1, 30, 20, 32, '2022-04-24 15:55:58', '1');
INSERT INTO `in_store` VALUES (47, 1, 33, 100, 1, '2023-07-26 23:21:03', '1');
INSERT INTO `in_store` VALUES (48, 1, 30, 1000, 1, '2023-07-27 14:58:07', '1');
INSERT INTO `in_store` VALUES (49, 1, 33, 10, 1, '2023-08-10 09:28:13', '1');
INSERT INTO `in_store` VALUES (50, 1, 33, 10, 1, '2023-08-24 15:59:06', '0');

-- ----------------------------
-- Table structure for out_store
-- ----------------------------
DROP TABLE IF EXISTS `out_store`;
CREATE TABLE `out_store`  (
  `outs_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NULL DEFAULT NULL,
  `store_id` int(11) NULL DEFAULT NULL,
  `tally_id` int(11) NULL DEFAULT NULL,
  `out_price` decimal(8, 2) NULL DEFAULT NULL,
  `out_num` int(11) NULL DEFAULT NULL,
  `create_by` int(11) NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `is_out` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '0 否 1 是',
  PRIMARY KEY (`outs_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '出库单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of out_store
-- ----------------------------
INSERT INTO `out_store` VALUES (1, 1, 1, 3, NULL, 100, 1, '2017-12-08 14:18:08', '1');
INSERT INTO `out_store` VALUES (2, 5, 1, 3, NULL, 160, 1, '2018-12-11 08:56:07', '1');
INSERT INTO `out_store` VALUES (3, 11, 2, 3, NULL, 200, 1, '2019-12-11 08:56:15', '0');
INSERT INTO `out_store` VALUES (4, 6, 1, 3, NULL, 270, 3, '2020-12-11 08:56:29', '0');
INSERT INTO `out_store` VALUES (5, 7, 1, 3, NULL, 450, 3, '2021-12-11 08:56:36', '1');
INSERT INTO `out_store` VALUES (6, 12, 1, 3, NULL, 340, 5, '2022-02-11 08:56:44', '0');
INSERT INTO `out_store` VALUES (7, 13, 1, 3, NULL, 120, 5, '2021-12-11 08:57:10', '1');
INSERT INTO `out_store` VALUES (8, 14, 1, 23, NULL, 800, 5, '2021-12-12 10:47:43', '0');
INSERT INTO `out_store` VALUES (9, 19, 1, 3, NULL, 300, 10, '2020-12-14 11:43:55', '1');
INSERT INTO `out_store` VALUES (10, 21, 1, 23, NULL, 30, 1, '2022-04-20 16:41:47', '1');
INSERT INTO `out_store` VALUES (11, 22, 1, 23, NULL, 20, 1, '2022-04-20 16:45:41', '1');
INSERT INTO `out_store` VALUES (12, 23, 1, 23, NULL, 15, 1, '2022-04-20 16:46:56', '1');
INSERT INTO `out_store` VALUES (13, 25, 1, NULL, NULL, 23, 1, '2022-04-24 15:53:17', '1');
INSERT INTO `out_store` VALUES (14, 30, 1, NULL, 299.00, 10, 1, '2023-07-26 11:31:28', '1');
INSERT INTO `out_store` VALUES (15, 30, 1, NULL, 299.00, 19, 1, '2023-07-27 13:05:54', '1');
INSERT INTO `out_store` VALUES (16, 30, 1, NULL, 299.00, 19, 1, '2023-07-27 13:21:20', '1');
INSERT INTO `out_store` VALUES (17, 30, 1, NULL, 299.00, 100, 1, '2023-08-10 09:39:52', '0');

-- ----------------------------
-- Table structure for place
-- ----------------------------
DROP TABLE IF EXISTS `place`;
CREATE TABLE `place`  (
  `place_id` int(11) NOT NULL AUTO_INCREMENT,
  `place_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `place_num` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `introduce` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_delete` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '0:可用  1:不可用',
  PRIMARY KEY (`place_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产地' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of place
-- ----------------------------
INSERT INTO `place` VALUES (1, '湖南', 'hunan', '湖南挺好的啊123123123', '0');
INSERT INTO `place` VALUES (2, '湖北', 'hubei', '湖北没有湖南好', '0');
INSERT INTO `place` VALUES (3, '陕西', 'shanxi', '还是陕西更好', '0');
INSERT INTO `place` VALUES (4, '浙江', 'zhejiang', '好地方', '0');
INSERT INTO `place` VALUES (5, '山东', 'shandong', '很好', '0');
INSERT INTO `place` VALUES (6, '广东', 'guangdong', '非常好', '0');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `store_id` int(11) NULL DEFAULT NULL,
  `brand_id` int(11) NULL DEFAULT NULL,
  `product_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `product_num` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `product_invent` int(11) NULL DEFAULT NULL,
  `type_id` int(11) NULL DEFAULT NULL,
  `supply_id` int(11) NULL DEFAULT NULL,
  `place_id` int(11) NULL DEFAULT NULL,
  `unit_id` int(11) NULL DEFAULT NULL,
  `introduce` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `up_down_state` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '0 下架 1 上架',
  `in_price` decimal(10, 2) NULL DEFAULT NULL,
  `sale_price` decimal(10, 2) NULL DEFAULT NULL,
  `mem_price` decimal(10, 2) NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_by` int(11) NULL DEFAULT NULL,
  `update_by` int(11) NULL DEFAULT NULL,
  `imgs` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `product_date` datetime NULL DEFAULT NULL,
  `supp_date` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES (1, 1, 3, '海尔电视d1-1111', 'haier1001', -91, 3, 4, 5, 6, '43242342342343', '1', 3899.00, 4999.00, 4599.00, '2017-12-06 12:09:12', '2022-04-08 15:24:14', 1, 1, '/img/upload/haier_tv.jpg', '2016-02-22 08:00:00', '2028-10-11 08:00:00');
INSERT INTO `product` VALUES (5, 2, 3, '海尔洗衣机h1-1131', 'haierh11132', 757, 2, 2, 3, 6, 'weqweqweqwe', '1', 3899.00, 4999.00, 4599.00, '2017-12-06 12:09:12', '2017-12-08 17:14:12', 1, 1, '', '2016-02-23 00:00:00', '2027-02-23 00:00:00');
INSERT INTO `product` VALUES (6, 2, 1, '香蕉', 'xj456', 200, 6, 2, 4, 3, '香蕉啊222', '0', 2.50, 5.50, 3.50, '2017-12-12 11:16:45', '2022-04-08 12:24:45', 1, 1, '/img/upload/banana.png', '2017-12-19 08:00:00', '2017-12-31 08:00:00');
INSERT INTO `product` VALUES (7, 1, 3, '海尔洗衣机h1-1132', 'haier1002', 116, 2, 4, 5, 6, 'weqweqweqwe', '0', 3899.00, 4999.00, 4599.00, '2017-12-06 12:09:12', '2022-04-08 15:25:14', 1, 1, '/img/upload/haier_wm.jpg', '2016-02-22 08:00:00', '2030-09-17 08:00:00');
INSERT INTO `product` VALUES (13, 2, 1, '西瓜', 'xigua', 80, 6, 1, 2, 2, '不好吃，别买了', '0', 2.50, 20.50, 8.50, '2017-12-14 10:39:14', '2017-12-14 10:43:31', 1, 1, '', '2017-12-10 00:00:00', '2027-12-19 00:00:00');
INSERT INTO `product` VALUES (14, 2, 3, '海尔洗衣机h1-1138', 'haierh11132a', 43, 2, 2, 2, 6, '海尔洗衣机好啊', '0', 3899.00, 4999.00, 4599.00, '2017-12-06 12:09:12', '2017-12-14 09:42:24', 1, 1, '', '2017-12-31 00:00:00', '2029-09-23 00:00:00');
INSERT INTO `product` VALUES (19, 2, 1, '西瓜2号', 'xg9527', 2000, 6, 2, 3, 2, '皮薄保甜', '0', 3.00, 5.00, 4.00, '2022-04-08 11:19:38', NULL, 1, NULL, '/img/upload/watermelon.png', '2022-04-09 08:00:00', '2022-04-30 08:00:00');
INSERT INTO `product` VALUES (21, 1, 1, '香蕉', 'xg001', 269, 6, 2, 4, 3, '香蕉啊 大香蕉', '0', 2.50, 5.50, 3.50, '2022-04-08 11:58:47', '2023-07-26 10:03:40', 1, 1, '/img/upload/happy-striker.png', '2017-12-19 00:00:00', '2017-12-29 00:00:00');
INSERT INTO `product` VALUES (22, 2, 3, '空调', 'midea10090', 170, 7, 5, 2, 6, '很凉快', '0', 2000.00, 3999.00, 3699.00, '2022-04-08 15:39:56', '2023-07-26 09:02:20', 1, 1, '/img/upload/sad.png', '2022-03-24 00:00:00', '2034-12-20 00:00:00');
INSERT INTO `product` VALUES (23, 2, 2, '风扇', 'midea1002', 980, 8, 5, 6, 6, '没有风，只有声。。。', '0', 100.00, 299.00, 249.00, '2022-04-08 15:44:22', NULL, 1, NULL, '/img/upload/midea_blower.png', '2022-04-01 08:00:00', '2038-09-15 08:00:00');
INSERT INTO `product` VALUES (24, 2, 1, '香蕉', 'xg124', NULL, 6, 2, 4, 3, '香蕉啊', '0', 2.50, 5.50, 3.50, '2022-04-08 11:58:47', '2022-04-08 15:11:48', 1, 1, '/img/upload/banana.png', '2017-12-19 08:00:00', '2017-12-29 08:00:00');
INSERT INTO `product` VALUES (25, 2, 3, '风扇', 'midea1004', 87, 8, 5, 6, 6, '没有风，只有声。。。', '0', 100.00, 299.00, 249.00, '2022-04-08 15:44:22', '2023-07-26 09:04:13', 1, 1, '/img/upload/midea_blower.png', '2022-04-01 00:00:00', '2038-09-15 00:00:00');
INSERT INTO `product` VALUES (27, 3, 1, '西瓜3号', 'xg9528', 100, 6, 2, 5, 2, '皮薄保甜', '0', 3.00, 5.00, 4.00, '2022-04-08 11:19:38', '2023-07-26 09:03:24', 1, 1, '/img/upload/happy-striker.png', '2022-04-09 00:00:00', '2022-06-05 00:00:00');
INSERT INTO `product` VALUES (28, 3, 1, '西瓜', 'xigua6', 220, 6, 1, 2, 2, '不好吃，别买了', '0', 2.50, 20.50, 8.50, '2017-12-14 10:39:14', '2022-04-24 16:02:49', 1, 1, '/img/upload/xigua2.jpeg', '2017-12-09 08:00:00', '2027-12-18 08:00:00');
INSERT INTO `product` VALUES (29, 3, 4, '华为手机', 'huawei_mate40_1', 30, 12, 5, 3, 6, '高端大气上档次', '0', 2000.00, 5999.00, 5699.00, '2022-04-24 15:43:05', '2022-04-24 15:57:44', 31, 1, '/img/upload/mate40.jpg', '2022-03-17 08:00:00', '2042-07-24 08:00:00');
INSERT INTO `product` VALUES (30, 1, 2, '风扇', 'midea1003', 799, 8, 5, 6, 6, '没有风，只有声。。。', '1', 100.00, 299.00, 249.00, '2022-04-08 15:44:22', NULL, 1, NULL, '/img/upload/midea_blower.png', '2022-04-01 08:00:00', '2038-09-15 08:00:00');
INSERT INTO `product` VALUES (31, 2, 2, '沙发', 'sofa_0001', 10, 8, 2, 2, 2, '风扇', '0', 100.00, 200.00, 190.00, '2023-07-25 17:16:48', NULL, 1, NULL, 'file.access-patherror.png', '2023-07-25 00:00:00', '2031-05-04 00:00:00');
INSERT INTO `product` VALUES (33, 1, 2, '空调', 'media000123', 130, 7, 4, 2, 2, '空调 大空调', '0', 1000.00, 4141.00, 2131.00, '2023-07-26 10:04:53', '2023-07-26 10:05:10', 1, 1, '/img/upload/error.png', '2023-07-26 00:00:00', '2023-07-26 00:00:00');

-- ----------------------------
-- Table structure for product_type
-- ----------------------------
DROP TABLE IF EXISTS `product_type`;
CREATE TABLE `product_type`  (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NULL DEFAULT NULL,
  `type_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type_desc` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_type
-- ----------------------------
INSERT INTO `product_type` VALUES (1, 0, 'appliance', '家电类', '种类齐全，货源充足');
INSERT INTO `product_type` VALUES (2, 1, 'washer', '洗衣机', '全是洗衣机啊~~');
INSERT INTO `product_type` VALUES (3, 1, 'televison', '电视机', '全是电视机啊~~');
INSERT INTO `product_type` VALUES (4, 0, 'fruit-vegetable', '果蔬类', '全是果蔬啊~~');
INSERT INTO `product_type` VALUES (5, 4, 'vegetable', '蔬菜', '全是蔬菜啊~~');
INSERT INTO `product_type` VALUES (6, 4, 'fruit', '水果', '全是水果啊~~');
INSERT INTO `product_type` VALUES (7, 1, 'air-condition', '空调', '很凉快');
INSERT INTO `product_type` VALUES (8, 1, 'blower', '风扇', '也很凉快');
INSERT INTO `product_type` VALUES (11, 0, 'phone', '手机', '大家都机不离手');
INSERT INTO `product_type` VALUES (12, 11, 'huawei', '华为手机', '中华有为');
INSERT INTO `product_type` VALUES (13, 11, 'apple', '苹果手机', '一般般，小心被定位');
INSERT INTO `product_type` VALUES (14, 11, 'xiaomi', '红米手机', '发烧 性价比高');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `role_desc` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `role_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `role_state` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '1 启用 0 禁用',
  `create_by` int(11) NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` int(11) NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '超级管理员', '超级管理员', 'supper_manage', '1', 1, '2017-11-14 16:49:12', 1, '2017-11-14 16:49:20');
INSERT INTO `role` VALUES (2, '管理员', '管理员', 'manage', '0', 1, '2018-11-14 16:49:12', 1, NULL);
INSERT INTO `role` VALUES (3, '普通用户', '普通用户', 'comm_manage', '1', 1, '2019-11-14 16:49:12', 1, '2022-03-25 15:09:41');
INSERT INTO `role` VALUES (11, '采购', '采购管理员', 'purchase_man', '1', 1, '2022-04-22 12:29:00', 1, '2022-04-22 13:56:29');
INSERT INTO `role` VALUES (12, '入库', '入库管理员', 'in_store', '1', 1, '2022-04-22 13:56:17', NULL, NULL);
INSERT INTO `role` VALUES (13, '商品', '商品管理员', 'commodity_manager', '1', 1, '2022-04-22 13:57:42', NULL, NULL);
INSERT INTO `role` VALUES (14, '出库', '出库管理员', 'out_store', '1', 1, '2022-04-22 14:00:00', NULL, NULL);
INSERT INTO `role` VALUES (15, '调货', '调货管理员', 'transshipment_manager', '1', 1, '2022-04-22 14:00:38', NULL, NULL);
INSERT INTO `role` VALUES (16, '仓库', '测试管理员', 'store_manager', '1', 1, '2022-04-24 15:12:56', 1, '2023-07-25 00:12:32');
INSERT INTO `role` VALUES (17, '测试1 ', '测试过hi', 'dd01', '1', 1, '2023-07-30 21:10:39', NULL, NULL);

-- ----------------------------
-- Table structure for role_auth
-- ----------------------------
DROP TABLE IF EXISTS `role_auth`;
CREATE TABLE `role_auth`  (
  `role_auth_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NULL DEFAULT NULL,
  `auth_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`role_auth_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 754 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_auth
-- ----------------------------
INSERT INTO `role_auth` VALUES (118, 4, 1);
INSERT INTO `role_auth` VALUES (119, 4, 2);
INSERT INTO `role_auth` VALUES (120, 4, 3);
INSERT INTO `role_auth` VALUES (121, 4, 10);
INSERT INTO `role_auth` VALUES (122, 4, 23);
INSERT INTO `role_auth` VALUES (123, 4, 24);
INSERT INTO `role_auth` VALUES (124, 4, 35);
INSERT INTO `role_auth` VALUES (125, 4, 36);
INSERT INTO `role_auth` VALUES (126, 4, 4);
INSERT INTO `role_auth` VALUES (127, 4, 5);
INSERT INTO `role_auth` VALUES (128, 4, 6);
INSERT INTO `role_auth` VALUES (129, 4, 27);
INSERT INTO `role_auth` VALUES (130, 4, 28);
INSERT INTO `role_auth` VALUES (131, 4, 7);
INSERT INTO `role_auth` VALUES (132, 4, 8);
INSERT INTO `role_auth` VALUES (133, 4, 9);
INSERT INTO `role_auth` VALUES (134, 5, 1);
INSERT INTO `role_auth` VALUES (135, 5, 2);
INSERT INTO `role_auth` VALUES (136, 5, 3);
INSERT INTO `role_auth` VALUES (137, 5, 10);
INSERT INTO `role_auth` VALUES (138, 8, 1);
INSERT INTO `role_auth` VALUES (139, 8, 2);
INSERT INTO `role_auth` VALUES (140, 8, 3);
INSERT INTO `role_auth` VALUES (141, 8, 10);
INSERT INTO `role_auth` VALUES (142, 8, 23);
INSERT INTO `role_auth` VALUES (143, 8, 24);
INSERT INTO `role_auth` VALUES (535, 2, 1);
INSERT INTO `role_auth` VALUES (536, 2, 2);
INSERT INTO `role_auth` VALUES (537, 2, 3);
INSERT INTO `role_auth` VALUES (538, 2, 10);
INSERT INTO `role_auth` VALUES (539, 2, 23);
INSERT INTO `role_auth` VALUES (540, 2, 24);
INSERT INTO `role_auth` VALUES (541, 2, 25);
INSERT INTO `role_auth` VALUES (542, 2, 26);
INSERT INTO `role_auth` VALUES (543, 2, 35);
INSERT INTO `role_auth` VALUES (544, 2, 36);
INSERT INTO `role_auth` VALUES (545, 2, 4);
INSERT INTO `role_auth` VALUES (546, 2, 5);
INSERT INTO `role_auth` VALUES (547, 2, 6);
INSERT INTO `role_auth` VALUES (548, 2, 27);
INSERT INTO `role_auth` VALUES (549, 2, 28);
INSERT INTO `role_auth` VALUES (550, 2, 30);
INSERT INTO `role_auth` VALUES (551, 2, 31);
INSERT INTO `role_auth` VALUES (552, 2, 37);
INSERT INTO `role_auth` VALUES (553, 2, 7);
INSERT INTO `role_auth` VALUES (554, 2, 8);
INSERT INTO `role_auth` VALUES (555, 2, 9);
INSERT INTO `role_auth` VALUES (556, 2, 32);
INSERT INTO `role_auth` VALUES (557, 2, 33);
INSERT INTO `role_auth` VALUES (558, 2, 34);
INSERT INTO `role_auth` VALUES (559, 2, 20);
INSERT INTO `role_auth` VALUES (560, 2, 21);
INSERT INTO `role_auth` VALUES (561, 2, 22);
INSERT INTO `role_auth` VALUES (562, 3, 23);
INSERT INTO `role_auth` VALUES (563, 3, 36);
INSERT INTO `role_auth` VALUES (564, 1, 1);
INSERT INTO `role_auth` VALUES (565, 1, 2);
INSERT INTO `role_auth` VALUES (566, 1, 3);
INSERT INTO `role_auth` VALUES (567, 1, 10);
INSERT INTO `role_auth` VALUES (568, 1, 23);
INSERT INTO `role_auth` VALUES (569, 1, 24);
INSERT INTO `role_auth` VALUES (570, 1, 25);
INSERT INTO `role_auth` VALUES (571, 1, 26);
INSERT INTO `role_auth` VALUES (572, 1, 35);
INSERT INTO `role_auth` VALUES (573, 1, 36);
INSERT INTO `role_auth` VALUES (574, 1, 4);
INSERT INTO `role_auth` VALUES (575, 1, 5);
INSERT INTO `role_auth` VALUES (576, 1, 6);
INSERT INTO `role_auth` VALUES (577, 1, 27);
INSERT INTO `role_auth` VALUES (578, 1, 28);
INSERT INTO `role_auth` VALUES (579, 1, 30);
INSERT INTO `role_auth` VALUES (580, 1, 31);
INSERT INTO `role_auth` VALUES (581, 1, 37);
INSERT INTO `role_auth` VALUES (582, 1, 7);
INSERT INTO `role_auth` VALUES (583, 1, 8);
INSERT INTO `role_auth` VALUES (584, 1, 9);
INSERT INTO `role_auth` VALUES (585, 1, 32);
INSERT INTO `role_auth` VALUES (586, 1, 33);
INSERT INTO `role_auth` VALUES (587, 1, 34);
INSERT INTO `role_auth` VALUES (588, 1, 22);
INSERT INTO `role_auth` VALUES (589, 1, 42);
INSERT INTO `role_auth` VALUES (590, 1, 50);
INSERT INTO `role_auth` VALUES (591, 1, 92);
INSERT INTO `role_auth` VALUES (592, 1, 93);
INSERT INTO `role_auth` VALUES (593, 1, 94);
INSERT INTO `role_auth` VALUES (594, 1, 76);
INSERT INTO `role_auth` VALUES (595, 1, 53);
INSERT INTO `role_auth` VALUES (596, 1, 56);
INSERT INTO `role_auth` VALUES (597, 1, 54);
INSERT INTO `role_auth` VALUES (598, 1, 57);
INSERT INTO `role_auth` VALUES (599, 1, 95);
INSERT INTO `role_auth` VALUES (600, 1, 55);
INSERT INTO `role_auth` VALUES (601, 1, 58);
INSERT INTO `role_auth` VALUES (602, 1, 63);
INSERT INTO `role_auth` VALUES (603, 1, 64);
INSERT INTO `role_auth` VALUES (604, 1, 68);
INSERT INTO `role_auth` VALUES (605, 1, 71);
INSERT INTO `role_auth` VALUES (606, 1, 96);
INSERT INTO `role_auth` VALUES (607, 1, 69);
INSERT INTO `role_auth` VALUES (608, 1, 70);
INSERT INTO `role_auth` VALUES (698, 11, 42);
INSERT INTO `role_auth` VALUES (699, 11, 50);
INSERT INTO `role_auth` VALUES (700, 11, 92);
INSERT INTO `role_auth` VALUES (701, 11, 93);
INSERT INTO `role_auth` VALUES (702, 11, 94);
INSERT INTO `role_auth` VALUES (703, 11, 97);
INSERT INTO `role_auth` VALUES (704, 11, 76);
INSERT INTO `role_auth` VALUES (705, 11, 53);
INSERT INTO `role_auth` VALUES (706, 11, 56);
INSERT INTO `role_auth` VALUES (707, 11, 63);
INSERT INTO `role_auth` VALUES (708, 11, 64);
INSERT INTO `role_auth` VALUES (709, 12, 54);
INSERT INTO `role_auth` VALUES (710, 12, 57);
INSERT INTO `role_auth` VALUES (711, 12, 95);
INSERT INTO `role_auth` VALUES (712, 12, 63);
INSERT INTO `role_auth` VALUES (713, 12, 64);
INSERT INTO `role_auth` VALUES (714, 13, 42);
INSERT INTO `role_auth` VALUES (715, 13, 50);
INSERT INTO `role_auth` VALUES (716, 13, 92);
INSERT INTO `role_auth` VALUES (717, 13, 93);
INSERT INTO `role_auth` VALUES (718, 13, 94);
INSERT INTO `role_auth` VALUES (719, 13, 97);
INSERT INTO `role_auth` VALUES (720, 13, 76);
INSERT INTO `role_auth` VALUES (721, 13, 63);
INSERT INTO `role_auth` VALUES (722, 13, 64);
INSERT INTO `role_auth` VALUES (723, 14, 42);
INSERT INTO `role_auth` VALUES (724, 14, 50);
INSERT INTO `role_auth` VALUES (725, 14, 92);
INSERT INTO `role_auth` VALUES (726, 14, 93);
INSERT INTO `role_auth` VALUES (727, 14, 94);
INSERT INTO `role_auth` VALUES (728, 14, 97);
INSERT INTO `role_auth` VALUES (729, 14, 76);
INSERT INTO `role_auth` VALUES (730, 14, 55);
INSERT INTO `role_auth` VALUES (731, 14, 58);
INSERT INTO `role_auth` VALUES (732, 14, 63);
INSERT INTO `role_auth` VALUES (733, 14, 64);
INSERT INTO `role_auth` VALUES (734, 15, 42);
INSERT INTO `role_auth` VALUES (735, 15, 50);
INSERT INTO `role_auth` VALUES (736, 15, 92);
INSERT INTO `role_auth` VALUES (737, 15, 93);
INSERT INTO `role_auth` VALUES (738, 15, 94);
INSERT INTO `role_auth` VALUES (739, 15, 97);
INSERT INTO `role_auth` VALUES (740, 15, 76);
INSERT INTO `role_auth` VALUES (741, 15, 63);
INSERT INTO `role_auth` VALUES (742, 15, 64);
INSERT INTO `role_auth` VALUES (743, 15, 68);
INSERT INTO `role_auth` VALUES (744, 15, 71);
INSERT INTO `role_auth` VALUES (745, 15, 96);
INSERT INTO `role_auth` VALUES (746, 16, 55);
INSERT INTO `role_auth` VALUES (747, 16, 58);
INSERT INTO `role_auth` VALUES (748, 16, 63);
INSERT INTO `role_auth` VALUES (749, 16, 64);
INSERT INTO `role_auth` VALUES (750, 16, 69);
INSERT INTO `role_auth` VALUES (751, 16, 70);
INSERT INTO `role_auth` VALUES (752, 17, 54);
INSERT INTO `role_auth` VALUES (753, 17, 57);

-- ----------------------------
-- Table structure for store
-- ----------------------------
DROP TABLE IF EXISTS `store`;
CREATE TABLE `store`  (
  `store_id` int(11) NOT NULL AUTO_INCREMENT,
  `store_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `store_num` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `store_address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `concat` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`store_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '仓库表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of store
-- ----------------------------
INSERT INTO `store` VALUES (1, '西安仓库', 'xa1', '西安市雁塔区', '张三', '13829086629');
INSERT INTO `store` VALUES (2, '北京仓库', 'bj2', '北京市朝阳区 ', '王麻子', '15229267291');
INSERT INTO `store` VALUES (3, '上海仓库', 'sh3', '上海市浦东区', '李四', '18092647320');

-- ----------------------------
-- Table structure for supply
-- ----------------------------
DROP TABLE IF EXISTS `supply`;
CREATE TABLE `supply`  (
  `supply_id` int(11) NOT NULL AUTO_INCREMENT,
  `supply_num` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `supply_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `supply_introduce` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `concat` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_delete` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '0:可用  1:不可用',
  PRIMARY KEY (`supply_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '供货商' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of supply
-- ----------------------------
INSERT INTO `supply` VALUES (1, 'zjsh', '浙江三禾竹木有限公司', '贷款是否会为加快和规范健康环境如何根据', '任伟', '15287653921', '浙江省丽水市', '0');
INSERT INTO `supply` VALUES (2, 'lqlo', '龙泉绿欧食品有限公司', NULL, '张三', '18134532830', '浙江省龙泉市', '0');
INSERT INTO `supply` VALUES (3, 'dhgy', '帝豪供应链公司', NULL, '李四', '17493976543', '陕西省西安市', '0');
INSERT INTO `supply` VALUES (4, 'haier', '海尔集团', '海尔智家为用户提供衣、食、住、娱的智慧全场景解决方案，全面提升用户生活品质，以“云”体验、全链路服务、个性化智慧终端，实现交互、体验、销售、服务于一体的全流程生态平台。', '周云杰', '4006999511', '山东省青岛市', '0');
INSERT INTO `supply` VALUES (5, 'midea', '美的集团股份有限公司', '科技尽善，生活尽美”– 美的集团秉承用科技创造美好生活的经营理念，如今已成为一家集智能家居事业群、机电事业群、暖通与楼宇事业部、机器人及自动化事业部、数字化创新业务五大板块为一体的全球化科技集团，产品及服务惠及全球200多个国家和地区约4亿用户。形成美的、小天鹅、东芝、华凌、布谷、COLMO、Clivet、Eureka、库卡、GMCC、威灵在内的多品牌组合。', '方洪波', '075726338788', '广东省佛山市', '0');

-- ----------------------------
-- Table structure for unit
-- ----------------------------
DROP TABLE IF EXISTS `unit`;
CREATE TABLE `unit`  (
  `unit_id` int(11) NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `unit_desc` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`unit_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '规格单位表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of unit
-- ----------------------------
INSERT INTO `unit` VALUES (1, '箱/件', '箱/件');
INSERT INTO `unit` VALUES (2, '个', '个');
INSERT INTO `unit` VALUES (3, '公斤', '公斤');
INSERT INTO `unit` VALUES (4, '只', '只');
INSERT INTO `unit` VALUES (5, '克', '克');
INSERT INTO `unit` VALUES (6, '台', '台');

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`  (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_pwd` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '1 超级管理员 、 2  管理员 、 3 普通用户',
  `user_state` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '0 未审核 、1 已审核',
  `is_delete` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '0 正常、 1 已删除',
  `create_by` int(11) NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` int(11) NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES (1, 'admin', '超级管理员', 'c431d451c81e75ffac75a640590ed0a1', NULL, '1', '0', 1, '2017-11-14 15:14:31', 1, '2022-04-24 15:33:12');
INSERT INTO `user_info` VALUES (3, 'root', 'root', 'c431d451c81e75ffac75a640590ed0a1', NULL, '1', '0', 1, '2017-11-16 19:31:49', 1, '2022-03-16 17:28:34');
INSERT INTO `user_info` VALUES (5, 'asdsjkb', '可爱吧1', 'c431d451c81e75ffac75a640590ed0a1', NULL, '1', '1', 1, '2017-11-16 21:25:41', 1, '2022-03-15 14:57:44');
INSERT INTO `user_info` VALUES (6, 'dasdasf', 'start', 'c431d451c81e75ffac75a640590ed0a1', '1', '1', '1', 1, '2017-11-16 21:36:41', 1, '2017-11-21 10:45:57');
INSERT INTO `user_info` VALUES (7, 'fsdfs', 'start', 'c431d451c81e75ffac75a640590ed0a1', '1', '0', '1', 1, '2017-11-16 21:39:09', 1, '2017-11-21 10:44:35');
INSERT INTO `user_info` VALUES (10, 'root', 'root', 'c431d451c81e75ffac75a640590ed0a1', '3', '0', '1', 1, '2017-11-17 10:48:24', NULL, NULL);
INSERT INTO `user_info` VALUES (19, 'static', 'static', 'c431d451c81e75ffac75a640590ed0a1', '2', '0', '1', 1, '2017-11-29 22:10:51', NULL, NULL);
INSERT INTO `user_info` VALUES (20, 'public', 'public', 'c431d451c81e75ffac75a640590ed0a1', '2', '1', '0', 1, '2017-12-01 14:40:15', NULL, NULL);
INSERT INTO `user_info` VALUES (21, 'wk', '晴空', NULL, NULL, '0', '1', 1, '2022-03-17 17:24:00', NULL, NULL);
INSERT INTO `user_info` VALUES (23, 'zhangsan', '张三', NULL, NULL, '0', '1', 1, '2022-04-08 16:18:52', NULL, NULL);
INSERT INTO `user_info` VALUES (24, 'lisi', '李四', NULL, NULL, '0', '1', 1, '2022-04-08 16:20:19', NULL, NULL);
INSERT INTO `user_info` VALUES (25, 'wangwu', '王五', NULL, NULL, '0', '1', 1, '2022-04-08 16:20:43', NULL, NULL);
INSERT INTO `user_info` VALUES (26, 'liuliu', '刘六', NULL, NULL, '0', '1', 1, '2022-04-08 16:21:14', NULL, NULL);
INSERT INTO `user_info` VALUES (27, 'wzl', '我这里', NULL, NULL, '1', '1', 1, '2022-04-19 17:09:13', NULL, NULL);
INSERT INTO `user_info` VALUES (28, 'caigou', '采购', 'c431d451c81e75ffac75a640590ed0a1', NULL, '1', '1', 1, '2022-04-22 13:42:35', NULL, NULL);
INSERT INTO `user_info` VALUES (29, 'ruku', '入库管理员', 'c431d451c81e75ffac75a640590ed0a1', NULL, '1', '1', 1, '2022-04-22 13:50:25', NULL, NULL);
INSERT INTO `user_info` VALUES (30, 'chuku', '出库管理员', 'c431d451c81e75ffac75a640590ed0a1', NULL, '1', '0', 1, '2022-04-22 13:53:20', NULL, NULL);
INSERT INTO `user_info` VALUES (31, 'shangpin', '商品管理员', 'c431d451c81e75ffac75a640590ed0a1', NULL, '1', '1', 1, '2022-04-22 13:57:11', NULL, NULL);
INSERT INTO `user_info` VALUES (32, 'diaohuo', '调货管理员', 'c431d451c81e75ffac75a640590ed0a1', NULL, '1', '1', 1, '2022-04-24 15:23:22', NULL, NULL);
INSERT INTO `user_info` VALUES (33, 'cangku', '仓库管理员', 'c431d451c81e75ffac75a640590ed0a1', NULL, '1', '1', 1, '2022-04-24 15:23:48', NULL, NULL);
INSERT INTO `user_info` VALUES (34, 'demo', '测试账号高', 'c431d451c81e75ffac75a640590ed0a1', NULL, '1', '0', 1, '2023-07-22 11:32:43', 1, '2023-07-23 12:36:31');
INSERT INTO `user_info` VALUES (35, 'test1', '测试账号1', 'c431d451c81e75ffac75a640590ed0a1', NULL, '1', '1', 1, '2023-07-23 11:57:13', NULL, NULL);
INSERT INTO `user_info` VALUES (36, 'test2', '测试账号2', 'c431d451c81e75ffac75a640590ed0a1', NULL, '1', '1', 1, '2023-07-23 11:57:33', NULL, NULL);
INSERT INTO `user_info` VALUES (37, 'test3', '测试账号3', 'c431d451c81e75ffac75a640590ed0a1', NULL, '1', '1', 1, '2023-07-23 11:57:49', NULL, NULL);
INSERT INTO `user_info` VALUES (38, 'halo', 'HALO', 'c431d451c81e75ffac75a640590ed0a1', NULL, '1', '0', 1, '2023-07-23 12:50:32', NULL, NULL);

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `user_role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`user_role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 63 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (11, 3, 7);
INSERT INTO `user_role` VALUES (12, 5, 7);
INSERT INTO `user_role` VALUES (13, 3, 6);
INSERT INTO `user_role` VALUES (14, 5, 6);
INSERT INTO `user_role` VALUES (15, 5, 9);
INSERT INTO `user_role` VALUES (20, 1, 1);
INSERT INTO `user_role` VALUES (23, 3, 5);
INSERT INTO `user_role` VALUES (25, 4, 5);
INSERT INTO `user_role` VALUES (26, 5, 5);
INSERT INTO `user_role` VALUES (27, 5, 19);
INSERT INTO `user_role` VALUES (28, 5, 20);
INSERT INTO `user_role` VALUES (45, 4, 3);
INSERT INTO `user_role` VALUES (46, 3, 3);
INSERT INTO `user_role` VALUES (47, 6, 3);
INSERT INTO `user_role` VALUES (48, 2, 3);
INSERT INTO `user_role` VALUES (49, 11, 28);
INSERT INTO `user_role` VALUES (51, 14, 30);
INSERT INTO `user_role` VALUES (52, 12, 29);
INSERT INTO `user_role` VALUES (53, 13, 31);
INSERT INTO `user_role` VALUES (54, 15, 32);
INSERT INTO `user_role` VALUES (55, 16, 33);
INSERT INTO `user_role` VALUES (56, 11, 34);
INSERT INTO `user_role` VALUES (57, 14, 34);
INSERT INTO `user_role` VALUES (58, 12, 34);
INSERT INTO `user_role` VALUES (62, 19, 38);

SET FOREIGN_KEY_CHECKS = 1;
