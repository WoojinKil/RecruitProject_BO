package kr.co.ta9.pandora3.linkruit.dto;

import kr.co.ta9.pandora3.app.bean.CommonBean;

public class BaseApplicantDto extends CommonBean{

	private int applicantNo;
	private String applicantId;
	private int recruitNo;
	private int applyNo;
	private String applicantMillitary;
	private String applicantVeteran;
	private String applicantDisability;
	private String applicantJobProtect;
	
	private String applicantHighSchoolName;
 	private int applicantHighSchoolGraduateYear; 
 	private String applicantHighSchoolGraduateState;
	
	
	
	private String applicantAssay1;
	private String applicantAssay2;
	private String applicantAssay3;
	
	private int finalApplyChecked;
	private String applyDate;
	
	public int getApplicantNo() {
		return applicantNo;
	}
	public void setApplicantNo(int applicantNo) {
		this.applicantNo = applicantNo;
	}
	public String getApplicantId() {
		return applicantId;
	}
	public void setApplicantId(String applicantId) {
		this.applicantId = applicantId;
	}
	public int getRecruitNo() {
		return recruitNo;
	}
	public void setRecruitNo(int recruitNo) {
		this.recruitNo = recruitNo;
	}
	public int getApplyNo() {
		return applyNo;
	}
	public void setApplyNo(int applyNo) {
		this.applyNo = applyNo;
	}
	

	public int getFinalApplyChecked() {
		return finalApplyChecked;
	}
	public void setFinalApplyChecked(int finalApplyChecked) {
		this.finalApplyChecked = finalApplyChecked;
	}
	public String getApplyDate() {
		return applyDate;
	}
	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}
	public String getApplicantMillitary() {
		return applicantMillitary;
	}
	public void setApplicantMillitary(String applicantMillitary) {
		this.applicantMillitary = applicantMillitary;
	}
	public String getApplicantVeteran() {
		return applicantVeteran;
	}
	public void setApplicantVeteran(String applicantVeteran) {
		this.applicantVeteran = applicantVeteran;
	}
	public String getApplicantDisability() {
		return applicantDisability;
	}
	public void setApplicantDisability(String applicantDisability) {
		this.applicantDisability = applicantDisability;
	}
	public String getApplicantJobProtect() {
		return applicantJobProtect;
	}
	public void setApplicantJobProtect(String applicantJobProtect) {
		this.applicantJobProtect = applicantJobProtect;
	}
	
	
	
	
	
	public String getApplicantHighSchoolName() {
		return applicantHighSchoolName;
	}
	public void setApplicantHighSchoolName(String applicantHighSchoolName) {
		this.applicantHighSchoolName = applicantHighSchoolName;
	}
	public int getApplicantHighSchoolGraduateYear() {
		return applicantHighSchoolGraduateYear;
	}
	public void setApplicantHighSchoolGraduateYear(int applicantHighSchoolGraduateYear) {
		this.applicantHighSchoolGraduateYear = applicantHighSchoolGraduateYear;
	}
	public String getApplicantHighSchoolGraduateState() {
		return applicantHighSchoolGraduateState;
	}
	public void setApplicantHighSchoolGraduateState(String applicantHighSchoolGraduateState) {
		this.applicantHighSchoolGraduateState = applicantHighSchoolGraduateState;
	}
	public String getApplicantAssay1() {
		return applicantAssay1;
	}
	public void setApplicantAssay1(String applicantAssay1) {
		this.applicantAssay1 = applicantAssay1;
	}
	public String getApplicantAssay2() {
		return applicantAssay2;
	}
	public void setApplicantAssay2(String applicantAssay2) {
		this.applicantAssay2 = applicantAssay2;
	}
	public String getApplicantAssay3() {
		return applicantAssay3;
	}
	public void setApplicantAssay3(String applicantAssay3) {
		this.applicantAssay3 = applicantAssay3;
	}
}
