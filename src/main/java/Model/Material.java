package Model;

public class Material {

	String materialId,title,description,pdf,upload_date,categoryId,subjectId,acadmicYear,schemeId,branchId,semesterId;

	public String getMaterialId() {
		return materialId;
	}

	public void setMaterialId(String materialId) {
		this.materialId = materialId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPdf() {
		return pdf;
	}

	public void setPdf(String pdf) {
		this.pdf = pdf;
	}

	public String getUpload_date() {
		return upload_date;
	}

	public void setUpload_date(String upload_date) {
		this.upload_date = upload_date;
	}

	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	public String getSubjectId() {
		return subjectId;
	}

	public void setSubjectId(String subjectId) {
		this.subjectId = subjectId;
	}

	public String getAcadmicYear() {
		return acadmicYear;
	}

	public void setAcadmicYear(String acadmicYear) {
		this.acadmicYear = acadmicYear;
	}

	public String getSchemeId() {
		return schemeId;
	}

	public void setSchemeId(String schemeId) {
		this.schemeId = schemeId;
	}

	public String getBranchId() {
		return branchId;
	}

	public void setBranchId(String branchId) {
		this.branchId = branchId;
	}

	public String getSemesterId() {
		return semesterId;
	}

	public void setSemesterId(String semesterId) {
		this.semesterId = semesterId;
	}

	public Material() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Material(String materialId, String title, String description, String pdf, String upload_date,
			String categoryId, String subjectId, String acadmicYear, String schemeId, String branchId,
			String semesterId) {
		super();
		this.materialId = materialId;
		this.title = title;
		this.description = description;
		this.pdf = pdf;
		this.upload_date = upload_date;
		this.categoryId = categoryId;
		this.subjectId = subjectId;
		this.acadmicYear = acadmicYear;
		this.schemeId = schemeId;
		this.branchId = branchId;
		this.semesterId = semesterId;
	}

	@Override
	public String toString() {
		return "Material [materialId=" + materialId + ", title=" + title + ", description=" + description + ", pdf="
				+ pdf + ", upload_date=" + upload_date + ", categoryId=" + categoryId + ", subjectId=" + subjectId
				+ ", acadmicYear=" + acadmicYear + ", schemeId=" + schemeId + ", branchId=" + branchId + ", semesterId="
				+ semesterId + "]";
	}

	public Material(String categoryId, String subjectId, String acadmicYear, String schemeId, String branchId,
			String semesterId) {
		super();
		this.categoryId = categoryId;
		this.subjectId = subjectId;
		this.acadmicYear = acadmicYear;
		this.schemeId = schemeId;
		this.branchId = branchId;
		this.semesterId = semesterId;
	}

	
	
}
