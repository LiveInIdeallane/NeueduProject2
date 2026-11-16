package com.panda.service.impl;

import com.panda.dao.UsersDAO;
import com.panda.dao.impl.UsersDAOImpl;
import com.panda.entity.Users;
import com.panda.service.UsersService;
import com.panda.utils.DBUtils;

import java.sql.SQLException;
import java.util.List;

public class UsersServiceImpl implements UsersService {

    //创建DAO层实体
    private UsersDAO userDAO = new UsersDAOImpl();

    @Override
    public List<Users> findAll() {
        List<Users> users = null;
        try {
            DBUtils.getConnection().setAutoCommit(false);
            users = userDAO.findAll();
            DBUtils.getConnection().commit();
        } catch (Exception e) {
            try {
                DBUtils.getConnection().rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
            e.printStackTrace();
        }finally {
            DBUtils.closeConnection();
        }
        return users;

    }

    @Override
    public Users login(String userId, String password) {
        Users user = null;
        try {
            DBUtils.getConnection().setAutoCommit(false);
            user = userDAO.login(userId, password);
            DBUtils.getConnection().commit();
        } catch (Exception e) {
            try {
                DBUtils.getConnection().rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
            e.printStackTrace();
        } finally {
            DBUtils.closeConnection();
        }
        return user;
    }

    @Override
    public boolean exists(String userId) {
        Users user = null;
        try {
            DBUtils.getConnection().setAutoCommit(false);
            user = userDAO.findByUserId(userId);
            DBUtils.getConnection().commit();
        } catch (Exception e) {
            try {
                DBUtils.getConnection().rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
            e.printStackTrace();
        } finally {
            DBUtils.closeConnection();
        }
        return user != null;
    }

    @Override
    public Users register(Users user) {
        Users registered = null;
        try {
            DBUtils.getConnection().setAutoCommit(false);
            if (userDAO.register(user)) {
                registered = user;
            }
            DBUtils.getConnection().commit();
        } catch (Exception e) {
            try {
                DBUtils.getConnection().rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
            e.printStackTrace();
        } finally {
            DBUtils.closeConnection();
        }
        return registered;
    }
}
