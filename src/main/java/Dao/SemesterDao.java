package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.apache.catalina.Cluster;

import Helper.Config;
import Model.Year;
import Model.semester;

public class SemesterDao{
    Connection con = null;
    Config fig = new Config();
	private String semester;
	private ArrayList<Model.semester> semesters;

    public String auto_Sid() {
        String sid = "sid_100";
        try {
            con = fig.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT semester_id FROM study4diploma.semesters ORDER BY semester_id", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ResultSet rs = ps.executeQuery();

            if (rs.last()) {
                sid = rs.getString(1);
            }

			
			String vid[]= sid.split("_");
			int vsid = Integer.parseInt(vid[1]);
			vsid = vsid+1;
			sid = "sid_"+vsid;		
     	
 
        } catch (Exception e) {
            System.out.println("Exception in auto_sid: " + e);
        }

        return sid;
    }

    public int semesterInsert(semester sem) {
        int result = 0;
        try {
            con = fig.getConnection();
            PreparedStatement ps = con.prepareStatement("INSERT INTO study4diploma.semesters VALUES (?, ?,?)");
            ps.setString(1, sem.getSemesterId());
            ps.setString(2, sem.getSemester());
            ps.setString(3, sem.getYear());
           
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Exception during semesterInsert: " + e);
        }
        return result;
    }

    public ArrayList<semester> getAllsemesters() {
        ArrayList<semester> semesters = new ArrayList<>();
        try {
            con = fig.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM study4diploma.semesters");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
            	   String sid = rs.getString(1);
                String semester = rs.getString(2);
                String year= rs.getString(3);
             
                semesters.add(new semester(semester, sid, year));
            }
        } catch (Exception e) {
            System.out.println("Exception in getAllsemesters: " + e);
        }
      	
		return semesters;
    }

    public int UpdateSemester(semester sem) {
        int result = 0;
        try {
            con = fig.getConnection();
            PreparedStatement ps = con.prepareStatement("UPDATE study4diploma.semesters SET number =?, year_id=? WHERE semester_id=?");
            ps.setString(1, sem.getSemester());
            ps.setString(2, sem.getYear());
            ps.setString(3, sem.getSemesterId());
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Exception in UpdateSemester: " + e);
        }
        return result;
    }

    public int deleteSemester(String semesterId) {
        int result = 0;
        try {
            con = fig.getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM study4diploma.semesters WHERE semester_id = ?");
            ps.setString(1, semesterId); // Corrected this line
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Exception in deleteSemester: " + e);
        }
        return result;
    }
    
    
    
    public semester getSemesterById(String semesterId) {
        semester sem = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = fig.getConnection();
            ps = con.prepareStatement("SELECT * FROM study4diploma.semesters WHERE semester_id = ?");
            ps.setString(1, semesterId);
            rs = ps.executeQuery();

            if (rs.next()) {
                sem = new semester();
                sem.setSemesterId(rs.getString(1));
                sem.setSemester(rs.getString(2));
                sem.setYear(rs.getString(3)); // Adjust if your column is named differently
            }
        } catch (Exception e) {
            System.out.println("Exception in getSemesterById: " + e);
        }
        

        return sem;
    }



	}

	

