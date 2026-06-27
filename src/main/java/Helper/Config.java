package Helper;

import java.sql.Connection;
import java.sql.DriverManager;

public class Config {

	private  Connection con;
	
	public  Connection getConnection() {
		try
		{
			if(con == null)
{
    Class.forName("com.mysql.cj.jdbc.Driver");

    String url  = System.getenv("DB_URL");
    String user = System.getenv("DB_USER");
    String pass = System.getenv("DB_PASSWORD");

    con = DriverManager.getConnection(url, user, pass);
}
			else
				con=con;
			
		}
		catch (Exception e) {
			System.out.println("exp="+e);
		}
		return con;
	}
}