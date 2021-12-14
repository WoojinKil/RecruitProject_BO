package kr.co.ta9.pandora3.linkruit.dto;

import java.sql.Timestamp;

import kr.co.ta9.pandora3.app.bean.CommonBean;

public class BaseMemberDto extends CommonBean{
	private String membername;
	private String memberbirth;
	private String memberid;
	private String memberpw;
	private String memberpwconfirm;
	private String memberroot;
	private String memberphonenumber1;
	private String memberphonenumber2;
	private String memberphonenumber3;
	private String memberregdate;
	private String memberupdatedate;
	
	
	
	public String getMemberupdatedate() {
		return memberupdatedate;
	}
	public void setMemberupdatedate(String memberupdatedate) {
		this.memberupdatedate = memberupdatedate;
	}
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
	public String getMemberid() {
		return memberid;
	}
	public void setMemberid(String memberid) {
		this.memberid = memberid;
	}
	public String getMemberpw() {
		return memberpw;
	}
	public void setMemberpw(String memberpw) {
		this.memberpw = memberpw;
	}
	public String getMemberpwconfirm() {
		return memberpwconfirm;
	}
	public void setMemberpwconfirm(String memberpwconfirm) {
		this.memberpwconfirm = memberpwconfirm;
	}
	public String getMemberroot() {
		return memberroot;
	}
	public void setMemberroot(String memberroot) {
		this.memberroot = memberroot;
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
	public String getMemberregdate() {
		return memberregdate;
	}
	public void setMemberregdate(String memberregdate) {
		this.memberregdate = memberregdate;
	}

	
}
