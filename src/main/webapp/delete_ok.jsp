<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Confirmation</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <%
        // MariaDB 연결 정보 설정
        String url = "jdbc:mariadb://walab.handong.edu:3306/OSS24_22300383"; // 실제 DB 이름으로 변경
        String username = "OSS24_22300383"; // DB 사용자 이름
        String password = "HunieD8z"; // DB 비밀번호

        // URL 매개변수로 전달된 ID 가져오기
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
    %>
    <div class="alert alert-danger" role="alert">
        No ID specified for deletion.
    </div>
    <a href="list.jsp" class="btn btn-primary mt-3">Go Back</a>
    <%
    } else {
        int id = Integer.parseInt(idParam);
        String name = null;

        // 데이터베이스에서 해당 ID에 대한 이름을 조회
        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement("SELECT name FROM person WHERE id = ?")) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                name = rs.getString("name");
            }
            rs.close();
        } catch (Exception e) {
    %>
    <div class="alert alert-danger" role="alert">
        Error fetching user data: <%= e.getMessage() %>
    </div>
    <a href="list.jsp" class="btn btn-primary mt-3">Go Back</a>
    <%
        }

        if (name == null) {
    %>
    <div class="alert alert-danger" role="alert">
        User not found.
    </div>
    <a href="list.jsp" class="btn btn-primary mt-3">Go Back</a>
    <%
    } else {
    %>
    <h2>Are you sure you want to delete the user: <%= name %>?</h2>
    <form method="post" action="delete_ok.jsp">
        <input type="hidden" name="id" value="<%= id %>">
        <button type="submit" class="btn btn-danger">Delete</button>
        <a href="list.jsp" class="btn btn-secondary">Cancel</a>
    </form>
    <%
            }
        }

        // 삭제 처리 (POST 요청일 경우)
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String idToDelete = request.getParameter("id");

            if (idToDelete != null && !idToDelete.trim().isEmpty()) {
                try (Connection conn = DriverManager.getConnection(url, username, password);
                     PreparedStatement pstmt = conn.prepareStatement("DELETE FROM person WHERE id = ?")) {
                    pstmt.setInt(1, Integer.parseInt(idToDelete));
                    int result = pstmt.executeUpdate();

                    if (result > 0) {
    %>
    <div class="alert alert-success mt-3" role="alert">
        User deleted successfully.
    </div>
    <a href="list.jsp" class="btn btn-primary mt-3">Go Back</a>
    <%
    } else {
    %>
    <div class="alert alert-danger mt-3" role="alert">
        Failed to delete user.
    </div>
    <a href="list.jsp" class="btn btn-primary mt-3">Go Back</a>
    <%
        }
    } catch (Exception e) {
    %>
    <div class="alert alert-danger mt-3" role="alert">
        Error deleting user: <%= e.getMessage() %>
    </div>
    <a href="list.jsp" class="btn btn-primary mt-3">Go Back</a>
    <%
                }
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
