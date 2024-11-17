package com.example.jspprojecttest.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    // 데이터 삽입 메서드
    public void insertUser(UserVO user) {
        String sql = "INSERT INTO sample_table (name, age, email) VALUES (?, ?, ?)";
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, user.getName());
            pstmt.setInt(2, user.getAge());
            pstmt.setString(3, user.getEmail());
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 모든 사용자 조회 메서드
    public List<UserVO> getAllUsers() {
        List<UserVO> userList = new ArrayList<>();
        String sql = "SELECT * FROM sample_table";
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                UserVO user = new UserVO(rs.getInt("id"), rs.getString("name"), rs.getInt("age"), rs.getString("email"));
                userList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userList;
    }

    // ID로 사용자 조회 메서드 (필요시 추가)
    public UserVO getUserById(int id) {
        UserVO user = null;
        String sql = "SELECT * FROM sample_table WHERE id = ?";
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    user = new UserVO(rs.getInt("id"), rs.getString("name"), rs.getInt("age"), rs.getString("email"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
}