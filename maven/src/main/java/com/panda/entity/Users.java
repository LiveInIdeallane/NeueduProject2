package com.panda.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Users {
    private String userId;           // 用户编号（手机号码）
    private String password;         // 密码
    private String realName;         // 真实姓名
    private Integer sex;             // 用户性别（1：男；0：女）
    private String identityCard;     // 身份证号
    private LocalDate birthday;      // 出生日期
    private Integer userType;        // 用户类型
}