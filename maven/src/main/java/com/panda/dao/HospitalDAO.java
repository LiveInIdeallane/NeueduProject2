package com.panda.dao;

import com.panda.entity.Hospital;

import java.util.List;

public interface HospitalDAO {

    List<Hospital> findAll() throws Exception;

    Hospital findById(int hpId) throws Exception;
}
