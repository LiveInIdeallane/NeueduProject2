package com.panda.dao.impl;

import com.panda.dao.OverallResultDAO;
import com.panda.entity.OverallResult;
import com.panda.utils.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class OverallResultDAOImpl implements OverallResultDAO {

    @Override
    public List<OverallResult> findAll() throws Exception {
        List<OverallResult> list = new ArrayList<>();
        Connection conn = DBUtils.getConnection();
        PreparedStatement ps = conn.prepareStatement(
                "select orId, title, content, orderId from overallresult order by orId");
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            list.add(mapRow(rs));
        }
        rs.close();
        ps.close();
        return list;
    }

    @Override
    public List<OverallResult> findByOrderId(int orderId) throws Exception {
        List<OverallResult> list = new ArrayList<>();
        Connection conn = DBUtils.getConnection();
        PreparedStatement ps = conn.prepareStatement(
                "select orId, title, content, orderId from overallresult where orderId = ? order by orId");
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
    public int add(OverallResult result) throws Exception {
        Connection conn = DBUtils.getConnection();
        PreparedStatement ps = conn.prepareStatement(
                "insert into overallresult(title, content, orderId) values(?, ?, ?)",
                Statement.RETURN_GENERATED_KEYS);
        ps.setString(1, result.getTitle());
        ps.setString(2, result.getContent());
        ps.setInt(3, result.getOrderId());
        ps.executeUpdate();
        ResultSet keys = ps.getGeneratedKeys();
        int id = keys.next() ? keys.getInt(1) : 0;
        keys.close();
        ps.close();
        return id;
    }

    @Override
    public boolean update(int orId, String title, String content) throws Exception {
        Connection conn = DBUtils.getConnection();
        PreparedStatement ps = conn.prepareStatement(
                "update overallresult set title = ?, content = ? where orId = ?");
        ps.setString(1, title);
        ps.setString(2, content);
        ps.setInt(3, orId);
        int rows = ps.executeUpdate();
        ps.close();
        return rows > 0;
    }

    @Override
    public boolean deleteById(int orId) throws Exception {
        Connection conn = DBUtils.getConnection();
        PreparedStatement ps = conn.prepareStatement("delete from overallresult where orId = ?");
        ps.setInt(1, orId);
        int rows = ps.executeUpdate();
        ps.close();
        return rows > 0;
    }

    private OverallResult mapRow(ResultSet rs) throws Exception {
        return new OverallResult(
                rs.getInt("orId"),
                rs.getString("title"),
                rs.getString("content"),
                rs.getInt("orderId"));
    }
}
