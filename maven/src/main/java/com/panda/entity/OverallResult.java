package com.panda.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OverallResult {
    private Integer orId;            // 总检结论项编号
    private String title;            // 总检结论项标题
    private String content;          // 总检结论项内容
    private Integer orderId;         // 所属预约编号
}
