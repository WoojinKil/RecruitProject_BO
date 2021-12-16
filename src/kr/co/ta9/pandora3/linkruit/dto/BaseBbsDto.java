package kr.co.ta9.pandora3.linkruit.dto;

import kr.co.ta9.pandora3.app.bean.CommonBean;

public class BaseBbsDto extends CommonBean {

	private int bbsno;
	private String bbstitle;
	private String bbscontent;
	private String bbswritedate;
	private int bbshit;
	private String bbsupdatedate;
	public int getBbsno() {
		return bbsno;
	}
	public void setBbsno(int bbsno) {
		this.bbsno = bbsno;
	}
	public String getBbstitle() {
		return bbstitle;
	}
	public void setBbstitle(String bbstitle) {
		this.bbstitle = bbstitle;
	}
	public String getBbscontent() {
		return bbscontent;
	}
	public void setBbscontent(String bbscontent) {
		this.bbscontent = bbscontent;
	}
	public String getBbswritedate() {
		return bbswritedate;
	}
	public void setBbswritedate(String bbswritedate) {
		this.bbswritedate = bbswritedate;
	}
	public int getBbshit() {
		return bbshit;
	}
	public void setBbshit(int bbshit) {
		this.bbshit = bbshit;
	}
	public String getBbsupdatedate() {
		return bbsupdatedate;
	}
	public void setBbsupdatedate(String bbsupdatedate) {
		this.bbsupdatedate = bbsupdatedate;
	}
	public BaseBbsDto(int bbsno, String bbstitle, String bbscontent, String bbswritedate, int bbshit,
			String bbsupdatedate) {
		super();
		this.bbsno = bbsno;
		this.bbstitle = bbstitle;
		this.bbscontent = bbscontent;
		this.bbswritedate = bbswritedate;
		this.bbshit = bbshit;
		this.bbsupdatedate = bbsupdatedate;
	}
	public BaseBbsDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
}
