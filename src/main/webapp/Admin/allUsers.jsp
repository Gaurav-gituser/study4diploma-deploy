<%@ page import="java.util.List" %>
<%@ page import="Model.User" %>
<%@ page import="Dao.UserDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>All Users</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        }
        .table-container {
            margin-top: 50px;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        h2 {
            color: #007bff;
        }
    </style>
</head>
<body>

<div class="container table-container">
    <h2 class="text-center mb-4">All Registered Users</h2>

    <%
        UserDao dao = new UserDao();
        List<User> users = dao.getAllUsers();
        if (users != null && !users.isEmpty()) {
    %>

    <div class="table-responsive">
        <table class="table table-striped table-bordered align-middle">
            <thead class="table-primary">
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Created At</th>
                    <th>Role ID</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
            <% for (User user : users) { %>
                <tr>
                    <td><%= user.getName() %></td>
                    <td><%= user.getEmail() %></td>
                    <td><%= user.getPhone() %></td>
                    <td><%= user.getCreated_at() %></td>
                    <td><%= user.getRoleId() %></td>
                    <td><a href="../UserController?btn=delete&userId=<%= user.getUserId() %>" 
       						onclick="return confirm('Are you sure you want to delete this user?')"
       						style="color:red; font-weight:600;">Delete</a>
                   </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <% } else { %>
        <div class="alert alert-info text-center">No users found.</div>
    <% } %>

    <!-- Back Button -->
    <a href="AdminPanel.jsp" class="btn btn-secondary mt-4">← Back to Admin Panel</a>

</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>