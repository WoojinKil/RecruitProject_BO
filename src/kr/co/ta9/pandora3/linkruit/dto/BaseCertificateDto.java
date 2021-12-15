package kr.co.ta9.pandora3.linkruit.dto;

import kr.co.ta9.pandora3.app.bean.CommonBean;

public class BaseCertificateDto extends CommonBean {


	private int certificateregisterno;
	private int applicantno;
	private String certificatename;
	private String certificatescore;
	private String certificatedate;
	private String certificatecode;
	private String certificateupdate;
	
	public int getCertificateregisterno() {
		return certificateregisterno;
	}
	public void setCertificateregisterno(int certificateregisterno) {
		this.certificateregisterno = certificateregisterno;
	}
	public int getApplicantno() {
		return applicantno;
	}
	public void setApplicantno(int applicantno) {
		this.applicantno = applicantno;
	}
	public String getCertificatename() {
		return certificatename;
	}
	public void setCertificatename(String certificatename) {
		this.certificatename = certificatename;
	}
	public String getCertificatescore() {
		return certificatescore;
	}
	public void setCertificatescore(String certificatescore) {
		this.certificatescore = certificatescore;
	}
	public String getCertificatedate() {
		return certificatedate;
	}
	public void setCertificatedate(String certificatedate) {
		this.certificatedate = certificatedate;
	}
	public String getCertificatecode() {
		return certificatecode;
	}
	public void setCertificatecode(String certificatecode) {
		this.certificatecode = certificatecode;
	}
	public String getCertificateUpdate() {
		return certificateupdate;
	}
	public void setCertificateUpdate(String certificateupdate) {
		this.certificateupdate = certificateupdate;
	}
	
	
	
}
