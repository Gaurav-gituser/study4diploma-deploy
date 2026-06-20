package Model;

import java.sql.PreparedStatement;

public class Scheme {

	
	 String schemeName,schemeId;

	@Override
	public String toString() {
		return "Scheme [schemeName=" + schemeName + ", schemeId=" + schemeId + "]";
	}

	public Scheme() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Scheme(String schemeName, String schemeId) {
		super();
		this.schemeName = schemeName;
		this.schemeId = schemeId;
	}

	public String getSchemeName() {
		return schemeName;
	}

	public void setSchemeName(String schemeName) {
		this.schemeName = schemeName;
	}

	public String getSchemeId() {
		return schemeId;
	}

	public void setSchemeId(String schemeId) {
		this.schemeId = schemeId;
	}

	
	
	
	


	
	
}
