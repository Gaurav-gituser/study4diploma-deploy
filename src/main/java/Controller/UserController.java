package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Helper.PasswordHelper;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import Dao.CategoryDao;
import Dao.SchemeDao;
import Dao.UserDao;
import Model.Category;
import Model.Scheme;
import Model.User;
import Model.Year;

@WebServlet("/UserController")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Object User = null;
	private String user;

	public UserController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// no-op
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");

		String btn = request.getParameter("btn");
		if (btn == null) {
			response.sendRedirect("./User/index.jsp");
			return;
		}

		if (btn.equals("insert")) {

			try {
				String name     = request.getParameter("name");
				String email    = request.getParameter("email");
				String phone    = request.getParameter("phone");
				String password = request.getParameter("password");

				password = PasswordHelper.hash(password);
				String roleId = "rid_102";

				LocalDateTime now = LocalDateTime.now();
				String formattedDate = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

				UserDao dao = new UserDao();
				String userId = dao.auto_uid();

				Model.User newUser = new Model.User(userId, name, email, phone, password, roleId, formattedDate);
				System.out.println("user=" + newUser);

				int result = dao.UserInsert(newUser);

				if (result == 1) {
					System.out.println("user inserted successfully");
					HttpSession session = request.getSession();
					session.setAttribute("signupSuccess", "Account created! Please log in.");
					response.sendRedirect("./User/login.jsp");
				} else {
					System.out.println("user insertion Failed");
					HttpSession session = request.getSession();
					session.setAttribute("signupError", "Account creation failed. Email or phone may already be in use, or database error. Please try again.");
					response.sendRedirect("./User/Signin.jsp");
				}
			} catch (Exception e) {
				e.printStackTrace();
				HttpSession session = request.getSession();
				session.setAttribute("signupError", "Signup failed: " + e.getMessage());
				response.sendRedirect("./User/Signin.jsp");
			}

		} else if (btn.equalsIgnoreCase("update")) {

			String userId = request.getParameter("userId");
			String name   = request.getParameter("name");
			String email  = request.getParameter("email");
			String phone  = request.getParameter("phone");

			UserDao dao = new UserDao();
			int result = dao.updateUser(userId, name, email, phone);
			if (result == 1) {
				HttpSession session = request.getSession();
				Model.User loggedUser = (Model.User) session.getAttribute("user");
				if (loggedUser != null) {
					loggedUser.setName(name);
					loggedUser.setEmail(email);
					loggedUser.setPhone(phone);
					session.setAttribute("user", loggedUser);
				}
				response.sendRedirect("./User/profile.jsp?msg=updated");
			} else {
				response.sendRedirect("./User/profile.jsp?msg=error");
			}

		} else if (btn.equalsIgnoreCase("changepassword")) {

			HttpSession session = request.getSession();
			Model.User loggedUser = (Model.User) session.getAttribute("user");

			String currentPassword  = request.getParameter("currentPassword");
			String newPassword      = request.getParameter("newPassword");
			String confirmPassword  = request.getParameter("confirmPassword");

			if (loggedUser != null && PasswordHelper.verify(currentPassword, loggedUser.getPassword())) {
				if (newPassword.equals(confirmPassword)) {
					UserDao dao = new UserDao();
					int result = dao.updatePassword(loggedUser.getEmail(), PasswordHelper.hash(newPassword));
					if (result == 1) {
						loggedUser.setPassword(PasswordHelper.hash(newPassword));
						session.setAttribute("user", loggedUser);
						response.sendRedirect("./User/profile.jsp?msg=success");
					} else {
						response.sendRedirect("./User/profile.jsp?msg=error");
					}
				} else {
					response.sendRedirect("./User/profile.jsp?msg=mismatch");
				}
			} else {
				response.sendRedirect("./User/profile.jsp?msg=wrongpassword");
			}
		}
	}
}
