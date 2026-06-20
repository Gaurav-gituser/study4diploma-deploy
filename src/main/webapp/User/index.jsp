<%@page import="Model.Subject"%>
<%@page import="Dao.SubjectDao"%>
<%@page import="Model.semester"%>
<%@page import="Dao.SemesterDao"%>
<%@page import="Model.Category"%>
<%@page import="Dao.CategoryDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Year"%>
<%@page import="Dao.YearDao"%>
<%@page import="Model.Branche"%>
<%@page import="Dao.BrancheDao"%>
<%@page import="Model.Scheme"%>
<%@page import="Dao.SchemeDao"%>
<%@page import="Model.User"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <title>Study4Diploma</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
  <link rel="stylesheet" href="index.css">
</head>

<body>
  <canvas id="bgCanvas"></canvas>

  <div class="main">
    <!-- Navbar -->
    <div class="navbar">
      <div class="logo">Study4Diploma</div>
      <div class="menu">
        <ul>
          <li><a href="index.jsp">HOME</a></li>
          <li><a href="#connect">CONTACT</a></li>
          <li><a href="#help">HELP</a></li>
          <li><a href="./profile.jsp">PROFILE</a></li>
        </ul>
      </div>
      <%
        User user = (User) session.getAttribute("user");
      %>
      <div class="nav-right">
        <% if (user != null) { %>
          <a href="./logout.jsp">Logout</a>
        <% } else { %>
          <a href="./login.jsp">Login</a>
        <% } %>
      </div>
    </div>

    <!-- Content Section -->
    <div class="content-wrapper">
      <div class="content">
        <h1>One of the best websites for <br><span>Diploma Students</span></h1>
        <div class="typing-text">
          <span class="fixed">We provide </span><span class="dynamic" id="typing"></span>
        </div>
        <p><b>Study4Diploma</b> is a learning platform created especially for MSBTE diploma students.
          It provides <b>notes, previous years question papers</b> – all in one place.
          Instead of searching everywhere, students can quickly find the right resources for their branch
          and semester to prepare smarter and score better.
        </p>
       
      </div>

      <!-- Study Material Form -->
    <!-- Study Material Form -->
<form class="form" id="studyForm" action="./Material.jsp" method="post">
  <h3>Fill the following information <br>To get study material:</h3>

  <!-- Scheme Dropdown -->
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

  <!-- Branch Dropdown -->
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

  <!-- Year Dropdown -->
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

  <!-- Semester Dropdown -->
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

  <!-- Category Dropdown -->
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

<!-- Subject Dropdown -->
<select id="subject" name="subjectId" required>
  <option value="" disabled selected>Select Subject</option>
  <%
    SubjectDao subjectDao = new SubjectDao();
    ArrayList<Subject> allSubjects = subjectDao.getAllsubjects();
    for (Subject subject : allSubjects) {
  %>
      <option value="<%= subject.getSubjectId() %>"><%= subject.getName() %></option>
  <%
    }
  %>
</select>

  <button type="submit">Submit</button>
</form>

        <p id="feedbackMsg" style="margin-top:10px; font-weight:600;"></p>
      </div>

    </div>
    
    

  <div id="help" class="help">
    <h2>📘 How to Use Study4Diploma</h2>
    <p>Welcome to <strong>Study4Diploma</strong> — your all-in-one study hub for MSBTE diploma students!</p>
    <p>This website is organized semester-wise and branch-wise. To get started:</p>
    <ul>
      <li><strong>Choose Your Scheme</strong> – Select either <strong>K-Scheme</strong> or <strong>I-Scheme</strong>
        based on your syllabus.</li>
      <li><strong>Select Your Branch</strong> – Such as <strong>Computer</strong>, <strong>Electrical</strong>, etc.
      </li>
      <li><strong>Pick Your Semester</strong> – Click the relevant semester (e.g., Semester 1, 2, 3...) to view the
        subjects.</li>
      <li><strong>View Notes</strong> – Each subject includes short, easy-to-understand notes prepared specially for
        diploma students.</li>
      <li><strong>Use the Feedback Form</strong> – If something is missing or unclear, drop a message through the
        feedback form.</li>
    </ul>
    <p style="color: #ff4c4c;"><strong>📌 If a page says "Page is not available for now," it means content is being
        prepared — check back soon!</strong></p>
    <p>Let’s make studying simple and smart. <strong>Happy Learning! 💡</strong></p>
  </div>

  <div class="connect text-center" id="connect">
    <h2>Connect With Us</h2>
    <p>We’d love to hear from you! Whether you have a question, suggestion, or feedback – feel free to reach out.</p>

    <div class="connect-wrapper">
      <!-- Feedback Form (Top) -->
      <div class="feedback-box">
        <h3>Send Us Feedback</h3>
        <form id="feedbackForm" action="../ContactController" method="post">
          <input type="text" name="name" id="name" placeholder="Your Name" required>
          <input type="email" name="email" email="email" id="email" placeholder="Your Email" required>
          <textarea id="message" name="message" placeholder="Your Feedback" required></textarea>
          <button type="submit">Submit Feedback</button>
        </form>
        <p id="feedbackMsg" style="margin-top:10px; font-weight:600;"></p>
      </div>

     
      <div class="contact-box">
        <h3>Contact Details</h3>
        <p><b>Email:</b> shendegaurav93@gmail.com</p>
        <p><b>Phone:</b> +917028026110</p>
        <p><b>Address:</b> Ahilyanagar,Maharashtra,India</p>

      </div>
    </div>
  </div>

  <!-- Scripts -->
  <script src="index.js"></script>
</body>
</html>
