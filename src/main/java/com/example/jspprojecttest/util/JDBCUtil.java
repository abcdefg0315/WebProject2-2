package com.example.jspprojecttest.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBCUtil {
    private static final String URL = "jdbc:mariadb://walab.handong.edu:3306/OSS24_22300383";
    private static final String USER = "OSS24_22300383";
    private static final String PASSWORD = "HunieD8z";

    static {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException("MariaDB 드라이버 로드 실패");
        }
    }

    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("DB 연결 실패");
        }
    }
}
