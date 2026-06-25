<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    Model.User sessionUser = (Model.User) session.getAttribute("user");
    if (sessionUser == null || sessionUser.getRoleId().equalsIgnoreCase("rid_102")) {
        response.sendRedirect("../User/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="../BrancheCantroller" method="post">
<label>Enter a Branche</label>
<input type="text" name="Branche" >
<br><br>


<button type="submit" value="insert" name="btn" >submit</button>
</form>
</body>
</html>