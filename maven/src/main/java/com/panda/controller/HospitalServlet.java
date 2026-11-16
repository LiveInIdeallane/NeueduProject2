package com.panda.controller;

import com.panda.dao.HospitalDAO;
import com.panda.dao.impl.HospitalDAOImpl;
import com.panda.entity.Hospital;
import com.panda.utils.JsonUtil;
import com.panda.utils.ResultVO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

//医院接口：GET /hospital/findall   GET /hospital/findone/{hpId}
@WebServlet("/hospital/*")
public class HospitalServlet extends HttpServlet {

    private final HospitalDAO hospitalDAO = new HospitalDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String path = req.getPathInfo();
            if (path == null || path.equals("/") || path.equals("/findall")) {
                JsonUtil.write(resp, ResultVO.success("查询成功", hospitalDAO.findAll()));
                return;
            }
            if (path.startsWith("/findone/")) {
                Integer hpId = JsonUtil.pathId(path);
                Hospital hospital = hpId == null ? null : hospitalDAO.findById(hpId);
                if (hospital == null) {
                    JsonUtil.write(resp, ResultVO.fail("医院不存在"));
                } else {
                    JsonUtil.write(resp, ResultVO.success("查询成功", hospital));
                }
                return;
            }
            JsonUtil.write(resp, ResultVO.fail("未知的医院接口"));
        } catch (Exception e) {
            JsonUtil.write(resp, ResultVO.fail("查询失败：" + e.getMessage()));
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        doGet(req, resp);
    }
}
