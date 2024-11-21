<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Data Insert Result</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Data Insert Result</h2>
    <%
        // MariaDB 연결 정보 설정 (DB 정보는 실제 환경에 맞게 변경하세요)
        String url = "jdbc:mariadb://walab.handong.edu:3306/OSS24_22300383";
        String username = "OSS24_22300383";
        String password = "HunieD8z";

        // 폼 데이터 가져오기
        String name = request.getParameter("name");
        String ageStr = request.getParameter("age");
        String email = request.getParameter("email");

        // 데이터베이스 삽입 로직
        Connection conn = null;
        PreparedStatement pstmt = null;

        // 기본적인 유효성 검사
        if (name == null || name.trim().isEmpty() || ageStr == null || ageStr.trim().isEmpty() || email == null || email.trim().isEmpty()) {
    %>
    <div class="alert alert-danger" role="alert">
        모든 필드를 입력해 주세요.
    </div>
    <a href="add_user.jsp" class="btn btn-primary mt-3">Go Back</a>
    <%
    } else {
        int age = 0;
        try {
            age = Integer.parseInt(ageStr); // 나이를 정수로 변환
        } catch (NumberFormatException e) {
    %>
    <div class="alert alert-danger" role="alert">
        나이는 숫자여야 합니다.
    </div>
    <a href="add_user.jsp" class="btn btn-primary mt-3">Go Back</a>
    <%
            return; // 잘못된 입력이므로 실행을 중단
        }

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
    %>
    <div class="alert alert-success" role="alert">
        데이터가 성공적으로 삽입되었습니다.
    </div>
    <%
    } else {
    %>
    <div class="alert alert-danger" role="alert">
        데이터 삽입에 실패했습니다.
    </div>
    <%
        }
    } catch (Exception e) {
    %>
    <div class="alert alert-danger" role="alert">
        오류 발생: <%= e.getMessage() %>
    </div>
    <%
            } finally {
                // 자원 정리
                if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
                if (conn != null) try { conn.close(); } catch (Exception e) {}
            }
        }
    %>
    <a href="add_user.jsp" class="btn btn-primary mt-3">Go Back</a> <!-- 작성 페이지로 돌아가기 -->
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
