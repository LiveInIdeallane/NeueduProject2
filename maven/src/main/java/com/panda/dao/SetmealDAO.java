package com.panda.dao;

import com.panda.entity.Setmeal;

import java.util.List;

public interface SetmealDAO {
    List<Setmeal> findAll() throws Exception;

    List<Setmeal> findByType(Integer type) throws Exception;

    Setmeal findById(int smId) throws Exception;
}
