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

import Dao.YearDao;
import Model.Year;

@WebServlet("/YearController")
public class YearCantrolletr extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public YearCantrolletr() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        YearDao dao = new YearDao();
        ArrayList<Year> years = dao.getAllyears();
        HttpSession session = request.getSession();
        session.setAttribute("allYears", years);
        response.sendRedirect("./Admin/UpdateYear.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String btn = request.getParameter("btn");
        String year = request.getParameter("year"); // Note: fixed the capital "Y"
        String year_id = request.getParameter("year_id");

        YearDao dao = new YearDao();

        if (btn.equalsIgnoreCase("insert")) {
            year_id = dao.auto_yid();
            Year yr = new Year(year, year_id);
            int result = dao.YearInsert(yr);
            if (result == 1) {
                System.out.println("Year inserted successfully");
                doGet(request, response);
            } else {
                System.out.println("Year insertion failed");
            }
        } else if (btn.equalsIgnoreCase("update")) {
            Year yr = new Year(year, year_id);
            int result = dao.UpdateYear(yr);
            System.out.println("yr="+yr);
            if (result == 1) {
                System.out.println("Year updated successfully");
                doGet(request, response);
            } else {
                System.out.println("Year update failed");
            }
        } else if (btn.equalsIgnoreCase("delete")) {
            int result = dao.deleteYear(year_id);
            if (result == 1) {
                System.out.println("Year deleted successfully");
                doGet(request, response);
            } else {
                System.out.println("Year deletion failed");
            }
        }
    }
}          
