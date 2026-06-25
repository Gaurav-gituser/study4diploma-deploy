<%@page import="Dao.YearDao"%>
<%@page import="Model.Year"%>
<%@page import="java.util.ArrayList"%>
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
    <title>Add Semester</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f1f4f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .form-container {
            max-width: 550px;
            margin: 80px auto;
            padding: 35px;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .form-label {
            font-weight: 600;
        }

        .btn-submit {
            width: 100%;
        }

        h3 {
            font-weight: bold;
            margin-bottom: 25px;
        }
    </style>
</head>
<body>

<%
    YearDao dao = new YearDao();
    ArrayList<Year> allYears = dao.getAllyears();
%>

<div class="container">
    <div class="form-container">
        <h3 class="text-center">Add Semester</h3>

        <form action="../SemesterController" method="post">

            <div class="mb-3">
                <label for="yearSelect" class="form-label">Select Year</label>
                <select name="year" class="form-select" id="yearSelect" required>
                    <option value="" disabled selected>Choose year</option>
                    <%
                        for (Year year : allYears) {
                    %>
                        <option value="<%= year.getyear_id() %>"><%= year.getyear() %></option>
                    <%
                        }
                    %>
                </select>
            </div>

            <div class="mb-3">
                <label for="semesterInput" class="form-label">Enter Semester</label>
                <input type="text" name="semester" class="form-control" id="semesterInput" placeholder="e.g., Semester 1" required>
            </div>

            <button type="submit" class="btn btn-primary btn-submit" name="btn" value="insert">Submit</button>
        </form>
    </div>
</div>

<!-- Bootstrap JS (optional) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
