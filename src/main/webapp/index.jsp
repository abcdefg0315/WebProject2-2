<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.Statement" %>
<!DOCTYPE html>
<html>
<head>
  <title>MariaDB Connection Test</title>
  <meta charset="UTF-8">
</head>
<body>
<h1>MariaDB 데이터 출력</h1>
<table border="1">
  <tr>
    <th>ID</th>
    <th>Name</th>
    <th>Age</th>
    <th>Email</th>
    <th>Actions</th>
  </tr>
  <%
    String url = "jdbc:mariadb://localhost:3306/project_db";
    String username = "root";
    String password = "root";

    try {
      // 데이터베이스 연결
      Connection conn = DriverManager.getConnection(url, username, password);
      Statement stmt = conn.createStatement();
      ResultSet rs = stmt.executeQuery("SELECT * FROM sample_table");

      // 데이터베이스의 각 행을 HTML 테이블 행으로 출력
      while (rs.next()) {
        int id = rs.getInt("id");
  %>
  <tr>
    <td><%= id %></td>
    <td><%= rs.getString("name") %></td>
    <td><%= rs.getInt("age") %></td>
    <td><%= rs.getString("email") %></td>
    <td>
      <!-- 삭제 및 수정 버튼 추가 -->
      <a href="delete_ok.jsp?id=<%= id %>" class="btn btn-danger">Delete</a>
      <a href="edit.jsp?id=<%= id %>" class="btn btn-primary">Edit</a>
    </td>
  </tr>
  <%
      }

      // 자원 정리
      rs.close();
      stmt.close();
      conn.close();
    } catch (Exception e) {
      e.printStackTrace(); // 에러를 출력합니다.
    }
  %>
</table>
</body>
</html>
