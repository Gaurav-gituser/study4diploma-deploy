<%@page import="Model.semester"%>
<%@page import="Model.Scheme"%>
<%@page import="Model.Branche"%>
<%@page import="Model.Subject"%>
<%@page import="Dao.SemesterDao"%>
<%@page import="Dao.SchemeDao"%>
<%@page import="Dao.BrancheDao"%>
<%@page import="Dao.SubjectDao"%>
<%@page import="java.util.*"%>
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
    <title>Update Subjects</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>

<%
    SubjectDao subjectDao = new SubjectDao();
    BrancheDao brancheDao = new BrancheDao();
    SchemeDao schemeDao = new SchemeDao();
    SemesterDao semesterDao = new SemesterDao();

    List<Subject> subjectList = subjectDao.getAllsubjects();
    List<Branche> branchList = brancheDao.getAllbranches();
    List<Scheme> schemeList = schemeDao.getAllScheme();
    List<semester> semesterList = semesterDao.getAllsemesters();
%>

<div class="container mt-5">
    
    <!-- Row for both buttons -->
    <div class="d-flex justify-content-between mb-3">
        <a href="./AdminPanel.jsp" class="btn btn-secondary">← Back to Admin Panel</a>
        <a href="./SubjectInsert.jsp" class="btn btn-dark">Add New Subject</a>
    </div>

    <h2 class="text-center mb-4">All Subjects</h2>

    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Subject Name</th>
                <th>Course Code</th>
                <th>Branch</th>
                <th>Scheme</th>
                <th>Semester</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <% if (subjectList != null && !subjectList.isEmpty()) {
            for (Subject s : subjectList) {
                Branche branch = brancheDao.getBranchById(s.getBranchId());
                Scheme scheme = schemeDao.getSchemeById(s.getSchemeId());
                semester sem = semesterDao.getSemesterById(s.getSemesterId());
        %>
        <tr>
            <form action="../SubjectController" method="post">
                <td>
                    <input type="text" name="subjectName" class="form-control" value="<%= s.getName() %>" disabled>
                </td>
                <td>
                    <input type="text" name="courseCode" class="form-control" value="<%= s.getCourseCode() %>" disabled>
                </td>
                <td>
                    <input type="text" class="form-control branch-text" value="<%= branch != null ? branch.getbranche() : "Unknown" %>" disabled>
                    <select name="branchId" class="form-select branch-select d-none">
                        <% for (Branche b : branchList) { %>
                            <option value="<%= b.getbranche_id() %>" <%= b.getbranche_id().equals(s.getBranchId()) ? "selected" : "" %>><%= b.getbranche() %></option>
                        <% } %>
                    </select>
                </td>
                <td>
                    <input type="text" class="form-control scheme-text" value="<%= scheme != null ? scheme.getSchemeName() : "Unknown" %>" disabled>
                    <select name="schemeId" class="form-select scheme-select d-none">
                        <% for (Scheme sch : schemeList) { %>
                            <option value="<%= sch.getSchemeId() %>" <%= sch.getSchemeId().equals(s.getSchemeId()) ? "selected" : "" %>><%= sch.getSchemeName() %></option>
                        <% } %>
                    </select>
                </td>
                <td>
                    <input type="text" class="form-control sem-text" value="<%= sem != null ? sem.getSemester() : "Unknown" %>" disabled>
                    <select name="semesterId" class="form-select sem-select d-none">
                        <% for (semester sm : semesterList) { %>
                            <option value="<%= sm.getSemesterId() %>" <%= sm.getSemesterId().equals(s.getSemesterId()) ? "selected" : "" %>><%= sm.getSemester() %></option>
                        <% } %>
                    </select>
                </td>
                <td>
                    <input type="hidden" name="subjectId" value="<%= s.getSubjectId() %>">
                    <input class="btn btn-info btn-update" type="submit" value="Update" name="btn" hidden>
                    <button type="button" class="btn btn-success btn-edit">Edit</button>
                    <input class="btn btn-danger" type="submit" value="Delete" name="btn">
                </td>
            </form>
        </tr>
        <% } 
        } else { %>
        <tr>
            <td colspan="6" class="text-center">No subjects found.</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

<!-- jQuery logic to toggle edit mode -->
<script>
    $("body").on("click", ".btn-edit", function () {
        const row = $(this).closest("tr");

        row.find("input[name='subjectName'], input[name='courseCode']").removeAttr("disabled");

        row.find(".branch-text, .scheme-text, .sem-text").addClass("d-none");
        row.find(".branch-select, .scheme-select, .sem-select").removeClass("d-none");

        row.find(".btn-update").removeAttr("hidden");
        row.find("td:last").prepend("<button type='button' class='btn btn-warning btn-cancel me-1'>Cancel</button>");
        $(this).hide();
    });

    $("body").on("click", ".btn-cancel", function () {
        const row = $(this).closest("tr");

        row.find("input[name='subjectName'], input[name='courseCode']").attr("disabled", true);

        row.find(".branch-text, .scheme-text, .sem-text").removeClass("d-none");
        row.find(".branch-select, .scheme-select, .sem-select").addClass("d-none");

        row.find(".btn-update").attr("hidden", true);
        row.find(".btn-edit").show();
        $(this).remove();
    });
</script>

</body>
</html>