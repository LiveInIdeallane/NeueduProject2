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

//用户注册 POST /user/register  body: {userId, password, realName, sex, identityCard, birthday}
@WebServlet("/user/register")
public class UserRegisterServlet extends HttpServlet {

    private final UsersService usersService = new UsersServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            Users user = JsonUtil.read(req, Users.class);
            if (user.getUserId() == null || user.getUserId().trim().isEmpty()
                    || user.getPassword() == null || user.getPassword().trim().isEmpty()
                    || user.getRealName() == null || user.getRealName().trim().isEmpty()) {
                JsonUtil.write(resp, ResultVO.fail("手机号码、密码和姓名不能为空"));
                return;
            }
            user.setUserId(user.getUserId().trim());
            if (usersService.exists(user.getUserId())) {
                JsonUtil.write(resp, ResultVO.fail("该手机号码已注册"));
                return;
            }
            if (user.getSex() == null) {
                user.setSex(1);
            }
            if (user.getUserType() == null) {
                user.setUserType(1);
            }
            Users registered = usersService.register(user);
            if (registered == null) {
                JsonUtil.write(resp, ResultVO.fail("注册失败，请检查填写信息"));
                return;
            }
            JsonUtil.write(resp, ResultVO.success("注册成功", registered));
        } catch (Exception e) {
            JsonUtil.write(resp, ResultVO.fail("注册失败：" + e.getMessage()));
        }
    }
}
