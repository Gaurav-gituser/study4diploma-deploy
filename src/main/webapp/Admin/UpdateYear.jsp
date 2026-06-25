<%@page import="Dao.YearDao"%>
<%@ page import="Model.Year" %>
<%@ page import="java.util.ArrayList" %>
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
    <title>Manage Years</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<%
    HttpSession session1 = request.getSession();
YearDao dao = new YearDao();
    ArrayList<Year> yrList = dao.getAllyears();
%>

<div class="container mt-5">

    <form action="../YearController" method="post">
        <p class="text-end">
<a href="./AdminPanel.jsp" class="btn btn-secondary me-2">← Back to Admin Panel</a>
<a href="./YearInsert.jsp" class="btn btn-dark">Add New Year</a>        </p>
    </form>

    <table class="table table-bordered w-75 mx-auto">
        <thead>
            <tr>
                <th>Year</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>

        <%
            if (yrList != null) {
                for (Year years : yrList) {
        %>
        <tr>
            <form action="../YearController" method="post">
                <td>
                    <input type="text" name="year" class="form-control" value="<%= years.getyear() %>" disabled>
                </td>
                <td>
                    <input type="hidden" name="year_id" value="<%= years.getyear_id() %>">
                    <input class="btn btn-info btn-update" type="submit" value="update" name="btn" hidden>
                    <button type="button" class="btn btn-success btn-edit">Edit</button>
                    <input class="btn btn-danger" type="submit" value="delete" name="btn">
                </td>
            </form>
        </tr>
        <%
                }
            } else {
                out.print("<tr><td colspan='2'>No years found.</td></tr>");
            }
        %>

        </tbody>
    </table>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
    $("body").on("click", ".btn-edit", function () {
        var row = $(this).closest("tr");
        row.find("input[name='year']").removeAttr("disabled");
        row.find(".btn-update").removeAttr("hidden");
        row.find("td:eq(1)").prepend("<button class='btn btn-warning btn-cancel'>Cancel</button>");
        $(this).hide();
    });

    $("body").on("click", ".btn-cancel", function () {
        var row = $(this).closest("tr");
        row.find("input[name='year']").attr("disabled", "disabled");
        row.find(".btn-update").attr("hidden", true);
        row.find(".btn-edit").show();
        $(this).remove();
    });

    $("body").on("click", ".btn-update", function () {
        // Nothing extra needed here; form submits
    });
</script>

</body>
</html>
