<%@page import="Model.Branche"%>
<%@page import="Dao.BrancheDao"%>
<%@page import="Model.semester"%>
<%@page import="Dao.SemesterDao"%>
<%@page import="Dao.SchemeDao"%>
<%@page import="Model.Scheme"%>
<%@page import="java.util.*"%>
<%@page import="Model.Category"%>
<%@page import="Model.Subject"%>
<%@page import="Model.Year"%>
<%@page import="Dao.CategoryDao"%>
<%@page import="Dao.SubjectDao"%>
<%@page import="Dao.YearDao"%>
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
    <title>Upload Material</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%
    CategoryDao categoryDao = new CategoryDao();
    SubjectDao subjectDao = new SubjectDao();
    YearDao yearDao = new YearDao();
    SchemeDao schemeDao = new SchemeDao();
    SemesterDao semesterDao = new SemesterDao();
    BrancheDao branchDao = new BrancheDao();

    List<Category> categories = categoryDao.getAllCategorys();
    List<Subject> subjects = subjectDao.getAllsubjects();
    List<Year> years = yearDao.getAllyears();
    List<Scheme> schemes = schemeDao.getAllScheme();
    List<semester> semesters = semesterDao.getAllsemesters();
    List<Branche> branches = branchDao.getAllbranches();
%>

<div class="container mt-5 w-50 border rounded p-4 shadow">
    <h3 class="text-center mb-4">Upload Material</h3>

    <form action="../MaterialController" method="post" enctype="multipart/form-data">
        <!-- Title -->
        <div class="mb-3">
            <label class="form-label">Title</label>
            <input type="text" name="title" class="form-control" required>
        </div>

        <!-- Description -->
        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea name="description" class="form-control" rows="3" required></textarea>
        </div>

        <!-- Upload PDF -->
        <div class="mb-3">
            <label class="form-label">Upload PDF</label>
            <input type="file" name="file" class="form-control" accept="application/pdf" required>
        </div>

        <!-- Category -->
        <div class="mb-3">
            <label class="form-label">Category</label>
            <select name="categoryId" class="form-select" required>
                <option value="">Select Category</option>
                <% for (Category c : categories) { %>
                    <option value="<%= c.getCategoryId() %>"><%= c.getCategoryName() %></option>
                <% } %>
            </select>
        </div>

        <!-- Scheme -->
        <div class="mb-3">
            <label class="form-label">Scheme</label>
            <select name="schemeId" class="form-select" required>
                <option value="">Select Scheme</option>
                <% for (Scheme s : schemes) { %>
                    <option value="<%= s.getSchemeId() %>"><%= s.getSchemeName() %></option>
                <% } %>
            </select>
        </div>

        <!-- Subject -->
        <div class="mb-3">
            <label class="form-label">Subject</label>
            <select name="subjectId" class="form-select" required>
                <option value="">Select Subject</option>
                <% for (Subject s : subjects) { %>
                    <option value="<%= s.getSubjectId() %>"><%= s.getName() %></option>
                <% } %>
            </select>
        </div>

        <!-- Academic Year -->
        <div class="mb-3">
            <label class="form-label">Academic Year</label>
            <select name="academicYear" class="form-select" required>
                <option value="">Select Year</option>
                <% for (Year y : years) { %>
                    <option value="<%= y.getyear_id() %>"><%= y.getyear() %></option>
                <% } %>
            </select>
        </div>

        <!-- Branch -->
        <div class="mb-3">
            <label class="form-label">Branch</label>
            <select name="branchId" class="form-select" required>
                <option value="">Select Branch</option>
                <% for (Branche b : branches) { %>
                    <option value="<%= b.getbranche_id() %>"><%= b.getbranche() %></option>
                <% } %>
            </select>
        </div>

        <!-- Semester -->
        <div class="mb-3">
            <label class="form-label">Semester</label>
            <select name="semesterId" class="form-select" required>
                <option value="">Select Semester</option>
                <% for (semester s : semesters) { %>
                    <option value="<%= s.getSemesterId() %>"><%= s.getSemester() %></option>
                <% } %>
            </select>
        </div>

        <!-- Submit -->
        <div class="text-center">
            <button type="submit" name="btn" value="insert" class="btn btn-primary">Upload</button>
        </div>
    </form>
</div>

</body>
</html>
