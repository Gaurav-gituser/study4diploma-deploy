package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import Helper.Config;
import Model.semester;

public class SemesterDao {
    Config fig = new Config();

    public String auto_Sid() {
        String sid = "sid_100";
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT semester_id FROM semesters ORDER BY semester_id",
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

    public int semesterInsert(semester sem) {
        int result = 0;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("INSERT INTO semesters VALUES (?, ?,?)")) {
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
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT semester_id, number, year_id FROM semesters ORDER BY number");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                semesters.add(new semester(rs.getString(2), rs.getString(1), rs.getString(3)));
            }
        } catch (Exception e) {
            System.out.println("Exception in getAllsemesters: " + e);
        }
        return semesters;
    }

    public int UpdateSemester(semester sem) {
        int result = 0;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE semesters SET number=?, year_id=? WHERE semester_id=?")) {
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
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM semesters WHERE semester_id = ?")) {
            ps.setString(1, semesterId);
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Exception in deleteSemester: " + e);
        }
        return result;
    }

    public semester getSemesterById(String semesterId) {
        semester sem = null;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT semester_id, number, year_id FROM semesters WHERE semester_id = ?")) {
            ps.setString(1, semesterId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                sem = new semester();
                sem.setSemesterId(rs.getString(1));
                sem.setSemester(rs.getString(2));
                sem.setYear(rs.getString(3));
            }
        } catch (Exception e) {
            System.out.println("Exception in getSemesterById: " + e);
        }
        return sem;
    }
}
