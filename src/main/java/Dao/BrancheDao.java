package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import Helper.Config;
import Model.Branche;

public class BrancheDao {
    Config fig = new Config();

    public String auto_bid() {
        String bid = "bid_100";
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT branche_id FROM branches ORDER BY branche_id",
                ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY)) {
            ResultSet rs = ps.executeQuery();
            if (rs.last()) bid = rs.getString(1);
            String[] vid = bid.split("_");
            bid = "bid_" + (Integer.parseInt(vid[1]) + 1);
        } catch (Exception e) {
            System.out.println("Exception in auto_bid: " + e);
        }
        return bid;
    }

    public int BrancheInsert(Branche br) {
        int result = 0;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("INSERT INTO branches VALUES (?, ?)")) {
            ps.setString(1, br.getbranche_id());
            ps.setString(2, br.getbranche());
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Exception during brancheInsert: " + e);
        }
        return result;
    }

    public ArrayList<Branche> getAllbranches() {
        ArrayList<Branche> branches = new ArrayList<>();
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT branche, branche_id FROM branches ORDER BY branche");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                branches.add(new Branche(rs.getString(1), rs.getString(2)));
            }
        } catch (Exception e) {
            System.out.println("Exception in getAllbranches: " + e);
        }
        return branches;
    }

    public int UpdateBranche(Branche b) {
        int result = 0;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE branches SET branche=? WHERE branche_id=?")) {
            ps.setString(1, b.getbranche());
            ps.setString(2, b.getbranche_id());
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Exception in UpdateBranche: " + e);
        }
        return result;
    }

    public int deleteBranche(String branche_id) {
        int result = 0;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM branches WHERE branche_id=?")) {
            ps.setString(1, branche_id);
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Exception in deleteBranche: " + e);
        }
        return result;
    }

    public Branche getBranchById(String branche_id) {
        Branche branch = null;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT branche_id, branche FROM branches WHERE branche_id = ?")) {
            ps.setString(1, branche_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                branch = new Branche();
                branch.setbranche_id(rs.getString("branche_id"));
                branch.setbranche(rs.getString("branche"));
            }
        } catch (Exception e) {
            System.out.println("Exception in getBranchById: " + e);
        }
        return branch;
    }
}
