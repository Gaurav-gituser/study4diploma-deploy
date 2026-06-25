package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import Helper.Config;
import Model.Branche;
import Model.Year;

public class BrancheDao {
    Connection con = null;
    Config fig = new Config();

    public String auto_bid() {
        String bid = "bid_100";
        try {
            con = fig.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT branche_id FROM branches ORDER BY branche_id", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ResultSet rs = ps.executeQuery();

            if (rs.last()) {
                bid = rs.getString(1);
            }

            String[] vid = bid.split("_");
            int vbid = Integer.parseInt(vid[1]) + 1;
            bid = "bid_" + vbid;

        } catch (Exception e) {
            System.out.println("Exception in auto_bid: " + e);
        }

        return bid;
    }

    public int BrancheInsert(Branche br) {
        int result = 0;
        try {
            con = fig.getConnection();
            PreparedStatement ps = con.prepareStatement("INSERT INTO branches VALUES (?, ?)");
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
        try {
            con = fig.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM branches");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String branche = rs.getString(1);
                String branche_id = rs.getString(2);
                branches.add(new Branche(branche_id,branche ));
            }
        } catch (Exception e) {
            System.out.println("Exception in getAllbranches: " + e);
        }
        return branches;
    }

    public int UpdateBranche(Branche branches) {
        int result = 0;
        try {
            con = fig.getConnection();
            PreparedStatement ps = con.prepareStatement("UPDATE branches SET branche=? WHERE branche_id=?");
            ps.setString(1, branches.getbranche ());
            ps.setString(2, branches.getbranche_id());
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Exception in UpdateBranche: " + e);
        }
        return result;
    }

    public int deleteBranche(String branche_id) {
        int result = 0;
        try {
            con = fig.getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM branches WHERE branche_id=?");
            ps.setString(1, branche_id);
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Exception in deletebranche: " + e);
        }
        return result;
    }
    
    
    public Branche getBranchById(String branche_id) {
        Branche branch = null;
        try {
            con = fig.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM branches WHERE branche_id = ?"
            );
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
