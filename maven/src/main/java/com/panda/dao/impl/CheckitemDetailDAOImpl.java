package com.panda.dao.impl;

import com.panda.dao.CheckitemDetailedDAO;
import com.panda.entity.CheckitemDetailed;
import com.panda.utils.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CheckitemDetailDAOImpl implements CheckitemDetailedDAO {

    private static final String COLUMNS =
            "cdId, name, unit, minrange, maxrange, normalValue, normalValueString, type, ciId, remarks";

    @Override
    public List<CheckitemDetailed> findAll() throws Exception {
        List<CheckitemDetailed> list = new ArrayList<>();
        Connection conn = DBUtils.getConnection();
        PreparedStatement ps = conn.prepareStatement(
                "select " + COLUMNS + " from checkitemdetailed order by cdId");
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            list.add(mapRow(rs));
        }
        rs.close();
        ps.close();
        return list;
    }

    @Override
    public List<CheckitemDetailed> findByCiId(int ciId) throws Exception {
        List<CheckitemDetailed> list = new ArrayList<>();
        Connection conn = DBUtils.getConnection();
        PreparedStatement ps = conn.prepareStatement(
                "select " + COLUMNS + " from checkitemdetailed where ciId = ? order by cdId");
        ps.setInt(1, ciId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            list.add(mapRow(rs));
        }
        rs.close();
        ps.close();
        return list;
    }

    @Override
    public CheckitemDetailed findById(int id) throws Exception {
        return null;
    }

    @Override
    public boolean deleteById(int id) throws Exception {
        return false;
    }

    @Override
    public boolean create(CheckitemDetailed checkitemDetailed) throws Exception {
        return false;
    }

    private CheckitemDetailed mapRow(ResultSet rs) throws Exception {
        CheckitemDetailed d = new CheckitemDetailed();
        d.setCdId(rs.getInt("cdId"));
        d.setName(rs.getString("name"));
        d.setUnit(rs.getString("unit"));
        double min = rs.getDouble("minrange");
        d.setMinrange(rs.wasNull() ? null : min);
        double max = rs.getDouble("maxrange");
        d.setMaxrange(rs.wasNull() ? null : max);
        d.setNormalValue(rs.getString("normalValue"));
        d.setNormalValueString(rs.getString("normalValueString"));
        d.setType(rs.getInt("type"));
        d.setCiId(rs.getInt("ciId"));
        d.setRemarks(rs.getString("remarks"));
        return d;
    }
}
