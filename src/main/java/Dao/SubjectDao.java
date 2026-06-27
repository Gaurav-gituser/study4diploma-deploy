package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import Helper.Config;
import Model.Subject;

public class SubjectDao {
    Config fig = new Config();

    public String auto_Sid() {
        String sid = "sid_100";
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT subject_id FROM subject ORDER BY subject_id",
                ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY)) {
            ResultSet rs = ps.executeQuery();
            if (rs.last()) sid = rs.getString(1);
            String[] vid = sid.split("_");
            sid = "sid_" + (Integer.parseInt(vid[1]) + 1);
        } catch (Exception e) {
            System.out.println("Exception in auto_Sid: " + e);
        }
        return sid;
    }

    public int insertSubject(Subject subject) {
        int result = 0;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("INSERT INTO subject VALUES (?, ?, ?, ?, ?,?)")) {
            ps.setString(1, subject.getSubjectId());
            ps.setString(2, subject.getName());
            ps.setString(3, subject.getCourseCode());
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
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT subject_id, name, course_code, branch_id, scheme_id, semester_id FROM subject ORDER BY name");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                subjects.add(new Subject(rs.getString(1), rs.getString(2), rs.getString(3),
                                         rs.getString(4), rs.getString(5), rs.getString(6)));
            }
        } catch (Exception e) {
            System.out.println("Exception in getAllsubjects: " + e);
        }
        return subjects;
    }

    public int updateSubject(Subject subject) {
        int result = 0;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "UPDATE subject SET name = ?, course_code = ?, branch_id = ?, scheme_id = ?, semester_id = ? WHERE subject_id = ?")) {
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

    // Keep old method name for compatibility
    public int UpdateSubject(Subject subject) {
        return updateSubject(subject);
    }

    public int deleteSubject(String subjectId) {
        int result = 0;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM subject WHERE subject_id = ?")) {
            ps.setString(1, subjectId);
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Exception in deleteSubject: " + e);
        }
        return result;
    }

    public Subject getSubjectById(String subjectId) {
        Subject subject = null;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT subject_id, name, course_code, branch_id, scheme_id, semester_id FROM subject WHERE subject_id = ?")) {
            ps.setString(1, subjectId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                subject = new Subject(rs.getString(1), rs.getString(2), rs.getString(3),
                                      rs.getString(4), rs.getString(5), rs.getString(6));
            }
        } catch (Exception e) {
            System.out.println("Exception in getSubjectById: " + e);
            e.printStackTrace();
        }
        return subject;
    }
}
