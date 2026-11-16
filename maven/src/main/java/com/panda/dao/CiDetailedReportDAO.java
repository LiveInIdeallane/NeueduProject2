package com.panda.dao;

import com.panda.entity.CiDetailedReport;

import java.util.List;

public interface CiDetailedReportDAO {

    List<CiDetailedReport> findAllCiDetailedReport() throws Exception;

    List<CiDetailedReport> findByCirId(int cirId) throws Exception;

    boolean updateValue(int cidrId, String value, int isError) throws Exception;

    int create(CiDetailedReport item) throws Exception;
}
