<%@page import="Model.User"%>
<%@ page import="java.util.*, Dao.MaterialDao, Model.Material, Dao.SubjectDao, Model.Subject" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Study Material — Study4Diploma</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        /* ── CSS VARIABLES (matches home page) ── */
        :root {
            --navy:      #0D1B3E;
            --navy-mid:  #112252;
            --navy-card: #0F1F48;
            --cyan:      #00C6FF;
            --cyan-dim:  #0099cc;
            --white:     #FFFFFF;
            --soft:      #CBD8F0;
            --border:    rgba(0,198,255,0.18);
            --glass:     rgba(13,27,62,0.82);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--navy);
            color: var(--white);
            overflow-x: hidden;
        }

        /* Background canvas — identical to home */
        #bgCanvas {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            z-index: -1;
            background: linear-gradient(160deg, #040d1f 0%, #0D1B3E 60%, #071430 100%);
        }

        /* ── NAVBAR (exact copy from home page CSS) ── */
        .navbar {
            width: 100%;
            background: rgba(10, 18, 42, 0.95);
            backdrop-filter: blur(12px);
            padding: 0 48px;
            height: 64px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 1000;
            border-bottom: 1px solid var(--border);
            animation: slideDown 0.9s cubic-bezier(.22,1,.36,1) forwards;
        }

        @keyframes slideDown {
            from { transform: translateY(-100%); }
            to   { transform: translateY(0); }
        }

        .logo-wrap {
            display: flex;
            flex-direction: column;
            line-height: 1;
            gap: 3px;
        }

        .logo {
            font-size: 22px;
            font-weight: 800;
            letter-spacing: 1px;
            text-decoration: none;
            white-space: nowrap;
        }

        .logo .logo-study   { color: var(--white); }
        .logo .logo-four    { color: var(--cyan); }
        .logo .logo-diploma { color: var(--white); }

        .logo-tagline {
            font-size: 9px;
            font-weight: 400;
            letter-spacing: 4px;
            color: var(--soft);
            text-transform: uppercase;
            border-top: 1px solid var(--cyan);
            padding-top: 3px;
        }

        .menu { flex: 1; display: flex; justify-content: center; }

        .menu ul {
            list-style: none;
            display: flex;
            gap: 40px;
            margin: 0;
            padding: 0;
        }

        .menu ul li a {
            text-decoration: none;
            color: var(--soft);
            font-weight: 500;
            font-size: 13px;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            transition: color 0.25s ease;
            position: relative;
            padding-bottom: 3px;
        }

        .menu ul li a::after {
            content: '';
            position: absolute;
            bottom: 0; left: 0;
            width: 0; height: 2px;
            background: var(--cyan);
            transition: width 0.3s ease;
        }

        .menu ul li a:hover { color: var(--white); }
        .menu ul li a:hover::after { width: 100%; }

        /* Active page indicator */
        .menu ul li a.active {
            color: var(--cyan);
        }
        .menu ul li a.active::after {
            width: 100%;
        }

        .nav-right a {
            background: transparent;
            border: 1.5px solid var(--cyan);
            padding: 7px 22px;
            border-radius: 4px;
            color: var(--cyan);
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
            letter-spacing: 1px;
            transition: all 0.25s ease;
        }

        .nav-right a:hover {
            background: var(--cyan);
            color: var(--navy);
        }

        /* ── PAGE CONTENT ── */
        .page-wrapper {
            max-width: 1000px;
            margin: 0 auto;
            padding: 50px 24px 80px;
        }

        /* Page header */
        .page-header {
            text-align: center;
            margin-bottom: 40px;
            animation: fadeUp 0.8s ease forwards;
        }

        .page-header .page-label {
            display: inline-block;
            font-size: 11px;
            font-weight: 600;
            letter-spacing: 3px;
            text-transform: uppercase;
            color: var(--cyan);
            border: 1px solid var(--border);
            padding: 5px 14px;
            border-radius: 2px;
            margin-bottom: 14px;
        }

        .page-header h1 {
            font-size: 32px;
            font-weight: 700;
            color: var(--white);
        }

        .page-header h1 span { color: var(--cyan); }

        .section-divider {
            width: 60px;
            height: 3px;
            background: var(--cyan);
            margin: 14px auto 0;
            border-radius: 2px;
        }

        /* ── SUBJECT SECTIONS ── */
        .subject-section {
            background: var(--navy-card);
            border: 1px solid var(--border);
            border-radius: 8px;
            margin-bottom: 24px;
            overflow: hidden;
            animation: fadeUp 0.7s ease forwards;
        }

        .subject-title {
            font-size: 17px;
            font-weight: 800;
            color: var(--cyan);
            padding: 16px 22px;
            border-bottom: 1px solid var(--border);
            letter-spacing: 0.5px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* ── TABLE ── */
        table {
            width: 100%;
            border-collapse: collapse;
        }

       th {
    background: rgba(0, 198, 255, 0.07);
    color: var(--cyan);
    font-size: 16px;
    font-weight: 700;
    letter-spacing: 1.5px;
    text-transform: uppercase;
    padding: 14px 20px;
    text-align: center;
    border-bottom: 1px solid var(--border);
}

       td {
    padding: 14px 20px;
    font-size: 16px;
    font-weight: 600;
    color: var(--white);
    border-bottom: 1px solid rgba(0,198,255,0.07);
    vertical-align: middle;
    text-align: center;
}

        tr:last-child td { border-bottom: none; }

        tr:hover td {
            background: rgba(0, 198, 255, 0.04);
            color: var(--white);
        }

        /* ── DOWNLOAD BUTTON ── */
        .download-link {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            text-decoration: none;
            color: var(--navy);
            background: var(--cyan);
            padding: 7px 16px;
            border-radius: 4px;
            font-size: 12.5px;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.25s ease;
            white-space: nowrap;
        }

        .download-link:hover {
            background: var(--white);
            transform: translateY(-1px);
            box-shadow: 0 6px 18px rgba(0,198,255,0.3);
        }

        .download-link.login-required {
            background: transparent;
            border: 1.5px solid var(--cyan);
            color: var(--cyan);
        }

        .download-link.login-required:hover {
            background: var(--cyan);
            color: var(--navy);
        }

        /* ── EMPTY STATE ── */
        .empty-state {
            background: var(--navy-card);
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 60px 24px;
            text-align: center;
        }

        .empty-state p {
            color: var(--soft);
            font-size: 15px;
        }

        /* ── BACK BUTTON ── */
        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            margin-top: 32px;
            padding: 11px 24px;
            background: transparent;
            border: 1.5px solid var(--cyan);
            border-radius: 4px;
            color: var(--cyan);
            font-family: 'Poppins', sans-serif;
            font-size: 13px;
            font-weight: 600;
            letter-spacing: 1px;
            text-decoration: none;
            transition: all 0.25s ease;
        }

        .btn-back:hover {
            background: var(--cyan);
            color: var(--navy);
            transform: translateY(-1px);
            box-shadow: 0 6px 18px rgba(0,198,255,0.3);
        }

        /* ── ANIMATIONS ── */
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(20px); }
            to   { opacity: 1; transform: translateY(0); }
        }
        
        /* ── HAMBURGER BUTTON ── */
.hamburger {
    display: none;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    gap: 5px;
    width: 36px;
    height: 36px;
    cursor: pointer;
    background: none;
    border: none;
    padding: 4px;
    z-index: 1100;
}

.hamburger span {
    display: block;
    width: 22px;
    height: 2px;
    background: var(--cyan);
    border-radius: 2px;
    transition: all 0.3s ease;
}

.hamburger.open span:nth-child(1) { transform: translateY(7px) rotate(45deg); }
.hamburger.open span:nth-child(2) { opacity: 0; }
.hamburger.open span:nth-child(3) { transform: translateY(-7px) rotate(-45deg); }

/* ── MOBILE DRAWER ── */
.mobile-menu {
    display: none;
    position: fixed;
    top: 64px;
    left: 0;
    width: 100%;
    background: rgba(8, 15, 38, 0.98);
    backdrop-filter: blur(16px);
    border-bottom: 1px solid var(--border);
    z-index: 999;
    padding: 20px 28px 28px;
    flex-direction: column;
    gap: 6px;
}

.mobile-menu.open {
    display: flex;
}

.mobile-menu a {
    display: block;
    padding: 13px 16px;
    color: var(--soft);
    text-decoration: none;
    font-size: 14px;
    font-weight: 500;
    letter-spacing: 1.5px;
    text-transform: uppercase;
    border-radius: 6px;
    border-left: 3px solid transparent;
    transition: all 0.2s ease;
}

.mobile-menu a:hover {
    color: var(--white);
    background: rgba(0,198,255,0.07);
    border-left-color: var(--cyan);
}

.mobile-divider {
    height: 1px;
    background: var(--border);
    margin: 10px 0;
}

.mobile-menu .mobile-login-btn {
    display: block;
    margin-top: 6px;
    padding: 12px 16px;
    background: transparent;
    border: 1.5px solid var(--cyan);
    border-radius: 6px;
    color: var(--cyan);
    font-size: 14px;
    font-weight: 600;
    text-align: center;
    letter-spacing: 1px;
    text-decoration: none;
    transition: all 0.25s ease;
}

.mobile-menu .mobile-login-btn:hover {
    background: var(--cyan);
    color: var(--navy);
}

        /* ── RESPONSIVE ── */
        @media (max-width: 640px) {
            .navbar { padding: 0 20px; }
            .menu ul { gap: 18px; }
            .menu ul li a { font-size: 12px; }
            .page-header h1 { font-size: 24px; }
            .menu { display: none; }
.nav-right { display: none; }
.hamburger { display: flex; }

            th, td { padding: 10px 14px; }

            table, thead, tbody, th, td, tr {
                display: block;
            }

            thead tr { display: none; }

            td {
                position: relative;
                padding-left: 45%;
            }

            td::before {
                content: attr(data-label);
                position: absolute;
                left: 14px;
                font-size: 10px;
                font-weight: 600;
                letter-spacing: 1px;
                text-transform: uppercase;
                color: var(--cyan);
                top: 50%;
                transform: translateY(-50%);
            }
        }
    </style>
</head>
<body>

<canvas id="bgCanvas"></canvas>

<!-- ── NAVBAR (matches home page exactly) ── -->
<nav class="navbar">
    <!-- Logo -->
    <div class="logo-wrap">
        <div class="logo">
            <span class="logo-study">STUDY</span><span class="logo-four">4</span><span class="logo-diploma">DIPLOMA</span>
        </div>
        <div class="logo-tagline">MSBTE &middot; DIPLOMA &middot; STUDY</div>
    </div>

    <!-- Nav links -->
    <div class="menu">
        <ul>
            <li><a href="index.jsp">HOME</a></li>
            <li><a href="index.jsp#connect">CONTACT</a></li>
            <li><a href="index.jsp#help">HELP</a></li>
            <%
              User navUser2 = (User) session.getAttribute("user");
              if (navUser2 != null && !navUser2.getRoleId().equalsIgnoreCase("rid_102")) {
            %>
              <li><a href="../Admin/AdminPanel.jsp">ADMIN</a></li>
            <% } %>
        </ul>
    </div>

    <!-- Login / Profile / Logout -->
    <div class="nav-right">
        <%
          User navUser = (User) session.getAttribute("user");
          if (navUser != null) {
        %>
            <a href="./logout.jsp">Logout</a>
        <% } else { %>
            <a href="./login.jsp">Login</a>
        <% } %>
    </div>
    <button class="hamburger" id="hamburger" aria-label="Menu">
  <span></span><span></span><span></span>
</button>
</nav>
<div class="mobile-menu" id="mobileMenu">
  <a href="index.jsp">HOME</a>
  <a href="index.jsp#connect">CONTACT</a>
  <a href="index.jsp#help">HELP</a>
  <div class="mobile-divider"></div>
  <a href="./logout.jsp" class="mobile-login-btn">Logout</a>
</div>
<!-- ── JAVA: FETCH MATERIAL DATA ── -->
<%
    String schemeId   = request.getParameter("schemeId");
    String branchId   = request.getParameter("branchId");
    String yearId     = request.getParameter("yearId");
    String semesterId = request.getParameter("semesterId");
    String categoryId = request.getParameter("categoryId");

    MaterialDao materialDao = new MaterialDao();
    ArrayList<Material> allMaterial;
    // If all filter params are absent (e.g. coming from navbar search), load all materials
    if (schemeId == null && branchId == null && yearId == null && semesterId == null && categoryId == null) {
        allMaterial = materialDao.getAllMaterials();
    } else {
        allMaterial = materialDao.getMaterials(schemeId, branchId, semesterId, yearId, categoryId);
    }

    SubjectDao subjectDao = new SubjectDao();
    ArrayList<Subject> allSubjects = subjectDao.getAllsubjects();

    HashMap<String, String> subjectNameById = new HashMap<>();
    for (Subject subj : allSubjects) {
        subjectNameById.put(subj.getSubjectId(), subj.getName());
    }

    LinkedHashMap<String, ArrayList<Material>> materialsBySubject = new LinkedHashMap<>();
    if (allMaterial != null) {
        for (Material mat : allMaterial) {
            String sid = mat.getSubjectId();
            if (!materialsBySubject.containsKey(sid)) {
                materialsBySubject.put(sid, new ArrayList<Material>());
            }
            materialsBySubject.get(sid).add(mat);
        }
    }

    User user = (User) session.getAttribute("user");
%>

<!-- ── PAGE CONTENT ── -->
<div class="page-wrapper">

    <!-- Header -->
    <div class="page-header">
    <h1>📚 <span>Study</span> Materials</h1>
    <div class="section-divider"></div>
    <!-- Search Bar -->
<div style="margin-bottom: 30px; text-align: center; display:flex; justify-content:center; gap:8px; flex-wrap:wrap;">
    <input type="text" id="searchInput" placeholder="🔍 Search…"
        value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>"
        style="width: 100%; max-width: 480px; height: 44px; padding: 0 18px;
        background: rgba(255,255,255,0.04); border: 1.5px solid rgba(0,198,255,0.3);
        border-radius: 6px; color: #fff; font-family: 'Poppins', sans-serif;
        font-size: 14px; outline: none; transition: border 0.25s;"
        oninput="searchMaterial()"
        onkeyup="searchMaterial()"
        onfocus="this.style.borderColor='#00C6FF'"
        onblur="this.style.borderColor='rgba(0,198,255,0.3)'">
    <button onclick="document.getElementById('searchInput').value=''; searchMaterial();"
        style="height:44px; padding:0 18px; background:rgba(0,198,255,0.1);
        border:1.5px solid rgba(0,198,255,0.3); border-radius:6px; color:var(--cyan);
        font-family:'Poppins',sans-serif; font-size:13px; font-weight:600;
        cursor:pointer; transition:all 0.2s;"
        onmouseover="this.style.background='rgba(0,198,255,0.2)'"
        onmouseout="this.style.background='rgba(0,198,255,0.1)'">✕ Clear</button>
</div>
</div>

    <!-- Material list or empty state -->
    <%
        if (materialsBySubject.isEmpty()) {
    %>
        <div class="empty-state">
            <p>No materials found for the selected filters.</p>
        </div>
    <%
        } else {
            for (Map.Entry<String, ArrayList<Material>> entry : materialsBySubject.entrySet()) {
                String subjectId       = entry.getKey();
                ArrayList<Material> subjectMaterials = entry.getValue();
                String subjectName     = subjectNameById.getOrDefault(subjectId, "Unknown Subject");
    %>
        <div class="subject-section">
            <div class="subject-title">📖 <%= subjectName %></div>
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
                    for (Material mat : subjectMaterials) {
                %>
                    <tr>
                        <td data-label="Title"><%= mat.getTitle() %></td>
                        <td data-label="Description"><%= mat.getDescription() %></td>
                        <td data-label="PDF">
                            <a class="download-link" href="../MaterialPdf/<%= mat.getPdf() %>" download="<%= mat.getPdf() %>">📄 Download</a>
                        </td>
                        <td data-label="Upload Date"><%= mat.getUpload_date() %></td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    <%
            }
        }
    %>
    
<div id="noResult" style="display:none; text-align:center; padding: 40px;
    background: var(--navy-card); border: 1px solid var(--border);
    border-radius: 8px; color: var(--soft); font-size: 15px; margin-bottom: 20px;">
    😕 No materials found matching your search.
</div>
    <a href="index.jsp" class="btn-back">← Back to Home</a>
</div>

<!-- Background animation (matches home page) -->
<script>
    const canvas = document.getElementById("bgCanvas");
    const ctx    = canvas.getContext("2d");

    function resize() {
        canvas.width  = window.innerWidth;
        canvas.height = window.innerHeight;
    }
    resize();
    window.addEventListener("resize", resize);

    const colors = [
        "rgba(0,198,255,0.9)",
        "rgba(0,150,255,0.7)",
        "rgba(100,200,255,0.6)",
        "rgba(0,198,255,0.5)"
    ];

    let dots = [];
    for (let i = 0; i < 120; i++) {
    	dots.push({
    	    x:      Math.random() * canvas.width,
    	    y:      Math.random() * canvas.height,
    	    radius: Math.random() * 2 + 1,
    	    speed:  Math.random() * 0.4 + 0.2,
    	    glow:   Math.random() * 6 + 4,
    	    color:  colors[Math.floor(Math.random() * colors.length)]
    	});
    }

    function draw() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        dots.forEach(d => {
            ctx.beginPath();
            ctx.shadowBlur  = d.glow;
            ctx.shadowColor = d.color;
            ctx.fillStyle   = d.color;
            ctx.arc(d.x, d.y, d.radius, 0, Math.PI * 2);
            ctx.fill();
            ctx.shadowBlur  = 0;
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

    (function animate() {
        draw();
        update();
        requestAnimationFrame(animate);
    })();
</script>
<script>
  const hamburger = document.getElementById('hamburger');
  const mobileMenu = document.getElementById('mobileMenu');
  hamburger.addEventListener('click', () => {
    hamburger.classList.toggle('open');
    mobileMenu.classList.toggle('open');
  });
  mobileMenu.querySelectorAll('a').forEach(link => {
    link.addEventListener('click', () => {
      hamburger.classList.remove('open');
      mobileMenu.classList.remove('open');
    });
  });
</script>

<script>
function searchMaterial() {
    const input = document.getElementById('searchInput').value.toLowerCase();
    const sections = document.querySelectorAll('.subject-section');

    sections.forEach(section => {
        const subjectTitle = section.querySelector('.subject-title').textContent.toLowerCase();
        const rows = section.querySelectorAll('tbody tr');
        let sectionHasMatch = false;

        rows.forEach(row => {
            const title = row.cells[0] ? row.cells[0].textContent.toLowerCase() : '';
            const desc  = row.cells[1] ? row.cells[1].textContent.toLowerCase() : '';

            if (title.includes(input) || desc.includes(input) || subjectTitle.includes(input)) {
                row.style.display = '';
                sectionHasMatch = true;
            } else {
                row.style.display = 'none';
            }
        });

        // Hide entire subject section if no rows match
        section.style.display = sectionHasMatch ? '' : 'none';
    });

    // Show empty message if nothing matches
    const noResult = document.getElementById('noResult');
    const anyVisible = [...sections].some(s => s.style.display !== 'none');
    noResult.style.display = anyVisible ? 'none' : 'block';
}
window.addEventListener('load', function() {
    const input = document.getElementById('searchInput');
    if (input.value.trim() !== '') {
        searchMaterial();
    }
});
</script>

</body>
</html>
