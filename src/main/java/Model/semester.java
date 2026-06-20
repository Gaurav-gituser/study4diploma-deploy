package Model;

public class semester {

	String semester,semesterId,year;

	public String getSemester() {
		return semester;
	}

	public void setSemester(String semester) {
		this.semester = semester;
	}

	public String getSemesterId() {
		return semesterId;
	}

	public void setSemesterId(String semesterId) {
		this.semesterId = semesterId;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public semester(String semester, String semesterId, String year) {
		super();
		this.semester = semester;
		this.semesterId = semesterId;
		this.year = year;
	}

	public semester() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		return "semester [semester=" + semester + ", semesterId=" + semesterId + ", year=" + year + "]";
	}
	
	
}
