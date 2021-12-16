package kr.co.ta9.pandora3.linkruit.dto;

import kr.co.ta9.pandora3.app.bean.CommonBean;

public class BaseCareerDto extends CommonBean {

	
	private int careerregisterno;
	private int applicantno;
	private String careername;
	private String careercontract;
	private String careerpart;
	private String careerrole;
	private String careerstartdate;
	private String careerenddate;
	private String careercontent;
	public int getCareerregisterno() {
		return careerregisterno;
	}
	public void setCareerregisterno(int careerregisterno) {
		this.careerregisterno = careerregisterno;
	}
	public int getApplicantno() {
		return applicantno;
	}
	public void setApplicantno(int applicantno) {
		this.applicantno = applicantno;
	}
	public String getCareername() {
		return careername;
	}
	public void setCareername(String careername) {
		this.careername = careername;
	}
	public String getCareercontract() {
		return careercontract;
	}
	public void setCareercontract(String careercontract) {
		this.careercontract = careercontract;
	}
	public String getCareerpart() {
		return careerpart;
	}
	public void setCareerpart(String careerpart) {
		this.careerpart = careerpart;
	}
	public String getCareerrole() {
		return careerrole;
	}
	public void setCareerrole(String careerrole) {
		this.careerrole = careerrole;
	}
	public String getCareerstartdate() {
		return careerstartdate;
	}
	public void setCareerstartdate(String careerstartdate) {
		this.careerstartdate = careerstartdate;
	}
	public String getCareerenddate() {
		return careerenddate;
	}
	public void setCareerenddate(String careerenddate) {
		this.careerenddate = careerenddate;
	}
	public String getCareercontent() {
		return careercontent;
	}
	public void setCareercontent(String careercontent) {
		this.careercontent = careercontent;
	}
	public BaseCareerDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public BaseCareerDto(int careerregisterno, int applicantno, String careername, String careercontract,
			String careerpart, String careerrole, String careerstartdate, String careerenddate, String careercontent) {
		super();
		this.careerregisterno = careerregisterno;
		this.applicantno = applicantno;
		this.careername = careername;
		this.careercontract = careercontract;
		this.careerpart = careerpart;
		this.careerrole = careerrole;
		this.careerstartdate = careerstartdate;
		this.careerenddate = careerenddate;
		this.careercontent = careercontent;
	}
	
	
	
}
