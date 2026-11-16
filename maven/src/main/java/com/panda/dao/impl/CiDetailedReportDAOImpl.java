package com.panda.dao.impl;

import com.panda.dao.CiDetailedReportDAO;
import com.panda.entity.CiDetailedReport;
import com.panda.utils.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class CiDetailedReportDAOImpl implements CiDetailedReportDAO {

    private static final String COLUMNS =
            "cidrId, name, unit, minrange, maxrange, normalValue, normalValueString, " +
            "type, value, isError, ciId, orderId";

    @Override
    public List<CiDetailedReport> findAllCiDetailedReport() throws Exception {
        List<CiDetailedReport> list = new ArrayList<>();
        Connection conn = DBUtils.getConnection();
        PreparedStatement ps = conn.prepareStatement(
                "select " + COLUMNS + " from cidetaliedreport order by cidrId");
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            list.add(mapRow(rs));
        }
        rs.close();
        ps.close();
        return list;
    }

    @Override
    public List<CiDetailedReport> findByCirId(int cirId) throws Exception {
        List<CiDetailedReport> list = new ArrayList<>();
        Connection conn = DBUtils.getConnection();
        PreparedStatement ps = conn.prepareStatement(
                "select " + COLUMNS + " from cidetaliedreport where ciId = ? order by cidrId");
        ps.setInt(1, cirId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            list.add(mapRow(rs));
        }
        rs.close();
        ps.close();
        return list;
    }

    @Override
    public boolean updateValue(int cidrId, String value, int isError) throws Exception {
        Connection conn = DBUtils.getConnection();
        PreparedStatement ps = conn.prepareStatement(
                "update cidetaliedreport set value = ?, isError = ? where cidrId = ?");
        ps.setString(1, value);
        ps.setInt(2, isError);
        ps.setInt(3, cidrId);
        int rows = ps.executeUpdate();
        ps.close();
        return rows > 0;
    }

    @Override
    public int create(CiDetailedReport item) throws Exception {
        Connection conn = DBUtils.getConnection();
        PreparedStatement ps = conn.prepareStatement(
                "insert into cidetaliedreport(name, unit, minrange, maxrange, normalValue, " +
                        "normalValueString, type, value, isError, ciId, orderId) " +
                        "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                Statement.RETURN_GENERATED_KEYS);
        ps.setString(1, item.getName());
        ps.setString(2, item.getUnit());
        setDouble(ps, 3, item.getMinrange());
        setDouble(ps, 4, item.getMaxrange());
        ps.setString(5, item.getNormalValue());
        ps.setString(6, item.getNormalValueString());
        ps.setInt(7, item.getType() == null ? 3 : item.getType());
        ps.setString(8, item.getValue());
        ps.setInt(9, item.getIsError() == null ? 0 : item.getIsError());
        ps.setInt(10, item.getCiId());
        ps.setInt(11, item.getOrderId());
        ps.executeUpdate();
        ResultSet keys = ps.getGeneratedKeys();
        int id = keys.next() ? keys.getInt(1) : 0;
        keys.close();
        ps.close();
        return id;
    }

    private void setDouble(PreparedStatement ps, int index, Double value) throws Exception {
        if (value == null) {
            ps.setNull(index, java.sql.Types.DOUBLE);
        } else {
            ps.setDouble(index, value);
        }
    }

    private CiDetailedReport mapRow(ResultSet rs) throws Exception {
        CiDetailedReport r = new CiDetailedReport();
        r.setCidrId(rs.getInt("cidrId"));
        r.setName(rs.getString("name"));
        r.setUnit(rs.getString("unit"));
        double min = rs.getDouble("minrange");
        r.setMinrange(rs.wasNull() ? null : min);
        double max = rs.getDouble("maxrange");
        r.setMaxrange(rs.wasNull() ? null : max);
        r.setNormalValue(rs.getString("normalValue"));
        r.setNormalValueString(rs.getString("normalValueString"));
        r.setType(rs.getInt("type"));
        r.setValue(rs.getString("value"));
        r.setIsError(rs.getInt("isError"));
        r.setCiId(rs.getInt("ciId"));
        r.setOrderId(rs.getInt("orderId"));
        return r;
    }
}
