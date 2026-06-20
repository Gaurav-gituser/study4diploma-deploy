package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;

import Dao.CategoryDao;
import Dao.SchemeDao;
import Dao.SemesterDao;
import Dao.YearDao;
import Model.Category;
import Model.Scheme;
import Model.Year;
import Model.semester;

/**
 * Servlet implementation class SemesterController
 */
@WebServlet("/SemesterController")
public class SemesterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private HttpServletResponse response;
	private String semesterName;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SemesterController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @param allYear 
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
		
		String btn  = request.getParameter("btn");
		if(btn.equalsIgnoreCase("insert"))
		{
			System.out.println("hello insert");
			String year,semester_id;
			String semester;
			
			semester =  request.getParameter("semester");
			
			year= request.getParameter("year");
			
			
			
		SemesterDao dao = new SemesterDao();
			semester_id = dao.auto_Sid();
			
			
			semester sem = new semester(semester, semester_id, year);
			System.out.println("sem="+sem);
					
			int result = dao.semesterInsert(sem);
			
			if(result == 1)
			{
				System.out.println("semester inserted successfully");
				response.sendRedirect("./Admin/UpdateSemester.jsp");
			}
			else
			{
	    	System.out.println(" semester insertion Failed");

			}
			
			
		}
		else if (btn.equalsIgnoreCase("update"))
		{
//System.out.println("hello update");
			
		
	String semester , year ;
			
			
	semester= request.getParameter("semesterName");
	 year = request.getParameter("year");
	String smesterId = request.getParameter("semesterId");
			
			
			 System.out.println("obj name "+year);
			 
			 
			 semester sem=new semester(semester, smesterId, year);
			 SemesterDao dao=new SemesterDao();
			 System.out.println("UP OBJ="+sem);
			 
			 int result=dao.UpdateSemester(sem);	
			 if (result==1) {
				 System.out.println("semester updated");
				 response.sendRedirect("./Admin/UpdateSemester.jsp");
			 }
			 else {
			System.out.println("semester not updated"); 
	}
			
	
	}
	else if(btn.equalsIgnoreCase("delete"))
	{
//		System.out.println("hello delete");
		String semId=request.getParameter("semesterId");
		 SemesterDao dao = new SemesterDao();
//		 System.out.println("id="+SchemeId);
	
		int result=dao.deleteSemester(semId);
		System.out.println(semId);
		if (result==1)
		{
			System.out.println("semester delete successfully");
			response.sendRedirect("./Admin/UpdateSemester.jsp");
		}
		else		{
			System.out.println("Semester not deleted");
		}
		
	}
		}
}
	
			
			