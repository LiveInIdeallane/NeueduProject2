package com.panda.dao.impl;

import com.panda.dao.SetmealDetailedDAO;
import com.panda.entity.Checkitem;
import com.panda.entity.SetmealDetailed;
import com.panda.utils.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SetmealDetailDAOImpl implements SetmealDetailedDAO {

    @Override
    public List<SetmealDetailed> findAllDetailed() throws Exception {
        List<SetmealDetailed> list = new ArrayList<>();
        Connection conn = DBUtils.getConnection();
        PreparedStatement ps = conn.prepareStatement(
                "select sdId, smId, ciId from setmealdetailed order by sdId");
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            list.add(new SetmealDetailed(
                    rs.getInt("sdId"),
                    rs.getInt("smId"),
                    rs.getInt("ciId")));
        }
        rs.close();
        ps.close();
        return list;
    }

    @Override
    public List<Checkitem> findCheckitemsBySmId(int smId) throws Exception {
        List<Checkitem> list = new ArrayList<>();
        Connection conn = DBUtils.getConnection();
        String sql = "select c.ciId, c.ciName, c.ciContent, c.meaning, c.remarks " +
                "from setmealdetailed sd join checkitem c on sd.ciId = c.ciId " +
                "where sd.smId = ? order by sd.sdId";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, smId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            list.add(new Checkitem(
                    rs.getInt("ciId"),
                    rs.getString("ciName"),
                    rs.getString("ciContent"),
                    rs.getString("meaning"),
                    rs.getString("remarks")));
        }
        rs.close();
        ps.close();
        return list;
    }
}
