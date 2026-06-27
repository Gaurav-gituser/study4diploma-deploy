<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="preconnect" href="https://cdn.jsdelivr.net">
  <title>Sign Up — Study4Diploma</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <style>
    :root {
      --navy:#0D1B3E; --navy-mid:#112252; --navy-card:#0F1F48;
      --cyan:#00C6FF; --white:#FFFFFF; --soft:#CBD8F0; --border:rgba(0,198,255,0.18);
    }
    * { margin:0; padding:0; box-sizing:border-box; }
    body { font-family:'Poppins',sans-serif; background:var(--navy); color:var(--white); overflow-x:hidden; }

    #bgCanvas { position:fixed; top:0; left:0; width:100%; height:100%; z-index:-1;
      background:linear-gradient(160deg,#040d1f 0%,#0D1B3E 60%,#071430 100%); }

    /* ── NAVBAR ── */
    .navbar { width:100%; background:rgba(10,18,42,0.95); backdrop-filter:blur(12px);
      padding:0 48px; height:64px; display:flex; justify-content:space-between;
      align-items:center; position:sticky; top:0; z-index:1000;
      border-bottom:1px solid var(--border);
      transform:translateY(-100%); animation:slideDown 0.9s cubic-bezier(.22,1,.36,1) forwards; }
    @keyframes slideDown { to { transform:translateY(0); } }

    .logo-wrap { display:flex; flex-direction:column; line-height:1; gap:3px; }
    .logo { font-size:22px; font-weight:800; letter-spacing:1px; white-space:nowrap; }
    .logo-study { color:var(--white); } .logo-four { color:var(--cyan); } .logo-diploma { color:var(--white); }
    .logo-tagline { font-size:9px; font-weight:400; letter-spacing:4px; color:var(--soft);
      text-transform:uppercase; border-top:1px solid var(--cyan); padding-top:3px; }

    .menu { flex:1; display:flex; justify-content:center; }
    .menu ul { list-style:none; display:flex; gap:40px; }
    .menu ul li a { text-decoration:none; color:var(--soft); font-weight:500; font-size:13px;
      letter-spacing:1.5px; text-transform:uppercase; transition:color 0.25s;
      position:relative; padding-bottom:3px; }
    .menu ul li a::after { content:''; position:absolute; bottom:0; left:0; width:0; height:2px;
      background:var(--cyan); transition:width 0.3s; }
    .menu ul li a:hover { color:var(--white); }
    .menu ul li a:hover::after { width:100%; }

    .nav-right a { background:transparent; border:1.5px solid var(--cyan); padding:7px 22px;
      border-radius:4px; color:var(--cyan); font-size:13px; font-weight:600;
      text-decoration:none; letter-spacing:1px; transition:all 0.25s; }
    .nav-right a:hover { background:var(--cyan); color:var(--navy); }

    /* ── HAMBURGER ── */
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
      transform: translateY(-10px);
      opacity: 0;
      transition: all 0.28s ease;
    }
    .mobile-menu.open {
      display: flex;
      transform: translateY(0);
      opacity: 1;
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
    .mobile-divider { height:1px; background:var(--border); margin:10px 0; }
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
      text-transform: uppercase;
      text-decoration: none;
      transition: all 0.25s ease;
    }
    .mobile-menu .mobile-login-btn:hover { background:var(--cyan); color:var(--navy); }

    /* ── SIGNUP FORM ── */
    .signup-wrapper { min-height:calc(100vh - 64px); display:flex;
      justify-content:center; align-items:center; padding:40px 20px; }

    .signup-box { width:480px; background:var(--navy-card);
      border:1px solid var(--border); border-radius:10px; padding:40px 36px;
      box-shadow:0 0 40px rgba(0,198,255,0.15);
      opacity:0; transform:translateY(40px); animation:fadeUp 1s ease forwards 0.3s; }
    @keyframes fadeUp { to { opacity:1; transform:translateY(0); } }

    .signup-box h2 { color:var(--cyan); font-size:26px; font-weight:700;
      text-align:center; margin-bottom:28px; }

    label { display:block; color:var(--soft); font-size:13px; font-weight:500; margin-bottom:6px; }
    input { width:100%; height:44px; padding:0 14px;
      background:rgba(255,255,255,0.04); border:1px solid var(--border);
      border-radius:5px; color:var(--white); font-family:'Poppins',sans-serif;
      font-size:14px; transition:border 0.25s, background 0.25s; margin-bottom:16px; }
    input:focus { outline:none; border-color:var(--cyan); background:rgba(0,198,255,0.06); }

    .field-note { font-size:11px; color:var(--soft); opacity:0.7; margin-top:-12px; margin-bottom:14px; }

    .btn-signup { width:100%; height:44px; background:var(--cyan); border:none;
      border-radius:5px; color:var(--navy); font-family:'Poppins',sans-serif;
      font-weight:700; font-size:15px; cursor:pointer; transition:all 0.25s;
      margin-top:4px; letter-spacing:0.5px; }
    .btn-signup:hover { background:var(--white); transform:translateY(-1px);
      box-shadow:0 6px 20px rgba(0,198,255,0.35); }

    .signup-box .links { margin-top:20px; text-align:center; }
    .signup-box .links p { color:var(--soft); font-size:13px; }
    .signup-box .links a { color:var(--cyan); text-decoration:none; font-weight:600; }
    .signup-box .links a:hover { text-decoration:underline; }

    /* ── RESPONSIVE — TABLET (≤900px) ── */
    @media (max-width: 900px) {
      .navbar { padding: 0 24px; }
      .menu { display: none; }
      .nav-right { display: none; }
      .hamburger { display: flex; }
      .mobile-menu { top: 64px; }
    }

    /* ── RESPONSIVE — MOBILE (≤640px) ── */
    @media (max-width: 640px) {
      .navbar { padding: 0 16px; height: 58px; }
      .mobile-menu { top: 58px; }
      .logo { font-size: 18px; }
      .logo-tagline { font-size: 8px; letter-spacing: 3px; }

      .signup-wrapper { padding: 30px 16px; align-items: flex-start; padding-top: 40px; }
      .signup-box { width: 100%; padding: 28px 20px; }
      .signup-box h2 { font-size: 22px; margin-bottom: 22px; }
      input { font-size: 13px; height: 42px; }
      .btn-signup { font-size: 14px; height: 42px; }
      label { font-size: 12px; }
    }

    /* ── RESPONSIVE — SMALL MOBILE (≤380px) ── */
    @media (max-width: 380px) {
      .logo { font-size: 16px; }
      .signup-box { padding: 22px 14px; }
      .signup-box h2 { font-size: 20px; }
    }
  </style>
</head>
<body>
<canvas id="bgCanvas"></canvas>

<nav class="navbar">
  <div class="logo-wrap">
    <div class="logo">
      <span class="logo-study">STUDY</span><span class="logo-four">4</span><span class="logo-diploma">DIPLOMA</span>
    </div>
    <div class="logo-tagline">MSBTE &middot; DIPLOMA &middot; STUDY</div>
  </div>
  <div class="menu">
    <ul>
      <li><a href="index.jsp">HOME</a></li>
      <li><a href="index.jsp#connect">CONTACT</a></li>
      <li><a href="index.jsp#help">HELP</a></li>
    </ul>
  </div>
  <div class="nav-right">
    <a href="./login.jsp">Login</a>
  </div>
  <!-- Hamburger (mobile only) -->
  <button class="hamburger" id="hamburger" aria-label="Menu">
    <span></span><span></span><span></span>
  </button>
</nav>

<!-- Mobile drawer -->
<div class="mobile-menu" id="mobileMenu">
  <a href="index.jsp">HOME</a>
  <a href="index.jsp#connect">CONTACT</a>
  <a href="index.jsp#help">HELP</a>
  <div class="mobile-divider"></div>
  <a href="./login.jsp" class="mobile-login-btn">Login</a>
</div>

<div class="signup-wrapper">
  <div class="signup-box">
    <h2>Create Account</h2>
    <form action="../UserController" method="post">

      <label for="name">Full Name</label>
      <input type="text" name="name" id="name" placeholder="Enter your full name" required>

      <label for="email">Email Address <span style="color:#ff6b6b;">*</span></label>
      <input type="email" name="email" id="email" placeholder="Enter your email" required>

      <label for="phone">Phone Number <span style="color:#ff6b6b;">*</span></label>
      <input type="tel" name="phone" id="phone" placeholder="Enter 10-digit phone number"
             pattern="[0-9]{10}" title="Enter a valid 10-digit phone number" required>
      <p class="field-note">Used for alternate login. 10 digits, no spaces.</p>

      <label for="password">Password</label>
      <input type="password" name="password" id="password" placeholder="Min 8 chars, include number &amp; symbol"
             pattern="(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{8,}"
             title="At least 8 characters including letters, number & symbol" required>

      <button type="submit" name="btn" value="insert" class="btn-signup">Create Account</button>
    </form>

    <div class="links">
      <p>Already have an account? <a href="login.jsp">Login</a></p>
    </div>
  </div>
</div>

<script>
  // Background canvas
  const canvas = document.getElementById("bgCanvas");
  const ctx = canvas.getContext("2d");
  function resize() { canvas.width = window.innerWidth; canvas.height = window.innerHeight; }
  resize(); window.addEventListener("resize", resize);
  let stars = [];
  for (let i = 0; i < 80; i++)
    stars.push({ x:Math.random()*canvas.width, y:Math.random()*canvas.height, r:Math.random()*1.5+0.3, a:Math.random() });
  function draw() {
    ctx.clearRect(0,0,canvas.width,canvas.height);
    stars.forEach(s => {
      ctx.beginPath(); ctx.arc(s.x,s.y,s.r,0,Math.PI*2);
      ctx.fillStyle=`rgba(0,198,255,${s.a})`; ctx.fill();
      s.a += (Math.random()-0.5)*0.02;
      if(s.a<0.1)s.a=0.1; if(s.a>0.8)s.a=0.8;
    });
    requestAnimationFrame(draw);
  }
  draw();

  // Hamburger
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
</body>
</html>
