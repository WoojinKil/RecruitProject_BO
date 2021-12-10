package kr.co.ta9.pandora3.linkruit.dto;

import kr.co.ta9.pandora3.app.bean.CommonBean;

public class BaseRecruitNoticeDto extends CommonBean {
	private Integer recruitNo; //채용공고 번호
	private String typeNo; //채용 유형 (수시, 공채, 혹은null)
	private String recruitObject; //채용 대상( 신입, 경력 혹은 null)
	private String recruitName; //채용공고 이름
	private String recruitScale; //채용 규모 (000명, 혹은 null)
	private String recruitStartDateTime; //채용 시작일
	private String recruitEndDateTime; //채용 마감일
	private int recruitHit; //공고 조회수
	private String recruitContent; //공고 내용
	private String recruitWriteDate; //
	public Integer getRecruitNo() {
		return recruitNo;
	}
	public void setRecruitNo(Integer recruitNo) {
		this.recruitNo = recruitNo;
	}
	public String getTypeNo() {
		return typeNo;
	}
	public void setTypeNo(String typeNo) {
		this.typeNo = typeNo;
	}
	public String getRecruitObject() {
		return recruitObject;
	}
	public void setRecruitObject(String recruitObject) {
		this.recruitObject = recruitObject;
	}
	public String getRecruitName() {
		return recruitName;
	}
	public void setRecruitName(String recruitName) {
		this.recruitName = recruitName;
	}
	public String getRecruitScale() {
		return recruitScale;
	}
	public void setRecruitScale(String recruitScale) {
		this.recruitScale = recruitScale;
	}
	public String getRecruitStartDateTime() {
		return recruitStartDateTime;
	}
	public void setRecruitStartDateTime(String recruitStartDateTime) {
		this.recruitStartDateTime = recruitStartDateTime;
	}
	public String getRecruitEndDateTime() {
		return recruitEndDateTime;
	}
	public void setRecruitEndDateTime(String recruitEndDateTime) {
		this.recruitEndDateTime = recruitEndDateTime;
	}
	public int getRecruitHit() {
		return recruitHit;
	}
	public void setRecruitHit(int recruitHit) {
		this.recruitHit = recruitHit;
	}
	public String getRecruitContent() {
		return recruitContent;
	}
	public void setRecruitContent(String recruitContent) {
		this.recruitContent = recruitContent;
	}
	public String getRecruitWriteDate() {
		return recruitWriteDate;
	}
	public void setRecruitWriteDate(String recruitWriteDate) {
		this.recruitWriteDate = recruitWriteDate;
	}
	@Override
	public String toString() {
		return "BaseRecruitNoticeDto [recruitNo=" + recruitNo + ", typeNo=" + typeNo + ", recruitObject="
				+ recruitObject + ", recruitName=" + recruitName + ", recruitScale=" + recruitScale
				+ ", recruitStartDateTime=" + recruitStartDateTime + ", recruitEndDateTime=" + recruitEndDateTime
				+ ", recruitHit=" + recruitHit + ", recruitContent=" + recruitContent + ", recruitWriteDate="
				+ recruitWriteDate + "]";
	}

	
	
}
