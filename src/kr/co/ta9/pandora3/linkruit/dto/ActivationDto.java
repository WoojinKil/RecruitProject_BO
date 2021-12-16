package kr.co.ta9.pandora3.linkruit.dto;

public class ActivationDto extends BaseActivationDto{

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
	public ActivationDto(int activationregisterno, int applicantno, String activationname, String activationkind,
			String activationcontent, String activationrole, String activationstartdate, String activationenddate,
			String activationorgan, String membername, String applicantid) {
		super(activationregisterno, applicantno, activationname, activationkind, activationcontent, activationrole,
				activationstartdate, activationenddate, activationorgan);
		this.membername = membername;
		this.applicantid = applicantid;
	}
	public ActivationDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ActivationDto(int activationregisterno, int applicantno, String activationname, String activationkind,
			String activationcontent, String activationrole, String activationstartdate, String activationenddate,
			String activationorgan) {
		super(activationregisterno, applicantno, activationname, activationkind, activationcontent, activationrole,
				activationstartdate, activationenddate, activationorgan);
		// TODO Auto-generated constructor stub
	}
	
	
}
