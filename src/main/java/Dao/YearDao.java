package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import Helper.Config;
import Model.Year;

public class YearDao {
    Config fig = new Config();

    public String auto_yid() {
        String yid = "yid_100";
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT year_id FROM year ORDER BY year_id",
                ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY)) {
            ResultSet rs = ps.executeQuery();
            if (rs.last()) yid = rs.getString(1);
            String[] vid = yid.split("_");
            yid = "yid_" + (Integer.parseInt(vid[1]) + 1);
        } catch (Exception e) {
            System.out.println("Exception in auto_yid: " + e);
        }
        return yid;
    }

    public int YearInsert(Year yr) {
        int result = 0;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("INSERT INTO year VALUES (?, ?)")) {
            ps.setString(1, yr.getyear_id());
            ps.setString(2, yr.getyear());
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Exception during YearInsert: " + e);
        }
        return result;
    }

    public ArrayList<Year> getAllyears() {
        ArrayList<Year> years = new ArrayList<>();
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT year, year_id FROM year ORDER BY year");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                years.add(new Year(rs.getString(1), rs.getString(2)));
            }
        } catch (Exception e) {
            System.out.println("Exception in getAllyears: " + e);
        }
        return years;
    }

    public int UpdateYear(Year yr) {
        int result = 0;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE year SET year=? WHERE year_id=?")) {
            ps.setString(1, yr.getyear());
            ps.setString(2, yr.getyear_id());
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Exception in UpdateYear: " + e);
        }
        return result;
    }

    public int deleteYear(String year_id) {
        int result = 0;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM year WHERE year_id=?")) {
            ps.setString(1, year_id);
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Exception in deleteYear: " + e);
        }
        return result;
    }

    public Year getYearById(String year_id) {
        Year yr = null;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT year, year_id FROM year WHERE year_id = ?")) {
            ps.setString(1, year_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                yr = new Year();
                yr.setyear(rs.getString(1));
                yr.setyear_id(rs.getString(2));
            }
        } catch (Exception e) {
            System.out.println("Exception in getYearById: " + e);
        }
        return yr;
    }
}
