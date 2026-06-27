package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import Helper.Config;
import Model.Category;

public class CategoryDao {
    Config fig = new Config();

    public String auto_Cid() {
        String cid = "cid_100";
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT category_id FROM categories ORDER BY category_id",
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

    public int categoryInsert(Category category) {
        int result = 0;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("INSERT INTO categories VALUES(?,?,?)")) {
            ps.setString(1, category.getCategoryId());
            ps.setString(2, category.getCategoryName());
            ps.setString(3, category.getDescription());
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("exp occur during course insert=" + e);
        }
        return result;
    }

    public ArrayList<Category> getAllCategorys() {
        ArrayList<Category> categorys = new ArrayList<>();
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT category_id, name, description FROM categories ORDER BY name");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                categorys.add(new Category(rs.getString(1), rs.getString(2), rs.getString(3)));
            }
        } catch (Exception e) {
            System.out.println("Exception occur during get all categorys");
        }
        return categorys;
    }

    public int updatecategory(Category cat) {
        int result = 0;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "UPDATE categories SET name=?, description=? WHERE category_id=?")) {
            ps.setString(1, cat.getCategoryName());
            ps.setString(2, cat.getDescription());
            ps.setString(3, cat.getCategoryId());
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Exp occurs Category update");
        }
        return result;
    }

    public int deleteCategory(String categoryId) {
        int result = 0;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM categories WHERE category_id=?")) {
            ps.setString(1, categoryId);
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("exp occur during category delete");
        }
        return result;
    }

    public Category getCategoryById(String categoryId) {
        Category category = null;
        try (Connection con = fig.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT category_id, name, description FROM categories WHERE category_id = ?")) {
            ps.setString(1, categoryId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                category = new Category(rs.getString(1), rs.getString(2), rs.getString(3));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return category;
    }
}
