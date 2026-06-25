<%@page import="Model.Branche"%>
<%@page import="Model.semester"%>
<%@page import="Model.Scheme"%>
<%@page import="Dao.BrancheDao"%>
<%@page import="Dao.SemesterDao"%>
<%@page import="Dao.SchemeDao"%>
<%@page import="Model.Material"%>
<%@page import="Model.Subject"%>
<%@page import="Model.Category"%>
<%@page import="Model.Year"%>
<%@page import="Dao.SubjectDao"%>
<%@page import="Dao.CategoryDao"%>
<%@page import="Dao.YearDao"%>
<%@page import="Dao.MaterialDao"%>
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
    <title>Manage Materials</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>

<%
    MaterialDao materialDao = new MaterialDao();
    ArrayList<Material> allMaterials = materialDao.getAllMaterials();

    CategoryDao categoryDao = new CategoryDao();
    ArrayList<Category> allCategories = categoryDao.getAllCategorys();

    SubjectDao subjectDao = new SubjectDao();
    ArrayList<Subject> allSubjects = subjectDao.getAllsubjects();

    YearDao yearDao = new YearDao();
    ArrayList<Year> allYears = yearDao.getAllyears();

    BrancheDao brancheDao = new BrancheDao();
    ArrayList<Branche> allBranches = brancheDao.getAllbranches();

    SemesterDao semesterDao = new SemesterDao();
    ArrayList<semester> allSemesters = semesterDao.getAllsemesters();

    SchemeDao schemeDao = new SchemeDao();
    ArrayList<Scheme> allSchemes = schemeDao.getAllScheme();
%>

<div class="mt-5 px-3">
  <h2 class="text-center mb-4">All Uploaded Materials</h2>
   <p class="text-end">
    <a href="./AdminPanel.jsp" class="btn btn-secondary me-2">← Back to Admin Panel</a>
    <a href="./MaterialInsert.jsp" class="btn btn-dark">Add New Material</a>
    </p>

    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Title</th>
                <th>Description</th>
                <th>PDF</th>
                <th>Upload Date</th>
                <th>Category</th>
                <th>Subject</th>
                <th>Academic Year</th>
                <th>Branch</th>
                <th>Semester</th>
                <th>Scheme</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
            if (allMaterials != null && !allMaterials.isEmpty()) {
                for (Material mat : allMaterials) {
        %>
        <tr>
            <form action="../MaterialController" method="post" enctype="multipart/form-data">
                <input type="hidden" name="materialId" value="<%=mat.getMaterialId()%>">

                <td><input type="text" name="title" class="form-control" value="<%=mat.getTitle()%>" disabled></td>

                <td><textarea name="description" class="form-control" rows="2" disabled><%=mat.getDescription()%></textarea></td>

                <td>
                    <input type="text" name="currentPdf" class="form-control" value="<%=mat.getPdf()%>" disabled>
                    <input type="file" name="pdfFile" class="form-control mt-1 d-none" accept="application/pdf">
                </td>

                <td><input type="text" name="upload_date" class="form-control" value="<%=mat.getUpload_date()%>" readonly></td>

                <td>
                    <select name="categoryId" class="form-select" disabled>
                        <% for (Category cat : allCategories) { %>
                            <option value="<%=cat.getCategoryId()%>" <%=cat.getCategoryId().equals(mat.getCategoryId()) ? "selected" : ""%>>
                                <%=cat.getCategoryName()%>
                            </option>
                        <% } %>
                    </select>
                </td>

                <td>
                    <select name="subjectId" class="form-select" disabled>
                        <% for (Subject sub : allSubjects) { %>
                            <option value="<%=sub.getSubjectId()%>" <%=sub.getSubjectId().equals(mat.getSubjectId()) ? "selected" : ""%>>
                                <%=sub.getName()%>
                            </option>
                        <% } %>
                    </select>
                </td>

                <td>
                    <select name="acadmicYear" class="form-select" disabled>
                        <% for (Year y : allYears) { %>
                            <option value="<%=y.getyear_id()%>" <%=y.getyear_id().equals(mat.getAcadmicYear()) ? "selected" : ""%>>
                                <%=y.getyear()%>
                            </option>
                        <% } %>
                    </select>
                </td>

                <td>
                    <select name="branchId" class="form-select" disabled>
                        <% for (Branche b : allBranches) { %>
                      

 <option value="<%=b.getbranche_id()%>" 
    <%= b.getbranche_id().trim().equalsIgnoreCase(
          mat.getBranchId() == null ? "" : mat.getBranchId().trim()
        ) ? "selected" : "" %>>
    <%=b.getbranche()%>
</option>

                        <% } %>
                    </select>
                </td>

                <td>
                    <select name="semesterId" class="form-select" disabled>
                        <% for (semester s : allSemesters) { %>
                            <option value="<%=s.getSemesterId()%>" <%=s.getSemesterId().equals(mat.getSemesterId()) ? "selected" : ""%>>
                                <%=s.getSemester()%>
                            </option>
                        <% } %>
                    </select>
                </td>

                <td>
                    <select name="schemeId" class="form-select" disabled>
                        <% for (Scheme sc : allSchemes) { %>
                            <option value="<%=sc.getSchemeId()%>" <%=sc.getSchemeId().equals(mat.getSchemeId()) ? "selected" : ""%>>
                                <%=sc.getSchemeName()%>
                            </option>
                        <% } %>
                    </select>
                </td>

                <td class="d-flex flex-wrap gap-1">
                    <button type="submit" name="btn" value="Update" class="btn btn-success btn-sm btn-update d-none">Update</button>
                    <button type="button" class="btn btn-warning btn-sm btn-cancel d-none">Cancel</button>
                    <button type="button" class="btn btn-primary btn-sm btn-edit">Edit</button>
                    <button type="submit" name="btn" value="Delete" class="btn btn-danger btn-sm"
                            onclick="return confirm('Are you sure you want to delete this material?');">Delete</button>
                </td>
            </form>
        </tr>
        <% } } %>
        </tbody>
    </table>
</div>

<!-- jQuery Logic -->
<script>
    $(document).on("click", ".btn-edit", function () {
        const row = $(this).closest("tr");

        // Enable inputs
        row.find("input[type='text'], textarea, select").not("[name='upload_date']").removeAttr("disabled");
        row.find("input[type='file']").removeClass("d-none");

        // Show update and cancel, hide edit
        row.find(".btn-update, .btn-cancel").removeClass("d-none");
        row.find(".btn-edit").addClass("d-none");
    });

    $(document).on("click", ".btn-cancel", function () {
        const row = $(this).closest("tr");

        // Reload the page to reset form (or you can reset manually each input)
        location.reload();
    });
</script>

</body>
</html>
