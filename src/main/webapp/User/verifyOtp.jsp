<%@page import="Model.User"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="preconnect" href="https://cdn.jsdelivr.net">
<title>OTP Verification</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<% User user = (User) session.getAttribute("otp");  %>
<div class="container d-flex justify-content-center align-items-center" style="height:100vh;">
    <div class="card p-4 shadow" style="width: 400px;">
        <h4 class="text-center mb-3">Verify OTP</h4>
        
        <form method="post" action="../ForgetPasswordController">
            <div class="mb-3">
                <label class="form-label">Send On Email</label>
                <input type="email" class="form-control" name="email"
                       value="<%=user.getEmail() %>" readonly>
            </div>
             <input type="hidden" value="<%=user.getOtp() %>" class="form-control" name="serverotp" >
            <div class="mb-3">
                <label class="form-label">Enter OTP</label>
                <input type="text" class="form-control" name="otp" placeholder="Enter OTP" required>
            </div>
            
            <button type="submit" name="btn" value="verifyOtp" class="btn btn-primary w-100">Verify</button>
        </form>
    </div>
</div>

</body>
</html>