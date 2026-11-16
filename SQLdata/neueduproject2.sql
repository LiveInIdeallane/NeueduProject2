/*
 Navicat Premium Data Transfer

 Source Server         : java
 Source Server Type    : MySQL
 Source Server Version : 80041 (8.0.41)
 Source Host           : localhost:3306
 Source Schema         : neueduproject2

 Target Server Type    : MySQL
 Target Server Version : 80041 (8.0.41)
 File Encoding         : 65001

 Date: 16/11/2026 11:33:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for checkitem
-- ----------------------------
DROP TABLE IF EXISTS `checkitem`;
CREATE TABLE `checkitem`  (
  `ciId` int NOT NULL AUTO_INCREMENT COMMENT '检查项编号',
  `ciName` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '检查项名称',
  `ciContent` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '检查项内容',
  `meaning` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '检查项意义',
  `remarks` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ciId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '体检项信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of checkitem
-- ----------------------------
INSERT INTO `checkitem` VALUES (1, '血常规', '检测血液中各类细胞数量', '判断贫血、感染等', '');
INSERT INTO `checkitem` VALUES (2, '肝功能', '检测转氨酶、胆红素等指标', '评估肝脏功能', '');
INSERT INTO `checkitem` VALUES (3, '肾功能', '检测肌酐、尿素氮等指标', '评估肾脏功能', '');
INSERT INTO `checkitem` VALUES (4, '心电图', '记录心脏电活动', '筛查心律失常、心肌缺血', '');
INSERT INTO `checkitem` VALUES (5, '胸部CT', '胸部断层扫描', '筛查肺部及胸腔疾病', '');
INSERT INTO `checkitem` VALUES (6, '尿常规', '检测尿液成分', '筛查泌尿系统疾病', '');

-- ----------------------------
-- Table structure for checkitemdetailed
-- ----------------------------
DROP TABLE IF EXISTS `checkitemdetailed`;
CREATE TABLE `checkitemdetailed`  (
  `cdId` int NOT NULL AUTO_INCREMENT COMMENT '检查项明细编号',
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '检查项明细名称',
  `unit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '检查项明细单位',
  `minrange` double NULL DEFAULT NULL COMMENT '正常值范围最小值',
  `maxrange` double NULL DEFAULT NULL COMMENT '正常值范围最大值',
  `normalValue` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '正常值(非数字型)',
  `normalValueString` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '验证范围说明文字',
  `type` int NOT NULL COMMENT '类型(1:数值范围;2:数值相等;3:无需验证;4:描述型;5:其它)',
  `ciId` int NOT NULL COMMENT '所属检查项编号',
  `remarks` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`cdId`) USING BTREE,
  INDEX `idx_cd_ciId`(`ciId` ASC) USING BTREE,
  CONSTRAINT `fk_cd_checkitem` FOREIGN KEY (`ciId`) REFERENCES `checkitem` (`ciId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '体检项明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of checkitemdetailed
-- ----------------------------
INSERT INTO `checkitemdetailed` VALUES (1, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, 1, '');
INSERT INTO `checkitemdetailed` VALUES (2, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, 1, '');
INSERT INTO `checkitemdetailed` VALUES (3, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, 1, '');
INSERT INTO `checkitemdetailed` VALUES (4, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, 2, '');
INSERT INTO `checkitemdetailed` VALUES (5, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, 2, '');
INSERT INTO `checkitemdetailed` VALUES (6, '肌酐', 'umol/L', 44, 115, NULL, '44 - 115', 1, 3, '');
INSERT INTO `checkitemdetailed` VALUES (7, '尿素氮', 'mmol/L', 2.9, 8.2, NULL, '2.9 - 8.2', 1, 3, '');
INSERT INTO `checkitemdetailed` VALUES (8, '心电图结论', NULL, NULL, NULL, NULL, '', 4, 4, '');
INSERT INTO `checkitemdetailed` VALUES (9, '胸部CT结论', NULL, NULL, NULL, NULL, '', 4, 5, '');
INSERT INTO `checkitemdetailed` VALUES (10, '尿蛋白', NULL, NULL, NULL, '-', '阴性', 2, 6, '');
INSERT INTO `checkitemdetailed` VALUES (11, '尿糖', NULL, NULL, NULL, '-', '阴性', 2, 6, '');

-- ----------------------------
-- Table structure for cidetaliedreport
-- ----------------------------
DROP TABLE IF EXISTS `cidetaliedreport`;
CREATE TABLE `cidetaliedreport`  (
  `cidrId` int NOT NULL AUTO_INCREMENT COMMENT '检查项明细报告编号',
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '检查项明细名称',
  `unit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '检查项明细单位',
  `minrange` double NULL DEFAULT NULL COMMENT '正常值范围最小值',
  `maxrange` double NULL DEFAULT NULL COMMENT '正常值范围最大值',
  `normalValue` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '正常值(非数字型)',
  `normalValueString` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '验证范围说明文字',
  `type` int NOT NULL COMMENT '类型(1:数值范围;2:数值相等;3:无需验证;4:描述型;5:其它)',
  `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '检查项目明细值',
  `isError` int NOT NULL COMMENT '是否异常(0:无异常;1:异常)',
  `ciId` int NOT NULL COMMENT '所属检查项报告编号',
  `orderId` int NOT NULL COMMENT '所属预约编号',
  PRIMARY KEY (`cidrId`) USING BTREE,
  INDEX `idx_cidr_ciId`(`ciId` ASC) USING BTREE,
  INDEX `idx_cidr_orderId`(`orderId` ASC) USING BTREE,
  CONSTRAINT `fk_cidr_cireport` FOREIGN KEY (`ciId`) REFERENCES `cireport` (`cirId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_cidr_orders` FOREIGN KEY (`orderId`) REFERENCES `orders` (`orderId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 318 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '体检报告检查项明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cidetaliedreport
-- ----------------------------
INSERT INTO `cidetaliedreport` VALUES (16, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 9, 3);
INSERT INTO `cidetaliedreport` VALUES (17, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 9, 3);
INSERT INTO `cidetaliedreport` VALUES (18, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 9, 3);
INSERT INTO `cidetaliedreport` VALUES (19, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 10, 3);
INSERT INTO `cidetaliedreport` VALUES (20, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '28.5', 1, 10, 3);
INSERT INTO `cidetaliedreport` VALUES (21, '肌酐', 'umol/L', 44, 115, NULL, '44 - 115', 1, '80', 0, 11, 3);
INSERT INTO `cidetaliedreport` VALUES (22, '尿素氮', 'mmol/L', 2.9, 8.2, NULL, '2.9 - 8.2', 1, '5.6', 0, 11, 3);
INSERT INTO `cidetaliedreport` VALUES (23, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 12, 3);
INSERT INTO `cidetaliedreport` VALUES (24, '胸部CT结论', NULL, NULL, NULL, NULL, '', 4, '双肺纹理清晰，未见明显异常', 0, 13, 3);
INSERT INTO `cidetaliedreport` VALUES (25, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '18', 1, 14, 4);
INSERT INTO `cidetaliedreport` VALUES (26, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 14, 4);
INSERT INTO `cidetaliedreport` VALUES (27, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 14, 4);
INSERT INTO `cidetaliedreport` VALUES (28, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 15, 4);
INSERT INTO `cidetaliedreport` VALUES (29, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 15, 4);
INSERT INTO `cidetaliedreport` VALUES (30, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 16, 4);
INSERT INTO `cidetaliedreport` VALUES (31, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 17, 5);
INSERT INTO `cidetaliedreport` VALUES (32, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 17, 5);
INSERT INTO `cidetaliedreport` VALUES (33, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 17, 5);
INSERT INTO `cidetaliedreport` VALUES (34, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 18, 5);
INSERT INTO `cidetaliedreport` VALUES (35, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '28.5', 1, 18, 5);
INSERT INTO `cidetaliedreport` VALUES (36, '肌酐', 'umol/L', 44, 115, NULL, '44 - 115', 1, '80', 0, 19, 5);
INSERT INTO `cidetaliedreport` VALUES (37, '尿素氮', 'mmol/L', 2.9, 8.2, NULL, '2.9 - 8.2', 1, '5.6', 0, 19, 5);
INSERT INTO `cidetaliedreport` VALUES (38, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 20, 5);
INSERT INTO `cidetaliedreport` VALUES (39, '胸部CT结论', NULL, NULL, NULL, NULL, '', 4, '双肺纹理清晰，未见明显异常', 0, 21, 5);
INSERT INTO `cidetaliedreport` VALUES (40, '尿蛋白', NULL, NULL, NULL, '-', '阴性', 2, '+', 1, 22, 5);
INSERT INTO `cidetaliedreport` VALUES (41, '尿糖', NULL, NULL, NULL, '-', '阴性', 2, '-', 0, 22, 5);
INSERT INTO `cidetaliedreport` VALUES (42, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 23, 6);
INSERT INTO `cidetaliedreport` VALUES (43, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 23, 6);
INSERT INTO `cidetaliedreport` VALUES (44, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 23, 6);
INSERT INTO `cidetaliedreport` VALUES (45, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '48', 1, 24, 6);
INSERT INTO `cidetaliedreport` VALUES (46, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 24, 6);
INSERT INTO `cidetaliedreport` VALUES (47, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 25, 6);
INSERT INTO `cidetaliedreport` VALUES (48, '尿蛋白', NULL, NULL, NULL, '-', '阴性', 2, '-', 0, 26, 6);
INSERT INTO `cidetaliedreport` VALUES (49, '尿糖', NULL, NULL, NULL, '-', '阴性', 2, '-', 0, 26, 6);
INSERT INTO `cidetaliedreport` VALUES (50, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '18', 1, 27, 7);
INSERT INTO `cidetaliedreport` VALUES (51, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 27, 7);
INSERT INTO `cidetaliedreport` VALUES (52, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 27, 7);
INSERT INTO `cidetaliedreport` VALUES (53, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 28, 7);
INSERT INTO `cidetaliedreport` VALUES (54, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 28, 7);
INSERT INTO `cidetaliedreport` VALUES (55, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 29, 7);
INSERT INTO `cidetaliedreport` VALUES (56, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 30, 8);
INSERT INTO `cidetaliedreport` VALUES (57, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 30, 8);
INSERT INTO `cidetaliedreport` VALUES (58, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '137', 0, 30, 8);
INSERT INTO `cidetaliedreport` VALUES (59, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 31, 8);
INSERT INTO `cidetaliedreport` VALUES (60, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '28.5', 1, 31, 8);
INSERT INTO `cidetaliedreport` VALUES (61, '肌酐', 'umol/L', 44, 115, NULL, '44 - 115', 1, '80', 0, 32, 8);
INSERT INTO `cidetaliedreport` VALUES (62, '尿素氮', 'mmol/L', 2.9, 8.2, NULL, '2.9 - 8.2', 1, '5.6', 0, 32, 8);
INSERT INTO `cidetaliedreport` VALUES (63, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 33, 8);
INSERT INTO `cidetaliedreport` VALUES (64, '胸部CT结论', NULL, NULL, NULL, NULL, '', 4, '双肺纹理清晰，正常', 0, 34, 8);
INSERT INTO `cidetaliedreport` VALUES (65, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '18', 1, 35, 9);
INSERT INTO `cidetaliedreport` VALUES (66, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 35, 9);
INSERT INTO `cidetaliedreport` VALUES (67, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 35, 9);
INSERT INTO `cidetaliedreport` VALUES (68, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 36, 9);
INSERT INTO `cidetaliedreport` VALUES (69, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 36, 9);
INSERT INTO `cidetaliedreport` VALUES (70, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 37, 9);
INSERT INTO `cidetaliedreport` VALUES (71, '尿蛋白', NULL, NULL, NULL, '-', '阴性', 2, '-', 0, 38, 9);
INSERT INTO `cidetaliedreport` VALUES (72, '尿糖', NULL, NULL, NULL, '-', '阴性', 2, '-', 0, 38, 9);
INSERT INTO `cidetaliedreport` VALUES (73, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 39, 10);
INSERT INTO `cidetaliedreport` VALUES (74, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 39, 10);
INSERT INTO `cidetaliedreport` VALUES (75, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '168', 1, 39, 10);
INSERT INTO `cidetaliedreport` VALUES (76, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 40, 10);
INSERT INTO `cidetaliedreport` VALUES (77, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 40, 10);
INSERT INTO `cidetaliedreport` VALUES (78, '肌酐', 'umol/L', 44, 115, NULL, '44 - 115', 1, '80', 0, 41, 10);
INSERT INTO `cidetaliedreport` VALUES (79, '尿素氮', 'mmol/L', 2.9, 8.2, NULL, '2.9 - 8.2', 1, '5.6', 0, 41, 10);
INSERT INTO `cidetaliedreport` VALUES (80, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 42, 10);
INSERT INTO `cidetaliedreport` VALUES (81, '胸部CT结论', NULL, NULL, NULL, NULL, '', 4, '双肺纹理清晰，未见明显异常', 0, 43, 10);
INSERT INTO `cidetaliedreport` VALUES (82, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 44, 11);
INSERT INTO `cidetaliedreport` VALUES (83, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 44, 11);
INSERT INTO `cidetaliedreport` VALUES (84, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 44, 11);
INSERT INTO `cidetaliedreport` VALUES (85, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '48', 1, 45, 11);
INSERT INTO `cidetaliedreport` VALUES (86, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 45, 11);
INSERT INTO `cidetaliedreport` VALUES (87, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 46, 11);
INSERT INTO `cidetaliedreport` VALUES (88, '尿蛋白', NULL, NULL, NULL, '-', '阴性', 2, '-', 0, 47, 11);
INSERT INTO `cidetaliedreport` VALUES (89, '尿糖', NULL, NULL, NULL, '-', '阴性', 2, '-', 0, 47, 11);
INSERT INTO `cidetaliedreport` VALUES (90, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '18', 1, 48, 12);
INSERT INTO `cidetaliedreport` VALUES (91, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 48, 12);
INSERT INTO `cidetaliedreport` VALUES (92, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 48, 12);
INSERT INTO `cidetaliedreport` VALUES (93, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 49, 12);
INSERT INTO `cidetaliedreport` VALUES (94, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 49, 12);
INSERT INTO `cidetaliedreport` VALUES (95, '肌酐', 'umol/L', 44, 115, NULL, '44 - 115', 1, '123', 1, 50, 12);
INSERT INTO `cidetaliedreport` VALUES (96, '尿素氮', 'mmol/L', 2.9, 8.2, NULL, '2.9 - 8.2', 1, '5.6', 0, 50, 12);
INSERT INTO `cidetaliedreport` VALUES (97, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 51, 12);
INSERT INTO `cidetaliedreport` VALUES (98, '胸部CT结论', NULL, NULL, NULL, NULL, '', 4, '双肺纹理清晰，未见明显异常', 0, 52, 12);
INSERT INTO `cidetaliedreport` VALUES (99, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 53, 13);
INSERT INTO `cidetaliedreport` VALUES (100, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '13.5', 1, 53, 13);
INSERT INTO `cidetaliedreport` VALUES (101, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 53, 13);
INSERT INTO `cidetaliedreport` VALUES (102, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 54, 13);
INSERT INTO `cidetaliedreport` VALUES (103, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 54, 13);
INSERT INTO `cidetaliedreport` VALUES (104, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 55, 13);
INSERT INTO `cidetaliedreport` VALUES (105, '尿蛋白', NULL, NULL, NULL, '-', '阴性', 2, '+', 1, 56, 13);
INSERT INTO `cidetaliedreport` VALUES (106, '尿糖', NULL, NULL, NULL, '-', '阴性', 2, '-', 0, 56, 13);
INSERT INTO `cidetaliedreport` VALUES (107, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 57, 14);
INSERT INTO `cidetaliedreport` VALUES (108, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 57, 14);
INSERT INTO `cidetaliedreport` VALUES (109, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 57, 14);
INSERT INTO `cidetaliedreport` VALUES (110, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '48', 1, 58, 14);
INSERT INTO `cidetaliedreport` VALUES (111, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 58, 14);
INSERT INTO `cidetaliedreport` VALUES (112, '肌酐', 'umol/L', 44, 115, NULL, '44 - 115', 1, '80', 0, 59, 14);
INSERT INTO `cidetaliedreport` VALUES (113, '尿素氮', 'mmol/L', 2.9, 8.2, NULL, '2.9 - 8.2', 1, '5.6', 0, 59, 14);
INSERT INTO `cidetaliedreport` VALUES (114, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 60, 14);
INSERT INTO `cidetaliedreport` VALUES (115, '胸部CT结论', NULL, NULL, NULL, NULL, '', 4, '双肺纹理清晰，未见明显异常', 0, 61, 14);
INSERT INTO `cidetaliedreport` VALUES (116, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 62, 15);
INSERT INTO `cidetaliedreport` VALUES (117, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 62, 15);
INSERT INTO `cidetaliedreport` VALUES (118, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 62, 15);
INSERT INTO `cidetaliedreport` VALUES (119, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 63, 15);
INSERT INTO `cidetaliedreport` VALUES (120, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '28.5', 1, 63, 15);
INSERT INTO `cidetaliedreport` VALUES (121, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 64, 15);
INSERT INTO `cidetaliedreport` VALUES (122, '尿蛋白', NULL, NULL, NULL, '-', '阴性', 2, '-', 0, 65, 15);
INSERT INTO `cidetaliedreport` VALUES (123, '尿糖', NULL, NULL, NULL, '-', '阴性', 2, '-', 0, 65, 15);
INSERT INTO `cidetaliedreport` VALUES (124, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 66, 16);
INSERT INTO `cidetaliedreport` VALUES (125, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '13.5', 1, 66, 16);
INSERT INTO `cidetaliedreport` VALUES (126, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 66, 16);
INSERT INTO `cidetaliedreport` VALUES (127, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 67, 16);
INSERT INTO `cidetaliedreport` VALUES (128, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 67, 16);
INSERT INTO `cidetaliedreport` VALUES (129, '肌酐', 'umol/L', 44, 115, NULL, '44 - 115', 1, '80', 0, 68, 16);
INSERT INTO `cidetaliedreport` VALUES (130, '尿素氮', 'mmol/L', 2.9, 8.2, NULL, '2.9 - 8.2', 1, '16.2', 1, 68, 16);
INSERT INTO `cidetaliedreport` VALUES (131, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 69, 16);
INSERT INTO `cidetaliedreport` VALUES (132, '胸部CT结论', NULL, NULL, NULL, NULL, '', 4, '双肺纹理清晰，未见明显异常', 0, 70, 16);
INSERT INTO `cidetaliedreport` VALUES (133, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 71, 17);
INSERT INTO `cidetaliedreport` VALUES (134, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 71, 17);
INSERT INTO `cidetaliedreport` VALUES (135, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '168', 1, 71, 17);
INSERT INTO `cidetaliedreport` VALUES (136, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 72, 17);
INSERT INTO `cidetaliedreport` VALUES (137, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 72, 17);
INSERT INTO `cidetaliedreport` VALUES (138, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 73, 17);
INSERT INTO `cidetaliedreport` VALUES (139, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 74, 18);
INSERT INTO `cidetaliedreport` VALUES (140, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '13.5', 1, 74, 18);
INSERT INTO `cidetaliedreport` VALUES (141, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 74, 18);
INSERT INTO `cidetaliedreport` VALUES (142, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 75, 18);
INSERT INTO `cidetaliedreport` VALUES (143, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 75, 18);
INSERT INTO `cidetaliedreport` VALUES (144, '肌酐', 'umol/L', 44, 115, NULL, '44 - 115', 1, '80', 0, 76, 18);
INSERT INTO `cidetaliedreport` VALUES (145, '尿素氮', 'mmol/L', 2.9, 8.2, NULL, '2.9 - 8.2', 1, '16.2', 1, 76, 18);
INSERT INTO `cidetaliedreport` VALUES (146, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 77, 18);
INSERT INTO `cidetaliedreport` VALUES (147, '胸部CT结论', NULL, NULL, NULL, NULL, '', 4, '双肺纹理清晰，未见明显异常', 0, 78, 18);
INSERT INTO `cidetaliedreport` VALUES (148, '尿蛋白', NULL, NULL, NULL, '-', '阴性', 2, '-', 0, 79, 18);
INSERT INTO `cidetaliedreport` VALUES (149, '尿糖', NULL, NULL, NULL, '-', '阴性', 2, '-', 0, 79, 18);
INSERT INTO `cidetaliedreport` VALUES (150, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '18', 1, 80, 19);
INSERT INTO `cidetaliedreport` VALUES (151, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 80, 19);
INSERT INTO `cidetaliedreport` VALUES (152, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 80, 19);
INSERT INTO `cidetaliedreport` VALUES (153, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 81, 19);
INSERT INTO `cidetaliedreport` VALUES (154, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 81, 19);
INSERT INTO `cidetaliedreport` VALUES (155, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 82, 19);
INSERT INTO `cidetaliedreport` VALUES (156, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 83, 20);
INSERT INTO `cidetaliedreport` VALUES (157, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 83, 20);
INSERT INTO `cidetaliedreport` VALUES (158, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 83, 20);
INSERT INTO `cidetaliedreport` VALUES (159, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 84, 20);
INSERT INTO `cidetaliedreport` VALUES (160, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '28.5', 1, 84, 20);
INSERT INTO `cidetaliedreport` VALUES (161, '肌酐', 'umol/L', 44, 115, NULL, '44 - 115', 1, '80', 0, 85, 20);
INSERT INTO `cidetaliedreport` VALUES (162, '尿素氮', 'mmol/L', 2.9, 8.2, NULL, '2.9 - 8.2', 1, '5.6', 0, 85, 20);
INSERT INTO `cidetaliedreport` VALUES (163, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 86, 20);
INSERT INTO `cidetaliedreport` VALUES (164, '胸部CT结论', NULL, NULL, NULL, NULL, '', 4, '双肺纹理清晰，未见明显异常', 0, 87, 20);
INSERT INTO `cidetaliedreport` VALUES (165, '尿蛋白', NULL, NULL, NULL, '-', '阴性', 2, '+', 1, 88, 20);
INSERT INTO `cidetaliedreport` VALUES (166, '尿糖', NULL, NULL, NULL, '-', '阴性', 2, '-', 0, 88, 20);
INSERT INTO `cidetaliedreport` VALUES (167, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 89, 21);
INSERT INTO `cidetaliedreport` VALUES (168, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 89, 21);
INSERT INTO `cidetaliedreport` VALUES (169, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 89, 21);
INSERT INTO `cidetaliedreport` VALUES (170, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '48', 1, 90, 21);
INSERT INTO `cidetaliedreport` VALUES (171, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 90, 21);
INSERT INTO `cidetaliedreport` VALUES (172, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 91, 21);
INSERT INTO `cidetaliedreport` VALUES (173, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 92, 22);
INSERT INTO `cidetaliedreport` VALUES (174, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 92, 22);
INSERT INTO `cidetaliedreport` VALUES (175, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '168', 1, 92, 22);
INSERT INTO `cidetaliedreport` VALUES (176, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 93, 22);
INSERT INTO `cidetaliedreport` VALUES (177, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 93, 22);
INSERT INTO `cidetaliedreport` VALUES (178, '肌酐', 'umol/L', 44, 115, NULL, '44 - 115', 1, '80', 0, 94, 22);
INSERT INTO `cidetaliedreport` VALUES (179, '尿素氮', 'mmol/L', 2.9, 8.2, NULL, '2.9 - 8.2', 1, '5.6', 0, 94, 22);
INSERT INTO `cidetaliedreport` VALUES (180, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 95, 22);
INSERT INTO `cidetaliedreport` VALUES (181, '胸部CT结论', NULL, NULL, NULL, NULL, '', 4, '双肺纹理清晰，未见明显异常', 0, 96, 22);
INSERT INTO `cidetaliedreport` VALUES (182, '尿蛋白', NULL, NULL, NULL, '-', '阴性', 2, '-', 0, 97, 22);
INSERT INTO `cidetaliedreport` VALUES (183, '尿糖', NULL, NULL, NULL, '-', '阴性', 2, '-', 0, 97, 22);
INSERT INTO `cidetaliedreport` VALUES (184, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 98, 23);
INSERT INTO `cidetaliedreport` VALUES (185, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '13.5', 1, 98, 23);
INSERT INTO `cidetaliedreport` VALUES (186, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 98, 23);
INSERT INTO `cidetaliedreport` VALUES (187, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 99, 23);
INSERT INTO `cidetaliedreport` VALUES (188, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 99, 23);
INSERT INTO `cidetaliedreport` VALUES (189, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 100, 23);
INSERT INTO `cidetaliedreport` VALUES (190, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '18', 1, 101, 24);
INSERT INTO `cidetaliedreport` VALUES (191, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 101, 24);
INSERT INTO `cidetaliedreport` VALUES (192, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 101, 24);
INSERT INTO `cidetaliedreport` VALUES (193, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 102, 24);
INSERT INTO `cidetaliedreport` VALUES (194, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 102, 24);
INSERT INTO `cidetaliedreport` VALUES (195, '肌酐', 'umol/L', 44, 115, NULL, '44 - 115', 1, '123', 1, 103, 24);
INSERT INTO `cidetaliedreport` VALUES (196, '尿素氮', 'mmol/L', 2.9, 8.2, NULL, '2.9 - 8.2', 1, '5.6', 0, 103, 24);
INSERT INTO `cidetaliedreport` VALUES (197, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 104, 24);
INSERT INTO `cidetaliedreport` VALUES (198, '胸部CT结论', NULL, NULL, NULL, NULL, '', 4, '双肺纹理清晰，未见明显异常', 0, 105, 24);
INSERT INTO `cidetaliedreport` VALUES (199, '尿蛋白', NULL, NULL, NULL, '-', '阴性', 2, '-', 0, 106, 24);
INSERT INTO `cidetaliedreport` VALUES (200, '尿糖', NULL, NULL, NULL, '-', '阴性', 2, '+', 1, 106, 24);
INSERT INTO `cidetaliedreport` VALUES (201, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 107, 25);
INSERT INTO `cidetaliedreport` VALUES (202, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 107, 25);
INSERT INTO `cidetaliedreport` VALUES (203, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 107, 25);
INSERT INTO `cidetaliedreport` VALUES (204, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 108, 25);
INSERT INTO `cidetaliedreport` VALUES (205, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '28.5', 1, 108, 25);
INSERT INTO `cidetaliedreport` VALUES (206, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 109, 25);
INSERT INTO `cidetaliedreport` VALUES (207, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 110, 26);
INSERT INTO `cidetaliedreport` VALUES (208, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 110, 26);
INSERT INTO `cidetaliedreport` VALUES (209, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 110, 26);
INSERT INTO `cidetaliedreport` VALUES (210, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '48', 1, 111, 26);
INSERT INTO `cidetaliedreport` VALUES (211, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 111, 26);
INSERT INTO `cidetaliedreport` VALUES (212, '肌酐', 'umol/L', 44, 115, NULL, '44 - 115', 1, '80', 0, 112, 26);
INSERT INTO `cidetaliedreport` VALUES (213, '尿素氮', 'mmol/L', 2.9, 8.2, NULL, '2.9 - 8.2', 1, '5.6', 0, 112, 26);
INSERT INTO `cidetaliedreport` VALUES (214, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 113, 26);
INSERT INTO `cidetaliedreport` VALUES (215, '胸部CT结论', NULL, NULL, NULL, NULL, '', 4, '双肺纹理清晰，未见明显异常', 0, 114, 26);
INSERT INTO `cidetaliedreport` VALUES (216, '尿蛋白', NULL, NULL, NULL, '-', '阴性', 2, '-', 0, 115, 26);
INSERT INTO `cidetaliedreport` VALUES (217, '尿糖', NULL, NULL, NULL, '-', '阴性', 2, '-', 0, 115, 26);
INSERT INTO `cidetaliedreport` VALUES (218, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 116, 27);
INSERT INTO `cidetaliedreport` VALUES (219, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 116, 27);
INSERT INTO `cidetaliedreport` VALUES (220, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '168', 1, 116, 27);
INSERT INTO `cidetaliedreport` VALUES (221, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 117, 27);
INSERT INTO `cidetaliedreport` VALUES (222, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 117, 27);
INSERT INTO `cidetaliedreport` VALUES (223, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 118, 27);
INSERT INTO `cidetaliedreport` VALUES (224, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 119, 28);
INSERT INTO `cidetaliedreport` VALUES (225, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '13.5', 1, 119, 28);
INSERT INTO `cidetaliedreport` VALUES (226, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 119, 28);
INSERT INTO `cidetaliedreport` VALUES (227, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 120, 28);
INSERT INTO `cidetaliedreport` VALUES (228, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 120, 28);
INSERT INTO `cidetaliedreport` VALUES (229, '肌酐', 'umol/L', 44, 115, NULL, '44 - 115', 1, '80', 0, 121, 28);
INSERT INTO `cidetaliedreport` VALUES (230, '尿素氮', 'mmol/L', 2.9, 8.2, NULL, '2.9 - 8.2', 1, '16.2', 1, 121, 28);
INSERT INTO `cidetaliedreport` VALUES (231, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 122, 28);
INSERT INTO `cidetaliedreport` VALUES (232, '胸部CT结论', NULL, NULL, NULL, NULL, '', 4, '双肺纹理清晰，未见明显异常', 0, 123, 28);
INSERT INTO `cidetaliedreport` VALUES (233, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 124, 29);
INSERT INTO `cidetaliedreport` VALUES (234, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 124, 29);
INSERT INTO `cidetaliedreport` VALUES (235, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '168', 1, 124, 29);
INSERT INTO `cidetaliedreport` VALUES (236, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 125, 29);
INSERT INTO `cidetaliedreport` VALUES (237, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 125, 29);
INSERT INTO `cidetaliedreport` VALUES (238, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 126, 29);
INSERT INTO `cidetaliedreport` VALUES (239, '尿蛋白', NULL, NULL, NULL, '-', '阴性', 2, '-', 0, 127, 29);
INSERT INTO `cidetaliedreport` VALUES (240, '尿糖', NULL, NULL, NULL, '-', '阴性', 2, '+', 1, 127, 29);
INSERT INTO `cidetaliedreport` VALUES (241, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 128, 30);
INSERT INTO `cidetaliedreport` VALUES (242, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 128, 30);
INSERT INTO `cidetaliedreport` VALUES (243, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 128, 30);
INSERT INTO `cidetaliedreport` VALUES (244, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 129, 30);
INSERT INTO `cidetaliedreport` VALUES (245, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '28.5', 1, 129, 30);
INSERT INTO `cidetaliedreport` VALUES (246, '肌酐', 'umol/L', 44, 115, NULL, '44 - 115', 1, '80', 0, 130, 30);
INSERT INTO `cidetaliedreport` VALUES (247, '尿素氮', 'mmol/L', 2.9, 8.2, NULL, '2.9 - 8.2', 1, '5.6', 0, 130, 30);
INSERT INTO `cidetaliedreport` VALUES (248, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 131, 30);
INSERT INTO `cidetaliedreport` VALUES (249, '胸部CT结论', NULL, NULL, NULL, NULL, '', 4, '双肺纹理清晰，未见明显异常', 0, 132, 30);
INSERT INTO `cidetaliedreport` VALUES (250, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '18', 1, 133, 31);
INSERT INTO `cidetaliedreport` VALUES (251, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 133, 31);
INSERT INTO `cidetaliedreport` VALUES (252, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 133, 31);
INSERT INTO `cidetaliedreport` VALUES (253, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 134, 31);
INSERT INTO `cidetaliedreport` VALUES (254, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 134, 31);
INSERT INTO `cidetaliedreport` VALUES (255, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 135, 31);
INSERT INTO `cidetaliedreport` VALUES (256, '尿蛋白', NULL, NULL, NULL, '-', '阴性', 2, '-', 0, 136, 31);
INSERT INTO `cidetaliedreport` VALUES (257, '尿糖', NULL, NULL, NULL, '-', '阴性', 2, '-', 0, 136, 31);
INSERT INTO `cidetaliedreport` VALUES (258, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 137, 32);
INSERT INTO `cidetaliedreport` VALUES (259, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 137, 32);
INSERT INTO `cidetaliedreport` VALUES (260, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '168', 1, 137, 32);
INSERT INTO `cidetaliedreport` VALUES (261, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 138, 32);
INSERT INTO `cidetaliedreport` VALUES (262, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 138, 32);
INSERT INTO `cidetaliedreport` VALUES (263, '肌酐', 'umol/L', 44, 115, NULL, '44 - 115', 1, '80', 0, 139, 32);
INSERT INTO `cidetaliedreport` VALUES (264, '尿素氮', 'mmol/L', 2.9, 8.2, NULL, '2.9 - 8.2', 1, '5.6', 0, 139, 32);
INSERT INTO `cidetaliedreport` VALUES (265, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 140, 32);
INSERT INTO `cidetaliedreport` VALUES (266, '胸部CT结论', NULL, NULL, NULL, NULL, '', 4, '双肺纹理清晰，未见明显异常', 0, 141, 32);
INSERT INTO `cidetaliedreport` VALUES (267, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 142, 33);
INSERT INTO `cidetaliedreport` VALUES (268, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 142, 33);
INSERT INTO `cidetaliedreport` VALUES (269, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 142, 33);
INSERT INTO `cidetaliedreport` VALUES (270, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '48', 1, 143, 33);
INSERT INTO `cidetaliedreport` VALUES (271, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 143, 33);
INSERT INTO `cidetaliedreport` VALUES (272, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 144, 33);
INSERT INTO `cidetaliedreport` VALUES (273, '尿蛋白', NULL, NULL, NULL, '-', '阴性', 2, '-', 0, 145, 33);
INSERT INTO `cidetaliedreport` VALUES (274, '尿糖', NULL, NULL, NULL, '-', '阴性', 2, '-', 0, 145, 33);
INSERT INTO `cidetaliedreport` VALUES (275, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '18', 1, 146, 34);
INSERT INTO `cidetaliedreport` VALUES (276, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 146, 34);
INSERT INTO `cidetaliedreport` VALUES (277, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 146, 34);
INSERT INTO `cidetaliedreport` VALUES (278, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 147, 34);
INSERT INTO `cidetaliedreport` VALUES (279, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 147, 34);
INSERT INTO `cidetaliedreport` VALUES (280, '肌酐', 'umol/L', 44, 115, NULL, '44 - 115', 1, '123', 1, 148, 34);
INSERT INTO `cidetaliedreport` VALUES (281, '尿素氮', 'mmol/L', 2.9, 8.2, NULL, '2.9 - 8.2', 1, '5.6', 0, 148, 34);
INSERT INTO `cidetaliedreport` VALUES (282, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 149, 34);
INSERT INTO `cidetaliedreport` VALUES (283, '胸部CT结论', NULL, NULL, NULL, NULL, '', 4, '双肺纹理清晰，未见明显异常', 0, 150, 34);
INSERT INTO `cidetaliedreport` VALUES (284, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 151, 35);
INSERT INTO `cidetaliedreport` VALUES (285, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '13.5', 1, 151, 35);
INSERT INTO `cidetaliedreport` VALUES (286, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 151, 35);
INSERT INTO `cidetaliedreport` VALUES (287, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 152, 35);
INSERT INTO `cidetaliedreport` VALUES (288, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 152, 35);
INSERT INTO `cidetaliedreport` VALUES (289, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 153, 35);
INSERT INTO `cidetaliedreport` VALUES (290, '尿蛋白', NULL, NULL, NULL, '-', '阴性', 2, '+', 1, 154, 35);
INSERT INTO `cidetaliedreport` VALUES (291, '尿糖', NULL, NULL, NULL, '-', '阴性', 2, '-', 0, 154, 35);
INSERT INTO `cidetaliedreport` VALUES (292, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 155, 36);
INSERT INTO `cidetaliedreport` VALUES (293, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 155, 36);
INSERT INTO `cidetaliedreport` VALUES (294, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 155, 36);
INSERT INTO `cidetaliedreport` VALUES (295, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '48', 1, 156, 36);
INSERT INTO `cidetaliedreport` VALUES (296, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 156, 36);
INSERT INTO `cidetaliedreport` VALUES (297, '肌酐', 'umol/L', 44, 115, NULL, '44 - 115', 1, '80', 0, 157, 36);
INSERT INTO `cidetaliedreport` VALUES (298, '尿素氮', 'mmol/L', 2.9, 8.2, NULL, '2.9 - 8.2', 1, '5.6', 0, 157, 36);
INSERT INTO `cidetaliedreport` VALUES (299, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 158, 36);
INSERT INTO `cidetaliedreport` VALUES (300, '胸部CT结论', NULL, NULL, NULL, NULL, '', 4, '双肺纹理清晰，未见明显异常', 0, 159, 36);
INSERT INTO `cidetaliedreport` VALUES (301, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 160, 37);
INSERT INTO `cidetaliedreport` VALUES (302, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '4.5', 0, 160, 37);
INSERT INTO `cidetaliedreport` VALUES (303, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 160, 37);
INSERT INTO `cidetaliedreport` VALUES (304, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 161, 37);
INSERT INTO `cidetaliedreport` VALUES (305, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '28.5', 1, 161, 37);
INSERT INTO `cidetaliedreport` VALUES (306, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 162, 37);
INSERT INTO `cidetaliedreport` VALUES (307, '尿蛋白', NULL, NULL, NULL, '-', '阴性', 2, '-', 0, 163, 37);
INSERT INTO `cidetaliedreport` VALUES (308, '尿糖', NULL, NULL, NULL, '-', '阴性', 2, '-', 0, 163, 37);
INSERT INTO `cidetaliedreport` VALUES (309, '白细胞计数', '10^9/L', 4, 10, NULL, '4.0 - 10.0', 1, '7', 0, 164, 38);
INSERT INTO `cidetaliedreport` VALUES (310, '红细胞计数', '10^12/L', 3.5, 5.5, NULL, '3.5 - 5.5', 1, '13.5', 1, 164, 38);
INSERT INTO `cidetaliedreport` VALUES (311, '血红蛋白', 'g/L', 110, 160, NULL, '110 - 160', 1, '135', 0, 164, 38);
INSERT INTO `cidetaliedreport` VALUES (312, '谷丙转氨酶', 'U/L', 0, 40, NULL, '0 - 40', 1, '20', 0, 165, 38);
INSERT INTO `cidetaliedreport` VALUES (313, '总胆红素', 'umol/L', 3.4, 20.5, NULL, '3.4 - 20.5', 1, '12.0', 0, 165, 38);
INSERT INTO `cidetaliedreport` VALUES (314, '肌酐', 'umol/L', 44, 115, NULL, '44 - 115', 1, '80', 0, 166, 38);
INSERT INTO `cidetaliedreport` VALUES (315, '尿素氮', 'mmol/L', 2.9, 8.2, NULL, '2.9 - 8.2', 1, '16.2', 1, 166, 38);
INSERT INTO `cidetaliedreport` VALUES (316, '心电图结论', NULL, NULL, NULL, NULL, '', 4, '窦性心律，未见明显异常', 0, 167, 38);
INSERT INTO `cidetaliedreport` VALUES (317, '胸部CT结论', NULL, NULL, NULL, NULL, '', 4, '双肺纹理清晰，未见明显异常', 0, 168, 38);

-- ----------------------------
-- Table structure for cireport
-- ----------------------------
DROP TABLE IF EXISTS `cireport`;
CREATE TABLE `cireport`  (
  `cirId` int NOT NULL AUTO_INCREMENT COMMENT '检查项报告主键',
  `ciId` int NOT NULL COMMENT '检查项编号',
  `ciName` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '检查项名称',
  `orderId` int NOT NULL COMMENT '所属预约编号',
  PRIMARY KEY (`cirId`) USING BTREE,
  INDEX `idx_cir_ciId`(`ciId` ASC) USING BTREE,
  INDEX `idx_cir_orderId`(`orderId` ASC) USING BTREE,
  CONSTRAINT `fk_cir_checkitem` FOREIGN KEY (`ciId`) REFERENCES `checkitem` (`ciId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_cir_orders` FOREIGN KEY (`orderId`) REFERENCES `orders` (`orderId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 169 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '体检报告检查项信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cireport
-- ----------------------------
INSERT INTO `cireport` VALUES (9, 1, '血常规', 3);
INSERT INTO `cireport` VALUES (10, 2, '肝功能', 3);
INSERT INTO `cireport` VALUES (11, 3, '肾功能', 3);
INSERT INTO `cireport` VALUES (12, 4, '心电图', 3);
INSERT INTO `cireport` VALUES (13, 5, '胸部CT', 3);
INSERT INTO `cireport` VALUES (14, 1, '血常规', 4);
INSERT INTO `cireport` VALUES (15, 2, '肝功能', 4);
INSERT INTO `cireport` VALUES (16, 4, '心电图', 4);
INSERT INTO `cireport` VALUES (17, 1, '血常规', 5);
INSERT INTO `cireport` VALUES (18, 2, '肝功能', 5);
INSERT INTO `cireport` VALUES (19, 3, '肾功能', 5);
INSERT INTO `cireport` VALUES (20, 4, '心电图', 5);
INSERT INTO `cireport` VALUES (21, 5, '胸部CT', 5);
INSERT INTO `cireport` VALUES (22, 6, '尿常规', 5);
INSERT INTO `cireport` VALUES (23, 1, '血常规', 6);
INSERT INTO `cireport` VALUES (24, 2, '肝功能', 6);
INSERT INTO `cireport` VALUES (25, 4, '心电图', 6);
INSERT INTO `cireport` VALUES (26, 6, '尿常规', 6);
INSERT INTO `cireport` VALUES (27, 1, '血常规', 7);
INSERT INTO `cireport` VALUES (28, 2, '肝功能', 7);
INSERT INTO `cireport` VALUES (29, 4, '心电图', 7);
INSERT INTO `cireport` VALUES (30, 1, '血常规', 8);
INSERT INTO `cireport` VALUES (31, 2, '肝功能', 8);
INSERT INTO `cireport` VALUES (32, 3, '肾功能', 8);
INSERT INTO `cireport` VALUES (33, 4, '心电图', 8);
INSERT INTO `cireport` VALUES (34, 5, '胸部CT', 8);
INSERT INTO `cireport` VALUES (35, 1, '血常规', 9);
INSERT INTO `cireport` VALUES (36, 2, '肝功能', 9);
INSERT INTO `cireport` VALUES (37, 4, '心电图', 9);
INSERT INTO `cireport` VALUES (38, 6, '尿常规', 9);
INSERT INTO `cireport` VALUES (39, 1, '血常规', 10);
INSERT INTO `cireport` VALUES (40, 2, '肝功能', 10);
INSERT INTO `cireport` VALUES (41, 3, '肾功能', 10);
INSERT INTO `cireport` VALUES (42, 4, '心电图', 10);
INSERT INTO `cireport` VALUES (43, 5, '胸部CT', 10);
INSERT INTO `cireport` VALUES (44, 1, '血常规', 11);
INSERT INTO `cireport` VALUES (45, 2, '肝功能', 11);
INSERT INTO `cireport` VALUES (46, 4, '心电图', 11);
INSERT INTO `cireport` VALUES (47, 6, '尿常规', 11);
INSERT INTO `cireport` VALUES (48, 1, '血常规', 12);
INSERT INTO `cireport` VALUES (49, 2, '肝功能', 12);
INSERT INTO `cireport` VALUES (50, 3, '肾功能', 12);
INSERT INTO `cireport` VALUES (51, 4, '心电图', 12);
INSERT INTO `cireport` VALUES (52, 5, '胸部CT', 12);
INSERT INTO `cireport` VALUES (53, 1, '血常规', 13);
INSERT INTO `cireport` VALUES (54, 2, '肝功能', 13);
INSERT INTO `cireport` VALUES (55, 4, '心电图', 13);
INSERT INTO `cireport` VALUES (56, 6, '尿常规', 13);
INSERT INTO `cireport` VALUES (57, 1, '血常规', 14);
INSERT INTO `cireport` VALUES (58, 2, '肝功能', 14);
INSERT INTO `cireport` VALUES (59, 3, '肾功能', 14);
INSERT INTO `cireport` VALUES (60, 4, '心电图', 14);
INSERT INTO `cireport` VALUES (61, 5, '胸部CT', 14);
INSERT INTO `cireport` VALUES (62, 1, '血常规', 15);
INSERT INTO `cireport` VALUES (63, 2, '肝功能', 15);
INSERT INTO `cireport` VALUES (64, 4, '心电图', 15);
INSERT INTO `cireport` VALUES (65, 6, '尿常规', 15);
INSERT INTO `cireport` VALUES (66, 1, '血常规', 16);
INSERT INTO `cireport` VALUES (67, 2, '肝功能', 16);
INSERT INTO `cireport` VALUES (68, 3, '肾功能', 16);
INSERT INTO `cireport` VALUES (69, 4, '心电图', 16);
INSERT INTO `cireport` VALUES (70, 5, '胸部CT', 16);
INSERT INTO `cireport` VALUES (71, 1, '血常规', 17);
INSERT INTO `cireport` VALUES (72, 2, '肝功能', 17);
INSERT INTO `cireport` VALUES (73, 4, '心电图', 17);
INSERT INTO `cireport` VALUES (74, 1, '血常规', 18);
INSERT INTO `cireport` VALUES (75, 2, '肝功能', 18);
INSERT INTO `cireport` VALUES (76, 3, '肾功能', 18);
INSERT INTO `cireport` VALUES (77, 4, '心电图', 18);
INSERT INTO `cireport` VALUES (78, 5, '胸部CT', 18);
INSERT INTO `cireport` VALUES (79, 6, '尿常规', 18);
INSERT INTO `cireport` VALUES (80, 1, '血常规', 19);
INSERT INTO `cireport` VALUES (81, 2, '肝功能', 19);
INSERT INTO `cireport` VALUES (82, 4, '心电图', 19);
INSERT INTO `cireport` VALUES (83, 1, '血常规', 20);
INSERT INTO `cireport` VALUES (84, 2, '肝功能', 20);
INSERT INTO `cireport` VALUES (85, 3, '肾功能', 20);
INSERT INTO `cireport` VALUES (86, 4, '心电图', 20);
INSERT INTO `cireport` VALUES (87, 5, '胸部CT', 20);
INSERT INTO `cireport` VALUES (88, 6, '尿常规', 20);
INSERT INTO `cireport` VALUES (89, 1, '血常规', 21);
INSERT INTO `cireport` VALUES (90, 2, '肝功能', 21);
INSERT INTO `cireport` VALUES (91, 4, '心电图', 21);
INSERT INTO `cireport` VALUES (92, 1, '血常规', 22);
INSERT INTO `cireport` VALUES (93, 2, '肝功能', 22);
INSERT INTO `cireport` VALUES (94, 3, '肾功能', 22);
INSERT INTO `cireport` VALUES (95, 4, '心电图', 22);
INSERT INTO `cireport` VALUES (96, 5, '胸部CT', 22);
INSERT INTO `cireport` VALUES (97, 6, '尿常规', 22);
INSERT INTO `cireport` VALUES (98, 1, '血常规', 23);
INSERT INTO `cireport` VALUES (99, 2, '肝功能', 23);
INSERT INTO `cireport` VALUES (100, 4, '心电图', 23);
INSERT INTO `cireport` VALUES (101, 1, '血常规', 24);
INSERT INTO `cireport` VALUES (102, 2, '肝功能', 24);
INSERT INTO `cireport` VALUES (103, 3, '肾功能', 24);
INSERT INTO `cireport` VALUES (104, 4, '心电图', 24);
INSERT INTO `cireport` VALUES (105, 5, '胸部CT', 24);
INSERT INTO `cireport` VALUES (106, 6, '尿常规', 24);
INSERT INTO `cireport` VALUES (107, 1, '血常规', 25);
INSERT INTO `cireport` VALUES (108, 2, '肝功能', 25);
INSERT INTO `cireport` VALUES (109, 4, '心电图', 25);
INSERT INTO `cireport` VALUES (110, 1, '血常规', 26);
INSERT INTO `cireport` VALUES (111, 2, '肝功能', 26);
INSERT INTO `cireport` VALUES (112, 3, '肾功能', 26);
INSERT INTO `cireport` VALUES (113, 4, '心电图', 26);
INSERT INTO `cireport` VALUES (114, 5, '胸部CT', 26);
INSERT INTO `cireport` VALUES (115, 6, '尿常规', 26);
INSERT INTO `cireport` VALUES (116, 1, '血常规', 27);
INSERT INTO `cireport` VALUES (117, 2, '肝功能', 27);
INSERT INTO `cireport` VALUES (118, 4, '心电图', 27);
INSERT INTO `cireport` VALUES (119, 1, '血常规', 28);
INSERT INTO `cireport` VALUES (120, 2, '肝功能', 28);
INSERT INTO `cireport` VALUES (121, 3, '肾功能', 28);
INSERT INTO `cireport` VALUES (122, 4, '心电图', 28);
INSERT INTO `cireport` VALUES (123, 5, '胸部CT', 28);
INSERT INTO `cireport` VALUES (124, 1, '血常规', 29);
INSERT INTO `cireport` VALUES (125, 2, '肝功能', 29);
INSERT INTO `cireport` VALUES (126, 4, '心电图', 29);
INSERT INTO `cireport` VALUES (127, 6, '尿常规', 29);
INSERT INTO `cireport` VALUES (128, 1, '血常规', 30);
INSERT INTO `cireport` VALUES (129, 2, '肝功能', 30);
INSERT INTO `cireport` VALUES (130, 3, '肾功能', 30);
INSERT INTO `cireport` VALUES (131, 4, '心电图', 30);
INSERT INTO `cireport` VALUES (132, 5, '胸部CT', 30);
INSERT INTO `cireport` VALUES (133, 1, '血常规', 31);
INSERT INTO `cireport` VALUES (134, 2, '肝功能', 31);
INSERT INTO `cireport` VALUES (135, 4, '心电图', 31);
INSERT INTO `cireport` VALUES (136, 6, '尿常规', 31);
INSERT INTO `cireport` VALUES (137, 1, '血常规', 32);
INSERT INTO `cireport` VALUES (138, 2, '肝功能', 32);
INSERT INTO `cireport` VALUES (139, 3, '肾功能', 32);
INSERT INTO `cireport` VALUES (140, 4, '心电图', 32);
INSERT INTO `cireport` VALUES (141, 5, '胸部CT', 32);
INSERT INTO `cireport` VALUES (142, 1, '血常规', 33);
INSERT INTO `cireport` VALUES (143, 2, '肝功能', 33);
INSERT INTO `cireport` VALUES (144, 4, '心电图', 33);
INSERT INTO `cireport` VALUES (145, 6, '尿常规', 33);
INSERT INTO `cireport` VALUES (146, 1, '血常规', 34);
INSERT INTO `cireport` VALUES (147, 2, '肝功能', 34);
INSERT INTO `cireport` VALUES (148, 3, '肾功能', 34);
INSERT INTO `cireport` VALUES (149, 4, '心电图', 34);
INSERT INTO `cireport` VALUES (150, 5, '胸部CT', 34);
INSERT INTO `cireport` VALUES (151, 1, '血常规', 35);
INSERT INTO `cireport` VALUES (152, 2, '肝功能', 35);
INSERT INTO `cireport` VALUES (153, 4, '心电图', 35);
INSERT INTO `cireport` VALUES (154, 6, '尿常规', 35);
INSERT INTO `cireport` VALUES (155, 1, '血常规', 36);
INSERT INTO `cireport` VALUES (156, 2, '肝功能', 36);
INSERT INTO `cireport` VALUES (157, 3, '肾功能', 36);
INSERT INTO `cireport` VALUES (158, 4, '心电图', 36);
INSERT INTO `cireport` VALUES (159, 5, '胸部CT', 36);
INSERT INTO `cireport` VALUES (160, 1, '血常规', 37);
INSERT INTO `cireport` VALUES (161, 2, '肝功能', 37);
INSERT INTO `cireport` VALUES (162, 4, '心电图', 37);
INSERT INTO `cireport` VALUES (163, 6, '尿常规', 37);
INSERT INTO `cireport` VALUES (164, 1, '血常规', 38);
INSERT INTO `cireport` VALUES (165, 2, '肝功能', 38);
INSERT INTO `cireport` VALUES (166, 3, '肾功能', 38);
INSERT INTO `cireport` VALUES (167, 4, '心电图', 38);
INSERT INTO `cireport` VALUES (168, 5, '胸部CT', 38);

-- ----------------------------
-- Table structure for doctor
-- ----------------------------
DROP TABLE IF EXISTS `doctor`;
CREATE TABLE `doctor`  (
  `docId` int NOT NULL AUTO_INCREMENT COMMENT '医生编号',
  `docCode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '医生编码(登录用)',
  `realName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '真实姓名',
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码(登录用)',
  `sex` int NOT NULL COMMENT '性别',
  `deptno` int NOT NULL COMMENT '所属科室(1:检验科;2:内科;3:外科)',
  PRIMARY KEY (`docId`) USING BTREE,
  UNIQUE INDEX `uk_doctor_docCode`(`docCode` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '医生信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of doctor
-- ----------------------------
INSERT INTO `doctor` VALUES (1, 'sun', '孙晨', '123456', 1, 1);
INSERT INTO `doctor` VALUES (2, 'zhang', '张石凡', '123456', 1, 2);

-- ----------------------------
-- Table structure for hospital
-- ----------------------------
DROP TABLE IF EXISTS `hospital`;
CREATE TABLE `hospital`  (
  `hpId` int NOT NULL AUTO_INCREMENT COMMENT '医院编号',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '医院名称',
  `picture` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '医院图片',
  `telephone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '医院电话',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '医院地址',
  `businessHours` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '营业时间',
  `deadline` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '采血截止时间',
  `rule` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '预约人数规则',
  `state` int NOT NULL COMMENT '医院状态(1:正常;2:其他)',
  PRIMARY KEY (`hpId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '医院信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hospital
-- ----------------------------
INSERT INTO `hospital` VALUES (1, '沈阳云医院', '', '024-8888-0001', '沈阳市和平区南京北街 100 号', '周一至周日 07:30-16:30', '每日 10:00 前采血', '每日限约 80 人', 1);
INSERT INTO `hospital` VALUES (2, '东软熙康体检中心', '', '024-8888-0002', '沈阳市浑南区新秀街 2 号', '周一至周六 08:00-17:00', '每日 09:30 前采血', '每日限约 60 人', 1);
INSERT INTO `hospital` VALUES (3, '沈阳市第一人民医院体检中心', '', '024-8888-0003', '沈阳市大东区清泉路 67 号', '周一至周五 07:00-16:00', '每日 09:00 前采血', '每日限约 50 人', 1);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `orderId` int NOT NULL AUTO_INCREMENT COMMENT '订单编号',
  `orderDate` date NOT NULL COMMENT '预约日期',
  `userId` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户编号',
  `hpId` int NOT NULL COMMENT '所属医院编号',
  `smId` int NOT NULL COMMENT '所属套餐编号',
  `state` int NOT NULL COMMENT '订单状态(1:未归档;2:已归档)',
  PRIMARY KEY (`orderId`) USING BTREE,
  INDEX `idx_orders_userId`(`userId` ASC) USING BTREE,
  INDEX `idx_orders_hpId`(`hpId` ASC) USING BTREE,
  INDEX `idx_orders_smId`(`smId` ASC) USING BTREE,
  CONSTRAINT `fk_orders_hospital` FOREIGN KEY (`hpId`) REFERENCES `hospital` (`hpId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_orders_setmeal` FOREIGN KEY (`smId`) REFERENCES `setmeal` (`smId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_orders_users` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '体检预约订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (3, '2026-10-12', '15642388888', 1, 2, 1);
INSERT INTO `orders` VALUES (4, '2026-09-05', '15642388888', 2, 1, 2);
INSERT INTO `orders` VALUES (5, '2026-10-20', '13900001234', 2, 4, 1);
INSERT INTO `orders` VALUES (6, '2026-08-15', '13900001234', 3, 3, 2);
INSERT INTO `orders` VALUES (7, '2026-11-01', '13800005678', 1, 1, 1);
INSERT INTO `orders` VALUES (8, '2026-09-28', '13800005678', 3, 2, 1);
INSERT INTO `orders` VALUES (9, '2026-06-01', '13700001001', 1, 3, 2);
INSERT INTO `orders` VALUES (10, '2026-06-06', '13700001002', 2, 2, 1);
INSERT INTO `orders` VALUES (11, '2026-06-11', '13700001003', 3, 3, 1);
INSERT INTO `orders` VALUES (12, '2026-06-16', '13700001004', 1, 2, 1);
INSERT INTO `orders` VALUES (13, '2026-06-21', '13700001005', 2, 3, 2);
INSERT INTO `orders` VALUES (14, '2026-06-26', '13700001006', 3, 2, 1);
INSERT INTO `orders` VALUES (15, '2026-07-01', '13700001007', 1, 3, 1);
INSERT INTO `orders` VALUES (16, '2026-07-06', '13700001008', 2, 2, 1);
INSERT INTO `orders` VALUES (17, '2026-07-11', '15642388888', 3, 1, 2);
INSERT INTO `orders` VALUES (18, '2026-07-16', '13900001234', 1, 4, 1);
INSERT INTO `orders` VALUES (19, '2026-07-21', '13800005678', 2, 1, 1);
INSERT INTO `orders` VALUES (20, '2026-07-26', '13700001001', 3, 4, 1);
INSERT INTO `orders` VALUES (21, '2026-07-31', '13700001002', 1, 1, 2);
INSERT INTO `orders` VALUES (22, '2026-08-05', '13700001003', 2, 4, 1);
INSERT INTO `orders` VALUES (23, '2026-08-10', '13700001004', 3, 1, 1);
INSERT INTO `orders` VALUES (24, '2026-08-15', '13700001005', 1, 4, 1);
INSERT INTO `orders` VALUES (25, '2026-08-20', '13700001006', 2, 1, 2);
INSERT INTO `orders` VALUES (26, '2026-08-25', '13700001007', 3, 4, 1);
INSERT INTO `orders` VALUES (27, '2026-08-30', '13700001008', 1, 1, 1);
INSERT INTO `orders` VALUES (28, '2026-09-04', '15642388888', 2, 2, 1);
INSERT INTO `orders` VALUES (29, '2026-09-09', '13900001234', 3, 3, 2);
INSERT INTO `orders` VALUES (30, '2026-09-14', '13800005678', 1, 2, 1);
INSERT INTO `orders` VALUES (31, '2026-09-19', '13700001001', 2, 3, 1);
INSERT INTO `orders` VALUES (32, '2026-09-24', '13700001002', 3, 2, 1);
INSERT INTO `orders` VALUES (33, '2026-09-29', '13700001003', 1, 3, 2);
INSERT INTO `orders` VALUES (34, '2026-10-04', '13700001004', 2, 2, 1);
INSERT INTO `orders` VALUES (35, '2026-10-09', '13700001005', 3, 3, 1);
INSERT INTO `orders` VALUES (36, '2026-10-14', '13700001006', 1, 2, 1);
INSERT INTO `orders` VALUES (37, '2026-10-19', '13700001007', 2, 3, 2);
INSERT INTO `orders` VALUES (38, '2026-10-24', '13700001008', 3, 2, 1);

-- ----------------------------
-- Table structure for overallresult
-- ----------------------------
DROP TABLE IF EXISTS `overallresult`;
CREATE TABLE `overallresult`  (
  `orId` int NOT NULL AUTO_INCREMENT COMMENT '总检结论项编号',
  `title` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '总检结论项标题',
  `content` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '总检结论项内容',
  `orderId` int NOT NULL COMMENT '所属预约编号',
  PRIMARY KEY (`orId`) USING BTREE,
  INDEX `idx_or_orderId`(`orderId` ASC) USING BTREE,
  CONSTRAINT `fk_or_orders` FOREIGN KEY (`orderId`) REFERENCES `orders` (`orderId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '总检结论信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of overallresult
-- ----------------------------
INSERT INTO `overallresult` VALUES (2, '血压偏高', '本次体检血压 148/92 mmHg，建议低盐饮食并复查。', 3);
INSERT INTO `overallresult` VALUES (3, '轻度脂肪肝', '腹部彩超提示轻度脂肪肝，建议控制体重、加强运动。', 3);
INSERT INTO `overallresult` VALUES (4, '总体正常', '本次体检各项指标基本正常，请注意规律作息。', 4);
INSERT INTO `overallresult` VALUES (5, '血红蛋白偏低', '血红蛋白 102 g/L，考虑轻度贫血，建议补充铁剂后复查。', 5);
INSERT INTO `overallresult` VALUES (6, '总体正常', '各项检查未见明显异常。', 6);
INSERT INTO `overallresult` VALUES (7, '建议定期体检', '建议每年进行一次全面体检。', 6);
INSERT INTO `overallresult` VALUES (8, '血脂异常', '总胆固醇偏高，建议低脂饮食，1 个月后复查血脂。', 8);
INSERT INTO `overallresult` VALUES (9, '心率正常', '正常', 8);
INSERT INTO `overallresult` VALUES (10, '血脂偏高', '总胆固醇轻度升高，建议低脂饮食，1 个月后复查血脂。', 10);
INSERT INTO `overallresult` VALUES (11, '血压偏高', '血压 146/94 mmHg，建议低盐饮食并监测血压变化。', 10);
INSERT INTO `overallresult` VALUES (12, '血压偏高', '血压 146/94 mmHg，建议低盐饮食并监测血压变化。', 11);
INSERT INTO `overallresult` VALUES (13, '血红蛋白偏低', '血红蛋白偏低，考虑轻度贫血，建议补充铁剂后复查。', 13);
INSERT INTO `overallresult` VALUES (14, '尿常规异常', '尿蛋白阳性，建议复查尿常规并咨询肾内科。', 14);
INSERT INTO `overallresult` VALUES (15, '建议定期体检', '建议每年进行一次全面体检，关注血压、血糖、血脂变化。', 14);
INSERT INTO `overallresult` VALUES (16, '总体正常', '本次体检各项指标基本正常，请注意规律作息、均衡饮食。', 16);
INSERT INTO `overallresult` VALUES (17, '血脂偏高', '总胆固醇轻度升高，建议低脂饮食，1 个月后复查血脂。', 16);
INSERT INTO `overallresult` VALUES (18, '血脂偏高', '总胆固醇轻度升高，建议低脂饮食，1 个月后复查血脂。', 17);
INSERT INTO `overallresult` VALUES (19, '轻度脂肪肝', '腹部彩超提示轻度脂肪肝，建议控制体重、加强运动。', 19);
INSERT INTO `overallresult` VALUES (20, '血红蛋白偏低', '血红蛋白偏低，考虑轻度贫血，建议补充铁剂后复查。', 20);
INSERT INTO `overallresult` VALUES (21, '尿常规异常', '尿蛋白阳性，建议复查尿常规并咨询肾内科。', 20);
INSERT INTO `overallresult` VALUES (22, '建议定期体检', '建议每年进行一次全面体检，关注血压、血糖、血脂变化。', 22);
INSERT INTO `overallresult` VALUES (23, '总体正常', '本次体检各项指标基本正常，请注意规律作息、均衡饮食。', 22);
INSERT INTO `overallresult` VALUES (24, '总体正常', '本次体检各项指标基本正常，请注意规律作息、均衡饮食。', 23);
INSERT INTO `overallresult` VALUES (25, '血压偏高', '血压 146/94 mmHg，建议低盐饮食并监测血压变化。', 25);
INSERT INTO `overallresult` VALUES (26, '轻度脂肪肝', '腹部彩超提示轻度脂肪肝，建议控制体重、加强运动。', 26);
INSERT INTO `overallresult` VALUES (27, '血红蛋白偏低', '血红蛋白偏低，考虑轻度贫血，建议补充铁剂后复查。', 26);
INSERT INTO `overallresult` VALUES (28, '尿常规异常', '尿蛋白阳性，建议复查尿常规并咨询肾内科。', 28);
INSERT INTO `overallresult` VALUES (29, '建议定期体检', '建议每年进行一次全面体检，关注血压、血糖、血脂变化。', 28);
INSERT INTO `overallresult` VALUES (30, '建议定期体检', '建议每年进行一次全面体检，关注血压、血糖、血脂变化。', 29);
INSERT INTO `overallresult` VALUES (31, '血脂偏高', '总胆固醇轻度升高，建议低脂饮食，1 个月后复查血脂。', 31);
INSERT INTO `overallresult` VALUES (32, '血压偏高', '血压 146/94 mmHg，建议低盐饮食并监测血压变化。', 32);
INSERT INTO `overallresult` VALUES (33, '轻度脂肪肝', '腹部彩超提示轻度脂肪肝，建议控制体重、加强运动。', 32);
INSERT INTO `overallresult` VALUES (34, '血红蛋白偏低', '血红蛋白偏低，考虑轻度贫血，建议补充铁剂后复查。', 34);
INSERT INTO `overallresult` VALUES (35, '尿常规异常', '尿蛋白阳性，建议复查尿常规并咨询肾内科。', 34);
INSERT INTO `overallresult` VALUES (36, '尿常规异常', '尿蛋白阳性，建议复查尿常规并咨询肾内科。', 35);
INSERT INTO `overallresult` VALUES (37, '总体正常', '本次体检各项指标基本正常，请注意规律作息、均衡饮食。', 37);
INSERT INTO `overallresult` VALUES (38, '血脂偏高', '总胆固醇轻度升高，建议低脂饮食，1 个月后复查血脂。', 38);
INSERT INTO `overallresult` VALUES (39, '血压偏高', '血压 146/94 mmHg，建议低盐饮食并监测血压变化。', 38);

-- ----------------------------
-- Table structure for setmeal
-- ----------------------------
DROP TABLE IF EXISTS `setmeal`;
CREATE TABLE `setmeal`  (
  `smId` int NOT NULL AUTO_INCREMENT COMMENT '体检套餐编号',
  `name` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '体检套餐名称',
  `type` int NOT NULL COMMENT '体检套餐类型(1:男士套餐;0:女士套餐)',
  `price` int NOT NULL COMMENT '体检套餐价格',
  PRIMARY KEY (`smId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '体检套餐信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of setmeal
-- ----------------------------
INSERT INTO `setmeal` VALUES (1, '男士基础套餐', 1, 399);
INSERT INTO `setmeal` VALUES (2, '男士全面套餐', 1, 899);
INSERT INTO `setmeal` VALUES (3, '女士基础套餐', 0, 459);
INSERT INTO `setmeal` VALUES (4, '女士全面套餐', 0, 999);

-- ----------------------------
-- Table structure for setmealdetailed
-- ----------------------------
DROP TABLE IF EXISTS `setmealdetailed`;
CREATE TABLE `setmealdetailed`  (
  `sdId` int NOT NULL AUTO_INCREMENT COMMENT '体检套餐项目明细编号',
  `smId` int NOT NULL COMMENT '体检套餐编号',
  `ciId` int NOT NULL COMMENT '体检检查项编号',
  PRIMARY KEY (`sdId`) USING BTREE,
  INDEX `idx_sd_smId`(`smId` ASC) USING BTREE,
  INDEX `idx_sd_ciId`(`ciId` ASC) USING BTREE,
  CONSTRAINT `fk_sd_checkitem` FOREIGN KEY (`ciId`) REFERENCES `checkitem` (`ciId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_sd_setmeal` FOREIGN KEY (`smId`) REFERENCES `setmeal` (`smId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '体检套餐项目明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of setmealdetailed
-- ----------------------------
INSERT INTO `setmealdetailed` VALUES (1, 1, 1);
INSERT INTO `setmealdetailed` VALUES (2, 1, 2);
INSERT INTO `setmealdetailed` VALUES (3, 1, 4);
INSERT INTO `setmealdetailed` VALUES (4, 2, 1);
INSERT INTO `setmealdetailed` VALUES (5, 2, 2);
INSERT INTO `setmealdetailed` VALUES (6, 2, 3);
INSERT INTO `setmealdetailed` VALUES (7, 2, 4);
INSERT INTO `setmealdetailed` VALUES (8, 2, 5);
INSERT INTO `setmealdetailed` VALUES (9, 3, 1);
INSERT INTO `setmealdetailed` VALUES (10, 3, 2);
INSERT INTO `setmealdetailed` VALUES (11, 3, 4);
INSERT INTO `setmealdetailed` VALUES (12, 3, 6);
INSERT INTO `setmealdetailed` VALUES (13, 4, 1);
INSERT INTO `setmealdetailed` VALUES (14, 4, 2);
INSERT INTO `setmealdetailed` VALUES (15, 4, 3);
INSERT INTO `setmealdetailed` VALUES (16, 4, 4);
INSERT INTO `setmealdetailed` VALUES (17, 4, 5);
INSERT INTO `setmealdetailed` VALUES (18, 4, 6);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `userId` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户编号(手机号码)',
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `realName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '真实姓名',
  `sex` int NOT NULL COMMENT '用户性别(1:男;0:女)',
  `identityCard` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '身份证号',
  `birthday` date NOT NULL COMMENT '出生日期',
  `userType` int NOT NULL COMMENT '用户类型(1:普通用户;2:东软内部员工;3:其他)',
  PRIMARY KEY (`userId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('12345678900', '123456', '周年', 1, '111111111111111111', '2026-11-16', 1);
INSERT INTO `users` VALUES ('13700001001', '123456', '赵敏', 0, '210101199203140011', '1992-03-14', 1);
INSERT INTO `users` VALUES ('13700001002', '123456', '钱伟', 1, '210101198807220022', '1988-07-22', 1);
INSERT INTO `users` VALUES ('13700001003', '123456', '孙丽', 0, '210101199511050033', '1995-11-05', 1);
INSERT INTO `users` VALUES ('13700001004', '123456', '李强', 1, '210101199001190044', '1990-01-19', 1);
INSERT INTO `users` VALUES ('13700001005', '123456', '周婷', 0, '210101199309080055', '1993-09-08', 1);
INSERT INTO `users` VALUES ('13700001006', '123456', '吴昊', 1, '210101198512300066', '1985-12-30', 1);
INSERT INTO `users` VALUES ('13700001007', '123456', '郑爽', 0, '210101199804160077', '1998-04-16', 1);
INSERT INTO `users` VALUES ('13700001008', '123456', '王磊', 1, '210101199106250088', '1991-06-25', 1);
INSERT INTO `users` VALUES ('13800005678', '123456', '王五', 1, '110101198808083456', '1988-08-08', 1);
INSERT INTO `users` VALUES ('13900001234', '123456', '李四', 0, '110101199505052345', '1995-05-05', 2);
INSERT INTO `users` VALUES ('15642388888', '123456', '张三', 1, '110101199001011234', '1990-01-01', 1);

SET FOREIGN_KEY_CHECKS = 1;
