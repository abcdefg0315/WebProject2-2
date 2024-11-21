<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit User</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Edit User</h2>
    <%
        // MariaDB 연결 정보 설정
        String url = "jdbc:mariadb://walab.handong.edu:3306/OSS24_22300383";
        String username = "OSS24_22300383";
        String password = "HunieD8z";

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
    %>
    <div class="alert alert-danger" role="alert">
        No ID specified for editing.
    </div>
    <a href="list.jsp" class="btn btn-primary mt-3">Go Back</a>
    <%
    } else {
        int id = Integer.parseInt(idParam);
        String name = null;
        int age = 0;
        String email = null;

        // 데이터베이스에서 기존 사용자 정보 조회
        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM person WHERE id = ?")) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                name = rs.getString("name");
                age = rs.getInt("age");
                email = rs.getString("email");
            } else {
    %>
    <div class="alert alert-danger" role="alert">
        User not found.
    </div>
    <a href="list.jsp" class="btn btn-primary mt-3">Go Back</a>
    <%
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

        if (name != null) {
    %>
    <form action="edit_ok.jsp" method="post">
        <input type="hidden" name="id" value="<%= id %>">
        <div class="form-group">
            <label for="name">Name:</label>
            <input type="text" class="form-control" id="name" name="name" value="<%= name %>" required>
        </div>
        <div class="form-group">
            <label for="age">Age:</label>
            <input type="number" class="form-control" id="age" name="age" value="<%= age %>" required>
        </div>
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" class="form-control" id="email" name="email" value="<%= email %>" required>
        </div>
        <button type="submit" class="btn btn-success">Save Changes</button>
        <a href="list.jsp" class="btn btn-secondary">Cancel</a>
    </form>
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
