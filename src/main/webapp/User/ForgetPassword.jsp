<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="preconnect" href="https://cdn.jsdelivr.net">
<title>Forget Password</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
    background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
    font-family: Arial, sans-serif;
}
.card {
    border-radius: 15px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
}
.card-header {
    background: #ffc107;
    color: #000;
    font-weight: bold;
    border-top-left-radius: 15px;
    border-top-right-radius: 15px;
    text-align: center;
}
.btn-custom {
    background-color: #ffc107;
    color: #000;
    font-weight: 600;
    transition: all 0.3s ease;
}
.btn-custom:hover {
    background-color: #ffca2c;
    color: #000;
    box-shadow: 0 4px 15px rgba(255, 193, 7, 0.5);
}
</style>
</head>
<body>

<div class="container d-flex justify-content-center align-items-center vh-100">
    <div class="card p-4" style="width: 100%; max-width: 400px;">
        <div class="card-header">
            Reset Your Password
        </div>
        <div class="card-body">
            <form method="post" action="../ForgetPasswordController">
                
               
                <div class="mb-3">
                    <label class="form-label">Enter your Email</label>
                    <input type="text" name="email" class="form-control" placeholder="Enter email" required>
                </div>

                <button type="submit" name="btn" value="forget" class="btn btn-custom w-100">Send Mail</button>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>