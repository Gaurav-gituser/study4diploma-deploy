package Dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import Helper.Config;
import Model.Material;

public class MaterialDao {

	Connection con= null;
	Config fig = new Config();
	
	public String auto_Mid() 
	{
		
		String mid="mid_100";
		PreparedStatement ps = null;
		con = fig.getConnection();
		ResultSet rs=null;
		try 
		    {
				ps = con.prepareStatement("select material_id from study4diploma.material order by material_id",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
				rs = ps.executeQuery();
				System.out.println(rs.last());
				
				if (rs.last()) 
					{
						mid = rs.getString(1);
			      	}
				
				String vid[]= mid.split("_");
				int vcid = Integer.parseInt(vid[1]);
				vcid = vcid+1;
				mid = "mid_"+vcid;		
	     	}
		
		catch (Exception e) 
		{
			
			System.out.println("Exp="+e);
			
		}
		
		return mid;
		
	 }
	
	
	public int insertMaterial(Material material) {
	    int result = 0;
	    PreparedStatement ps = null;
	    con = fig.getConnection();

	    String newMaterialId = auto_Mid(); // Generate new material ID
	    System.out.println("materisl="+material);
	    try {
	        String sql = "INSERT INTO study4diploma.material  VALUES (?, ?, ?,?,?,?,?,?,?,?,?)";
	        ps = con.prepareStatement(sql);
	        ps.setString(1, material.getMaterialId());
	        ps.setString(2, material.getTitle());
	        
	        ps.setString(3, material.getDescription());
	        ps.setString(4, material.getPdf());
	        ps.setString(5, material.getUpload_date());
	        ps.setString(6, material.getCategoryId());
	        ps.setString(7, material.getSubjectId());
	        ps.setString(8, material.getAcadmicYear());
	        ps.setString(9, material.getSchemeId());
	        ps.setString(10, material.getSemesterId().trim());
	        ps.setString(11, material.getBranchId());
	       

	        result = ps.executeUpdate();  // returns number of rows affected
	        System.out.println("Rows inserted: " + result + ", Material ID: " + newMaterialId);
	    }
	    catch (Exception e) {
	        System.out.println("Exception in insertMaterial: " + e);
	    } 
	    
	    return result;
	}

	
	public ArrayList<Material> getAllMaterials() {
	    ArrayList<Material> materialList = new ArrayList<>();
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	    con = fig.getConnection();

	    try {
	        String sql = "SELECT * FROM study4diploma.material";
	        ps = con.prepareStatement(sql);
	        rs = ps.executeQuery();

	        while (rs.next()) {
	            Material material = new Material();
	            material.setMaterialId(rs.getString(1));
	            material.setTitle(rs.getString(2));
	            material.setDescription(rs.getString(3));
	            material.setPdf(rs.getString(4));
	            material.setUpload_date(rs.getString(5));
	            material.setCategoryId(rs.getString(6));
	            material.setSubjectId(rs.getString(7));
	            material.setAcadmicYear(rs.getString(8));
	            material.setSchemeId(rs.getString(9));
	            material.setSemesterId(rs.getString(10));
	            material.setBranchId(rs.getString(11));

	            materialList.add(material);
	        }
	    } catch (Exception e) {
	        System.out.println("Exception in getAllMaterials: " + e);
	    } 

	    return materialList;
	}
	
	public ArrayList<Material> getMaterials(String schemeId, String branchId, String semesterId, String academicYearId, String categoryId) {
	    ArrayList<Material> materialList = new ArrayList<>();
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	    con = fig.getConnection();

	    try {
	        String sql = "SELECT * FROM study4diploma.material " +
	                     "WHERE category_id = ? AND acadamic_year = ? " +
	                     "AND schemes_id = ? AND semester_id = ? AND branche_id = ?";

	        ps = con.prepareStatement(sql);
	        ps.setString(1, categoryId);
	        ps.setString(2, academicYearId);
	        ps.setString(3, schemeId);
	        ps.setString(4, semesterId);
	        ps.setString(5, branchId);

	        rs = ps.executeQuery();

	        while (rs.next()) {
	            Material material = new Material();
	            material.setMaterialId(rs.getString(1));
	            material.setTitle(rs.getString(2));
	            material.setDescription(rs.getString(3));
	            material.setPdf(rs.getString(4));
	            material.setUpload_date(rs.getString(5));
	            material.setCategoryId(rs.getString(6));
	            material.setSubjectId(rs.getString(7));
	            material.setAcadmicYear(rs.getString(8));
	            material.setSchemeId(rs.getString(9));
	            material.setSemesterId(rs.getString(10));
	            material.setBranchId(rs.getString(11));

	            materialList.add(material);
	            System.out.println("show mat="+material);
	        }
	    } catch (Exception e) {
	        System.out.println("Exception in getMaterials: " + e);
	    }

	    return materialList;
	}

	

	public int updateMaterial(Material material) {
	    int result = 0;
	    PreparedStatement ps = null;
	    con = fig.getConnection(); // assuming `fig` is your DB utility object

	    try {
	        String sql = "UPDATE study4diploma.material SET " +
	                     "titel = ?, " +
	                     "description = ?, " +
	                     "file_path = ?, " +
	                     "upload_date = ?, " +
	                     "category_id = ?, " +
	                     "subject_id = ?, " +
	                     "acadamic_year = ?, " +
	                     "schemes_id = ?, " +
	                     "semester_id = ?, " +
	                     "branche_id = ? " +
	                     "WHERE material_id = ?";

	        ps = con.prepareStatement(sql);
	        ps.setString(1, material.getTitle());
	        ps.setString(2, material.getDescription());
	        ps.setString(3, material.getPdf());
	        ps.setString(4, material.getUpload_date());
	        ps.setString(5, material.getCategoryId());
	        ps.setString(6, material.getSubjectId());
	        ps.setString(7, material.getAcadmicYear());
	       
	        ps.setString(8, material.getSchemeId()); // WHERE condition
	        ps.setString(9, material.getSemesterId()); // WHERE condition
	        ps.setString(10, material.getBranchId()); // WHERE condition
	        ps.setString(11, material.getMaterialId());
	        System.out.println("material="+material);

	        result = ps.executeUpdate();  // number of rows affected
	        System.out.println("Rows updated: " + result + ", Material ID: " + material.getMaterialId());
	    } catch (Exception e) {
	        System.out.println("Exception in updateMaterial: " + e);
	    }

	    return result;
	}
	
	public int deleteMaterial(String materialId) {
	    int result = 0;
	    PreparedStatement ps = null;
	    con = fig.getConnection(); // Assumes fig is your DB connection utility

	    try {
	        String sql = "DELETE FROM study4diploma.material WHERE material_id = ?";
	        ps = con.prepareStatement(sql);
	        ps.setString(1, materialId);

	        result = ps.executeUpdate(); // Returns number of rows affected
	        System.out.println("Rows deleted: " + result + ", Material ID: " + materialId);
	    } catch (Exception e) {
	        System.out.println("Exception in deleteMaterial: " + e);
	    }

	    return result;
	}

	
	public int noOfUploaded() {
	    int count = 0;
	    PreparedStatement ps = null;
	    ResultSet rs = null;

	    try {
	        con = fig.getConnection();
	        ps = con.prepareStatement("SELECT COUNT(*) FROM study4diploma.material");
	        rs = ps.executeQuery();

	        if (rs.next()) {
	            count = rs.getInt(1); // total number of rows in the table
	        }

	    } catch (Exception e) {
	        System.out.println("Exception in noOfUploaded: " + e);
	    }

	    return count;
	}

}


