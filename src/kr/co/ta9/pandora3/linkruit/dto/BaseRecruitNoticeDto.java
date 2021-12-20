package kr.co.ta9.pandora3.linkruit.dto;

import kr.co.ta9.pandora3.app.bean.CommonBean;

public class BaseRecruitNoticeDto extends CommonBean {
	private Integer recruitno; //채용공고 번호
	private String typename; //채용 유형 (수시, 공채, 혹은null)
	private String recruitname; //채용공고 이름
	private String recruitscale; //채용 규모 (000명, 혹은 null)
	private String recruitstartdatetime; //채용 시작일
	private String recruitenddatetime; //채용 마감일
	private int recruithit; //공고 조회수
	private String recruitcontent; //공고 내용
	private String recruitwritedate; //작성일자
	private String recruitupdate;
	
	
	public Integer getRecruitno() {
		return recruitno;
	}
	public void setRecruitno(Integer recruitno) {
		this.recruitno = recruitno;
	}
	public String getTypename() {
		return typename;
	}
	public void setTypename(String typename) {
		this.typename = typename;
	}

	public String getRecruitname() {
		return recruitname;
	}
	public void setRecruitname(String recruitname) {
		this.recruitname = recruitname;
	}
	public String getRecruitscale() {
		return recruitscale;
	}
	public void setRecruitscale(String recruitscale) {
		this.recruitscale = recruitscale;
	}
	public String getRecruitstartdatetime() {
		return recruitstartdatetime;
	}
	public void setRecruitstartdatetime(String recruitstartdatetime) {
		this.recruitstartdatetime = recruitstartdatetime;
	}
	public String getRecruitenddatetime() {
		return recruitenddatetime;
	}
	public void setRecruitenddatetime(String recruitenddatetime) {
		this.recruitenddatetime = recruitenddatetime;
	}
	public int getRecruithit() {
		return recruithit;
	}
	public void setRecruithit(int recruithit) {
		this.recruithit = recruithit;
	}
	public String getRecruitcontent() {
		return recruitcontent;
	}
	public void setRecruitcontent(String recruitcontent) {
		this.recruitcontent = recruitcontent;
	}
	public String getRecruitwritedate() {
		return recruitwritedate;
	}
	public void setRecruitwritedate(String recruitwritedate) {
		this.recruitwritedate = recruitwritedate;
	}
	
	
	public String getRecruitupdate() {
		return recruitupdate;
	}
	public void setRecruitupdate(String recruitupdate) {
		this.recruitupdate = recruitupdate;
	}
	@Override
	public String toString() {
		return "BaseRecruitNoticeDto [recruitno=" + recruitno + ", typename=" + typename + ", recruitname=" + recruitname
				+ ", recruitscale=" + recruitscale + ", recruitstartdatetime=" + recruitstartdatetime
				+ ", recruitenddatetime=" + recruitenddatetime + ", recruithit=" + recruithit + ", recruitcontent="
				+ recruitcontent + ", recruitwritedate=" + recruitwritedate + ", recruitupdate=" + recruitupdate + "]";
	}

	
	
}
