package com.panda.service;

import com.panda.entity.Users;

import java.util.List;

public interface UsersService {
    List<Users> findAll();
    //登录验证：成功返回用户，失败返回null
    Users login(String userId, String password);
    //判断手机号是否已注册
    boolean exists(String userId);
    //注册：成功返回新用户，失败返回null
    Users register(Users user);
}
