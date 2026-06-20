package Model;

public class User {
	
String userId,name,email,password,roleId,created_at;

int otp;



public int getOtp() {
	return otp;
}

public void setOtp(int otp) {
	this.otp = otp;
}

public User(String email, int otp) {
	super();
	this.email = email;
	this.otp = otp;
}

public String getUserId() {
	return userId;
}

public void setUserId(String userId) {
	this.userId = userId;
}

public String getName() {
	return name;
}

public void setName(String name) {
	this.name = name;
}

public String getEmail() {
	return email;
}

public void setEmail(String email) {
	this.email = email;
}

public String getPassword() {
	return password;
}

public void setPassword(String password) {
	this.password = password;
}

public String getRoleId() {
	return roleId;
}

public void setRoleId(String roleId) {
	this.roleId = roleId;
}

public String getCreated_at() {
	return created_at;
}

public void setCreated_at(String created_at) {
	this.created_at = created_at;
}

public User() {
	super();
	// TODO Auto-generated constructor stub
}

public User(String userId, String name, String email, String password, String roleId, String created_at) {
	super();
	this.userId = userId;
	this.name = name;
	this.email = email;
	this.password = password;
	this.roleId = roleId;
	this.created_at = created_at;
}

@Override
public String toString() {
	return "User [userId=" + userId + ", name=" + name + ", email=" + email + ", password=" + password + ", roleId="
			+ roleId + ", created_at=" + created_at + "]";
}


}