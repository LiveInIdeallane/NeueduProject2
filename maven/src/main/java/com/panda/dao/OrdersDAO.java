package com.panda.dao;

import com.panda.entity.OrderView;
import com.panda.entity.Orders;

import java.util.List;

public interface OrdersDAO {

    List<OrderView> findAll() throws Exception;

    List<OrderView> findByUserId(String userId) throws Exception;

    OrderView findById(int orderId) throws Exception;

    int create(Orders order) throws Exception;

    boolean updateState(int orderId, int state) throws Exception;

    boolean deleteById(int orderId) throws Exception;
}
