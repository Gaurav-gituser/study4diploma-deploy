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

import Dao.BrancheDao;
import Dao.CategoryDao;
import Dao.SchemeDao;
import Model.Branche;
import Model.Category;
import Model.Scheme;



/**
 * Servlet implementation class BrancheCantroller
 */
@WebServlet("/BrancheCantroller")
public class BrancheCantrolletr extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String branche;
	private String branche_id;

       
    /**
     * @return 
     * @see HttpServlet#HttpServlet()
     */
    public BrancheCantrolletr() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	
	    BrancheDao dao =new BrancheDao();
		ArrayList<Branche> branches = dao.getAllbranches(); 
		System.out.println("obj"+ branches);

//		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		HttpSession session =request.getSession();
		session.setAttribute("allbranches",branches);
		response.sendRedirect("./Admin/UpdateBranche.jsp");
	}

	/**
	 * @param BrancheName 
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

		
		String branche,branche_id;
		
		branche= request.getParameter("Branche");
		
		
		
       BrancheDao dao = new  BrancheDao();
		branche_id = dao.auto_bid();
		
		
		
		
		Branche branches= new Branche(branche, branche_id);
		

		int result = dao.BrancheInsert(branches);
		
		if(result == 1)
		{
			System.out.println("branche inserted successfully");
			response.sendRedirect("./Admin/UpdateBranche.jsp");
		}
		else
		{
			System.out.println("branche insertion Failed");
		}
		
		
		}
		else if (btn.equalsIgnoreCase("update"))
		{
//System.out.println("hello update");
			
			String branche ,branche_id ;
					
					
			branche= request.getParameter("branche");
					
               branche_id= request.getParameter("branche_id");
					 System.out.println("obj name "+branche_id);
					 
					Branche  branches=new Branche(branche, branche_id);
					 BrancheDao dao=new BrancheDao();
					 System.out.println("UP OBJ="+branches);
					 
					 int result=dao.UpdateBranche(branches);
					 if (result==1) {
						 System.out.println("branche updated");
						 doGet(request, response);
					 }
					 else {
					System.out.println("branche not updated"); 
			}
					
			
			}
			else if(btn.equalsIgnoreCase("delete"))
			{
//				System.out.println("hello delete");
				String branche_id=request.getParameter("branche_id");
				 BrancheDao dao=new BrancheDao();
//				 System.out.println("id="+branche_id);
				int result=dao.deleteBranche(branche_id);
				
				if (result==1)
				{
					System.out.println("branche delete successfully");
					doGet(request, response);
				}
				else
				{
					System.out.println("branche not deleted");
				}
				
			}
				}

			
		}
//				doGet(request, response);
			



			
		
	