package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import Dao.UserDao;
import Model.User;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String emailOrPhone = request.getParameter("email");
		String password     = request.getParameter("password");

		if (emailOrPhone == null || emailOrPhone.trim().isEmpty()
				|| password == null || password.trim().isEmpty()) {
			HttpSession session = request.getSession();
			session.setAttribute("loginError", "Please enter your email/phone and password.");
			response.sendRedirect("./User/login.jsp");
			return;
		}

		try {
			UserDao userDAO = new UserDao();
			User user = userDAO.login(emailOrPhone, password);
			System.out.println("login user=" + user);

			if (user != null) {
				HttpSession session = request.getSession();
				session.setAttribute("user", user);
				System.out.println("session set");

				if (user.getRoleId().equalsIgnoreCase("rid_102")) {
					response.sendRedirect("./User/index.jsp");
				} else {
					response.sendRedirect("./Admin/AdminPanel.jsp");
				}
			} else {
				HttpSession session = request.getSession();
				session.setAttribute("loginError", "Invalid email/phone or password. Please try again.");
				response.sendRedirect("./User/login.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
			HttpSession session = request.getSession();
			session.setAttribute("loginError", "Login failed: database connection error. Please try again later.");
			response.sendRedirect("./User/login.jsp");
		}
	}
}
