package kr.co.ta9.pandora3.linkruit.dto;

public class CareerDto extends BaseCareerDto{
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
	public CareerDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CareerDto(int careerregisterno, int applicantno, String careername, String careercontract, String careerpart,
			String careerrole, String careerstartdate, String careerenddate, String careercontent) {
		super(careerregisterno, applicantno, careername, careercontract, careerpart, careerrole, careerstartdate, careerenddate,
				careercontent);
		// TODO Auto-generated constructor stub
	}
	public CareerDto(String membername, String applicantid) {
		super();
		this.membername = membername;
		this.applicantid = applicantid;
	}
	
	
	

}
