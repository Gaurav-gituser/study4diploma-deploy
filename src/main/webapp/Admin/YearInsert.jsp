<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>Insert Year</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .form-container {
            max-width: 450px;
            margin: 100px auto;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .form-label {
            font-weight: 600;
        }

        .btn-submit {
            width: 100%;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="form-container">
        <h2>Insert Year</h2>

        <form action="../YearController" method="post">
            <!-- Input field for Year -->
            <div class="mb-3">
                <label for="year" class="form-label">Enter Year</label>
                <input type="text" class="form-control" name="year" id="year" placeholder="e.g., 1st year" required>
            </div>

            <!-- Hidden field for year_id (handled by server) -->
            <input type="hidden" name="year_id" value="">

            <!-- Submit button -->
            <button type="submit" class="btn btn-primary btn-submit" name="btn" value="insert">Submit</button>
        </form>
    </div>
</div>

<!-- Bootstrap 5 JS (optional for dynamic components) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
