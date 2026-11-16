package com.panda.utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtils {

    private static ThreadLocal<Connection> threadLocal = new ThreadLocal<Connection>();

    static{
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    public static Connection getConnection(){
        Connection conn = threadLocal.get();
        if(conn == null){
            try {
                String url = System.getenv().getOrDefault(
                        "DB_URL",
                        "jdbc:mysql://localhost:3306/neueduproject2?useUnicode=true&characterEncoding=utf8&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Shanghai"
                );
                String user = System.getenv().getOrDefault("DB_USER", "root");
                String password = System.getenv().getOrDefault("DB_PASSWORD", "123456");
                conn = DriverManager.getConnection(url, user, password);
                threadLocal.set(conn);
            }catch (Exception e){
                throw new RuntimeException(e);
            }
        }
        return conn;
    }

    public static void closeConnection(){
        Connection conn = threadLocal.get();
        if(conn!=null){
            try {
                conn.close();
                threadLocal.remove();
            }catch (Exception e){
                throw new RuntimeException(e);
            }
        }
    }


}
