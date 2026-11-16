package com.panda.dao;

import com.panda.entity.Doctor;

import java.util.List;

public interface DocterDAO {

    List<Doctor> findAll() throws Exception;

    Doctor login(String docCode, String password) throws Exception;
}
