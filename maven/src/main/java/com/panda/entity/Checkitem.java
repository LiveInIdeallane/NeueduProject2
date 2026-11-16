package com.panda.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Checkitem {
    private Integer ciId;            // 检查项编号
    private String ciName;           // 检查项名称
    private String ciContent;        // 检查项内容
    private String meaning;          // 检查项意义
    private String remarks;          // 备注
}
