package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import Helper.Config;
import Helper.PasswordHelper;
import Model.User;

public class UserDao {
    Config fig = new Config();

    public String auto_uid() {
        String uid = "uid_100";
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT user_id FROM users ORDER BY user_id",
                ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY)) {
            ResultSet rs = ps.executeQuery();
            if (rs.last()) uid = rs.getString(1);
            String[] vid = uid.split("_");
            uid = "uid_" + (Integer.parseInt(vid[1]) + 1);
        } catch (Exception e) {
            System.out.println("Exception in auto_uid: " + e);
        }
        return uid;
    }

    public int UserInsert(User user) {
        int result = 0;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "INSERT INTO users (user_id, name, email, phone, password, created_at, role_id) VALUES (?,?,?,?,?,?,?)")) {
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

    public User login(String email, String password) {
        User user = null;
        try (Connection con = fig.getConnection();
             PreparedStatement stmt = con.prepareStatement(
                "SELECT user_id, name, email, phone, password, created_at, role_id FROM users WHERE email = ? OR phone = ?")) {
            stmt.setString(1, email);
            stmt.setString(2, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String storedPassword = rs.getString("password");
                if (PasswordHelper.verify(password, storedPassword)) {
                    user = new User(rs.getString("user_id"), rs.getString("name"),
                                    rs.getString("email"), rs.getString("phone"),
                                    storedPassword, rs.getString("role_id"), rs.getString("created_at"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public int updateUser(String userId, String name, String email, String phone) {
        int res = 0;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "UPDATE users SET name = ?, email = ?, phone = ? WHERE user_id = ?")) {
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, userId);
            res = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return res;
    }

    public int totalNoOfUsers() {
        int count = 0;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM users");
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) count = rs.getInt(1);
        } catch (Exception e) {
            System.out.println("Exception in totalNoOfUsers: " + e);
        }
        return count;
    }

    public ArrayList<User> getAllUsers() {
        ArrayList<User> users = new ArrayList<>();
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT user_id, name, email, phone, password, created_at, role_id FROM users ORDER BY created_at DESC");
             ResultSet rs = ps.executeQuery()) {
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
        int isUpdated = 0;
        try (Connection con = fig.getConnection();
             PreparedStatement stmt = con.prepareStatement("UPDATE users SET password = ? WHERE email = ?")) {
            stmt.setString(1, newPassword);
            stmt.setString(2, email);
            isUpdated = stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isUpdated;
    }

    public int deleteUser(String userId) {
        int result = 0;
        try (Connection con = fig.getConnection();
             PreparedStatement stmt = con.prepareStatement("DELETE FROM users WHERE user_id = ?")) {
            stmt.setString(1, userId);
            result = stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
