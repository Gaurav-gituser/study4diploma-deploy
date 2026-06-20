<%@page import="Model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%

User user = (User) session.getAttribute("user");

session.invalidate();

response.sendRedirect("./index.jsp");

%>
</body>
</html>