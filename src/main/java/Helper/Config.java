package Helper;

import java.sql.Connection;
import java.sql.DriverManager;

public class Config {

	public Connection getConnection() {
		Connection con = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");

			String url  = System.getenv("DB_URL");
			String user = System.getenv("DB_USER");
			String pass = System.getenv("DB_PASSWORD");

			con = DriverManager.getConnection(url, user, pass);
		}
		catch (Exception e) {
			System.out.println("DB Connection error: " + e);
			e.printStackTrace();
		}
		return con;
	}
}
