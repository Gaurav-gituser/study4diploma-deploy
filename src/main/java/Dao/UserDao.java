package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import Helper.PasswordHelper;
import Helper.Config;
import Model.User;
import Model.semester;

public class UserDao {
    Connection con = null;
    Config fig = new Config();
	private String user;
	private ArrayList<Model.User> users;
 

    public String auto_uid() {
        String uid = "uid_100";
      
		try {
            con = fig.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT user_id FROM users ORDER BY user_id", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ResultSet rs = ps.executeQuery();

            if (rs.last()) {
                uid = rs.getString(1);
            }

			
			String vid[]= uid.split("_");
			int vuid = Integer.parseInt(vid[1]);
			vuid = vuid+1;
			uid = "uid_"+vuid;		
     	
 
        } catch (Exception e) {
            System.out.println("Exception in auto_uid: " + e);
        }

        return uid;
    }

    public int UserInsert(User user) {
        int result = 0;
        try {
            con = fig.getConnection();
            PreparedStatement ps = con.prepareStatement("INSERT INTO users (user_id, name, email, phone, password, created_at, role_id) VALUES (?,?,?,?,?,?,?)");
            ps.setString(1, user.getUserId());
            ps.setString(2, user.getName());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getPassword());
            ps.setString(6, user.getCreated_at());
            ps.setString(7, user.getRoleId());

  		  result = ps.executeUpdate();
  		 
           
        } catch (Exception e) {
            System.out.println("Exception during userInsert: " + e);
        }
        return result;
    }

//    public ArrayList<User> getAll() {
//        ArrayList<User> user = new ArrayList<>();
//        try {
//            con = fig.getConnection();
//            PreparedStatement ps = con.prepareStatement("SELECT * FROM users");
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                String user_id = rs.getString(1);
//                String name= rs.getString(2);
//                String email= rs.getString(3);
//                String password= rs.getString(4);
//                String role= rs.getString(5);
//                String created_at= rs.getString(6);
//                String role_id= rs.getString(7);
//                user.add(new User(user, name, email, password,role,created_at,role_id));
//            }
//        } catch (Exception e) {
//            System.out.println("Exception in getAlluser: " + e);
//        }
//      	
//		return user;
//    }
//
//    public int UpdateUser(user user) {
//		int result = 0;
//        try {
//            con = fig.getConnection();
//            PreparedStatement ps = con.prepareStatement("UPDATE users SET user=? WHERE user_id=?");
//            ps.setString(1, user.getuser_id());
//            ps.setString(2, user.getname());
//            ps.setString(3, user.getemail());
//            ps.setString(4, user.getpassword());
//            ps.setString(5, user.getrole());
//            ps.setString(6, user.getcreated_at());
//            ps.setString(7, user.getrole_id());
//            result = ps.executeUpdate();
//        } catch (Exception e) {
//            System.out.println("Exception in Updateuser: " + e);
//        }
//        return result;
//    }
//
//    public int deleteuser(String user_id) {
//        int result = 0;
//        try {
//            con = fig.getConnection();
//            PreparedStatement ps = con.prepareStatement("DELETE FROM users WHERE user_id=?");
//           
//			ps.setString(1, user_id);
//            result = ps.executeUpdate();
//        } catch (Exception e) {
//            System.out.println("Exception in deleteuser: " + e);
//        }
//        return result;
//    }
//    
    
    public User login(String email, String password) {
        User user = null;
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        String sql = "SELECT * FROM users WHERE (email = ? OR phone = ?)";
        try {
            con = fig.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setString(1, email);  // email parameter holds email OR phone value
            stmt.setString(2, email);  // check phone column too
            rs = stmt.executeQuery();

            if (rs.next()) {
                String uid = rs.getString("user_id");
                String name = rs.getString("name");
                String email1 = rs.getString("email");
                String phone1 = rs.getString("phone");
                String password1 = rs.getString("password");
                String createAt = rs.getString("created_at");
                String role = rs.getString("role_id");

                if (PasswordHelper.verify(password, password1)) {
                    user = new User(uid, name, email1, phone1, password1, role, createAt);
                }              
                // Password is not stored in the session for security
            }

        } catch (Exception e) {
            e.printStackTrace();
        } 
        

        return user;
    }
    
  
    public int updateUser(String userId, String name, String email, String phone) {
        int res = 0;
        try  {
            System.out.println(userId + name + email + phone);
            con = fig.getConnection();
            String sql = "UPDATE users SET name = ?, email = ?, phone = ? WHERE user_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, userId);
            res = ps.executeUpdate();
               
            } catch (Exception e) {
                e.printStackTrace();
               System.out.println("update profile during error");
            }
            return res;
    }

        public int totalNoOfUsers() {
            int count = 0;

            try {
                con = fig.getConnection();
                PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM users");
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    count = rs.getInt(1); // Get the count from the first column
                }

            } catch (Exception e) {
                System.out.println("Exception in totalNoOfUsers: " + e);
            }

            return count;
        }

        public ArrayList<User> getAllUsers() {
            ArrayList<User> users = new ArrayList<>();

            try {
                con = fig.getConnection();
                String sql = "SELECT * FROM users";
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getString("user_id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setPassword(rs.getString("password"));
                    user.setCreated_at(rs.getString("created_at"));
                    user.setRoleId(rs.getString("role_id"));

                    users.add(user);
                }

            } catch (Exception e) {
                System.out.println("Exception during getAllUsers: " + e);
            }

            return users;
        }
      
        public int updatePassword(String email, String newPassword) {
            Connection con = null;
            PreparedStatement stmt = null;
          int isUpdated = 0;

            String sql = "UPDATE users SET password = ? WHERE email = ?";

            try {
                con = fig.getConnection();
                stmt = con.prepareStatement(sql);
                stmt.setString(1, newPassword);
                stmt.setString(2, email);

                 isUpdated = stmt.executeUpdate();
                

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // Optionally close resources here
            }

            return isUpdated;
        }
        
        public int deleteUser(String userId) {
            int result = 0;
            try {
                Connection con = fig.getConnection();
                String sql = "DELETE FROM users WHERE user_id = ?";
                PreparedStatement stmt = con.prepareStatement(sql);
                stmt.setString(1, userId);
                result = stmt.executeUpdate();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            return result;
        }

        
}
