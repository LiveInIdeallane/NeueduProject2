package com.panda.dao;

import com.panda.entity.CiReport;

import java.util.List;

public interface CiReportDAO {

    List<CiReport> findAll() throws Exception;

    List<CiReport> findByOrderId(int orderId) throws Exception;

    int create(CiReport ciReport) throws Exception;
}
