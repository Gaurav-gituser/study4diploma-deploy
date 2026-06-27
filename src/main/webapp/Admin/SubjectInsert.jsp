<%@page import="Model.Branche"%>
<%@page import="Dao.BrancheDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>

<%@page import="Model.Scheme"%>
<%@page import="Model.semester"%>

<%@page import="Dao.SchemeDao"%>
<%@page import="Dao.SemesterDao"%>

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
    <title>Add Subject</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%
    BrancheDao branchDao = new BrancheDao();
    SchemeDao schemeDao = new SchemeDao();
    SemesterDao semesterDao = new SemesterDao();

    List<Branche> branchList = branchDao.getAllbranches();
    List<Scheme> schemeList = schemeDao.getAllScheme();
    List<semester> semesterList = semesterDao.getAllsemesters();
%>

<div class="container mt-5 w-50 border p-4 rounded shadow">
    <h3 class="text-center mb-4">Add New Subject</h3>

    <form action="../SubjectController" method="post">
        <div class="mb-3">
            <label for="subjectName" class="form-label">Subject Name</label>
            <input type="text" name="subjectName" class="form-control" id="subjectName" required>
        </div>

        <div class="mb-3">
            <label for="courseCode" class="form-label">Course Code</label>
            <input type="text" name="courseCode" class="form-control" id="courseCode" required>
        </div>

        <div class="mb-3">
            <label for="branch" class="form-label">Branch</label>
            <select name="branchId" id="branch" class="form-select" required>
                <option value="">Select Branch</option>
                <% for (Branche b : branchList) { %>
                    <option value="<%= b.getbranche_id() %>"><%= b.getbranche() %></option>
                <% } %>
            </select>
        </div>

        <div class="mb-3">
            <label for="scheme" class="form-label">Scheme</label>
            <select name="schemeId" id="scheme" class="form-select" required>
                <option value="">Select Scheme</option>
                <% for (Scheme s : schemeList) { %>
                    <option value="<%= s.getSchemeId() %>"><%= s.getSchemeName() %></option>
                <% } %>
            </select>
        </div>

        <div class="mb-3">
            <label for="semester" class="form-label">Semester</label>
            <select name="semesterId" id="semester" class="form-select" required>
                <option value="">Select Semester</option>
                <% for (semester sem : semesterList) { %>
                    <option value="<%= sem.getSemesterId() %>"><%= sem.getSemester() %></option>
                <% } %>
            </select>
        </div>

        <div class="text-center">
            <button type="submit" name="btn" value="insert" class="btn btn-primary">Submit</button>
        </div>
    </form>
</div>

</body>
</html>
