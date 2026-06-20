package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import Dao.MaterialDao;
import Helper.FileUpload;
import Model.Material;

/**
 * Servlet implementation class MaterialController
 */
@WebServlet("/MaterialController")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
		maxFileSize = 1024 * 1024 * 10, // 10MB
		maxRequestSize = 1024 * 1024 * 50)
public class MaterialController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MaterialController() {
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
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String btn = request.getParameter("btn");

		if (btn.equalsIgnoreCase("insert")) {

			// Get form data
			String title = request.getParameter("title");
			String description = request.getParameter("description");

			String categoryId = request.getParameter("categoryId");
			String subjectId = request.getParameter("subjectId");
			String academicYear = request.getParameter("academicYear");
			String branchId = request.getParameter("branchId");
            String semesterId = request.getParameter("semesterId");
            String schemeId = request.getParameter("schemeId");
            
			Part filePart = request.getPart("file");

			LocalDateTime now = LocalDateTime.now();

			// Define the desired format
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

			// Convert to string
			String formattedDateTime = now.format(formatter);

			String filename = FileUpload.Image_upload(filePart,request.getServletContext().getRealPath("/MaterialPdf"));

			MaterialDao dao = new MaterialDao();
			String mid = dao.auto_Mid();

			Material material = new Material(mid, title, description, filename, formattedDateTime, categoryId, subjectId, academicYear, schemeId, branchId, semesterId);
//			System.out.println("material=" + material);

			int result = dao.insertMaterial(material);

			if (result == 1) {
				System.out.println("material insert succcess");
				response.sendRedirect("./Admin/UpdateMaterial.jsp");
			} else {
				System.out.println("material insert failed");
			}

		}

		if (btn.equalsIgnoreCase("Update")) {
			String materialId = request.getParameter("materialId");
			String title = request.getParameter("title");
			String description = request.getParameter("description");
			String currentPdf = request.getParameter("currentPdf");
			String uploadDate = request.getParameter("upload_date");

			String categoryId = request.getParameter("categoryId");
			String subjectId = request.getParameter("subjectId");
			String academicYear = request.getParameter("acadmicYear");
			
			String branchId = request.getParameter("branchId");
            String semesterId = request.getParameter("semesterId");
            String schemeId = request.getParameter("schemeId");

			// Handle PDF upload
			Part filePart = request.getPart("pdfFile");
			String fileName = FileUpload.Image_upload(filePart,request.getServletContext().getRealPath("/MaterialPdf"));

			Material material = new Material(materialId, title, description, fileName, uploadDate, categoryId, subjectId, academicYear, schemeId, branchId, semesterId);
			System.out.println("material=" + material);
			
			MaterialDao dao = new MaterialDao();
			int result = dao.updateMaterial(material);
			
			if(result == 1)
			{
				System.out.println("update success");
				response.sendRedirect("./Admin/UpdateMaterial.jsp");
			}
			else
			{
				System.out.println("update failed");
			}
			

		}
		else if(btn.equalsIgnoreCase("Delete"))
		{
			String mid = request.getParameter("materialId");
			
			MaterialDao dao = new MaterialDao();
			int result = dao.deleteMaterial(mid);
			if(result == 1)
			{
				System.out.println("material delete success");
				response.sendRedirect("./Admin/UpdateMaterial.jsp");
			}
			else
			{
				System.out.println("material delete failed");
			}
		}
			

	}
}
