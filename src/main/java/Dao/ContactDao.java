package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import Helper.Config;
import Model.Contact;

public class ContactDao {

	Connection con= null;
	Config fig = new Config();
	
	public String auto_Cid() 
	{
		
		String cid="cid_100";
		PreparedStatement ps = null;
		con = fig.getConnection();
		ResultSet rs=null;
		try 
		    {
				ps = con.prepareStatement("select contact_id from contact order by contact_id",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
				rs = ps.executeQuery();
				System.out.println(rs.last());
				
				if (rs.last()) 
					{
						cid = rs.getString(1);
			      	}
				
				String vid[]= cid.split("_");
				int vcid = Integer.parseInt(vid[1]);
				vcid = vcid+1;
				cid = "cid_"+vcid;		
	     	}
		
		catch (Exception e) 
		{
			
			System.out.println("Exp="+e);
			
		}
		
		return cid;
		
	 }
	
	 public int saveFeedback(Contact c) {
	        int result = 0;
	        String sql = "INSERT INTO contact (contact_id, name, email, message) VALUES (?, ?, ?, ?)";	        PreparedStatement ps =null;
	        con = fig.getConnection();
	        try  {
	        	
	        	ps = con.prepareStatement(sql);
	        	ps.setString(1, c.getContactId());
	            ps.setString(2, c.getName());
	            ps.setString(3, c.getEmail());
	            ps.setString(4, c.getComment());

	             result = ps.executeUpdate();
	          
	        } catch (Exception e) {
	            e.printStackTrace(); // You can also log this
	            System.out.println("exp occure during contact insert="+e);
	        }

	        return result;
	    }
	 
	 public int noOfContact() {
		    int count = 0;
		    PreparedStatement ps = null;
		    ResultSet rs = null;

		    try {
		        con = fig.getConnection();
		        ps = con.prepareStatement("SELECT COUNT(*) FROM contact");
		        rs = ps.executeQuery();

		        if (rs.next()) {
		            count = rs.getInt(1); // Get the count from first column
		        }

		    } catch (Exception e) {
		        System.out.println("Exception in noOfContact: " + e);
		    }

		    return count;
		}
	 
	 public ArrayList<Contact> getAllContacts() {
		    ArrayList<Contact> contactList = new ArrayList<>();

		    String sql = "SELECT * FROM contact";
		    PreparedStatement ps = null;
		    ResultSet rs = null;

		    try {
		        con = fig.getConnection();
		        ps = con.prepareStatement(sql);
		        rs = ps.executeQuery();

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
		        System.out.println("Exception during getAllContacts: " + e);
		    }

		    return contactList;
		}
	 
	 public int deleteContact(String contactId) {
		    int result = 0;
		    try {
		        con = fig.getConnection();
		        PreparedStatement ps = con.prepareStatement("DELETE FROM contact WHERE contact_id = ?");
		        ps.setString(1, contactId);
		        result = ps.executeUpdate();
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return result;
		}

		public int markAsRead(String contactId) {
		    int result = 0;
		    try {
		        con = fig.getConnection();
		        PreparedStatement ps = con.prepareStatement("UPDATE contact SET status = 'read' WHERE contact_id = ?");
		        ps.setString(1, contactId);
		        result = ps.executeUpdate();
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return result;
		}


}
