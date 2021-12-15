package kr.co.ta9.pandora3.linkruit.dto;

import kr.co.ta9.pandora3.app.bean.CommonBean;

public class BaseApplicantDto extends CommonBean{

	private int applicantno;
	private String applicantid;
	private int recruitno;
	private int applyno;
	private String applicantmillitary;
	private String applicantveteran;
	private String applicantdisability;
	private String applicantjobprotect;
	
	private String applicanthighschoolname;
 	private int applicanthighschoolgraduateyear; 
 	private String applicanthighschoolgraduatestate;
	
	
	
	private String applicantassay1;
	private String applicantassay2;
	private String applicantassay3;
	
	private int finalapplychecked;
	private String applydate;
	
	private String updatedate;

	public int getApplicantno() {
		return applicantno;
	}

	public void setApplicantno(int applicantno) {
		this.applicantno = applicantno;
	}

	public String getApplicantid() {
		return applicantid;
	}

	public void setApplicantid(String applicantid) {
		this.applicantid = applicantid;
	}

	public int getRecruitno() {
		return recruitno;
	}

	public void setRecruitno(int recruitno) {
		this.recruitno = recruitno;
	}

	public int getApplyno() {
		return applyno;
	}

	public void setApplyno(int applyno) {
		this.applyno = applyno;
	}

	public String getApplicantmillitary() {
		return applicantmillitary;
	}

	public void setApplicantmillitary(String applicantmillitary) {
		this.applicantmillitary = applicantmillitary;
	}

	public String getApplicantveteran() {
		return applicantveteran;
	}

	public void setApplicantveteran(String applicantveteran) {
		this.applicantveteran = applicantveteran;
	}

	public String getApplicantdisability() {
		return applicantdisability;
	}

	public void setApplicantdisability(String applicantdisability) {
		this.applicantdisability = applicantdisability;
	}

	public String getApplicantjobprotect() {
		return applicantjobprotect;
	}

	public void setApplicantjobprotect(String applicantjobprotect) {
		this.applicantjobprotect = applicantjobprotect;
	}

	public String getApplicanthighschoolname() {
		return applicanthighschoolname;
	}

	public void setApplicanthighschoolname(String applicanthighschoolname) {
		this.applicanthighschoolname = applicanthighschoolname;
	}

	public int getApplicanthighschoolgraduateyear() {
		return applicanthighschoolgraduateyear;
	}

	public void setApplicanthighschoolgraduateyear(int applicanthighschoolgraduateyear) {
		this.applicanthighschoolgraduateyear = applicanthighschoolgraduateyear;
	}

	public String getApplicanthighschoolgraduatestate() {
		return applicanthighschoolgraduatestate;
	}

	public void setApplicanthighschoolgraduatestate(String applicanthighschoolgraduatestate) {
		this.applicanthighschoolgraduatestate = applicanthighschoolgraduatestate;
	}

	public String getApplicantassay1() {
		return applicantassay1;
	}

	public void setApplicantassay1(String applicantassay1) {
		this.applicantassay1 = applicantassay1;
	}

	public String getApplicantassay2() {
		return applicantassay2;
	}

	public void setApplicantassay2(String applicantassay2) {
		this.applicantassay2 = applicantassay2;
	}

	public String getApplicantassay3() {
		return applicantassay3;
	}

	public void setApplicantassay3(String applicantassay3) {
		this.applicantassay3 = applicantassay3;
	}

	public int getFinalapplychecked() {
		return finalapplychecked;
	}

	public void setFinalapplychecked(int finalapplychecked) {
		this.finalapplychecked = finalapplychecked;
	}

	public String getApplydate() {
		return applydate;
	}

	public void setApplydate(String applydate) {
		this.applydate = applydate;
	}

	public String getUpdatedate() {
		return updatedate;
	}

	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}

	public BaseApplicantDto(int applicantno, String applicantid, int recruitno, int applyno, String applicantmillitary,
			String applicantveteran, String applicantdisability, String applicantjobprotect,
			String applicanthighschoolname, int applicanthighschoolgraduateyear,
			String applicanthighschoolgraduatestate, String applicantassay1, String applicantassay2,
			String applicantassay3, int finalapplychecked, String applydate, String updatedate) {
		super();
		this.applicantno = applicantno;
		this.applicantid = applicantid;
		this.recruitno = recruitno;
		this.applyno = applyno;
		this.applicantmillitary = applicantmillitary;
		this.applicantveteran = applicantveteran;
		this.applicantdisability = applicantdisability;
		this.applicantjobprotect = applicantjobprotect;
		this.applicanthighschoolname = applicanthighschoolname;
		this.applicanthighschoolgraduateyear = applicanthighschoolgraduateyear;
		this.applicanthighschoolgraduatestate = applicanthighschoolgraduatestate;
		this.applicantassay1 = applicantassay1;
		this.applicantassay2 = applicantassay2;
		this.applicantassay3 = applicantassay3;
		this.finalapplychecked = finalapplychecked;
		this.applydate = applydate;
		this.updatedate = updatedate;
	}

	public BaseApplicantDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
	

}
