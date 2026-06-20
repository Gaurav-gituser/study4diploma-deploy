<%@ page import="Model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile - Study4Diploma</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #5b5f90;
            overflow-x: hidden;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        #bgCanvas {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            background: #010115df;
        }

        .profile-box {
            max-width: 500px;
            width: 100%;
            background: #0e103d;
            padding: 30px 25px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 212, 255, 0.4);
            color: #fff;
            animation: fadeUp 1.2s ease forwards;
        }

        .profile-box h2 {
            text-align: center;
            color: #00d4ff;
            margin-bottom: 20px;
            font-size: 24px;
        }

        .form-label {
            color: #d1e6ff;
            font-weight: 500;
            margin-bottom: 6px;
            display: block;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            background: #1a1a3d;
            border: 1px solid #00d4ff;
            border-radius: 6px;
            color: #fff;
            margin-bottom: 15px;
            font-size: 14px;
        }

        .form-control:focus {
            outline: none;
            border-color: #00cfff;
            background: #20225c;
        }

        .btn-primary {
            background: #007bff;
            border: none;
            color: #fff;
            font-weight: 600;
            padding: 10px 15px;
            border-radius: 6px;
            cursor: pointer;
            transition: all .3s ease;
            width: 100%;
        }

        .btn-primary:hover {
            background: #00bfff;
            transform: scale(1.05);
            box-shadow: 0 0 20px rgba(0, 212, 255, .8);
        }

        .back-btn {
            display: inline-block;
            margin-top: 15px;
            text-decoration: none;
            background: #20225c;
            padding: 10px 18px;
            border-radius: 6px;
            color: #00d4ff;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .back-btn:hover {
            background: #00d4ff;
            color: #fff;
            box-shadow: 0 0 15px rgba(0, 212, 255, 0.7);
        }

        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
<canvas id="bgCanvas"></canvas>

<%
    // Retrieve the user object from the session
    User loginUser = (User) session.getAttribute("user");

    if (loginUser == null) {
        response.sendRedirect("./login.jsp");
    } else {
%>

<div class="profile-box">
    <h2>Update Profile</h2>
    <form method="post" action="../UserController">
        <input type="hidden" name="userId" value="<%= loginUser.getUserId() %>">

        <label for="name" class="form-label">Full Name</label>
        <input type="text" id="name" name="name" class="form-control" value="<%= loginUser.getName() %>" required>

        <label for="email" class="form-label">Email Address</label>
        <input type="email" id="email" name="email" class="form-control" value="<%= loginUser.getEmail() %>" required>

        <button type="submit" name="btn" value="update" class="btn-primary">Save Changes</button>
    </form>

    <a href="index.jsp" class="back-btn">← Back</a>
</div>

<%
    }
%>

<script>
    // Background glowing dots animation (same as memorized CSS page)
    const canvas = document.getElementById("bgCanvas");
    const ctx = canvas.getContext("2d");
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
    let dots = [], colors = [
        "rgba(0,212,255,1)",
        "rgba(0,100,200,1)",
        "rgba(200,100,255,1)",
        "rgba(120,0,180,1)"
    ];
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