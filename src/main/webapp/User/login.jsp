<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <title>LOGIN_PAGE</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="login.css">
</head>

<body>
  <canvas id="bgCanvas"></canvas>

  <div class="navbar">
    <div class="logo">Study4Diploma</div>
    <div class="menu">
      <ul>
        <li><a href="index.jsp">HOME</a></li>
        <li><a href="#">CONTACT</a></li>
        <li><a href="#">HELP</a></li>
        <li><a href="#">PROFILE</a></li>
      </ul>
    </div>
    <div class="nav-right"></div>
  </div>

  <div class="login-wrapper">
    <div class="login-box">
      <h2>Login</h2>
      <form action="../LoginController" method="post">
        <label for="email">Email</label>
        <input type="email" id="email" name="email" placeholder="Enter Email" required>

        <label for="password">Password</label>
        <input type="password" id="password" name="password" placeholder="Enter Password" required>

        <button type="submit" name="btn" value="login">Login</button>
      </form>
      <p>Don't have an account? <a href="./Signin.jsp">Sign Up</a></p>
       <p> <a href="./ForgetPassword.jsp">Forget Password</a></p>
    </div>
  </div>

  <script src="login.js"></script>
</body>

</html>
