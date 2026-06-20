package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import Dao.SchemeDao;
import Dao.SubjectDao;
import Dao.UserDao;
import Model.Scheme;
import Model.Subject;
import Model.User;

/**
 * Servlet implementation class SubjectController
 */
@WebServlet("/SubjectController")
public class SubjectController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SubjectController() {
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
//		// TODO Auto-generated method stub
//		doGet(request, response);
		
		
		String btn = request.getParameter("btn");
		if(btn.equalsIgnoreCase("insert"))
		{
				String subjectName = request.getParameter("subjectName");
	            String courseCode = request.getParameter("courseCode");
	            String branchId = request.getParameter("branchId");
	            String schemeId = request.getParameter("schemeId");
	            String semesterId = request.getParameter("semesterId");
	            
	            SubjectDao dao = new SubjectDao();
				String subjectId = dao.auto_Sid();

				Subject subject = new Subject(subjectId, subjectName, courseCode, branchId, schemeId, semesterId);
				
				System.out.println("subject="+subject);

				int result = dao.insertSubject(subject);
				
				if(result == 1)
				{
					System.out.println("insert success");
					response.sendRedirect("./Admin/UpdateSubject.jsp");
				}
				else
				{
					System.out.println("insert failed");
				}
						
		}

     else if (btn.equalsIgnoreCase("Update")) {
        String subjectId = request.getParameter("subjectId");
        String subjectName = request.getParameter("subjectName");
        String courseCode = request.getParameter("courseCode");
        String branchId = request.getParameter("branchId");
        String schemeId = request.getParameter("schemeId");
        String semesterId = request.getParameter("semesterId");

        Subject subject = new Subject(subjectId, subjectName, courseCode, branchId, schemeId, semesterId);
        SubjectDao dao = new SubjectDao();
        int result = dao.updateSubject(subject);

        if (result == 1) {
            System.out.println("Subject updated successfully");
        } else {
            System.out.println("Update failed");
        }

        response.sendRedirect("./Admin/UpdateSubject.jsp");

    }
		
     else if(btn.equalsIgnoreCase("Delete"))
     {
    	
    	 
    	 
    	  SubjectDao dao = new SubjectDao();
    	  String sid = request.getParameter("subjectId");
          int result = dao.deleteSubject(sid);
          
          if(result==1)
          {
        	 System.out.println("delete successfully"); 
        	 response.sendRedirect("./Admin/UpdateSubject.jsp");
          }
          else
          {
        	  System.out.println("subject delete failed");
          }
    	 
     }
		
		
		
		
	}
	
}

