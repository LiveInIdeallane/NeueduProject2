package com.panda.dao.impl;

import com.panda.dao.SetmealDAO;
import com.panda.entity.Setmeal;
import com.panda.utils.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SetmealDAOImpl implements SetmealDAO {

    @Override
    public List<Setmeal> findAll() throws Exception {
        return query("select smId, name, type, price from setmeal order by smId", null);
    }

    @Override
    public List<Setmeal> findByType(Integer type) throws Exception {
        return query("select smId, name, type, price from setmeal where type = ? order by smId", type);
    }

    @Override
    public Setmeal findById(int smId) throws Exception {
        Connection conn = DBUtils.getConnection();
        String sql = "select smId, name, type, price from setmeal where smId = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, smId);
        ResultSet rs = ps.executeQuery();
        Setmeal setmeal = null;
        if (rs.next()) {
            setmeal = mapRow(rs);
        }
        rs.close();
        ps.close();
        if (setmeal != null) {
            fillItems(setmeal);
        }
        return setmeal;
    }

    private List<Setmeal> query(String sql, Integer type) throws Exception {
        List<Setmeal> list = new ArrayList<>();
        Connection conn = DBUtils.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
        if (type != null) {
            ps.setInt(1, type);
        }
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            list.add(mapRow(rs));
        }
        rs.close();
        ps.close();
        for (Setmeal setmeal : list) {
            fillItems(setmeal);
        }
        return list;
    }

    private Setmeal mapRow(ResultSet rs) throws Exception {
        Setmeal s = new Setmeal();
        s.setSmId(rs.getInt("smId"));
        s.setName(rs.getString("name"));
        s.setType(rs.getInt("type"));
        s.setPrice(rs.getInt("price"));
        return s;
    }

    //填充套餐包含的检查项名称与说明
    private void fillItems(Setmeal setmeal) throws Exception {
        List<String> items = new ArrayList<>();
        Connection conn = DBUtils.getConnection();
        String sql = "select c.ciName from setmealdetailed sd " +
                "join checkitem c on sd.ciId = c.ciId where sd.smId = ? order by sd.sdId";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, setmeal.getSmId());
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            items.add(rs.getString("ciName"));
        }
        rs.close();
        ps.close();
        setmeal.setItems(items);
        setmeal.setDesc(items.isEmpty() ? "" : "共 " + items.size() + " 项检查");
    }
}
