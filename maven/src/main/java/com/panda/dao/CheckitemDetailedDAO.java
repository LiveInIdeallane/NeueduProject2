package com.panda.dao;

import com.panda.entity.CheckitemDetailed;

import java.util.List;

public interface CheckitemDetailedDAO {
    List<CheckitemDetailed> findAll() throws Exception;

    List<CheckitemDetailed> findByCiId(int ciId) throws Exception;

    CheckitemDetailed findById(int id) throws Exception;

    boolean deleteById(int id) throws Exception;

    boolean create(CheckitemDetailed checkitemDetailed) throws Exception;
}
