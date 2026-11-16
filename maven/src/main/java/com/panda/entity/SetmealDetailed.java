package com.panda.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SetmealDetailed {
    private Integer sdId;            // 体检套餐项目明细编号
    private Integer smId;            // 体检套餐编号
    private Integer ciId;            // 体检检查项编号
}
