package com.panda.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Setmeal {
    private Integer smId;            // 体检套餐编号
    private String name;             // 体检套餐名称
    private Integer type;            // 体检套餐类型（1：男士套餐；0：女士套餐）
    private Integer price;           // 体检套餐价格
    private List<String> items;      // 套餐包含的检查项名称（非表字段，查询时填充）
    private String desc;             // 套餐说明（非表字段，查询时填充）
}
