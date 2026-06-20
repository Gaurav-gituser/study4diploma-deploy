package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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

/**
 * Servlet implementation class UserController
 */
@WebServlet("/UserController")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Object User = null;
	private String user;

	/**
	 * @return
	 * @see HttpServlet#HttpServlet()
	 */
	public UserController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

//		UserDao dao = new UserDao();
//		ArrayList<User> alluser = dao.getAll();
//		System.out.println("obj" + user);
////		response.getWriter().append("Served at: ").append(request.getContextPath());
//
//		HttpSession session = request.getSession();
//		session.setAttribute("alluser", User);
//		response.sendRedirect("./Admin/UpdateUser.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		PrintWriter out = response.getWriter();
		response.setContentType("text/html");

		String btn = request.getParameter("btn");
		if (btn.equals("insert"))

		{

			String user_id, name, email, password, roleId;

		
			name = request.getParameter("name");
			email = request.getParameter("email");
			password = request.getParameter("password");
			roleId = "rid_102";
			 LocalDateTime now = LocalDateTime.now();
		     String formattedDate = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
			
			UserDao dao = new UserDao();
			String userId = dao.auto_uid();

			User user = new User(userId, name, email, password, roleId,formattedDate);
			
			System.out.println("user="+user);

			int result = dao.UserInsert(user);

			if (result == 1) {
				System.out.println("user inserted successfully");
				response.sendRedirect("./User/login.jsp");
			} else {
				System.out.println("user insertion Failed");
			}

		} else if (btn.equalsIgnoreCase("update")) {

			String userId = request.getParameter("userId");
            String name = request.getParameter("name");
            String email = request.getParameter("email");

            UserDao dao = new UserDao();
			int result = dao.updateUser(userId,name,email);
			if(result == 1)
			{
				System.out.println("user insert");
				response.sendRedirect("./User/index.jsp");
			}
			else
			{
				response.sendRedirect("./User/index.jsp");
			}

		}
	}

}
