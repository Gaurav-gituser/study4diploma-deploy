package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import Dao.ContactDao;
import Model.Contact;

/**
 * Servlet implementation class ContactController
 */
@WebServlet("/ContactController")
public class ContactController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ContactController() {
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
		// TODO Auto-generated method stub
//		doGet(request, response);
		
		 String name = request.getParameter("name");
	        String email = request.getParameter("email");
	        String message = request.getParameter("message");
	        ContactDao dao2 = new ContactDao();
	        String cid = dao2.auto_Cid();
	        
	        Contact con = new Contact(cid, name, email, message);
	        
	        int result = dao2.saveFeedback(con); 
	        if(result == 1)
	        {
	        	response.sendRedirect("./User/index.jsp");
	        }
	        else
	        {
	        	response.sendRedirect("./User/index.jsp");
	        }
	        
	}

}
