
package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.mysql.cj.PreparedQuery;

import Helper.Config;
import Model.Category;
import Model.Scheme;

public class SchemeDao 
{
	
	Connection con= null;
	Config fig = new Config();
	
	public String auto_sid() 
	{
		
		String sid="sid_100";
		PreparedStatement ps = null;
		con = fig.getConnection();
		ResultSet rs=null;
		try 
		    {
				ps = con.prepareStatement("select schemes_id from schemes order by schemes_id",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
				rs = ps.executeQuery();
				System.out.println(rs.last());
				
				if (rs.last()) 
					{
						sid = rs.getString(1);
			      	}
				
				String vid[]= sid.split("_");
				int vsid = Integer.parseInt(vid[1]);
				vsid = vsid+1;
				sid = "sid_"+vsid;		
	     	}
		
		catch (Exception e) 
		{
			
			System.out.println("Exp="+e);
			
		}
		
		return sid;
		
	 }
	
	public int SchemeInsert(Scheme Sch)
	{
	   con = fig.getConnection();
	   PreparedStatement ps = null;
	   int result = 0;
	   
	   try {
		  ps = con.prepareStatement("insert into schemes values(?,?)");
		  ps.setString(1,Sch.getSchemeId());
		  ps.setString(2,Sch.getSchemeName());
		  
		  result = ps.executeUpdate();

	  } 
	   catch (Exception e) 
	   {
		  System.out.println("exp occur during schemes insert="+e);
	   }
	   
	   return result;
	}
	
	public ArrayList<Scheme> getAllScheme()
	{
	  con = fig.getConnection()	;
	  PreparedStatement ps = null;
	  ResultSet rs = null;
	  ArrayList<Scheme> Scheme = new ArrayList<Scheme>();
	  Scheme Sch = null;         
	  
	  
	  try 
		  { 
			  ps = con.prepareStatement("select * from schemes");
			  rs = ps.executeQuery();
			  
			  while (rs.next()) 
				  {
					  String SchemeId = rs.getString(1);
					  String SchemeName = rs.getString(2);
					Sch = new Scheme(SchemeName, SchemeId);
					System.out.println("sch="+Sch);
					Scheme.add(Sch);  
				  }
			  
			return Scheme;
			  
		   }
	  
	  catch (Exception e) 
		  {
			System.out.println("Exception occur during get all schemes");
		  }
	  
	  return Scheme;
	  
	}
	//for update
	public int updatecategory(Scheme sch) {
		con=fig.getConnection();
		PreparedStatement ps=null;
		int result = 0;
		System.out.println("fcastd="+sch);
		try
		{
			ps=con.prepareStatement("update schemes  set  name=? where schemes_id=?");
					
					ps.setString(1, sch.getSchemeName());
					ps.setString(2, sch.getSchemeId());
					
					result = ps.executeUpdate();
		}
		        
		 catch(Exception e)
		 {
		        	System.out.println("Exp occurs Scheme Update");
		        }
	
	return result;
}
public int deleteScheme(String SchemeId )
{
	con=fig.getConnection();
	PreparedStatement ps=null;
	ResultSet rs=null;
	int result=0;
	try
	{
		System.out.println("id="+SchemeId);
		ps=con.prepareStatement("delete from schemes where schemes_id=?");
		ps.setString(1, SchemeId);
		result=ps.executeUpdate();
		
	} catch (Exception e)
	{ System.out.println("exp occur during scheme delete");
		// TODO: handle exception
	}
	
	return result;
	
}


public Scheme getSchemeById(String schemeId) {
    Scheme scheme = null;

    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        con = fig.getConnection();
        ps = con.prepareStatement("SELECT * FROM schemes WHERE schemes_id = ?");
        ps.setString(1, schemeId);
        rs = ps.executeQuery();

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
	


