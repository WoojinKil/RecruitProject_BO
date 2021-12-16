package kr.co.ta9.pandora3.linkruit.dto;

import kr.co.ta9.pandora3.app.bean.CommonBean;

public class BaseActivationDto extends CommonBean {

	private int activationregisterno;
	private int applicantno;
	private String activationname;
	private String activationkind;
	private String activationcontent;
	private String activationrole;
	private String activationstartdate;
	private String activationenddate;
	private String activationorgan;
	public int getActivationregisterno() {
		return activationregisterno;
	}
	public void setActivationregisterno(int activationregisterno) {
		this.activationregisterno = activationregisterno;
	}
	public int getApplicantno() {
		return applicantno;
	}
	public void setApplicantno(int applicantno) {
		this.applicantno = applicantno;
	}
	public String getActivationname() {
		return activationname;
	}
	public void setActivationname(String activationname) {
		this.activationname = activationname;
	}
	public String getActivationkind() {
		return activationkind;
	}
	public void setActivationkind(String activationkind) {
		this.activationkind = activationkind;
	}
	public String getActivationcontent() {
		return activationcontent;
	}
	public void setActivationcontent(String activationcontent) {
		this.activationcontent = activationcontent;
	}
	public String getActivationrole() {
		return activationrole;
	}
	public void setActivationrole(String activationrole) {
		this.activationrole = activationrole;
	}
	public String getActivationstartdate() {
		return activationstartdate;
	}
	public void setActivationstartdate(String activationstartdate) {
		this.activationstartdate = activationstartdate;
	}
	public String getActivationenddate() {
		return activationenddate;
	}
	public void setActivationenddate(String activationenddate) {
		this.activationenddate = activationenddate;
	}
	public String getActivationorgan() {
		return activationorgan;
	}
	public void setActivationorgan(String activationorgan) {
		this.activationorgan = activationorgan;
	}
	public BaseActivationDto(int activationregisterno, int applicantno, String activationname, String activationkind,
			String activationcontent, String activationrole, String activationstartdate, String activationenddate,
			String activationorgan) {
		super();
		this.activationregisterno = activationregisterno;
		this.applicantno = applicantno;
		this.activationname = activationname;
		this.activationkind = activationkind;
		this.activationcontent = activationcontent;
		this.activationrole = activationrole;
		this.activationstartdate = activationstartdate;
		this.activationenddate = activationenddate;
		this.activationorgan = activationorgan;
	}
	public BaseActivationDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
}
