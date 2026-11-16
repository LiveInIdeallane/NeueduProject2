package com.panda.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

//订单联表视图（订单 + 用户 + 医院 + 套餐），供前端直接展示
@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderView {
    private Integer orderId;
    private LocalDate orderDate;
    private String userId;
    private Integer hpId;
    private Integer smId;
    private Integer state;
    private String realName;
    private Integer sex;
    private String identityCard;
    private LocalDate birthday;
    private String hospitalName;
    private String setmealName;
    private Integer price;
    private Integer type;
}
