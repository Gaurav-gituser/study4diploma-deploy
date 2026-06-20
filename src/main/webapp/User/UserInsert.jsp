<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Insert User</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f0f2f5;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }
    .form-container {
      background: white;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 0 15px rgba(0,0,0,0.1);
      width: 320px;
    }
    .form-container h2 {
      text-align: center;
      margin-bottom: 20px;
      color: #333;
    }
    .form-group {
      margin-bottom: 15px;
    }
    label {
      display: block;
      margin-bottom: 5px;
      font-weight: 600;
      color: #555;
    }
    input[type="text"],
    input[type="email"],
    input[type="password"] {
      width: 100%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 5px;
      box-sizing: border-box;
      font-size: 14px;
    }
    input:focus {
      border-color: #007bff;
      outline: none;
      box-shadow: 0 0 2px rgba(0,123,255,0.5);
    }
    .submit-btn {
      width: 100%;
      padding: 12px;
      background-color: #28a745;
      border: none;
      border-radius: 5px;
      color: white;
      font-size: 16px;
      font-weight: bold;
      cursor: pointer;
    }
    .submit-btn:hover {
      background-color: #218838;
    }
  </style>
</head>
<body>
  <div class="form-container">
    <h2>Insert User</h2>
    <form action="../UserController" method="post">
      <div class="form-group">
           <div class="form-group">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required />
      </div>
      <div class="form-group">
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required />
      </div>
      <div class="form-group">
        <label for="password">Password:</label>
        <input type="password"
               id="password" name="password"
               pattern="(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{8,}"
               title="At least 8 characters including letters, number & symbol"
               required />
      </div>
      <button type="submit" name="btn" value="insert" class="submit-btn">
        Submit
      </button>
    </form>
  </div>
</body>
</html>
    