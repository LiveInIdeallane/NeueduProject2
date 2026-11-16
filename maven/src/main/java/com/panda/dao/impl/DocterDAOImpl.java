package com.panda.dao.impl;

import com.panda.dao.DocterDAO;
import com.panda.entity.Doctor;
import com.panda.utils.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DocterDAOImpl implements DocterDAO {

    @Override
    public List<Doctor> findAll() throws Exception {
        List<Doctor> list = new ArrayList<>();
        Connection conn = DBUtils.getConnection();
        String sql = "select docId, docCode, realName, password, sex, deptno from doctor order by docId";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            list.add(mapRow(rs));
        }
        rs.close();
        ps.close();
        return list;
    }

    @Override
    public Doctor login(String docCode, String password) throws Exception {
        Connection conn = DBUtils.getConnection();
        String sql = "select docId, docCode, realName, password, sex, deptno from doctor " +
                "where lower(docCode) = lower(?) and password = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, docCode);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();
        Doctor doctor = rs.next() ? mapRow(rs) : null;
        rs.close();
        ps.close();
        return doctor;
    }

    private Doctor mapRow(ResultSet rs) throws Exception {
        Doctor d = new Doctor();
        d.setDocId(rs.getInt("docId"));
        d.setDocCode(rs.getString("docCode"));
        d.setRealName(rs.getString("realName"));
        d.setPassword(rs.getString("password"));
        d.setSex(rs.getInt("sex"));
        d.setDeptno(rs.getInt("deptno"));
        return d;
    }
}
