package com.panda.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.panda.entity.Users;
import com.panda.service.UsersService;
import com.panda.service.impl.UsersServiceImpl;
import com.panda.utils.ResultVO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;


//用户的全查找
@WebServlet("/user/findall")
public class UsersFindAllServlet extends HttpServlet {

    private UsersService usersService = new UsersServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        //解决中文乱码
        resp.setContentType("application/json;charset=UTF-8");

        List<Users> usersList = usersService.findAll();
        ResultVO sucess = ResultVO.success("查询成功",usersList);

        ObjectMapper mapper = new ObjectMapper();
        mapper.registerModule(new JavaTimeModule());
        PrintWriter writer = resp.getWriter();

        mapper.writeValue(writer,sucess);
        writer.flush();
        writer.close();

    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        doGet(req, resp);

    }
}
