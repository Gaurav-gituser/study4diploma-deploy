package Model;

public class Contact {

	String contactId,name,email,comment,status;
	
	public String getContactId() {
		return contactId;
	}

	public void setContactId(String contactId) {
		this.contactId = contactId;
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

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}
	
	public String getStatus() {
	    return status;
	}

	public void setStatus(String status) {
	    this.status = status;
	}

	public Contact() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Contact(String contactId, String name, String email, String comment) {
		super();
		this.contactId = contactId;
		this.name = name;
		this.email = email;
		this.comment = comment;
	}

	@Override
	public String toString() {
		return "Contact [contactId=" + contactId + ", name=" + name + ", email=" + email + ", comment=" + comment + "]";
	}
	
	
}
