package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.LinkedHashSet;

import Dao.MaterialDao;
import Dao.SubjectDao;
import Model.Material;
import Model.Subject;

@WebServlet("/SearchHintsController")
public class SearchHintsController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "max-age=300");

        LinkedHashSet<String> hints = new LinkedHashSet<>();

        try {
            SubjectDao subjectDao = new SubjectDao();
            ArrayList<Subject> subjects = subjectDao.getAllsubjects();
            if (subjects != null) {
                for (Subject s : subjects) {
                    if (s.getName() != null && !s.getName().trim().isEmpty()) {
                        hints.add(s.getName().trim());
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("SearchHintsController subject error: " + e);
        }

        try {
            MaterialDao matDao = new MaterialDao();
            ArrayList<Material> mats = matDao.getAllMaterials();
            if (mats != null) {
                for (Material m : mats) {
                    if (m.getTitle() != null && !m.getTitle().trim().isEmpty()) {
                        hints.add(m.getTitle().trim());
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("SearchHintsController material error: " + e);
        }

        // Build JSON array manually — safe escaping for ALL special chars
        StringBuilder json = new StringBuilder("[");
        boolean first = true;
        for (String h : hints) {
            if (!first) json.append(",");
            json.append(jsonString(h));
            first = false;
        }
        json.append("]");

        PrintWriter out = response.getWriter();
        out.print(json.toString());
        out.flush();
    }

    // Properly escape a string for JSON
    private String jsonString(String s) {
        StringBuilder sb = new StringBuilder("\"");
        for (char c : s.toCharArray()) {
            switch (c) {
                case '"':  sb.append("\\\""); break;
                case '\\': sb.append("\\\\"); break;
                case '\n': sb.append("\\n");  break;
                case '\r': sb.append("\\r");  break;
                case '\t': sb.append("\\t");  break;
                default:
                    if (c < 0x20) {
                        sb.append(String.format("\\u%04x", (int) c));
                    } else {
                        sb.append(c);
                    }
            }
        }
        sb.append("\"");
        return sb.toString();
    }
}
