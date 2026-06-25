package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.mysql.cj.PreparedQuery;

import Helper.Config;
import Model.Category;

public class CategoryDao 
{
	
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
				ps = con.prepareStatement("select category_id from categories order by category_id",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
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
	
	public int categoryInsert(Category category)
	{
	   con = fig.getConnection();
	   PreparedStatement ps = null;
	   int result = 0;
	   
	   try {
		  ps = con.prepareStatement("insert into categories values(?,?,?)");
		  ps.setString(1,category.getCategoryId());
		  ps.setString(2,category.getCategoryName());
		  ps.setString(3,category.getDescription());
		  result = ps.executeUpdate();

	  } 
	   catch (Exception e) 
	   {
		  System.out.println("exp occur during course insert="+e);
	   }
	   
	   return result;
	}
	
	public ArrayList<Category> getAllCategorys()
	{
	  con = fig.getConnection()	;
	  PreparedStatement ps = null;
	  ResultSet rs = null;
	  ArrayList<Category> Categorys = new ArrayList<Category>();
	  Category category = null;         
	  
	  
	  try 
		  { 
			  ps = con.prepareStatement("select * from categories");
			  rs = ps.executeQuery();
			  
			  while (rs.next()) 
				  {
					  String categoryId = rs.getString(1);
					  String categoryName = rs.getString(2);
					  String description=rs.getString(3) ;
					category = new Category(categoryId, categoryName, description);
					  Categorys.add(category);  
				  }
			  
			return Categorys;
			  
		   }
	  
	  catch (Exception e) 
		  {
			System.out.println("Exception occur during get all categorys");
		  }
	  
	  return Categorys;
	  
	}
	//for update
	public int updatecategory(Category Cat) {
		con=fig.getConnection();
		PreparedStatement ps=null;
		int result = 0;
		System.out.println("fcastd="+Cat);
		try
		{
			ps=con.prepareStatement("update categories  set  name=?,description=? where category_id=?");
					ps.setString(1, Cat.getCategoryName());
					ps.setString(2, Cat.getDescription());
					ps.setString(3, Cat.getCategoryId());
					
					result = ps.executeUpdate();
		}
		        
		 catch(Exception e)
		 {
		        	System.out.println("Exp occurs Category uodate");
		        }
	
	return result;
}
public int deleteCategory(String CategoryId)
{
	con=fig.getConnection();
	PreparedStatement ps=null;
	ResultSet  rs =null;
	int result=0;
	try
	{
		ps=con.prepareStatement("delete from categories where category_id=?");
		ps.setString(1, CategoryId);
		result=ps.executeUpdate();
		
	} catch (Exception e)
	{ System.out.println("exp occur during category delete");
		// TODO: handle exception
	}
	
	return result;
	
}

public Category getCategoryById(String categoryId) {
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    Category category = null;

    try {
        con = fig.getConnection();
        ps = con.prepareStatement("SELECT * FROM categories WHERE category_id = ?");
        ps.setString(1, categoryId);
        rs = ps.executeQuery();

        if (rs.next()) {
            String id = rs.getString(1);
            String name = rs.getString(2);
            String description = rs.getString(3);
            category = new Category(id, name, description);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return category;
}



}
	


