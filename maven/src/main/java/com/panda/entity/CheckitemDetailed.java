package com.panda.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CheckitemDetailed {
    private Integer cdId;                // 检查项明细编号
    private String name;                 // 检查项明细名称
    private String unit;                 // 检查项明细单位
    private Double minrange;             // 检查项明细正常值范围中的最小值
    private Double maxrange;             // 检查项明细正常值范围中的最大值
    private String normalValue;          // 检查项明细正常值（非数字型）
    private String normalValueString;    // 检查项验证范围说明文字
    private Integer type;                // 检查项明细类型
    private Integer ciId;                // 所属检查项编号
    private String remarks;              // 备注
}
