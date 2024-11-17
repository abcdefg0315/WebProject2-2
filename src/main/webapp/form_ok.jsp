<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  String email = request.getParameter("email");
  String username = request.getParameter("username");
  String isCheck = request.getParameter("isCheck");

  if (isCheck != null && isCheck.equals("1")) {
    isCheck = "체크됨!";
  } else {
    isCheck = "체크되지 않음";
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Form Result</title>
</head>
<body>
<h1>Form Submission Result</h1>
<p>이메일: <%= email != null ? email : "이메일이 입력되지 않았습니다." %></p>
<p>사용자 이름: <%= username != null ? username : "이름이 입력되지 않았습니다." %></p>
<p>체크 상태: <%= isCheck %></p>
</body>
</html>
