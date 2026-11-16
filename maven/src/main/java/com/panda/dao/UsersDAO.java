package com.panda.dao;

import com.panda.entity.Users;

import java.util.List;

public interface UsersDAO {
    List<Users> findAll()throws Exception;
    Users findById(int id)throws Exception;
    Boolean deleteById(int id)throws Exception;
    //登录验证：账号+密码匹配则返回用户，否则返回null
    Users login(String userId, String password)throws Exception;
    //按手机号查询，用于注册时判断账号是否已存在
    Users findByUserId(String userId)throws Exception;
    //新增用户，成功返回true
    Boolean register(Users user)throws Exception;
}
