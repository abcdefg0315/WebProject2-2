<%@ page import="java.sql.ResultSet" %>
<%
    ResultSet rs = (ResultSet) request.getAttribute("resultSet");
%>
<table class="table table-striped table-hover">
    <thead class="thead-dark">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Age</th>
        <th>Email</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
        if (rs != null) {
            try {
                while (rs.next()) {
                    int id = rs.getInt("id");
    %>
    <tr>
        <td><%= id %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getInt("age") %></td>
        <td><%= rs.getString("email") %></td>
        <td>
            <!-- Bootstrap 버튼 스타일 적용 -->
            <a href="delete_ok.jsp?id=<%= id %>" class="btn btn-danger btn-sm">Delete</a>
            <a href="edit.jsp?id=<%= id %>" class="btn btn-primary btn-sm">Edit</a>
        </td>
    </tr>
    <%
        }
    } catch (Exception e) {
    %>
    <tr>
        <td colspan="5" class="text-danger">오류 발생: <%= e.getMessage() %></td>
    </tr>
    <%
        } finally {
            // 자원 정리
            if (rs != null) try { rs.close(); } catch (Exception e) {}
        }
    } else {
    %>
    <tr>
        <td colspan="5">No data available.</td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>
