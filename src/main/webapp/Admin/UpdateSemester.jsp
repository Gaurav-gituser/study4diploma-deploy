<%@page import="Dao.SemesterDao"%>
<%@page import="Dao.YearDao"%>
<%@page import="Model.semester"%>
<%@page import="Model.Year"%>
<%@page import="java.util.ArrayList"%>
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
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="preconnect" href="https://cdn.jsdelivr.net">
    <title>Manage Semesters</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<%
    SemesterDao semesterDao = new SemesterDao();
    ArrayList<semester> allSem = semesterDao.getAllsemesters();

    YearDao yearDao = new YearDao();
    ArrayList<Year> allYears = yearDao.getAllyears(); // You must implement this if not done
%>

<div class="container mt-5">

   
        <p class="text-end">
<a href="./AdminPanel.jsp" class="btn btn-secondary me-2">← Back to Admin Panel</a>
<a href="./SemesterInsert.jsp" class="btn btn-dark">Add New Semester</a>        </p>
  
    <table class="table table-bordered w-75 mx-auto">
        <thead>
            <tr>
                <th>Semester</th>
                <th>Year</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>

        <%
            if (allSem != null && !allSem.isEmpty()) {
                for (semester sem : allSem) {
                    Year selectedYear = yearDao.getYearById(sem.getYear());
        %>
        <tr>
            <form action="../SemesterController" method="post">
                <td>
                    <input type="text" name="semesterName" class="form-control" value="<%= sem.getSemester() %>" disabled>
                </td>
                <td>
                    <!-- Displayed when not editing -->
                    <input type="text" class="form-control year-text" value="<%= selectedYear != null ? selectedYear.getyear() : "Unknown" %>" disabled>

                    <!-- Dropdown hidden by default -->
                    <select name="year" class="form-select year-select d-none">
                        <% for (Year y : allYears) { %>
                            <option value="<%= y.getyear_id() %>" <%= y.getyear_id().equals(sem.getYear()) ? "selected" : "" %>>
                                <%= y.getyear() %>
                            </option>
                        <% } %>
                    </select>
                </td>
                <td>
                    <input type="hidden" name="semesterId" value="<%= sem.getSemesterId() %>">
                    <input class="btn btn-info btn-update" type="submit" value="Update" name="btn" hidden>
                    <button type="button" class="btn btn-success btn-edit">Edit</button>
                    <input class="btn btn-danger" type="submit" value="Delete" name="btn">
                </td>
            </form>
        </tr>
        <%
                }
            } else {
        %>
            <tr>
                <td colspan="3" class="text-center">No semesters found.</td>
            </tr>
        <%
            }
        %>

        </tbody>
    </table>
</div>

<!-- JQuery and Edit/Cancel logic -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
    $("body").on("click", ".btn-edit", function () {
        const row = $(this).closest("tr");

        // Enable semester input
        row.find("input[name='semesterName']").removeAttr("disabled");

        // Toggle year input/display
        row.find(".year-text").addClass("d-none");
        row.find(".year-select").removeClass("d-none");

        // Show update button, hide edit, add cancel
        row.find(".btn-update").removeAttr("hidden");
        row.find("td:last").prepend("<button type='button' class='btn btn-warning btn-cancel me-1'>Cancel</button>");
        $(this).hide();
    });

    $("body").on("click", ".btn-cancel", function () {
        const row = $(this).closest("tr");

        // Re-disable semester input
        row.find("input[name='semesterName']").attr("disabled", "disabled");

        // Toggle year dropdown/display
        row.find(".year-text").removeClass("d-none");
        row.find(".year-select").addClass("d-none");

        // Hide update, show edit again, remove cancel
        row.find(".btn-update").attr("hidden", true);
        row.find(".btn-edit").show();
        $(this).remove();
    });
</script>

</body>
</html>
