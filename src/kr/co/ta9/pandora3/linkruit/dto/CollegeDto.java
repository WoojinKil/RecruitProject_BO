package kr.co.ta9.pandora3.linkruit.dto;

public class CollegeDto extends BaseCollegeDto {

	private String membername;
	private String applicantid;
	public String getMembername() {
		return membername;
	}
	public void setMembername(String membername) {
		this.membername = membername;
	}
	public String getApplicantid() {
		return applicantid;
	}
	public void setApplicantid(String applicantid) {
		this.applicantid = applicantid;
	}
	@Override
	public String toString() {
		return "CollegeDto [membername=" + membername + ", applicantid=" + applicantid + "]";
	}
	public CollegeDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CollegeDto(int collegeregisterno, int applicantno, String collegename, String collegelocation,
			String collegeenter, String collegedegree, String collegemajor1, String collegedoublemajorkind,
			String collegemajor2, double collegescore, double collegescoremax, String collegestartdate,
			String collegeenddate, String collegegraduate, String membername, String applicantid) {
		super(collegeregisterno, applicantno, collegename, collegelocation, collegeenter, collegedegree, collegemajor1,
				collegedoublemajorkind, collegemajor2, collegescore, collegescoremax, collegestartdate, collegeenddate,
				collegegraduate);
		this.membername = membername;
		this.applicantid = applicantid;
	}
	
	
	
}
