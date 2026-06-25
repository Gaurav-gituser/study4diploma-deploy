<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="Helper.Config" %>
<!DOCTYPE html>
<html><head><meta charset="UTF-8"><title>DB Test</title>
<style>
  body{font-family:monospace;background:#0D1B3E;color:#CBD8F0;padding:30px;}
  .ok{color:#00c664;} .err{color:#ff6b6b;} pre{background:#0F1F48;padding:16px;border-radius:6px;}
</style>
</head><body>
<h2>Database Connection Test</h2>
<pre>
<%
  String dbUrl  = System.getenv("DB_URL");
  String dbUser = System.getenv("DB_USER");
  String dbPass = System.getenv("DB_PASSWORD");

  out.println("DB_URL    = " + (dbUrl  != null ? dbUrl  : "NOT SET ❌"));
  out.println("DB_USER   = " + (dbUser != null ? dbUser : "NOT SET ❌"));
  out.println("DB_PASS   = " + (dbPass != null ? "(set, length " + dbPass.length() + ")" : "NOT SET ❌"));
  out.println("");

  if (dbUrl == null || dbUser == null || dbPass == null) {
    out.println("RESULT: ❌ Environment variables missing. Set DB_URL, DB_USER, DB_PASSWORD in Render → Environment.");
  } else {
    try {
      Config cfg = new Config();
      Connection con = cfg.getConnection();
      if (con != null && !con.isClosed()) {
        out.println("RESULT: ✅ Connected successfully!");
        // List tables
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SHOW TABLES");
        out.println("Tables in database:");
        while(rs.next()) out.println("  - " + rs.getString(1));
        // Count users
        try {
          ResultSet rs2 = stmt.executeQuery("SELECT COUNT(*) FROM users");
          if(rs2.next()) out.println("Users count: " + rs2.getInt(1));
        } catch(Exception e2) { out.println("users table: " + e2.getMessage()); }
        con.close();
      } else {
        out.println("RESULT: ❌ Connection returned null. Check DB_URL format and SSL settings.");
      }
    } catch(Exception e) {
      out.println("RESULT: ❌ Connection FAILED");
      out.println("Error: " + e.getMessage());
      out.println("Cause: " + (e.getCause() != null ? e.getCause().getMessage() : "none"));
    }
  }
%>
</pre>
<p style="font-size:12px;color:#888;margin-top:20px;">
  ⚠️ Delete this file (dbtest.jsp) after testing — it exposes DB info.
</p>
</body></html>
