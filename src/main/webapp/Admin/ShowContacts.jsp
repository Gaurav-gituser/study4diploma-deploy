<%@ page import="java.util.List" %>
<%@ page import="Model.Contact" %>
<%@ page import="Dao.ContactDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Contact Messages</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f6f9;
        }
        .container {
            margin-top: 60px;
        }
        .table-wrapper {
            background: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0,0,0,0.08);
        }
        h2 {
            color: #007bff;
            font-weight: 600;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="table-wrapper">
        <h2 class="text-center mb-4">📩 All Contact Messages</h2>

        <%
            ContactDao dao = new ContactDao();
            List<Contact> contactList = dao.getAllContacts();
            if (contactList != null && !contactList.isEmpty()) {
        %>

        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle text-center">
                <thead class="table-primary">
                    <tr>
                      
                        <th>Name</th>
                        <th>Email</th>
                        <th>Message</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Contact c : contactList) { %>
                        <tr>
                         
                            <td><%= c.getName() %></td>
                            <td><%= c.getEmail() %></td>
                            <td><%= c.getComment() %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <% } else { %>
            <div class="alert alert-info text-center">No contact messages found.</div>
        <% } %>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
