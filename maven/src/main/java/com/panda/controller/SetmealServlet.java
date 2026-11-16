package com.panda.controller;

import com.panda.dao.SetmealDAO;
import com.panda.dao.impl.SetmealDAOImpl;
import com.panda.entity.Setmeal;
import com.panda.utils.JsonUtil;
import com.panda.utils.ResultVO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

//套餐接口：GET /setmeal/findall[?type=1]   GET /setmeal/findone/{smId}
@WebServlet("/setmeal/*")
public class SetmealServlet extends HttpServlet {

    private final SetmealDAO setmealDAO = new SetmealDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String path = req.getPathInfo();
            if (path == null || path.equals("/") || path.equals("/findall")) {
                String typeStr = req.getParameter("type");
                if (typeStr == null || typeStr.trim().isEmpty()) {
                    JsonUtil.write(resp, ResultVO.success("查询成功", setmealDAO.findAll()));
                } else {
                    JsonUtil.write(resp, ResultVO.success("查询成功", setmealDAO.findByType(Integer.valueOf(typeStr))));
                }
                return;
            }
            if (path.startsWith("/findone/")) {
                Integer smId = JsonUtil.pathId(path);
                Setmeal setmeal = smId == null ? null : setmealDAO.findById(smId);
                if (setmeal == null) {
                    JsonUtil.write(resp, ResultVO.fail("套餐不存在"));
                } else {
                    JsonUtil.write(resp, ResultVO.success("查询成功", setmeal));
                }
                return;
            }
            JsonUtil.write(resp, ResultVO.fail("未知的套餐接口"));
        } catch (Exception e) {
            JsonUtil.write(resp, ResultVO.fail("查询失败：" + e.getMessage()));
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        doGet(req, resp);
    }
}
