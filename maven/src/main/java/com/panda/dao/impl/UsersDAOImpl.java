package com.panda.dao.impl;

import com.panda.dao.UsersDAO;
import com.panda.entity.Users;
import com.panda.utils.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class UsersDAOImpl implements UsersDAO {
    @Override
    public List<Users> findAll() throws Exception {
        List<Users> usersList = new ArrayList<>();
        Connection conn = DBUtils.getConnection();
        String sql = "select userId, password, realName, sex, identityCard, birthday, userType from users";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            usersList.add(mapRow(rs));
        }
        rs.close();
        ps.close();
        return usersList;
    }

    @Override
    public Users findById(int id) throws Exception {
        return null;
    }

    @Override
    public Boolean deleteById(int id) throws Exception {
        return null;
    }

    @Override
    public Users login(String userId, String password) throws Exception {
        Connection conn = DBUtils.getConnection();
        //用 ? 占位符，避免SQL注入；不要用字符串拼接
        String sql = "select userId, password, realName, sex, identityCard, birthday, userType " +
                "from users where userId = ? and password = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, userId);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();
        Users user = null;
        if (rs.next()) {
            user = mapRow(rs);
        }
        rs.close();
        ps.close();
        return user;
    }

    @Override
    public Users findByUserId(String userId) throws Exception {
        Connection conn = DBUtils.getConnection();
        String sql = "select userId, password, realName, sex, identityCard, birthday, userType " +
                "from users where userId = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, userId);
        ResultSet rs = ps.executeQuery();
        Users user = null;
        if (rs.next()) {
            user = mapRow(rs);
        }
        rs.close();
        ps.close();
        return user;
    }

    @Override
    public Boolean register(Users user) throws Exception {
        Connection conn = DBUtils.getConnection();
        String sql = "insert into users(userId, password, realName, sex, identityCard, birthday, userType) " +
                "values(?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, user.getUserId());
        ps.setString(2, user.getPassword());
        ps.setString(3, user.getRealName());
        ps.setInt(4, user.getSex());
        ps.setString(5, user.getIdentityCard());
        if (user.getBirthday() != null) {
            ps.setDate(6, Date.valueOf(user.getBirthday()));
        } else {
            ps.setDate(6, null);
        }
        ps.setInt(7, user.getUserType());
        int rows = ps.executeUpdate();
        ps.close();
        return rows > 0;
    }

    //把结果集当前行封装成Users对象
    private Users mapRow(ResultSet rs) throws Exception {
        Users user = new Users();
        user.setUserId(rs.getString("userId"));
        user.setPassword(rs.getString("password"));
        user.setRealName(rs.getString("realName"));
        user.setSex(rs.getInt("sex"));
        user.setIdentityCard(rs.getString("identityCard"));
        Date birthday = rs.getDate("birthday");
        if (birthday != null) {
            user.setBirthday(birthday.toLocalDate());
        }
        user.setUserType(rs.getInt("userType"));
        return user;
    }
}
