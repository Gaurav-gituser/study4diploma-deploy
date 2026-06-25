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

/**
 * Servlet implementation class LoginController
 */
@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String emailOrPhone = request.getParameter("email");  // field name stays "email" in form
		String password = request.getParameter("password");
		
	        UserDao userDAO = new UserDao();
	        User user = userDAO.login(emailOrPhone, password);
	        System.out.println("login user="+user);
	        if (user != null) {
	            // Login successful, store user in session
	            HttpSession session = request.getSession();
	            session.setAttribute("user", user);
	            System.out.println("session set");
	            
	            if(user.getRoleId().equalsIgnoreCase("rid_102"))
	            {
	            	 response.sendRedirect("./User/index.jsp"); 
	            }
	            else
	            {
	            	 response.sendRedirect("./Admin/AdminPanel.jsp"); 
	            }
	            
	            // Redirect to homepage
	        } else {
	            // Login failed
	        	 response.sendRedirect("./User/login.jsp");  // Redirect to homepage
	        }
		
		
//		// TODO Auto-generated method stub
//		doGet(request, response);
	}

}
