package com.panda.dao.impl;

import com.panda.dao.CiReportDAO;
import com.panda.entity.CiReport;
import com.panda.utils.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class CiReportDAOImpl implements CiReportDAO {

    @Override
    public List<CiReport> findAll() throws Exception {
        List<CiReport> list = new ArrayList<>();
        Connection conn = DBUtils.getConnection();
        PreparedStatement ps = conn.prepareStatement(
                "select cirId, ciId, ciName, orderId from cireport order by cirId");
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            list.add(mapRow(rs));
        }
        rs.close();
        ps.close();
        return list;
    }

    @Override
    public List<CiReport> findByOrderId(int orderId) throws Exception {
        List<CiReport> list = new ArrayList<>();
        Connection conn = DBUtils.getConnection();
        PreparedStatement ps = conn.prepareStatement(
                "select cirId, ciId, ciName, orderId from cireport where orderId = ? order by cirId");
        ps.setInt(1, orderId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            list.add(mapRow(rs));
        }
        rs.close();
        ps.close();
        return list;
    }

    @Override
    public int create(CiReport ciReport) throws Exception {
        Connection conn = DBUtils.getConnection();
        PreparedStatement ps = conn.prepareStatement(
                "insert into cireport(ciId, ciName, orderId) values(?, ?, ?)",
                Statement.RETURN_GENERATED_KEYS);
        ps.setInt(1, ciReport.getCiId());
        ps.setString(2, ciReport.getCiName());
        ps.setInt(3, ciReport.getOrderId());
        ps.executeUpdate();
        ResultSet keys = ps.getGeneratedKeys();
        int id = keys.next() ? keys.getInt(1) : 0;
        keys.close();
        ps.close();
        return id;
    }

    private CiReport mapRow(ResultSet rs) throws Exception {
        return new CiReport(
                rs.getInt("cirId"),
                rs.getInt("ciId"),
                rs.getString("ciName"),
                rs.getInt("orderId"));
    }
}
