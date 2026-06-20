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
import Model.Category;



/**
 * Servlet implementation class CategoryController
 */
@WebServlet("/CategoryController")
public class CategoryController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String Decscription = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CategoryController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	
	CategoryDao dao =new CategoryDao();
		ArrayList<Category> categories = dao.getAllCategorys();
		System.out.println("obj"+categories);
//		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		HttpSession session =request.getSession();
		session.setAttribute("allCategorys",categories);
		response.sendRedirect("./Admin/UpdateCategory.jsp");
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

		
		String categoryName,description,courseId;
		
		categoryName = request.getParameter("categoryName");
		description = request.getParameter("description");
		
		
		//genrate courseId 
		
	CategoryDao dao = new CategoryDao();
		courseId = dao.auto_Cid();
		
		
		
		
		Category category = new Category(courseId, categoryName, description);
		
		int result = dao.categoryInsert(category);
		
		if(result == 1)
		{
			System.out.println("course inserted successfully");
			doGet (request,response);
		}
		else
		{
			System.out.println("course insertion Failed");
		}
		
		
		}
		else if (btn.equalsIgnoreCase("update"))
		{
//System.out.println("hello update");
			
		
	String categoryName ,Description,categoryId ;
			
			
	categoryName= request.getParameter("categoryName");
			 Description=request.getParameter("description");
			 categoryId  = request.getParameter("categoryId");
			 System.out.println("obj name "+categoryName+Description);
			 
			 Category cat =new Category(categoryId, categoryName, Description);
			 CategoryDao dao=new CategoryDao();
			 System.out.println("UP OBJ="+cat);
			 
			 int result=dao.updatecategory(cat);
			 if (result==1) {
				 System.out.println("Category updated");
				 doGet(request, response);
			 }
			 else {
			System.out.println("Category not updated"); 
	}
			
	
	}
	else if(btn.equalsIgnoreCase("delete"))
	{
		System.out.println("hello delete");
		String categoryId=request.getParameter("categoryId");
		CategoryDao dao=new CategoryDao();
		int result=dao.deleteCategory(categoryId);
		
		if (result==1)
		{
			System.out.println("category delete successfully");
			doGet(request, response);
		}
		else
		{
			System.out.println("category not deleted");
		}
		
	}
		}	
	
}
//		doGet(request, response);
	


