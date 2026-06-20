package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import Helper.Config;
import Model.Subject;


public class SubjectDao {

	 Connection con = null;
	    Config fig = new Config();
		private String subject;
		private ArrayList<Subject> subjects;
		 

	    public String auto_Sid() {
	        String sid = "sid_100";
	        try {
	            con = fig.getConnection();
	            PreparedStatement ps = con.prepareStatement("SELECT subject_id FROM study4diploma.subject ORDER BY subject_id", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
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
	    
	    
	    public int insertSubject(Subject subject) {
	        int result = 0;

	        try {
	            con = fig.getConnection();
	            String sql = "INSERT INTO subject  VALUES (?, ?, ?, ?, ?,?)";
	            PreparedStatement ps = con.prepareStatement(sql);
	            ps.setString(1, subject.getSubjectId());
	            ps.setString(2, subject.getName());
	            ps.setString(3,subject.getCourseCode());
	            ps.setString(4, subject.getBranchId());
	            ps.setString(5, subject.getSchemeId());
	            ps.setString(6, subject.getSemesterId());

	            result = ps.executeUpdate();
	        } catch (Exception e) {
	            System.out.println("Exception in insertSubject: " + e);
	        }

	        return result;
	    }
	    public ArrayList<Subject> getAllsubjects() {
	        ArrayList<Subject> subjects = new ArrayList<>();
	        try {
	            con = fig.getConnection();
	            PreparedStatement ps = con.prepareStatement("SELECT * FROM study4diploma.subject");
	            ResultSet rs = ps.executeQuery();
	            while (rs.next()) {
	            	   
	            	   String subjectId = rs.getString(1);
	            	   String Name = rs.getString(2);
	            	   String courseCode = rs.getString(3);
	            	   String BranchId = rs.getString(4);
	            	   String SchemeId = rs.getString(5);
	            	   String SemesterId = rs.getString(6);
	            	  
	                subjects.add(new Subject(subjectId, Name, courseCode, BranchId, SchemeId, SemesterId));
	            }
	        } catch (Exception e) {
	            System.out.println("Exception in getAllsubjects: " + e);
	        }
	      	
			return subjects;
	    }

	    public int UpdateSubject(Subject subject) {
	   
			int result = 0;
	        try {
	            con = fig.getConnection();
	            PreparedStatement ps = con.prepareStatement("UPDATE study4diploma.subject SET number =?, year_id=? WHERE subject_id=?");
	            ps.setString(1, subject.getSubjectId());
	            ps.setString(2, subject.getName());
	            ps.setString(3, subject.getBranchId());
	            ps.setString(4, subject.getSchemeId());
	            ps.setString(5, subject.getSemesterId());
	            result = ps.executeUpdate();
	        } catch (Exception e) {
	            System.out.println("Exception in UpdateSubject: " + e);
	        }
	        return result;
	    }
	    
	    
	    public int updateSubject(Subject subject) {
	        int result = 0;
	        try {
	            con = fig.getConnection();
	            PreparedStatement ps = con.prepareStatement(
	                "UPDATE subject SET name = ?, course_code = ?, branch_id = ?, scheme_id = ?, semester_id = ? WHERE subject_id = ?"
	            );

	            ps.setString(1, subject.getName());
	            ps.setString(2, subject.getCourseCode());
	            ps.setString(3, subject.getBranchId());
	            ps.setString(4, subject.getSchemeId());
	            ps.setString(5, subject.getSemesterId());
	            ps.setString(6, subject.getSubjectId());

	            result = ps.executeUpdate();

	        } catch (Exception e) {
	            System.out.println("Exception in updateSubject: " + e);
	        }
	        return result;
	    }

	    

	    public int deleteSubject(String subjectId) {
	        int result = 0;
	        try {
	            con = fig.getConnection();
	            PreparedStatement ps = con.prepareStatement("DELETE FROM study4diploma.subject WHERE subject_id = ?");
	            ps.setString(1, subjectId);
	            result = ps.executeUpdate();
	        } catch (Exception e) {
	            System.out.println("Exception in deleteSubject: " + e);
	        }
	        return result;
	    }
	    
	    public Subject getSubjectById(String subjectId) {
	        Subject subject = null;
	        Connection con = null;
	        PreparedStatement ps = null;
	        ResultSet rs = null;

	        try {
	            con = fig.getConnection();
	            ps = con.prepareStatement("SELECT * FROM study4diploma.subject WHERE subject_id = ?");
	            ps.setString(1, subjectId);
	            rs = ps.executeQuery();

	            if (rs.next()) {
	                String id = rs.getString(1);
	                String name = rs.getString(2);
	                String courseCode = rs.getString(3);
	                String branchId = rs.getString(4);
	                String schemeId = rs.getString(5);
	                String semesterId = rs.getString(6);

	                subject = new Subject(id, name, courseCode, branchId, schemeId, semesterId);
	            }
	        } catch (Exception e) {
	            System.out.println("Exception in getSubjectById: " + e);
	            e.printStackTrace();
	        } 

	        return subject;
	    }



		}

		



		