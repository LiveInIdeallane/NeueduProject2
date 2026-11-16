package com.panda.dao;

import com.panda.entity.OverallResult;

import java.util.List;

public interface OverallResultDAO {
    List<OverallResult> findAll() throws Exception;

    List<OverallResult> findByOrderId(int orderId) throws Exception;

    int add(OverallResult result) throws Exception;

    boolean update(int orId, String title, String content) throws Exception;

    boolean deleteById(int orId) throws Exception;
}
