package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import Dao.CategoryDao;
import Dao.SchemeDao;
import Model.Category;
import Model.Scheme;



/**
 * Servlet implementation class SchemeController
 */
@WebServlet("/SchemeController")
public class SchemeCantrolletr extends HttpServlet {
	private static final long serialVersionUID = 1L;

       
    /**
     * @return 
     * @see HttpServlet#HttpServlet()
     */
    public SchemeCantrolletr() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	
	    SchemeDao dao =new SchemeDao();
		ArrayList<Scheme> Schemes = dao.getAllScheme();
		System.out.println("obj"+Schemes);
//		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		HttpSession session =request.getSession();
		session.setAttribute("allSchemes",Schemes);
		response.sendRedirect("./Admin/UpdateScheme.jsp");
	}

	/**
	 * @param CategoryName 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
//		out.print("hiiiiii byyyyyy");
		
		String btn = request.getParameter("btn");
		if(btn.equals("insert"))
		{

		
		String SchemeName,SchemeId;
		
		SchemeName = request.getParameter("SchemeName");
		
		
		
		//genrate courseId 
		
       SchemeDao dao = new  SchemeDao();
		SchemeId = dao.auto_sid();
		
		
		
		
		Scheme scheme= new Scheme(SchemeName, SchemeId);
		

		int result = dao.SchemeInsert(scheme);
		
		if(result == 1)
		{
			System.out.println("Scheme inserted successfully");
			doGet (request,response);
		}
		else
		{
			System.out.println("scheme insertion Failed");
		}
		
		
		}
		else if (btn.equalsIgnoreCase("update"))
		{
//System.out.println("hello update");
			
		
	String SchemeName ,SchemeId ;
			
			
	SchemeName= request.getParameter("schemeName");
			
			 SchemeId  = request.getParameter("schemeId");
			 System.out.println("obj name "+SchemeId);
			 
			 Scheme Sch=new Scheme(SchemeName, SchemeId);
			 SchemeDao dao=new SchemeDao();
			 System.out.println("UP OBJ="+Sch);
			 
			 int result=dao.updatecategory(Sch);
			 if (result==1) {
				 System.out.println("Scheme updated");
				 doGet(request, response);
			 }
			 else {
			System.out.println("Scheme not updated"); 
	}
			
	
	}
	else if(btn.equalsIgnoreCase("delete"))
	{
//		System.out.println("hello delete");
		String SchemeId=request.getParameter("schemeId");
		 SchemeDao dao=new SchemeDao();
//		 System.out.println("id="+SchemeId);
		int result=dao.deleteScheme(SchemeId);
		
		if (result==1)
		{
			System.out.println("Scheme delete successfully");
			doGet(request, response);
		}
		else
		{
			System.out.println("Scheme not deleted");
		}
		
	}
		}

	
}
//		doGet(request, response);
	


