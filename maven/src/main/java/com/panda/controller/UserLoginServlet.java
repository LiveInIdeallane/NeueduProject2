package com.panda.controller;

import com.panda.entity.Users;
import com.panda.service.UsersService;
import com.panda.service.impl.UsersServiceImpl;
import com.panda.utils.JsonUtil;
import com.panda.utils.ResultVO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;

//用户登录 POST /user/login  body: {userId, password}
@WebServlet("/user/login")
public class UserLoginServlet extends HttpServlet {

    private final UsersService usersService = new UsersServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            Map<String, Object> body = JsonUtil.readMap(req);
            String userId = JsonUtil.getStr(body, "userId");
            String password = JsonUtil.getStr(body, "password");
            if (userId == null || password == null) {
                JsonUtil.write(resp, ResultVO.fail("请输入手机号码和密码"));
                return;
            }
            Users user = usersService.login(userId.trim(), password);
            if (user == null) {
                JsonUtil.write(resp, ResultVO.fail("手机号码或密码错误"));
                return;
            }
            JsonUtil.write(resp, ResultVO.success("登录成功", user));
        } catch (Exception e) {
            JsonUtil.write(resp, ResultVO.fail("登录失败：" + e.getMessage()));
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        doPost(req, resp);
    }
}
