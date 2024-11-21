<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.Statement" %>
<!DOCTYPE html>
<html>
<head>
  <title>User List</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%@ include file="top.jsp" %>
<div class="container mt-5">
  <h1 class="mb-4">User List</h1>
  <%
    String url = "jdbc:mariadb://walab.handong.edu:3306/OSS24_22300383";
    String username = "OSS24_22300383";
    String password = "HunieD8z";
    ResultSet rs = null;

    try {
      // 데이터베이스 연결
      Connection conn = DriverManager.getConnection(url, username, password);
      Statement stmt = conn.createStatement();
      rs = stmt.executeQuery("SELECT * FROM person");

      // 데이터베이스 결과를 request 속성에 설정
      request.setAttribute("resultSet", rs);
  %>
  <jsp:include page="view.jsp" />
  <%
    // 자원 정리는 view.jsp에서 수행
  } catch (Exception e) {
  %>
  <div class="alert alert-danger">오류 발생: <%= e.getMessage() %></div>
  <%
    }
  %>

</div>
<%@ include file="footer.jsp" %>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
