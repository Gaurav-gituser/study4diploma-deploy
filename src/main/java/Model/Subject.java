package Model;

public class Subject {

	String subjectId,name,courseCode,branchId,schemeId,semesterId;

	public Subject(String subjectId, String name, String courseCode, String branchId, String schemeId,
			String semesterId) {
		super();
		this.subjectId = subjectId;
		this.name = name;
		this.courseCode = courseCode;
		this.branchId = branchId;
		this.schemeId = schemeId;
		this.semesterId = semesterId;
	}

	public Subject() {
		super();
		// TODO Auto-generated constructor stub
	}

	public String getSubjectId() {
		return subjectId;
	}

	public void setSubjectId(String subjectId) {
		this.subjectId = subjectId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCourseCode() {
		return courseCode;
	}

	public void setCourseCode(String courseCode) {
		this.courseCode = courseCode;
	}

	public String getBranchId() {
		return branchId;
	}

	public void setBranchId(String branchId) {
		this.branchId = branchId;
	}

	public String getSchemeId() {
		return schemeId;
	}

	public void setSchemeId(String schemeId) {
		this.schemeId = schemeId;
	}

	public String getSemesterId() {
		return semesterId;
	}

	public void setSemesterId(String semesterId) {
		this.semesterId = semesterId;
	}

	@Override
	public String toString() {
		return "Subject [subjectId=" + subjectId + ", name=" + name + ", courseCode=" + courseCode + ", branchId="
				+ branchId + ", schemeId=" + schemeId + ", semesterId=" + semesterId + "]";
	}
	
	
	
}
