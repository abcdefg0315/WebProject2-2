<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Result</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Edit Result</h2>
    <%
        // MariaDB 연결 정보 설정
        String url = "jdbc:mariadb://localhost:3306/project_db"; // 실제 DB 이름으로 변경
        String username = "root"; // DB 사용자 이름
        String password = "root"; // DB 비밀번호

        // 폼 데이터 가져오기
        String idParam = request.getParameter("id");
        String updatedName = request.getParameter("name");
        String updatedAgeStr = request.getParameter("age");
        String updatedEmail = request.getParameter("email");

        // 유효성 검사
        if (idParam == null || idParam.trim().isEmpty() ||
                updatedName == null || updatedName.trim().isEmpty() ||
                updatedAgeStr == null || updatedAgeStr.trim().isEmpty() ||
                updatedEmail == null || updatedEmail.trim().isEmpty()) {
    %>
    <div class="alert alert-danger" role="alert">
        All fields are required. Please go back and try again.
    </div>
    <a href="edit.jsp?id=<%= idParam %>" class="btn btn-primary mt-3">Go Back</a>
    <%
    } else {
        int id = Integer.parseInt(idParam);
        int updatedAge = Integer.parseInt(updatedAgeStr);

        // 데이터베이스 업데이트 로직
        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(
                     "UPDATE sample_table SET name = ?, age = ?, email = ? WHERE id = ?")) {
            pstmt.setString(1, updatedName);
            pstmt.setInt(2, updatedAge);
            pstmt.setString(3, updatedEmail);
            pstmt.setInt(4, id);

            int result = pstmt.executeUpdate();
            if (result > 0) {
    %>
    <div class="alert alert-success" role="alert">
        User information updated successfully.
    </div>
    <a href="list.jsp" class="btn btn-primary mt-3">View User List</a>
    <%
    } else {
    %>
    <div class="alert alert-danger" role="alert">
        Failed to update user information.
    </div>
    <a href="edit.jsp?id=<%= idParam %>" class="btn btn-primary mt-3">Go Back</a>
    <%
        }
    } catch (Exception e) {
    %>
    <div class="alert alert-danger" role="alert">
        Error updating user information: <%= e.getMessage() %>
    </div>
    <a href="edit.jsp?id=<%= idParam %>" class="btn btn-primary mt-3">Go Back</a>
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
