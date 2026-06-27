package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import Helper.Config;
import Model.Scheme;

public class SchemeDao {
    Config fig = new Config();

    public String auto_sid() {
        String sid = "sid_100";
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT schemes_id FROM schemes ORDER BY schemes_id",
                ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY)) {
            ResultSet rs = ps.executeQuery();
            if (rs.last()) sid = rs.getString(1);
            String[] vid = sid.split("_");
            sid = "sid_" + (Integer.parseInt(vid[1]) + 1);
        } catch (Exception e) {
            System.out.println("Exp=" + e);
        }
        return sid;
    }

    public int SchemeInsert(Scheme sch) {
        int result = 0;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("INSERT INTO schemes VALUES(?,?)")) {
            ps.setString(1, sch.getSchemeId());
            ps.setString(2, sch.getSchemeName());
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("exp occur during schemes insert=" + e);
        }
        return result;
    }

    public ArrayList<Scheme> getAllScheme() {
        ArrayList<Scheme> schemes = new ArrayList<>();
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT schemes_id, name FROM schemes ORDER BY name");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                schemes.add(new Scheme(rs.getString(2), rs.getString(1)));
            }
        } catch (Exception e) {
            System.out.println("Exception occur during get all schemes");
        }
        return schemes;
    }

    public int updatecategory(Scheme sch) {
        int result = 0;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE schemes SET name=? WHERE schemes_id=?")) {
            ps.setString(1, sch.getSchemeName());
            ps.setString(2, sch.getSchemeId());
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Exp occurs Scheme Update");
        }
        return result;
    }

    public int deleteScheme(String schemeId) {
        int result = 0;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM schemes WHERE schemes_id=?")) {
            ps.setString(1, schemeId);
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("exp occur during scheme delete");
        }
        return result;
    }

    public Scheme getSchemeById(String schemeId) {
        Scheme scheme = null;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT schemes_id, name FROM schemes WHERE schemes_id = ?")) {
            ps.setString(1, schemeId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                scheme = new Scheme();
                scheme.setSchemeId(rs.getString(1));
                scheme.setSchemeName(rs.getString(2));
            }
        } catch (Exception e) {
            System.out.println("Exception in getSchemeById: " + e);
        }
        return scheme;
    }
}
