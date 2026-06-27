<%@page import="Model.User"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    User user = (User) session.getAttribute("verifyuser") ; // coming from ForgetPassword_Controller
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="preconnect" href="https://cdn.jsdelivr.net">
<title>Reset Password</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container d-flex justify-content-center align-items-center" style="height:100vh;">
    <div class="card p-4 shadow" style="width: 400px;">
        <h4 class="text-center mb-3">Reset Your Password</h4>

        <form method="post" action="../ForgetPasswordController">
            <!-- Email (readonly) -->
            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" class="form-control" name="email" value="<%=user.getEmail()%>" readonly>
            </div>

            <!-- New Password -->
            <div class="mb-3">
                <label class="form-label">New Password</label>
                <input type="password" class="form-control" name="newPassword" placeholder="Enter New Password" required>
            </div>

            <!-- Confirm Password -->
            <div class="mb-3">
                <label class="form-label">Confirm Password</label>
                <input type="password" class="form-control" name="confirmPassword" placeholder="Confirm New Password" required>
            </div>

            <!-- Submit -->
            <button type="submit" name="btn" value="update" class="btn btn-success w-100">Update Password</button>
        </form>
    </div>
</div>

</body>
</html>