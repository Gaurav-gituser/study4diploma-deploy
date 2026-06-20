<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <title>SIGN_UP</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="./signin.css">
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
      <h2>Sign Up</h2>
      <form action="../UserController" method="post">
        <label for="name">Full Name</label>
        <input type="text" name="name" id="name" placeholder="Enter Name" required="required">

        <label for="email">Email</label>
        <input type="email" name="email" id="email" placeholder="Enter Email" required="required">

        <label for="password">Password</label>
        <input type="password"
               name="password" id="password"
               placeholder="Enter Password"
               pattern="(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{8,}"
               title="At least 8 characters including letters, number & symbol"
               required>

        <button type="submit" name="btn" value="insert">Sign Up</button>
      </form>
      <p>Already have an account? <a href="login.jsp">Login</a></p>
    </div>
  </div>

  <script src="signin.js"></script>
</body>

</html>
