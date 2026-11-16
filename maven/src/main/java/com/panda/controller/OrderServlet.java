package com.panda.controller;

import com.panda.dao.OrdersDAO;
import com.panda.dao.impl.OrdersDAOImpl;
import com.panda.entity.OrderView;
import com.panda.entity.Orders;
import com.panda.utils.JsonUtil;
import com.panda.utils.ReportGenerator;
import com.panda.utils.ResultVO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

//订单接口：
//POST /order/create            创建订单（同时生成空体检报告）
//GET  /order/findbyuser?userId 用户订单列表
//GET  /order/findone/{id}      订单详情
//POST /order/cancel/{id}       取消订单
//POST /order/archive/{id}      归档订单
@WebServlet("/order/*")
public class OrderServlet extends HttpServlet {

    private final OrdersDAO ordersDAO = new OrdersDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String path = req.getPathInfo();
            if (path != null && path.equals("/findbyuser")) {
                String userId = req.getParameter("userId");
                List<OrderView> list = ordersDAO.findByUserId(userId);
                JsonUtil.write(resp, ResultVO.success("查询成功", list));
                return;
            }
            if (path != null && path.startsWith("/findone/")) {
                Integer orderId = JsonUtil.pathId(path);
                OrderView order = orderId == null ? null : ordersDAO.findById(orderId);
                if (order == null) {
                    JsonUtil.write(resp, ResultVO.fail("订单不存在"));
                } else {
                    JsonUtil.write(resp, ResultVO.success("查询成功", order));
                }
                return;
            }
            JsonUtil.write(resp, ResultVO.fail("未知的订单接口"));
        } catch (Exception e) {
            JsonUtil.write(resp, ResultVO.fail("查询失败：" + e.getMessage()));
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String path = req.getPathInfo();
            if (path == null) {
                JsonUtil.write(resp, ResultVO.fail("未知的订单接口"));
                return;
            }
            if (path.equals("/create")) {
                createOrder(req, resp);
                return;
            }
            if (path.startsWith("/cancel/")) {
                Integer orderId = JsonUtil.pathId(path);
                boolean ok = orderId != null && ordersDAO.deleteById(orderId);
                JsonUtil.write(resp, ok ? ResultVO.success("已取消预约") : ResultVO.fail("取消失败"));
                return;
            }
            if (path.startsWith("/archive/")) {
                Integer orderId = JsonUtil.pathId(path);
                boolean ok = orderId != null && ordersDAO.updateState(orderId, 2);
                JsonUtil.write(resp, ok ? ResultVO.success("已归档") : ResultVO.fail("归档失败"));
                return;
            }
            JsonUtil.write(resp, ResultVO.fail("未知的订单接口"));
        } catch (Exception e) {
            JsonUtil.write(resp, ResultVO.fail("操作失败：" + e.getMessage()));
        }
    }

    private void createOrder(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Map<String, Object> body = JsonUtil.readMap(req);
        String orderDate = JsonUtil.getStr(body, "orderDate");
        String userId = JsonUtil.getStr(body, "userId");
        Integer hpId = JsonUtil.getInt(body, "hpId");
        Integer smId = JsonUtil.getInt(body, "smId");
        if (orderDate == null || userId == null || hpId == null || smId == null) {
            JsonUtil.write(resp, ResultVO.fail("预约信息不完整"));
            return;
        }
        Orders order = new Orders();
        order.setOrderDate(LocalDate.parse(orderDate));
        order.setUserId(userId);
        order.setHpId(hpId);
        order.setSmId(smId);
        order.setState(1);

        int orderId = ordersDAO.create(order);
        //按套餐检查项生成空报告，供医生后续填写
        ReportGenerator.generate(orderId, smId);

        OrderView view = ordersDAO.findById(orderId);
        JsonUtil.write(resp, ResultVO.success("预约成功", view));
    }
}
