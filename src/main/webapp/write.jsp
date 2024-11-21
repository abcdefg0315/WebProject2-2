<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add User</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Add User</h2>
    <form name="userForm" id="userForm" action="write.jsp" method="post">
        <div class="form-group">
            <label for="name">Name:</label>
            <input type="text" class="form-control" id="name" name="name" placeholder="Enter name" required>
        </div>
        <div class="form-group">
            <label for="age">Age:</label>
            <input type="number" class="form-control" id="age" name="age" placeholder="Enter age" required>
        </div>
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" class="form-control" id="email" name="email" placeholder="Enter email" required>
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
    </form>

    <%
        // MariaDB 연결 정보 설정 (DB 정보는 실제 사용 환경에 맞게 변경하세요)
        String url = "jdbc:mariadb://walab.handong.edu:3306/OSS24_22300383";
        String username = "OSS24_22300383";
        String password = "HunieD8z";

        // POST 요청인 경우 폼 데이터를 처리
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            // 폼 데이터 가져오기
            String name = request.getParameter("name");
            String ageStr = request.getParameter("age");
            String email = request.getParameter("email");

            // 결과 메시지를 저장할 변수
            String message = null;
            String alertClass = "alert-danger"; // 기본적으로 실패 메시지 스타일

            // 유효성 검사
            if (name != null && !name.trim().isEmpty() &&
                    ageStr != null && !ageStr.trim().isEmpty() &&
                    email != null && !email.trim().isEmpty()) {

                int age = 0;
                try {
                    age = Integer.parseInt(ageStr); // 나이를 정수로 변환
                    Connection conn = null;
                    PreparedStatement pstmt = null;

                    try {
                        // 데이터베이스 연결
                        Class.forName("org.mariadb.jdbc.Driver");
                        conn = DriverManager.getConnection(url, username, password);
                        String sql = "INSERT INTO person (name, age, email) VALUES (?, ?, ?)";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, name);
                        pstmt.setInt(2, age);
                        pstmt.setString(3, email);

                        int result = pstmt.executeUpdate();
                        if (result > 0) {
                            message = "User added successfully!";
                            alertClass = "alert-success";
                        } else {
                            message = "Failed to add user. Please try again.";
                        }
                    } catch (Exception e) {
                        message = "Error: " + e.getMessage();
                    } finally {
                        // 자원 정리
                        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
                        if (conn != null) try { conn.close(); } catch (Exception e) {}
                    }
                } catch (NumberFormatException e) {
                    message = "Invalid age format. Please enter a valid number.";
                }
            } else {
                message = "All fields are required.";
            }

            // 메시지 출력
            if (message != null) {
    %>
    <div class="alert <%= alertClass %> mt-3" role="alert">
        <%= message %>
    </div>
    <%
            }
        }
    %>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
