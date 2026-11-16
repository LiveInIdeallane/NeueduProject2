package com.panda.controller;

import com.panda.dao.DocterDAO;
import com.panda.dao.OrdersDAO;
import com.panda.dao.impl.DocterDAOImpl;
import com.panda.dao.impl.OrdersDAOImpl;
import com.panda.entity.Doctor;
import com.panda.entity.OrderView;
import com.panda.utils.JsonUtil;
import com.panda.utils.ResultVO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

//医生端接口：POST /doctor/login    GET /doctor/queryCustomers
@WebServlet("/doctor/*")
public class DoctorServlet extends HttpServlet {

    private final DocterDAO docterDAO = new DocterDAOImpl();
    private final OrdersDAO ordersDAO = new OrdersDAOImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String path = req.getPathInfo();
            if (path != null && path.equals("/login")) {
                Map<String, Object> body = JsonUtil.readMap(req);
                String docCode = JsonUtil.getStr(body, "docCode");
                String password = JsonUtil.getStr(body, "password");
                Doctor doctor = docCode == null || password == null ? null : docterDAO.login(docCode.trim(), password);
                if (doctor == null) {
                    JsonUtil.write(resp, ResultVO.fail("医生工号或密码错误"));
                } else {
                    JsonUtil.write(resp, ResultVO.success("登录成功", doctor));
                }
                return;
            }
            JsonUtil.write(resp, ResultVO.fail("未知的医生接口"));
        } catch (Exception e) {
            JsonUtil.write(resp, ResultVO.fail("登录失败：" + e.getMessage()));
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String path = req.getPathInfo();
            if (path != null && path.equals("/queryCustomers")) {
                JsonUtil.write(resp, ResultVO.success("查询成功", queryCustomers(req)));
                return;
            }
            JsonUtil.write(resp, ResultVO.fail("未知的医生接口"));
        } catch (Exception e) {
            JsonUtil.write(resp, ResultVO.fail("查询失败：" + e.getMessage()));
        }
    }

    private List<OrderView> queryCustomers(HttpServletRequest req) throws Exception {
        String userId = trim(req.getParameter("userId"));
        String realName = trim(req.getParameter("realName"));
        String sex = trim(req.getParameter("sex"));
        String type = trim(req.getParameter("type"));
        String orderDate = trim(req.getParameter("orderDate"));
        String state = trim(req.getParameter("state"));

        List<OrderView> result = new ArrayList<>();
        for (OrderView order : ordersDAO.findAll()) {
            if (userId != null && !contains(order.getUserId(), userId)) {
                continue;
            }
            if (realName != null && !contains(order.getRealName(), realName)) {
                continue;
            }
            if (sex != null && !sex.equals(String.valueOf(order.getSex()))) {
                continue;
            }
            if (type != null && !type.equals(String.valueOf(order.getType()))) {
                continue;
            }
            if (orderDate != null && !orderDate.equals(String.valueOf(order.getOrderDate()))) {
                continue;
            }
            if (state != null && !state.equals(String.valueOf(order.getState()))) {
                continue;
            }
            result.add(order);
        }
        return result;
    }

    private String trim(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        return value.trim();
    }

    private boolean contains(String source, String keyword) {
        return source != null && source.contains(keyword);
    }
}
