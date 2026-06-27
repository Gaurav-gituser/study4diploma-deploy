<%@page import="Model.semester"%>
<%@page import="Dao.SemesterDao"%>
<%@page import="Model.Category"%>
<%@page import="Dao.CategoryDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.LinkedHashSet"%>
<%@page import="Model.Year"%>
<%@page import="Dao.YearDao"%>
<%@page import="Model.Branche"%>
<%@page import="Dao.BrancheDao"%>
<%@page import="Model.Scheme"%>
<%@page import="Dao.SchemeDao"%>
<%@page import="Model.User"%>
<%@page import="Model.Material"%>
<%@page import="Dao.MaterialDao"%>
<%@page import="Model.Subject"%>
<%@page import="Dao.SubjectDao"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Study4Diploma — MSBTE Study Material</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="index.css">
</head>

<body>
  <canvas id="bgCanvas"></canvas>

  <div class="main">

    <!-- ── NAVBAR ────────────────────────────── -->
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
          <li><a href="#connect">CONTACT</a></li>
          <li><a href="#help">HELP</a></li>
          <%
            User navUser = (User) session.getAttribute("user");
            if (navUser != null && !navUser.getRoleId().equalsIgnoreCase("rid_102")) {
          %>
            <li><a href="../Admin/AdminPanel.jsp">ADMIN</a></li>
          <% } else { %>
            <li><a href="./profile.jsp">PROFILE</a></li>
          <% } %>
        </ul>
      </div>

      <!-- Navbar Search -->
      <div class="nav-search-wrap" id="navSearchWrap">
        <div class="nav-search-box">
          <input type="text" id="navSearch" class="nav-search-input" placeholder="Search materials…"
            autocomplete="off"
            oninput="navSearchSuggest(this.value)"
            onkeydown="if(event.key==='Enter') navGoSearch()">
          <button class="nav-search-btn" onclick="navGoSearch()" title="Search">
            <svg width="15" height="15" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
              <circle cx="8.5" cy="8.5" r="5.5"/><line x1="13.5" y1="13.5" x2="18" y2="18"/>
            </svg>
          </button>
        </div>
        <div class="nav-search-dropdown" id="navSearchDropdown"></div>
      </div>

      <!-- Login / Logout -->
      <div class="nav-right">
        <%
          User user = (User) session.getAttribute("user");
        %>
        <% if (user != null) { %>
          <a href="./logout.jsp">Logout</a>
        <% } else { %>
          <a href="./login.jsp">Login</a>
        <% } %>
      </div>
      <!-- Hamburger button (mobile only) -->
      <button class="hamburger" id="hamburger" aria-label="Menu">
        <span></span><span></span><span></span>
      </button>
    </nav>

    <!-- Mobile drawer -->
    <div class="mobile-menu" id="mobileMenu">
      <a href="index.jsp">HOME</a>
      <a href="#connect">CONTACT</a>
      <a href="#help">HELP</a>
      <%
        User mobileUser = (User) session.getAttribute("user");
        if (mobileUser != null && !mobileUser.getRoleId().equalsIgnoreCase("rid_102")) {
      %>
        <a href="../Admin/AdminPanel.jsp">ADMIN</a>
      <% } else { %>
        <a href="./profile.jsp">PROFILE</a>
      <% } %>
      <div class="mobile-divider"></div>
      <%
        User mobileLoginUser = (User) session.getAttribute("user");
        if (mobileLoginUser != null) {
      %>
        <a href="./logout.jsp" class="mobile-login-btn">Logout</a>
      <% } else { %>
        <a href="./login.jsp" class="mobile-login-btn">Login</a>
      <% } %>
    </div>
    </nav>
    

    <!-- ── HERO + FORM ────────────────────────── -->
    <div class="content-wrapper">

      <!-- Left: Text -->
      <div class="content">
        <div class="hero-label">MSBTE Diploma Platform</div>
        <h1>One of the best websites for<br><span>Diploma Students</span></h1>
        <div class="typing-text">
          <span class="fixed">We provide </span><span class="dynamic" id="typing"></span>
        </div>
        <p><strong>Study4Diploma</strong> is a learning platform built exclusively for MSBTE diploma students.
          Find <strong>notes, previous year question papers</strong> and more — all in one place.
          Stop searching everywhere; pick your branch and semester and start studying smarter.</p>

      </div>

      <!-- Right: Study Material Form -->
      <form class="form" id="studyForm" action="./Material.jsp" method="post">
        <h3>Fill the details below<br>to get study material</h3>

        <!-- Scheme -->
        <select id="scheme" name="schemeId" required>
          <option value="" disabled selected>Select Scheme</option>
          <%
            SchemeDao dao = new SchemeDao();
            ArrayList<Scheme> allScheme = dao.getAllScheme();
            for (Scheme sc : allScheme) {
          %>
            <option value="<%= sc.getSchemeId() %>"><%= sc.getSchemeName() %></option>
          <% } %>
        </select>

        <!-- Branch -->
        <select id="branch" name="branchId" required>
          <option value="" disabled selected>Select Branch</option>
          <%
            BrancheDao dao1 = new BrancheDao();
            ArrayList<Branche> allBranch = dao1.getAllbranches();
            for (Branche b : allBranch) {
          %>
            <option value="<%= b.getbranche_id() %>"><%= b.getbranche() %></option>
          <% } %>
        </select>

        <!-- Year -->
        <select id="year" name="yearId" required>
          <option value="" disabled selected>Select Academic Year</option>
          <%
            YearDao dao2 = new YearDao();
            ArrayList<Year> allYear = dao2.getAllyears();
            for (Year y : allYear) {
          %>
            <option value="<%= y.getyear_id() %>"><%= y.getyear() %></option>
          <% } %>
        </select>

        <!-- Semester -->
        <select id="semester" name="semesterId" required>
          <option value="" disabled selected>Select Semester</option>
          <%
            SemesterDao semDao = new SemesterDao();
            ArrayList<semester> allSem = semDao.getAllsemesters();
            for (semester s : allSem) {
          %>
            <option value="<%= s.getSemesterId() %>"><%= s.getSemester() %></option>
          <% } %>
        </select>

        <!-- Category -->
        <select id="category" name="categoryId" required>
          <option value="" disabled selected>Select Category</option>
          <%
            CategoryDao catDao = new CategoryDao();
            ArrayList<Category> allCats = catDao.getAllCategorys();
            for (Category cat : allCats) {
          %>
            <option value="<%= cat.getCategoryId() %>"><%= cat.getCategoryName() %></option>
          <% } %>
        </select>

        <button type="submit">Get Study Material</button>
        <p id="feedbackMsg" style="margin-top:8px; font-weight:600; font-size:13px; text-align:center;"></p>
      </form>

    </div><!-- /.content-wrapper -->


    <!-- ── HOW TO USE ─────────────────────────── -->
    <div id="help" class="help" style="animation: fadeUp 0.9s ease forwards;">
      <h2>How to Use Study4Diploma</h2>
      <div class="section-divider"></div>
      <p>Welcome to <strong>Study4Diploma</strong> — your all-in-one study hub for MSBTE diploma students. This website is organised semester-wise and branch-wise to help you find exactly what you need, fast.</p>
      <ul>
        <li><strong>Choose Your Scheme</strong> — Select <strong>K-Scheme</strong> or <strong>I-Scheme</strong> based on your syllabus.</li>
        <li><strong>Select Your Branch</strong> — Computer, Electrical, Mechanical and more.</li>
        <li><strong>Pick Your Semester</strong> — Click the relevant semester (1 through 6) to view subjects.</li>
        <li><strong>View Notes &amp; Papers</strong> — Short, exam-focused notes and previous year papers for every subject.</li>
        <li><strong>Use Feedback Form</strong> — Missing something? Drop us a message and we'll add it soon.</li>
        <li><strong>Download &amp; Study Offline</strong> — All PDFs can be downloaded directly to your device. No internet needed during your exam revision — save them once, study anywhere, anytime.</li>
      </ul>
      <p class="help-note">📌 If a page says "Not available yet", content is being prepared — check back soon!</p>
    </div>


    <!-- ── CONNECT ─────────────────────────────── -->
    <div class="connect text-center" id="connect">
      <h2>Connect With Us</h2>
      <div class="section-divider"></div>
      <p>Have a question, suggestion, or feedback? We'd love to hear from you.</p>

      <div class="connect-wrapper">

        <!-- Feedback Form -->
        <div class="feedback-box">
          <h3>Send Us Feedback</h3>
          <form id="feedbackForm" action="../ContactController" method="post">
            <input type="text"  name="name"    id="name"    placeholder="Your Name"     required>
            <input type="email" name="email"   id="email"   placeholder="Your Email"    required>
            <textarea           name="message" id="message" placeholder="Your message…" required></textarea>
            <button type="submit">Submit Feedback</button>
          </form>
        </div>

        <!-- Contact Details -->
        <div class="contact-box">
          <h3>Contact Details</h3>

          <div class="contact-item">
            <div class="contact-item-icon">✉</div>
            <div class="contact-item-text">
              <span>Email</span>
              <span>shendegaurav93@gmail.com</span>
            </div>
          </div>

          <div class="contact-item">
            <div class="contact-item-icon">📞</div>
            <div class="contact-item-text">
              <span>Phone</span>
              <span>+91 70280 26110</span>
            </div>
          </div>

          <div class="contact-item">
            <div class="contact-item-icon">📍</div>
            <div class="contact-item-text">
              <span>Location</span>
              <span>Ahilyanagar, Maharashtra, India</span>
            </div>
          </div>
        </div>

      </div>
    </div><!-- /.connect -->


    <!-- ── DISCLAIMER FOOTER ───────────────────── -->
    <footer class="disclaimer-footer">
      <p>
        This website is an independent educational platform created strictly to assist students with exam preparation.
        It is not affiliated with, authorized, or endorsed by the Maharashtra State Board of Technical Education (MSBTE).
        All official resources can be found on the <a href="https://msbte.ac.in" target="_blank" rel="noopener">Official MSBTE Portal</a>.
      </p>
      
      <p class="footer-copy">&copy; 2025 Study4Diploma. All rights reserved.</p>
    </footer>

  </div><!-- /.main -->

  <!-- Scripts -->
  <script>
  const hamburger = document.getElementById('hamburger');
  const mobileMenu = document.getElementById('mobileMenu');

  hamburger.addEventListener('click', () => {
    hamburger.classList.toggle('open');
    mobileMenu.classList.toggle('open');
  });

  // Close menu when a link is clicked
  mobileMenu.querySelectorAll('a').forEach(link => {
    link.addEventListener('click', () => {
      hamburger.classList.remove('open');
      mobileMenu.classList.remove('open');
    });
  });
</script>
<script>
// ── Navbar Search — hints from real DB data ──────────────────
const MATERIAL_HINTS = (function() {
  const raw = [
    <%
      LinkedHashSet<String> hints = new LinkedHashSet<>();
      try {
        // Subject names
        SubjectDao subjectDao = new SubjectDao();
        ArrayList<Subject> subjects = subjectDao.getAllsubjects();
        if (subjects != null) {
          for (Subject s : subjects) {
            if (s.getName() != null && !s.getName().trim().isEmpty()) {
              hints.add(s.getName().trim().replace("\"","\\\""));
            }
          }
        }
        // Material titles
        MaterialDao matDao = new MaterialDao();
        ArrayList<Material> mats = matDao.getAllMaterials();
        if (mats != null) {
          for (Material m : mats) {
            if (m.getTitle() != null && !m.getTitle().trim().isEmpty()) {
              hints.add(m.getTitle().trim().replace("\"","\\\""));
            }
          }
        }
      } catch (Exception ignored) {}
      StringBuilder sb = new StringBuilder();
      boolean first = true;
      for (String h : hints) {
        if (!first) sb.append(",\n    ");
        sb.append("\"").append(h).append("\"");
        first = false;
      }
      out.print(sb.toString());
    %>
  ];
  return raw;
})();

function navGoSearch() {
  const q = document.getElementById('navSearch').value.trim();
  if (!q) return;
  closeNavDropdown();
  window.location.href = './Material.jsp?search=' + encodeURIComponent(q);
}

function navSearchSuggest(val) {
  const dropdown = document.getElementById('navSearchDropdown');
  const q = val.trim().toLowerCase();
  if (q.length < 1) { closeNavDropdown(); return; }

  const escaped = q.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
  const re = new RegExp(escaped, 'gi');

  // Sort: starts-with first, then contains
  const startsWith = MATERIAL_HINTS.filter(h => h.toLowerCase().startsWith(q));
  const contains   = MATERIAL_HINTS.filter(h => !h.toLowerCase().startsWith(q) && h.toLowerCase().includes(q));
  const matches = [...startsWith, ...contains].slice(0, 7);

  if (!matches.length) { closeNavDropdown(); return; }

  dropdown.innerHTML = matches.map(m => {
    const hl = m.replace(re, '<mark>$&</mark>');
    const safe = m.replace(/\\/g,'\\\\').replace(/'/g,"\\'");
    return `<div class="nav-search-item" onclick="navPickSuggestion('${safe}')">
      <span class="nav-si-icon">📄</span>
      <span class="nav-si-text">${hl}</span>
    </div>`;
  }).join('');
  dropdown.style.display = 'block';
}

function navPickSuggestion(text) {
  document.getElementById('navSearch').value = text;
  closeNavDropdown();
  window.location.href = './Material.jsp?search=' + encodeURIComponent(text);
}

function closeNavDropdown() {
  const d = document.getElementById('navSearchDropdown');
  if (d) d.style.display = 'none';
}

document.addEventListener('click', function(e) {
  const wrap = document.getElementById('navSearchWrap');
  if (wrap && !wrap.contains(e.target)) closeNavDropdown();
});
</script>
  <script src="index.js"></script>
</body>
</html>
