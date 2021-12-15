package kr.co.ta9.pandora3.linkruit.dto;

public class CertificateDto extends BaseCertificateDto {

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


	

	public CertificateDto(String membername, String applicantid) {
		super();
		this.membername = membername;
		this.applicantid = applicantid;
	}

	public CertificateDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
}
