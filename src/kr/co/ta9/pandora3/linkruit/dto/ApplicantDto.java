package kr.co.ta9.pandora3.linkruit.dto;

public class ApplicantDto extends BaseApplicantDto {

	
	private String membername;
	private String memberbirth;
	private String memberphonenumber1;
	private String memberphonenumber2;
	private String memberphonenumber3;
	public String getMembername() {
		return membername;
	}
	public void setMembername(String membername) {
		this.membername = membername;
	}
	public String getMemberbirth() {
		return memberbirth;
	}
	public void setMemberbirth(String memberbirth) {
		this.memberbirth = memberbirth;
	}
	public String getMemberphonenumber1() {
		return memberphonenumber1;
	}
	public void setMemberphonenumber1(String memberphonenumber1) {
		this.memberphonenumber1 = memberphonenumber1;
	}
	public String getMemberphonenumber2() {
		return memberphonenumber2;
	}
	public void setMemberphonenumber2(String memberphonenumber2) {
		this.memberphonenumber2 = memberphonenumber2;
	}
	public String getMemberphonenumber3() {
		return memberphonenumber3;
	}
	public void setMemberphonenumber3(String memberphonenumber3) {
		this.memberphonenumber3 = memberphonenumber3;
	}
	public ApplicantDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ApplicantDto(String membername, String memberbirth, String memberphonenumber1, String memberphonenumber2,
			String memberphonenumber3) {
		super();
		this.membername = membername;
		this.memberbirth = memberbirth;
		this.memberphonenumber1 = memberphonenumber1;
		this.memberphonenumber2 = memberphonenumber2;
		this.memberphonenumber3 = memberphonenumber3;
	}
	
	
}
