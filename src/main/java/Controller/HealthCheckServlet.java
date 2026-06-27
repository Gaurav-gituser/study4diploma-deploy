package Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import Helper.Config;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/health")
public class HealthCheckServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	Config fig = new Config();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/plain");
		try {
			Connection con = fig.getConnection();
			PreparedStatement ps = con.prepareStatement("SELECT 1");
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				response.setStatus(HttpServletResponse.SC_OK);
				response.getWriter().write("OK - Database connection alive");
			}
		} catch (Exception e) {
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			response.getWriter().write("FAILED - " + e.getMessage());
		}
	}
}
