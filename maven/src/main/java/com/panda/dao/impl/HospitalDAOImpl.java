package com.panda.dao.impl;

import com.panda.dao.HospitalDAO;
import com.panda.entity.Hospital;
import com.panda.utils.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class HospitalDAOImpl implements HospitalDAO {

    @Override
    public List<Hospital> findAll() throws Exception {
        List<Hospital> list = new ArrayList<>();
        Connection conn = DBUtils.getConnection();
        String sql = "select hpId, name, picture, telephone, address, businessHours, deadline, rule, state " +
                "from hospital order by hpId";
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
    public Hospital findById(int hpId) throws Exception {
        Connection conn = DBUtils.getConnection();
        String sql = "select hpId, name, picture, telephone, address, businessHours, deadline, rule, state " +
                "from hospital where hpId = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, hpId);
        ResultSet rs = ps.executeQuery();
        Hospital hospital = rs.next() ? mapRow(rs) : null;
        rs.close();
        ps.close();
        return hospital;
    }

    private Hospital mapRow(ResultSet rs) throws Exception {
        Hospital h = new Hospital();
        h.setHpId(rs.getInt("hpId"));
        h.setName(rs.getString("name"));
        h.setPicture(rs.getString("picture"));
        h.setTelephone(rs.getString("telephone"));
        h.setAddress(rs.getString("address"));
        h.setBusinessHours(rs.getString("businessHours"));
        h.setDeadline(rs.getString("deadline"));
        h.setRule(rs.getString("rule"));
        h.setState(rs.getInt("state"));
        return h;
    }
}
