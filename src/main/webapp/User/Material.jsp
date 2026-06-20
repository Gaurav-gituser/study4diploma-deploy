<%@page import="Model.User"%>
<%@ page import="java.util.*, Dao.MaterialDao, Model.Material" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Material Results</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #5b5f90;
            overflow-x: hidden;
            color: #fff;
        }

        #bgCanvas {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            z-index: -1;
            background: #010115df;
        }

        .container {
            max-width: 1000px;
            margin: 80px auto;
            padding: 0 20px;
        }

        h2 {
            text-align: center;
            color: #00d4ff;
            margin-bottom: 25px;
            text-shadow: 0 0 10px rgba(0, 212, 255, 0.6);
        }

        /* ---- SAME STYLE AS YOUR FIRST CODE ---- */
        .semester-box {
            background: #0e103d;
            margin: 20px auto;
            padding: 30px 25px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 212, 255, 0.3);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .semester-box:hover {
            transform: scale(1.02);
            box-shadow: 0 0 25px rgba(0, 212, 255, 0.6);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
        }
        th {
            background: #1c1b3b;
            color: #00d4ff;
        }
        tr {
            background: #20225c;
        }
        tr:nth-child(even) {
            background: #282a6c;
        }
        tr:hover {
            background: #30337c;
            box-shadow: 0 0 12px rgba(0,212,255,0.5);
        }

        .download-link {
            text-decoration: none;
            color: #fff;
            background: #007bff;
            padding: 6px 14px;
            border-radius: 5px;
            font-weight: 600;
            transition: 0.3s;
        }
        .download-link:hover {
            background: #00cfff;
            box-shadow: 0 0 15px rgba(0,212,255,0.8);
        }

        .btn-back {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 18px;
            background: #007bff;
            border-radius: 6px;
            color: #fff;
            text-decoration: none;
            font-weight: 600;
        }
        .btn-back:hover {
            background: #00bfff;
            box-shadow: 0 0 15px rgba(0,212,255,0.6);
        }
    </style>
</head>
<body>
<canvas id="bgCanvas"></canvas>

<%
    String schemeId = request.getParameter("schemeId");
    String branchId = request.getParameter("branchId");
    String yearId = request.getParameter("yearId");
    String semesterId = request.getParameter("semesterId");
    String categoryId = request.getParameter("categoryId");
    String subjectId = request.getParameter("subjectId");

    MaterialDao materialDao = new MaterialDao();
    ArrayList<Material> allMaterial = materialDao.getMaterials(schemeId, branchId, semesterId, subjectId, yearId, categoryId);
%>

<div class="container">
    <h2>📚 Study Materials</h2>

    <div class="semester-box">
    <%
        if (allMaterial != null && !allMaterial.isEmpty()) {
    %>
        <table>
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Description</th>
                    <th>PDF</th>
                    <th>Upload Date</th>
                </tr>
            </thead>
            <tbody>
            <%
                for (Material mat : allMaterial) {
                    User user = (User) session.getAttribute("user");
            %>
                <tr>
                    <td><%= mat.getTitle() %></td>
                    <td><%= mat.getDescription() %></td>
                    <td>
                        <%
                        if(user != null) {
                        %>
                            <a class="download-link" href="../MaterialPdf/<%= mat.getPdf() %>" download="<%= mat.getPdf() %>">📄 Download</a>
                        <%
                        } else {
                        %>
                            <a class="download-link" href="./login.jsp">📄 Download</a>
                        <%
                        }
                        %>
                    </td>
                    <td><%= mat.getUpload_date() %></td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
    <%
        } else {
    %>
        <p>No materials found for the selected filters.</p>
    <%
        }
    %>
    </div>

    <a href="index.jsp" class="btn-back">← Back to Search</a>
</div>

<script>
    const canvas = document.getElementById("bgCanvas");
    const ctx = canvas.getContext("2d");
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;

    let dots = [], colors = ["rgba(0,212,255,1)", "rgba(0,100,200,1)", "rgba(200,100,255,1)", "rgba(120,0,180,1)"];
    for (let i = 0; i < 50; i++) {
        dots.push({
            x: Math.random() * canvas.width,
            y: Math.random() * canvas.height,
            radius: Math.random() * 20 + 10,
            speed: Math.random() * 0.5 + 0.2,
            glow: Math.random() * 40 + 80,
            color: colors[Math.floor(Math.random() * colors.length)]
        });
    }
    function draw() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        dots.forEach(d => {
            ctx.beginPath();
            ctx.shadowBlur = d.glow;
            ctx.shadowColor = d.color;
            ctx.fillStyle = d.color;
            ctx.arc(d.x, d.y, d.radius, 0, Math.PI * 2, false);
            ctx.fill();
            ctx.shadowBlur = 0;
        });
    }
    function update() {
        dots.forEach(d => {
            d.y += d.speed;
            if (d.y - d.radius > canvas.height) {
                d.y = -d.radius;
                d.x = Math.random() * canvas.width;
            }
        });
    }
    function animate() {
        draw();
        update();
        requestAnimationFrame(animate);
    }
    animate();

    window.addEventListener("resize", () => {
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
    });
</script>
</body>
</html>