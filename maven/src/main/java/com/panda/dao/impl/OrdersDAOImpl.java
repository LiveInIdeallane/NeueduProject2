package com.panda.dao.impl;

import com.panda.dao.OrdersDAO;
import com.panda.entity.OrderView;
import com.panda.entity.Orders;
import com.panda.utils.DBUtils;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class OrdersDAOImpl implements OrdersDAO {

    private static final String BASE_SQL =
            "select o.orderId, o.orderDate, o.userId, o.hpId, o.smId, o.state, " +
            "u.realName, u.sex, u.identityCard, u.birthday, " +
            "h.name as hospitalName, s.name as setmealName, s.price, s.type " +
            "from orders o " +
            "left join users u on o.userId = u.userId " +
            "left join hospital h on o.hpId = h.hpId " +
            "left join setmeal s on o.smId = s.smId ";

    @Override
    public List<OrderView> findAll() throws Exception {
        List<OrderView> list = new ArrayList<>();
        Connection conn = DBUtils.getConnection();
        PreparedStatement ps = conn.prepareStatement(BASE_SQL + "order by o.orderId desc");
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            list.add(mapRow(rs));
        }
        rs.close();
        ps.close();
        return list;
    }

    @Override
    public List<OrderView> findByUserId(String userId) throws Exception {
        List<OrderView> list = new ArrayList<>();
        Connection conn = DBUtils.getConnection();
        PreparedStatement ps = conn.prepareStatement(BASE_SQL + "where o.userId = ? order by o.orderId desc");
        ps.setString(1, userId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            list.add(mapRow(rs));
        }
        rs.close();
        ps.close();
        return list;
    }

    @Override
    public OrderView findById(int orderId) throws Exception {
        Connection conn = DBUtils.getConnection();
        PreparedStatement ps = conn.prepareStatement(BASE_SQL + "where o.orderId = ?");
        ps.setInt(1, orderId);
        ResultSet rs = ps.executeQuery();
        OrderView view = rs.next() ? mapRow(rs) : null;
        rs.close();
        ps.close();
        return view;
    }

    @Override
    public int create(Orders order) throws Exception {
        Connection conn = DBUtils.getConnection();
        String sql = "insert into orders(orderDate, userId, hpId, smId, state) values(?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        ps.setDate(1, Date.valueOf(order.getOrderDate()));
        ps.setString(2, order.getUserId());
        ps.setInt(3, order.getHpId());
        ps.setInt(4, order.getSmId());
        ps.setInt(5, order.getState() == null ? 1 : order.getState());
        ps.executeUpdate();
        ResultSet keys = ps.getGeneratedKeys();
        int id = keys.next() ? keys.getInt(1) : 0;
        keys.close();
        ps.close();
        return id;
    }

    @Override
    public boolean updateState(int orderId, int state) throws Exception {
        Connection conn = DBUtils.getConnection();
        PreparedStatement ps = conn.prepareStatement("update orders set state = ? where orderId = ?");
        ps.setInt(1, state);
        ps.setInt(2, orderId);
        int rows = ps.executeUpdate();
        ps.close();
        return rows > 0;
    }

    @Override
    public boolean deleteById(int orderId) throws Exception {
        Connection conn = DBUtils.getConnection();
        //先删子表（报告明细 -> 报告项 -> 总检结论），再删订单，避免外键约束报错
        deleteChildren(conn, "delete from cidetaliedreport where orderId = ?", orderId);
        deleteChildren(conn, "delete from cireport where orderId = ?", orderId);
        deleteChildren(conn, "delete from overallresult where orderId = ?", orderId);
        PreparedStatement ps = conn.prepareStatement("delete from orders where orderId = ?");
        ps.setInt(1, orderId);
        int rows = ps.executeUpdate();
        ps.close();
        return rows > 0;
    }

    private void deleteChildren(Connection conn, String sql, int orderId) throws Exception {
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, orderId);
        ps.executeUpdate();
        ps.close();
    }

    private OrderView mapRow(ResultSet rs) throws Exception {
        OrderView v = new OrderView();
        v.setOrderId(rs.getInt("orderId"));
        Date orderDate = rs.getDate("orderDate");
        v.setOrderDate(orderDate == null ? null : orderDate.toLocalDate());
        v.setUserId(rs.getString("userId"));
        v.setHpId(rs.getInt("hpId"));
        v.setSmId(rs.getInt("smId"));
        v.setState(rs.getInt("state"));
        v.setRealName(rs.getString("realName"));
        v.setSex(rs.getInt("sex"));
        v.setIdentityCard(rs.getString("identityCard"));
        Date birthday = rs.getDate("birthday");
        v.setBirthday(birthday == null ? null : birthday.toLocalDate());
        v.setHospitalName(rs.getString("hospitalName"));
        v.setSetmealName(rs.getString("setmealName"));
        v.setPrice(rs.getInt("price"));
        v.setType(rs.getInt("type"));
        return v;
    }
}
