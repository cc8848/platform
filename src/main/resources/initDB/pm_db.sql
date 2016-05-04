/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50610
Source Host           : localhost:3306
Source Database       : pm_db

Target Server Type    : MYSQL
Target Server Version : 50610
File Encoding         : 65001

Date: 2016-04-13 19:17:16
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `active_retention`
-- ----------------------------
DROP TABLE IF EXISTS `active_retention`;
CREATE TABLE `active_retention` (
  `gameid` bigint(20) NOT NULL DEFAULT '0' COMMENT '游戏id:游戏产品id (0,第一款盗墓笔记)',
  `gameserverid` bigint(20) NOT NULL DEFAULT '0' COMMENT '游戏服务器唯一id',
  `platformid` bigint(20) NOT NULL DEFAULT '0' COMMENT '平台idplatformid',
  `createtime` datetime NOT NULL COMMENT '统计时间',
  `ru` bigint(20) DEFAULT '0' COMMENT '新增人数',
  `one_day_retained` bigint(20) DEFAULT '0' COMMENT '一日留存',
  `two_day_retained` bigint(20) DEFAULT '0' COMMENT '二日留存',
  `three_day_retained` bigint(20) DEFAULT '0' COMMENT '三日留存',
  `four_day_retained` bigint(20) DEFAULT '0' COMMENT '四日留存',
  `five_day_retained` bigint(20) DEFAULT '0' COMMENT '5日留存',
  `six_day_retained` bigint(20) DEFAULT '0' COMMENT '六日留存',
  `seven_day_retained` bigint(20) DEFAULT '0' COMMENT '七日留存',
  `ten_day_retained` bigint(20) DEFAULT '0' COMMENT '十日留存',
  `fifteen_day_retained` bigint(20) DEFAULT '0' COMMENT '15日留存',
  `thirty_day_retained` bigint(20) DEFAULT '0' COMMENT '30日留存',
  `updatetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`gameid`,`gameserverid`,`platformid`,`createtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of active_retention
-- ----------------------------

-- ----------------------------
-- Table structure for `data_analysis`
-- ----------------------------
DROP TABLE IF EXISTS `data_analysis`;
CREATE TABLE `data_analysis` (
  `gameid` bigint(20) NOT NULL DEFAULT '0' COMMENT '游戏id:游戏产品id (0,第一款盗墓笔记)',
  `gameserverid` bigint(20) NOT NULL DEFAULT '0' COMMENT '游戏服务器唯一id',
  `platformid` bigint(20) NOT NULL DEFAULT '0' COMMENT '平台idplatformid',
  `createtime` datetime NOT NULL COMMENT '统计时间',
  `online_count` bigint(20) DEFAULT '0' COMMENT '当前在线人数',
  `register_role_count` bigint(20) DEFAULT '0' COMMENT '注册角色数',
  `register_accout_count` bigint(20) DEFAULT '0' COMMENT '注册账号数',
  `active_role_count` bigint(20) DEFAULT '0' COMMENT '活跃角色数',
  `active_accout_count` bigint(20) DEFAULT '0' COMMENT '活跃账号数（第三方账号、mac、设备id等）',
  `sumpay_role_count` bigint(20) DEFAULT '0' COMMENT '总充值角色数',
  `sumpay_money` bigint(20) DEFAULT '0' COMMENT '（角色）总充值钱数',
  `sumpay_money_count` bigint(20) DEFAULT '0' COMMENT '（角色）充值总笔数',
  `fispay_role_count` bigint(20) DEFAULT '0' COMMENT '首次充值（角色）人数',
  `fispay_money` bigint(20) DEFAULT '0' COMMENT '首次（角色）充值总钱数',
  `fispay_money_count` bigint(20) DEFAULT '0' COMMENT '首次（角色）充值笔数',
  `arppu` decimal(10,0) DEFAULT '0' COMMENT '平均每付费用户收入，可通过总收入/APA (活跃付费用户数)',
  `arpu` decimal(10,0) DEFAULT '0' COMMENT '平均每用户收入，即可通过 总收入/AU 活跃用户，统计周期内，登录过游戏的用户数',
  `pur` decimal(10,0) DEFAULT '0' COMMENT '付费比率，可通过 APA/AU (活跃付费用户数/活跃用户)',
  `updatetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`gameid`,`gameserverid`,`platformid`,`createtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_analysis
-- ----------------------------

-- ----------------------------
-- Table structure for `game_server`
-- ----------------------------
DROP TABLE IF EXISTS `game_server`;
CREATE TABLE `game_server` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `serverId` bigint(20) DEFAULT NULL COMMENT '服务器id',
  `serverName` varchar(50) DEFAULT NULL COMMENT '服务器名',
  `serverIp` varchar(50) CHARACTER SET utf32 DEFAULT NULL COMMENT '服务器ip',
  `serverPort` varchar(20) DEFAULT NULL COMMENT '服务器端口',
  `creatTime` datetime DEFAULT NULL COMMENT '开服时间',
  `status` tinyint(4) DEFAULT '0' COMMENT '开服状态：0：关闭  1：开启',
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `operator` varchar(50) DEFAULT NULL COMMENT '操作人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of game_server
-- ----------------------------
INSERT INTO `game_server` VALUES ('1', '111', '哈哈', '127.0.0.1', '8000', '2016-03-17 12:27:02', '1', '2016-03-25 11:24:11', 'zhengjun');
INSERT INTO `game_server` VALUES ('2', '1', '圣剑1区', '127.0.0.1', '20', '2016-03-18 09:03:23', '1', '2016-03-25 11:27:30', 'zhengjun');
INSERT INTO `game_server` VALUES ('3', '31', 'jj看看', '127.0.1.1', '111', '2016-03-26 10:03:50', '1', '2016-03-25 18:07:08', 'zhengjun');
INSERT INTO `game_server` VALUES ('4', '11', '21', '127.1.1.1', '43', '2016-03-17 08:03:44', '1', '2016-03-25 18:09:58', 'zhengjun');

-- ----------------------------
-- Table structure for `gm_tool_log`
-- ----------------------------
DROP TABLE IF EXISTS `gm_tool_log`;
CREATE TABLE `gm_tool_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `gameid` bigint(20) DEFAULT NULL COMMENT '游戏id:游戏产品id',
  `gameserverid` bigint(20) DEFAULT NULL COMMENT '游戏服务器唯一id',
  `platformid` bigint(20) DEFAULT NULL COMMENT '平台idplatformid',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `accountid` bigint(20) DEFAULT NULL COMMENT '用户id',
  `name` varchar(20) DEFAULT NULL COMMENT '角色名',
  `type` int(4) DEFAULT NULL COMMENT '操作码（0：金钱 1：体力 2:血量 4：物品：）',
  `itemId` bigint(20) DEFAULT NULL COMMENT '物品id  技能id 等',
  `rewardNum
奖励

rewardNum` bigint(20) DEFAULT '0' COMMENT '奖励数量--物品数量  等级数 钻石数  ',
  `incomeNum` bigint(20) DEFAULT '0' COMMENT '扣除数量（物品数量  等级数 钻石数  ）',
  `status` int(4) DEFAULT '0' COMMENT '执行状态(0:成功 1：失败）',
  `operator` varchar(20) DEFAULT NULL COMMENT '操作人',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of gm_tool_log
-- ----------------------------

-- ----------------------------
-- Table structure for `pay_retention`
-- ----------------------------
DROP TABLE IF EXISTS `pay_retention`;
CREATE TABLE `pay_retention` (
  `gameid` bigint(20) NOT NULL DEFAULT '0' COMMENT '游戏id:游戏产品id (0,第一款盗墓笔记)',
  `gameserverid` bigint(20) NOT NULL DEFAULT '0' COMMENT '游戏服务器唯一id',
  `platformid` bigint(20) NOT NULL DEFAULT '0' COMMENT '平台idplatformid',
  `createtime` datetime NOT NULL COMMENT '统计时间',
  `fispu` bigint(20) DEFAULT '0' COMMENT '首次付费人数',
  `one_day_retained` bigint(20) DEFAULT '0' COMMENT '一日留存',
  `two_day_retained` bigint(20) DEFAULT '0' COMMENT '二日留存',
  `three_day_retained` bigint(20) DEFAULT '0' COMMENT '三日留存',
  `four_day_retained` bigint(20) DEFAULT '0' COMMENT '四日留存',
  `five_day_retained` bigint(20) DEFAULT '0' COMMENT '5日留存',
  `six_day_retained` bigint(20) DEFAULT '0' COMMENT '六日留存',
  `seven_day_retained` bigint(20) DEFAULT '0' COMMENT '七日留存',
  `ten_day_retained` bigint(20) DEFAULT '0' COMMENT '10日留存',
  `fifteen_day_retained` bigint(20) DEFAULT '0' COMMENT '15日留存',
  `thirty_day_retained` bigint(20) DEFAULT '0' COMMENT '30日留存',
  `updatetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`gameid`,`gameserverid`,`platformid`,`createtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of pay_retention
-- ----------------------------

-- ----------------------------
-- Table structure for `resources`
-- ----------------------------
DROP TABLE IF EXISTS `resources`;
CREATE TABLE `resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(50) DEFAULT NULL COMMENT '资源名称',
  `parentId` int(11) DEFAULT NULL COMMENT '父节点',
  `resKey` varchar(50) DEFAULT NULL COMMENT '资源key',
  `type` int(2) DEFAULT NULL COMMENT '资源类型（0：目录 1：菜单）',
  `resUrl` varchar(250) DEFAULT NULL COMMENT '资源链接',
  `level` int(11) DEFAULT NULL COMMENT '级别',
  `description` varchar(50) DEFAULT NULL COMMENT '描述',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态：0 正常   1 隐藏',
  `operator` varchar(20) DEFAULT NULL COMMENT '操作人',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `pid` int(11) DEFAULT '0' COMMENT '顺序号',
  `delete_flag` tinyint(2) DEFAULT '0' COMMENT '伦理删除标志（0：正常；1：伦理删除）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of resources
-- ----------------------------
INSERT INTO `resources` VALUES ('1', '系统基础管理', '0', 'sys_mana', '0', '', '1', '管理角色，菜单', '0', '', '2015-09-10 17:02:16', '2015-08-12 16:31:11', '0', '0');
INSERT INTO `resources` VALUES ('2', '角色管理', '1', 'sys_mana_role', '1', 'role/roleList', '2', '创建角色', '0', '', '2015-08-31 15:00:48', '2015-08-12 16:33:50', '1', '0');
INSERT INTO `resources` VALUES ('3', '菜单管理', '1', 'sys_mana_menu', '1', 'resources/list', '2', '菜单新增，编辑，删除', '0', '', '2015-08-31 15:01:08', '2015-08-12 16:35:19', '2', '0');
INSERT INTO `resources` VALUES ('4', '用户管理', '0', 'user_mana', '0', '', '1', '用户管理目录', '0', '', '2015-12-02 17:07:10', '2015-12-02 17:07:07', '2', '0');
INSERT INTO `resources` VALUES ('5', '个人信息', '4', 'user_mana_personalInfo', '1', 'user/getUserInfoByUserKey', '2', '个人信息管理', '0', '', '2015-12-02 17:08:25', '2015-12-02 17:08:22', '0', '0');
INSERT INTO `resources` VALUES ('6', '用户列表', '4', 'user_mana_list', '1', 'user/userInfoList', '2', '用户列表，以及管理', '0', '', '2015-12-03 17:01:32', '2015-12-02 17:13:42', '1', '0');
INSERT INTO `resources` VALUES ('26', '服务器管理', '0', 'game_server', '0', '', '1', '游戏服务器管理', '0', 'zhengjun', '2016-03-22 16:47:15', '2016-03-22 16:46:11', '3', '0');
INSERT INTO `resources` VALUES ('27', '平台日志管理', '1', 'log_manager', '1', 'user/userLogsList', '2', '平台日志管理', '0', 'zhengjun', '2016-03-22 20:41:55', '2016-03-22 20:41:54', '3', '0');
INSERT INTO `resources` VALUES ('28', '服务器列表', '26', 'game_server_list', '1', 'game/gameServerList', '2', '服务器列表', '0', 'zhengjun', '2016-03-24 12:16:33', '2016-03-24 12:16:33', '0', '0');
INSERT INTO `resources` VALUES ('29', '数据分析', '0', 'data_analysis', '0', '', '1', '数据分析', '0', 'zhengjun', '2016-03-25 11:44:22', '2016-03-25 11:32:45', '4', '0');
INSERT INTO `resources` VALUES ('30', 'GM功能', '0', 'gm_tool', '0', '', '1', 'GM功能', '0', 'zhengjun', '2016-03-25 11:36:56', '2016-03-25 11:36:55', '5', '0');
INSERT INTO `resources` VALUES ('31', '日关键数据', '29', 'data_day_analysis', '1', 'data/dataDayAnalysis', '2', '日关键数据', '0', 'zhengjun', '2016-03-29 14:46:20', '2016-03-29 14:46:19', '0', '0');
INSERT INTO `resources` VALUES ('32', '玩家实时查询', '30', 'user_info', '1', 'tool/usersInfoList', '2', '玩家实时查询', '0', 'zhengjun', '2016-03-30 10:30:26', '2016-03-30 10:30:25', '0', '0');
INSERT INTO `resources` VALUES ('33', '日留存', '29', 'user_day_active_retention', '1', 'data/userDayActiveRetention', '2', '日留存', '0', 'zhengjun', '2016-04-01 14:17:45', '2016-04-01 14:17:44', '1', '0');
INSERT INTO `resources` VALUES ('34', '发公告', '30', 'announcement', '1', 'tool/announcementInfoList', '2', '发公告', '0', 'zhengjun', '2016-04-11 16:42:03', '2016-04-11 16:42:02', '1', '0');
INSERT INTO `resources` VALUES ('35', '发邮件', '30', 'send_email', '1', 'tool/emailInfoList', '2', '发邮件', '0', 'zhengjun', '2016-04-12 14:45:20', '2016-04-11 16:43:58', '2', '0');
INSERT INTO `resources` VALUES ('36', '禁言|封号管理', '30', 'game_banned', '1', 'tool/gameBannedInfoList', '2', '禁言|封号', '0', 'zhengjun', '2016-04-13 14:35:03', '2016-04-13 14:35:02', '3', '0');
INSERT INTO `resources` VALUES ('37', '发物品', '30', 'game_reward', '1', 'tool/gameRewardInfoList', '2', '给玩家发放物品（资源，等级、体力、金钱、钻石）', '0', 'zhengjun', '2016-04-13 14:39:38', '2016-04-13 14:39:38', '4', '0');
INSERT INTO `resources` VALUES ('38', 'ckey激活码管理', '30', 'ckey', '1', 'tool/gameCkeyInfoList', '2', 'ckey激活码--礼包生成', '0', 'zhengjun', '2016-04-13 14:42:48', '2016-04-13 14:42:48', '5', '0');

-- ----------------------------
-- Table structure for `resources_role`
-- ----------------------------
DROP TABLE IF EXISTS `resources_role`;
CREATE TABLE `resources_role` (
  `resc_id` int(11) NOT NULL COMMENT '资源id',
  `role_id` int(11) NOT NULL COMMENT '角色id',
  PRIMARY KEY (`resc_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of resources_role
-- ----------------------------
INSERT INTO `resources_role` VALUES ('1', '1');
INSERT INTO `resources_role` VALUES ('2', '1');
INSERT INTO `resources_role` VALUES ('3', '1');
INSERT INTO `resources_role` VALUES ('4', '1');
INSERT INTO `resources_role` VALUES ('4', '2');
INSERT INTO `resources_role` VALUES ('4', '4');
INSERT INTO `resources_role` VALUES ('5', '1');
INSERT INTO `resources_role` VALUES ('5', '2');
INSERT INTO `resources_role` VALUES ('5', '4');
INSERT INTO `resources_role` VALUES ('6', '1');
INSERT INTO `resources_role` VALUES ('6', '4');
INSERT INTO `resources_role` VALUES ('18', '4');
INSERT INTO `resources_role` VALUES ('19', '4');
INSERT INTO `resources_role` VALUES ('20', '2');
INSERT INTO `resources_role` VALUES ('21', '2');
INSERT INTO `resources_role` VALUES ('22', '2');
INSERT INTO `resources_role` VALUES ('23', '2');
INSERT INTO `resources_role` VALUES ('24', '2');
INSERT INTO `resources_role` VALUES ('25', '4');
INSERT INTO `resources_role` VALUES ('26', '1');
INSERT INTO `resources_role` VALUES ('27', '1');
INSERT INTO `resources_role` VALUES ('28', '1');
INSERT INTO `resources_role` VALUES ('29', '1');
INSERT INTO `resources_role` VALUES ('30', '1');
INSERT INTO `resources_role` VALUES ('31', '1');
INSERT INTO `resources_role` VALUES ('32', '1');
INSERT INTO `resources_role` VALUES ('33', '1');
INSERT INTO `resources_role` VALUES ('34', '1');
INSERT INTO `resources_role` VALUES ('35', '1');
INSERT INTO `resources_role` VALUES ('36', '1');
INSERT INTO `resources_role` VALUES ('37', '1');
INSERT INTO `resources_role` VALUES ('38', '1');

-- ----------------------------
-- Table structure for `role`
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `role_name` varchar(32) DEFAULT NULL COMMENT '角色名',
  `role_sign` varchar(32) DEFAULT NULL COMMENT '角色标识,程序中判断使用,如"admin"',
  `description` varchar(50) DEFAULT NULL COMMENT '角色描述,UI界面显示使用',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态：0 正常 1 失效',
  `operator` varchar(20) DEFAULT NULL COMMENT '操作人',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='角色表';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '超级管理员', 'superAdmin', '超级管理员：所有权限', '0', 'lvjincheng', '2015-12-03 15:06:45', '2015-12-03 15:06:45');
INSERT INTO `role` VALUES ('5', '产品人员', 'productUser', '产品', '0', 'zhengjun', '2016-03-22 17:37:59', '2016-03-22 17:37:59');
INSERT INTO `role` VALUES ('6', '运营人员', 'operationalUser', '运营', '0', 'zhengjun', '2016-03-22 17:38:42', '2016-03-22 17:38:42');
INSERT INTO `role` VALUES ('7', '研发', 'openUser', '研发', '0', 'zhengjun', '2016-03-22 17:39:09', '2016-03-22 17:39:09');
INSERT INTO `role` VALUES ('8', '平台管理员', 'openAdmin', '平台管理员', '0', 'zhengjun', '2016-03-22 17:39:49', '2016-03-22 17:39:49');

-- ----------------------------
-- Table structure for `user_info`
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_key` varchar(255) NOT NULL COMMENT '用户key',
  `user_mobile` varchar(255) DEFAULT NULL COMMENT '手机号',
  `password` varchar(255) NOT NULL COMMENT '登录密码',
  `groupname` varchar(255) DEFAULT NULL COMMENT '组名',
  `email` varchar(30) DEFAULT NULL,
  `log_level` int(11) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `role` varchar(25) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT '0--启用；1--禁用',
  `team_id` int(11) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `operator` varchar(255) DEFAULT NULL,
  `bank` varchar(100) DEFAULT NULL COMMENT '开户银行',
  `id_number` varchar(20) DEFAULT NULL COMMENT '用户详细补充内容--身份证号码',
  `bank_card` varchar(50) DEFAULT NULL COMMENT '银行卡',
  `province` varchar(100) DEFAULT NULL COMMENT '省份',
  `city` varchar(100) DEFAULT NULL COMMENT '城市--地级市',
  `county` varchar(100) DEFAULT NULL COMMENT '县级市',
  `bank_subbranch` varchar(255) DEFAULT NULL COMMENT '支行名称--xxx支行xxx分理处',
  `readid` int(8) DEFAULT NULL COMMENT '已阅读最新公告Id--',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_key` (`user_key`) USING BTREE,
  KEY `index_userKey_Mobile` (`user_key`,`user_mobile`) USING BTREE,
  KEY `index_password` (`password`) USING BTREE,
  KEY `idx_groupname` (`groupname`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES ('1', 'zhengjun', '0', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'superAdmin', '', '0', 'zhengjun', '', '0', null, '2015-12-01 16:58:26', '2016-03-22 17:36:10', '', '', '1', '', '', '', '', '', null);
INSERT INTO `user_info` VALUES ('31', 'open1', null, '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'openUser', null, null, 'open1', null, '0', null, '2016-03-22 19:14:22', '2016-03-22 19:15:03', 'zhengjun', null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for `user_log`
-- ----------------------------
DROP TABLE IF EXISTS `user_log`;
CREATE TABLE `user_log` (
  `id` bigint(80) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `login_name` varchar(50) NOT NULL COMMENT '操作人',
  `login_ip` varchar(200) DEFAULT NULL COMMENT 'ip',
  `createTime` datetime DEFAULT NULL COMMENT '操作时间',
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `operation` varchar(50) DEFAULT NULL COMMENT '操作描述：“用户登陆，用户退出、查看服务器列表，添加用户，删除用户等等”',
  `log_level` tinyint(2) DEFAULT '0' COMMENT '日志级别：0:登陆、退出  1：查看、2：新增、编辑、删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_log
-- ----------------------------
INSERT INTO `user_log` VALUES ('43', 'open1', '192.168.0.144', '2016-03-23 11:42:11', '2016-03-23 11:42:11', 'open1登陆成功！', '0');
INSERT INTO `user_log` VALUES ('44', 'open1', '192.168.0.144', '2016-03-23 11:42:11', '2016-03-23 11:42:11', 'open1登陆成功！', '0');
INSERT INTO `user_log` VALUES ('45', 'open1', '192.168.0.144', '2016-03-23 11:42:16', '2016-03-23 11:42:16', 'open1登出成功！', '0');
INSERT INTO `user_log` VALUES ('46', 'zhengjun', '192.168.0.144', '2016-03-23 11:42:23', '2016-03-23 11:42:23', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('47', 'zhengjun', '192.168.0.144', '2016-03-23 11:42:43', '2016-03-23 11:42:43', 'zhengjun登出成功！', '0');
INSERT INTO `user_log` VALUES ('48', 'zhengjun', '192.168.0.144', '2016-03-23 11:42:51', '2016-03-23 11:42:51', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('49', 'zhengjun', '192.168.0.144', '2016-03-23 11:42:51', '2016-03-23 11:42:51', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('50', 'zhengjun', '192.168.0.144', '2016-03-23 11:43:16', '2016-03-23 11:43:16', 'zhengjun登出成功！', '0');
INSERT INTO `user_log` VALUES ('51', 'zhengjun', '192.168.0.144', '2016-03-23 11:43:21', '2016-03-23 11:43:21', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('52', 'zhengjun', '192.168.0.144', '2016-03-23 11:43:21', '2016-03-23 11:43:21', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('53', 'zhengjun', '192.168.0.144', '2016-03-23 11:48:04', '2016-03-23 11:48:04', 'zhengjun登出成功！', '0');
INSERT INTO `user_log` VALUES ('54', 'zhengjun', '192.168.0.144', '2016-03-23 11:48:09', '2016-03-23 11:48:09', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('55', 'zhengjun', '192.168.0.144', '2016-03-23 11:48:09', '2016-03-23 11:48:09', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('56', 'zhengjun', '192.168.0.144', '2016-03-23 11:55:36', '2016-03-23 11:55:36', 'zhengjun登出成功！', '0');
INSERT INTO `user_log` VALUES ('57', 'zhengjun', '192.168.0.144', '2016-03-23 11:56:33', '2016-03-23 11:56:33', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('58', 'zhengjun', '192.168.0.144', '2016-03-23 11:56:33', '2016-03-23 11:56:33', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('59', 'zhengjun', '192.168.0.144', '2016-03-23 11:58:00', '2016-03-23 11:58:00', 'zhengjun登出成功！', '0');
INSERT INTO `user_log` VALUES ('60', 'zhengjun', '192.168.0.144', '2016-03-23 11:58:11', '2016-03-23 11:58:11', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('61', 'zhengjun', '192.168.0.144', '2016-03-23 11:58:11', '2016-03-23 11:58:11', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('62', 'zhengjun', '192.168.0.144', '2016-03-23 19:48:39', '2016-03-23 19:48:39', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('63', 'zhengjun', '192.168.0.144', '2016-03-23 19:48:39', '2016-03-23 19:48:39', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('64', 'zhengjun', '192.168.0.144', '2016-03-23 20:39:02', '2016-03-23 20:39:02', 'zhengjun登出成功！', '0');
INSERT INTO `user_log` VALUES ('65', 'zhengjun', '192.168.0.144', '2016-03-23 20:39:10', '2016-03-23 20:39:10', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('66', 'zhengjun', '192.168.0.144', '2016-03-23 20:39:32', '2016-03-23 20:39:32', 'zhengjun登出成功！', '0');
INSERT INTO `user_log` VALUES ('67', 'zhengjun', '192.168.0.144', '2016-03-24 12:15:36', '2016-03-24 12:15:36', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('68', 'zhengjun', '192.168.0.144', '2016-03-24 12:15:36', '2016-03-24 12:15:36', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('69', 'zhengjun', '192.168.0.144', '2016-03-24 12:43:34', '2016-03-24 12:43:34', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('70', 'zhengjun', '192.168.0.144', '2016-03-24 12:43:34', '2016-03-24 12:43:34', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('71', 'zhengjun', '192.168.0.144', '2016-03-25 10:49:59', '2016-03-25 10:49:59', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('72', 'zhengjun', '192.168.0.144', '2016-03-25 10:49:59', '2016-03-25 10:49:59', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('73', 'zhengjun', '192.168.0.144', '2016-03-25 18:04:45', '2016-03-25 18:04:45', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('74', 'zhengjun', '192.168.0.144', '2016-03-25 18:04:45', '2016-03-25 18:04:45', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('75', 'zhengjun', '192.168.0.144', '2016-03-25 18:06:44', '2016-03-25 18:06:44', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('76', 'zhengjun', '192.168.0.144', '2016-03-25 18:06:44', '2016-03-25 18:06:44', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('77', 'zhengjun', '192.168.0.144', '2016-03-25 18:06:45', '2016-03-25 18:06:45', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('78', 'zhengjun', '192.168.0.144', '2016-03-25 18:22:32', '2016-03-25 18:22:32', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('79', 'zhengjun', '192.168.0.144', '2016-03-25 18:22:32', '2016-03-25 18:22:32', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('80', 'zhengjun', '192.168.0.144', '2016-03-28 15:23:55', '2016-03-28 15:23:55', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('81', 'zhengjun', '192.168.0.144', '2016-03-28 15:23:55', '2016-03-28 15:23:55', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('82', 'zhengjun', '192.168.0.144', '2016-03-29 10:12:20', '2016-03-29 10:12:20', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('83', 'zhengjun', '192.168.0.144', '2016-03-29 10:12:20', '2016-03-29 10:12:20', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('84', 'zhengjun', '192.168.0.144', '2016-03-30 09:45:50', '2016-03-30 09:45:50', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('85', 'zhengjun', '192.168.0.144', '2016-03-30 09:45:50', '2016-03-30 09:45:50', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('86', 'zhengjun', '192.168.0.144', '2016-03-30 09:47:59', '2016-03-30 09:47:59', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('87', 'zhengjun', '192.168.0.144', '2016-03-30 09:47:59', '2016-03-30 09:47:59', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('88', 'zhengjun', '192.168.0.144', '2016-03-30 09:49:07', '2016-03-30 09:49:07', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('89', 'zhengjun', '192.168.0.144', '2016-03-30 09:49:07', '2016-03-30 09:49:07', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('90', 'zhengjun', '192.168.0.144', '2016-03-30 09:58:34', '2016-03-30 09:58:34', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('91', 'zhengjun', '192.168.0.144', '2016-03-30 09:58:34', '2016-03-30 09:58:34', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('92', 'zhengjun', '192.168.0.144', '2016-03-30 09:58:43', '2016-03-30 09:58:43', 'zhengjun登出成功！', '0');
INSERT INTO `user_log` VALUES ('93', 'zhengjun', '192.168.0.144', '2016-03-30 09:59:07', '2016-03-30 09:59:07', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('94', 'zhengjun', '192.168.0.144', '2016-03-30 09:59:07', '2016-03-30 09:59:07', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('95', 'zhengjun', '192.168.0.144', '2016-03-30 16:53:47', '2016-03-30 16:53:47', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('96', 'zhengjun', '192.168.0.144', '2016-03-30 16:53:47', '2016-03-30 16:53:47', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('97', 'zhengjun', '192.168.0.144', '2016-03-30 17:07:00', '2016-03-30 17:07:00', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('98', 'zhengjun', '192.168.0.144', '2016-03-30 17:07:00', '2016-03-30 17:07:00', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('99', 'zhengjun', '192.168.0.144', '2016-03-30 17:07:56', '2016-03-30 17:07:56', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('100', 'zhengjun', '192.168.0.144', '2016-03-30 17:07:56', '2016-03-30 17:07:56', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('101', 'zhengjun', '192.168.0.144', '2016-03-31 10:06:26', '2016-03-31 10:06:26', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('102', 'zhengjun', '192.168.0.144', '2016-03-31 10:06:26', '2016-03-31 10:06:26', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('103', 'zhengjun', '192.168.0.144', '2016-03-31 16:09:37', '2016-03-31 16:09:37', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('104', 'zhengjun', '192.168.0.144', '2016-03-31 16:09:37', '2016-03-31 16:09:37', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('105', 'zhengjun', '192.168.0.144', '2016-03-31 16:11:40', '2016-03-31 16:11:40', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('106', 'zhengjun', '192.168.0.144', '2016-03-31 16:11:40', '2016-03-31 16:11:40', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('107', 'zhengjun', '192.168.0.144', '2016-03-31 16:37:40', '2016-03-31 16:37:40', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('108', 'zhengjun', '192.168.0.144', '2016-03-31 16:37:40', '2016-03-31 16:37:40', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('109', 'zhengjun', '192.168.0.144', '2016-03-31 17:05:37', '2016-03-31 17:05:37', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('110', 'zhengjun', '192.168.0.144', '2016-03-31 17:05:37', '2016-03-31 17:05:37', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('111', 'zhengjun', '192.168.0.144', '2016-03-31 17:14:46', '2016-03-31 17:14:46', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('112', 'zhengjun', '192.168.0.144', '2016-03-31 17:14:46', '2016-03-31 17:14:46', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('113', 'zhengjun', '192.168.0.144', '2016-03-31 17:24:15', '2016-03-31 17:24:15', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('114', 'zhengjun', '192.168.0.144', '2016-04-01 14:16:44', '2016-04-01 14:16:44', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('115', 'zhengjun', '192.168.0.144', '2016-04-01 14:16:44', '2016-04-01 14:16:44', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('116', 'zhengjun', '192.168.0.144', '2016-04-05 12:05:54', '2016-04-05 12:05:54', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('117', 'zhengjun', '192.168.0.144', '2016-04-05 12:05:54', '2016-04-05 12:05:54', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('118', 'zhengjun', '192.168.0.144', '2016-04-09 15:31:22', '2016-04-09 15:31:22', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('119', 'zhengjun', '192.168.0.144', '2016-04-11 13:42:05', '2016-04-11 13:42:05', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('120', 'zhengjun', '192.168.0.144', '2016-04-11 13:42:05', '2016-04-11 13:42:05', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('121', 'zhengjun', '192.168.0.144', '2016-04-11 15:22:52', '2016-04-11 15:22:52', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('122', 'zhengjun', '192.168.0.144', '2016-04-11 15:22:51', '2016-04-11 15:22:51', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('123', 'zhengjun', '192.168.0.144', '2016-04-11 16:09:14', '2016-04-11 16:09:14', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('124', 'zhengjun', '192.168.0.144', '2016-04-11 16:09:14', '2016-04-11 16:09:14', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('125', 'zhengjun', '192.168.0.144', '2016-04-11 16:13:55', '2016-04-11 16:13:55', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('126', 'zhengjun', '192.168.0.144', '2016-04-11 16:15:40', '2016-04-11 16:15:40', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('127', 'zhengjun', '192.168.0.144', '2016-04-11 16:15:40', '2016-04-11 16:15:40', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('128', 'zhengjun', '192.168.0.144', '2016-04-12 10:40:13', '2016-04-12 10:40:13', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('129', 'zhengjun', '192.168.0.144', '2016-04-12 10:40:13', '2016-04-12 10:40:13', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('130', 'zhengjun', '192.168.0.144', '2016-04-13 13:51:34', '2016-04-13 13:51:34', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('131', 'zhengjun', '192.168.0.144', '2016-04-13 13:51:34', '2016-04-13 13:51:34', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('132', 'zhengjun', '192.168.0.144', '2016-04-13 14:01:07', '2016-04-13 14:01:07', 'zhengjun登陆成功！', '0');
INSERT INTO `user_log` VALUES ('133', 'zhengjun', '192.168.0.144', '2016-04-13 16:48:08', '2016-04-13 16:48:08', 'zhengjun登出成功！', '0');
