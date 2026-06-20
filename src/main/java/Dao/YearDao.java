package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


import Helper.Config;
import Model.Year;

public class YearDao {
    Connection con = null;
    Config fig = new Config();

    public String auto_yid() {
        String yid = "yid_100";
        try {
            con = fig.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT year_id FROM study4diploma.year ORDER BY year_id", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ResultSet rs = ps.executeQuery();

            if (rs.last()) {
                yid = rs.getString(1);
            }

            String[] vid = yid.split("_");
            int vyid = Integer.parseInt(vid[1]) + 1;
            yid = "yid_" + vyid;

        } catch (Exception e) {
            System.out.println("Exception in auto_yid: " + e);
        }

        return yid;
    }

    public int YearInsert(Year yr) {
        int result = 0;
        try {
            con = fig.getConnection();
            PreparedStatement ps = con.prepareStatement("INSERT INTO study4diploma.year VALUES (?, ?)");
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
        try {
            con = fig.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM study4diploma.year");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String year = rs.getString(1);
                String year_id = rs.getString(2);
                years.add(new Year(year_id,year));
            }
        } catch (Exception e) {
            System.out.println("Exception in getAllyears: " + e);
        }
        return years;
    }

    public int UpdateYear(Year yr) {
        int result = 0;
        try {
            con = fig.getConnection();
            PreparedStatement ps = con.prepareStatement("UPDATE study4diploma.year SET year=? WHERE year_id=?");
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
        try {
            con = fig.getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM study4diploma.year WHERE year_id=?");
            ps.setString(1, year_id);
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Exception in deleteYear: " + e);
        }
        return result;
    }
    
    public Year getYearById(String year_id) {
        Year yr = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = fig.getConnection();
            String sql = "SELECT * FROM study4diploma.year WHERE year_id = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, year_id);

            rs = ps.executeQuery();

            if (rs.next()) {
                yr = new Year();
                yr.setyear_id(rs.getString(1));
                yr.setyear(rs.getString(2));
            }

        } catch (Exception e) {
            System.out.println("Exception in getYearById: " + e);
       
       
    }
        return yr;

    }
	
}
