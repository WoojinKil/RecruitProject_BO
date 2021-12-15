package kr.co.ta9.pandora3.linkruit.dto;

import kr.co.ta9.pandora3.app.bean.CommonBean;

public class BaseCollegeDto extends CommonBean {


	private int collegeregisterno;
	private int applicantno;
	private String collegename;
	private String collegelocation;
	private String collegeenter;
	private String collegedegree;
	private String collegemajor1;
	private String collegedoublemajorkind;
	private String collegemajor2;
	private double collegescore;
	private double collegescoremax;
	private String collegestartdate;
	private String collegeenddate;
	private String collegegraduate;
	public int getCollegeregisterno() {
		return collegeregisterno;
	}
	public void setCollegeregisterno(int collegeregisterno) {
		this.collegeregisterno = collegeregisterno;
	}
	public int getApplicantno() {
		return applicantno;
	}
	public void setApplicantno(int applicantno) {
		this.applicantno = applicantno;
	}
	public String getCollegename() {
		return collegename;
	}
	public void setCollegename(String collegename) {
		this.collegename = collegename;
	}
	public String getCollegelocation() {
		return collegelocation;
	}
	public void setCollegelocation(String collegelocation) {
		this.collegelocation = collegelocation;
	}
	public String getCollegeenter() {
		return collegeenter;
	}
	public void setCollegeenter(String collegeenter) {
		this.collegeenter = collegeenter;
	}
	public String getCollegedegree() {
		return collegedegree;
	}
	public void setCollegedegree(String collegedegree) {
		this.collegedegree = collegedegree;
	}
	public String getCollegemajor1() {
		return collegemajor1;
	}
	public void setCollegemajor1(String collegemajor1) {
		this.collegemajor1 = collegemajor1;
	}
	public String getCollegedoublemajorkind() {
		return collegedoublemajorkind;
	}
	public void setCollegedoublemajorkind(String collegedoublemajorkind) {
		this.collegedoublemajorkind = collegedoublemajorkind;
	}
	public String getCollegemajor2() {
		return collegemajor2;
	}
	public void setCollegemajor2(String collegemajor2) {
		this.collegemajor2 = collegemajor2;
	}
	public double getCollegescore() {
		return collegescore;
	}
	public void setCollegescore(double collegescore) {
		this.collegescore = collegescore;
	}
	public double getCollegescoremax() {
		return collegescoremax;
	}
	public void setCollegescoremax(double collegescoremax) {
		this.collegescoremax = collegescoremax;
	}
	public String getCollegestartdate() {
		return collegestartdate;
	}
	public void setCollegestartdate(String collegestartdate) {
		this.collegestartdate = collegestartdate;
	}
	public String getCollegeenddate() {
		return collegeenddate;
	}
	public void setCollegeenddate(String collegeenddate) {
		this.collegeenddate = collegeenddate;
	}
	public String getCollegegraduate() {
		return collegegraduate;
	}
	public void setCollegegraduate(String collegegraduate) {
		this.collegegraduate = collegegraduate;
	}
	public BaseCollegeDto(int collegeregisterno, int applicantno, String collegename, String collegelocation,
			String collegeenter, String collegedegree, String collegemajor1, String collegedoublemajorkind,
			String collegemajor2, double collegescore, double collegescoremax, String collegestartdate,
			String collegeenddate, String collegegraduate) {
		super();
		this.collegeregisterno = collegeregisterno;
		this.applicantno = applicantno;
		this.collegename = collegename;
		this.collegelocation = collegelocation;
		this.collegeenter = collegeenter;
		this.collegedegree = collegedegree;
		this.collegemajor1 = collegemajor1;
		this.collegedoublemajorkind = collegedoublemajorkind;
		this.collegemajor2 = collegemajor2;
		this.collegescore = collegescore;
		this.collegescoremax = collegescoremax;
		this.collegestartdate = collegestartdate;
		this.collegeenddate = collegeenddate;
		this.collegegraduate = collegegraduate;
	}
	@Override
	public String toString() {
		return "BaseCollegeDto [collegeregisterno=" + collegeregisterno + ", applicantno=" + applicantno
				+ ", collegename=" + collegename + ", collegelocation=" + collegelocation + ", collegeenter="
				+ collegeenter + ", collegedegree=" + collegedegree + ", collegemajor1=" + collegemajor1
				+ ", collegedoublemajorkind=" + collegedoublemajorkind + ", collegemajor2=" + collegemajor2
				+ ", collegescore=" + collegescore + ", collegescoremax=" + collegescoremax + ", collegestartdate="
				+ collegestartdate + ", collegeenddate=" + collegeenddate + ", collegegraduate=" + collegegraduate
				+ "]";
	}
	public BaseCollegeDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	

	
}
