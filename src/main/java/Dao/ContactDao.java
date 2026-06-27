package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import Helper.Config;
import Model.Contact;

public class ContactDao {
    Config fig = new Config();

    public String auto_Cid() {
        String cid = "cid_100";
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT contact_id FROM contact ORDER BY contact_id",
                ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY)) {
            ResultSet rs = ps.executeQuery();
            if (rs.last()) cid = rs.getString(1);
            String[] vid = cid.split("_");
            cid = "cid_" + (Integer.parseInt(vid[1]) + 1);
        } catch (Exception e) {
            System.out.println("Exp=" + e);
        }
        return cid;
    }

    public int saveFeedback(Contact c) {
        int result = 0;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "INSERT INTO contact (contact_id, name, email, message) VALUES (?, ?, ?, ?)")) {
            ps.setString(1, c.getContactId());
            ps.setString(2, c.getName());
            ps.setString(3, c.getEmail());
            ps.setString(4, c.getComment());
            result = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public int noOfContact() {
        int count = 0;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM contact");
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) count = rs.getInt(1);
        } catch (Exception e) {
            System.out.println("Exception in noOfContact: " + e);
        }
        return count;
    }

    public ArrayList<Contact> getAllContacts() {
        ArrayList<Contact> contactList = new ArrayList<>();
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT contact_id, name, email, message, status FROM contact ORDER BY contact_id DESC");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Contact contact = new Contact();
                contact.setContactId(rs.getString("contact_id"));
                contact.setName(rs.getString("name"));
                contact.setEmail(rs.getString("email"));
                contact.setComment(rs.getString("message"));
                contact.setStatus(rs.getString("status"));
                contactList.add(contact);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return contactList;
    }

    public int deleteContact(String contactId) {
        int result = 0;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM contact WHERE contact_id = ?")) {
            ps.setString(1, contactId);
            result = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public int markAsRead(String contactId) {
        int result = 0;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE contact SET status = 'read' WHERE contact_id = ?")) {
            ps.setString(1, contactId);
            result = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
