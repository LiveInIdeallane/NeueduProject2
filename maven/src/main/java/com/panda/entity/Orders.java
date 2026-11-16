package com.panda.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Orders {
    private Integer orderId;         // 订单编号
    private LocalDate orderDate;     // 预约日期
    private String userId;           // 客户编号
    private Integer hpId;            // 所属医院编号
    private Integer smId;            // 所属套餐编号
    private Integer state;           // 订单状态（1：未归档；2：已归档）
}