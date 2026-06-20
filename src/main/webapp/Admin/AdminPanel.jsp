<%@page import="Dao.ContactDao"%>
<%@page import="Dao.MaterialDao"%>
<%@page import="Model.Material"%>
<%@page import="Dao.UserDao"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Panel - Study4Diploma</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f6f9;
            margin: 0;
        }

        .sidebar {
            height: 100vh;
            width: 250px;
            background-color: #343a40;
            color: #fff;
            position: fixed;
            top: 0;
            left: 0;
            padding-top: 60px;
        }

        .sidebar a {
            color: #adb5bd;
            display: block;
            padding: 15px 25px;
            text-decoration: none;
            transition: 0.3s;
        }

        .sidebar a:hover,
        .sidebar a.active {
            background-color: #495057;
            color: #fff;
        }

        .topbar {
            height: 60px;
            background-color: #fff;
            padding: 10px 30px;
            margin-left: 250px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #dee2e6;
        }

        .main-content {
            margin-left: 250px;
            padding: 30px;
        }

        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
        }

        .card h5 {
            font-weight: 600;
        }

        .admin-title {
            font-weight: bold;
            color: #343a40;
        }

        @media (max-width: 768px) {
            .sidebar {
                display: none;
            }

            .topbar {
                margin-left: 0;
            }

            .main-content {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>

 
<div class="sidebar">
    <h4 class="text-center text-light">Admin Panel</h4>
    
    <a href="#" class="active"><i class="bi bi-speedometer2 me-2"></i> Dashboard</a>
    
    <a href="./allUsers.jsp"><i class="bi bi-people-fill me-2"></i> Manage Users</a>
    
    <a href="./UpdateSubject.jsp"><i class="bi bi-journal-text me-2"></i> Manage Subjects</a>
    
    <a href="./UpdateMaterial.jsp"><i class="bi bi-cloud-upload-fill me-2"></i> Upload Materials</a>
    
    <a href="./ShowContacts.jsp"><i class="bi bi-envelope-fill me-2"></i> Contacts</a>
    
    <a href="./UpdateCategory.jsp"><i class="bi bi-tags-fill me-2"></i> Category</a>
    
    <a href="./UpdateScheme.jsp"><i class="bi bi-diagram-3-fill me-2"></i> Scheme</a>
    
    <a href="./UpdateSemester.jsp"><i class="bi bi-calendar-week-fill me-2"></i> Semester</a>
    
    <a href="./UpdateYear.jsp"><i class="bi bi-calendar2-range-fill me-2"></i> Year's</a>
    
 
    
    <a href="../User/logout.jsp"><i class="bi bi-box-arrow-right me-2"></i> Logout</a>
</div>
   
    <!-- Topbar -->
    <div class="topbar">
        <h4 class="admin-title">Welcome, Admin</h4>
        <span><i class="bi bi-bell-fill me-3"></i><i class="bi bi-person-circle"></i></span>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card p-4 bg-primary text-white">
                    <h5>Total Users</h5>
                    <h3><%
                    UserDao dao1 = new UserDao();
                    int no1 = dao1.totalNoOfUsers();
                    out.print(no1);
                    %></h3>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card p-4 bg-success text-white">
                    <h5>Materials Uploaded</h5>
                    <h3>
                   <%
                    MaterialDao dao2 = new MaterialDao();
                    int no2 = dao2.noOfUploaded();
                    out.print(no2);
                    %> 
                    </h3>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card p-4 bg-warning text-dark">
                    <h5>Feedbacks Received</h5>
                    <h3>
                     <%
                    ContactDao dao3 = new ContactDao();
                    int no3 = dao3.noOfContact();
                    out.print(no3);
                    %> 
                    </h3>
                </div>
            </div>
        </div>

      
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
