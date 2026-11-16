package com.panda.dao;

import com.panda.entity.Checkitem;

import java.util.List;

public interface CheckitemDAO {
    List<CheckitemDAO> findAll()throws Exception;
    Checkitem findById(int id)throws Exception;
    Boolean deleteById(int id)throws Exception;
    Boolean create(Checkitem checkitem)throws Exception;

}
