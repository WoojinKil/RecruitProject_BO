package kr.co.ta9.pandora3.linkruit.dto;

import java.sql.Timestamp;

import kr.co.ta9.pandora3.app.bean.CommonBean;

public class BaseMemberDto extends CommonBean{
	private String memberName;
	private String memberBirth;
	private String memberId;
	private String memberPw;
	private String memberPwConfirm;
	private String memberRoot;
	private String memberPhoneNumber1;
	private String memberPhoneNumber2;
	private String memberPhoneNumber3;
	private String memberRegDate;
	
	public String getMemberRegDate() {
		return memberRegDate;
	}

	public void setMemberRegDate(String memberRegDate) {
		this.memberRegDate = memberRegDate;
	}

	private int memberIsAdmin;

	
	public String getMemberPhoneNumber1() {
		return memberPhoneNumber1;
	}

	public void setMemberPhoneNumber1(String memberPhoneNumber1) {
		this.memberPhoneNumber1 = memberPhoneNumber1;
	}

	public String getMemberPhoneNumber2() {
		return memberPhoneNumber2;
	}

	public void setMemberPhoneNumber2(String memberPhoneNumber2) {
		this.memberPhoneNumber2 = memberPhoneNumber2;
	}

	public String getMemberPhoneNumber3() {
		return memberPhoneNumber3;
	}

	public void setMemberPhoneNumber3(String memberPhoneNumber3) {
		this.memberPhoneNumber3 = memberPhoneNumber3;
	}

	public String getMemberPw() {
		return memberPw;
	}

	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}

	public String getMemberPwConfirm() {
		return memberPwConfirm;
	}

	public void setMemberPwConfirm(String memberPwConfirm) {
		this.memberPwConfirm = memberPwConfirm;
	}

	public String getMemberRoot() {
		return memberRoot;
	}

	public void setMemberRoot(String memberRoot) {
		this.memberRoot = memberRoot;
	}


	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getMemberBirth() {
		return memberBirth;
	}

	public void setMemberBirth(String memberBirth) {
		this.memberBirth = memberBirth;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public int getMemberIsAdmin() {
		return memberIsAdmin;
	}

	public void setMemberIsAdmin(int memberIsAdmin) {
		this.memberIsAdmin = memberIsAdmin;
	}



	
}
