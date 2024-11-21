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

  <!-- 검색 폼 -->
  <form method="get" action="<%= request.getContextPath() %>/list.jsp" class="mb-4">
    <div class="form-group">
      <input type="text" name="search" class="form-control" placeholder="Search users by name" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
    </div>
    <button type="submit" class="btn btn-primary">Search</button>
  </form>

  <%
    String url = "jdbc:mariadb://walab.handong.edu:3306/OSS24_22300383";
    String username = "OSS24_22300383";
    String password = "HunieD8z";
    ResultSet rs = null;

    String searchQuery = request.getParameter("search"); // 검색어 가져오기
    String query = "SELECT * FROM person";

    // 검색어가 있을 경우 쿼리에 조건 추가
    if (searchQuery != null && !searchQuery.trim().isEmpty()) {
      query += " WHERE name LIKE '%" + searchQuery + "%'";
    }

    try {
      // 데이터베이스 연결
      Connection conn = DriverManager.getConnection(url, username, password);
      Statement stmt = conn.createStatement();
      rs = stmt.executeQuery(query);

      // 데이터베이스 결과를 request 속성에 설정
      request.setAttribute("resultSet", rs);
  %>
  <a href="<%= request.getContextPath() %>/write.jsp" class="btn btn-primary btn-sm mt-3">Add</a>
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
