package com.panda.utils;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
@WebFilter("/*") // 拦截所有请求
public class CorsFilter implements Filter {
    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws
            IOException, ServletException {


        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;

        // 允许来源，开发写 *，生产不要写*，写前端地址如 http://localhost:5173
        response.setHeader("Access-Control-Allow-Origin", "*");
        // 允许的请求方法
        response.setHeader("Access-Control-Allow-Methods", "GET,POST,PUT,DELETE,OPTIONS");
        // 允许前端携带的请求头
        response.setHeader("Access-Control-Allow-Headers", "Content-Type,Authorization");
        // 预检有效期，单位秒
        response.setHeader("Access-Control-Max-Age", "3600");
        // 是否允许携带cookie，*不能和true同时开启
        // response.setHeader("Access-Control-Allow-Credentials", "true");
        // 重点：预检OPTIONS请求，直接返回200，不要继续走servlet
        if ("OPTIONS".equalsIgnoreCase(request.getMethod())) {
            response.setStatus(HttpServletResponse.SC_OK);
            return;
        }
        chain.doFilter(req, resp);
    }
}
