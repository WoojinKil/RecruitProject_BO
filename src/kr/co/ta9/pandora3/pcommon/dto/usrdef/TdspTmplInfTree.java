/**
* <pre>
* 1. 프로젝트명 : 판도라 패키징
* 2. 패키지명 : kr.co.ta9.pandora3.display.dto
* 3. 파일명 : TemplateDispTree
* 4. 작성일 : 2017-11-22
* </pre>
*/
package kr.co.ta9.pandora3.pcommon.dto.usrdef;

import java.beans.SimpleBeanInfo;


/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.pcommon.dto.usrdef
* 2. 타입명    : class
* 3. 작성일    : 2017-11-22
* 4. 설명       : 템플릿 tree dto
* </pre>
*/
public class TdspTmplInfTree extends SimpleBeanInfo{
	private String url;		        // 링크 URL
	private String tmpl_url;
	private String tmpl_tp_cd;
	private String upp_tmpl_tp_cd;
	private String mnu_seq;
	private String mnu_nm;
	private int mnu_dph;
	private int dsply_no;
	private String dsply_yn;
	private String chd_yn;
	private String mnu_yn;
	private int id;					// 자식(본인)
	private int pId;				// 부모
	private String name;			    // 트리이름
	private boolean open;			// 트리 OPEN 여부, true/false
	private boolean isParent;		// 부모 여부, true/false
	private String isSaved;		// 부모 여부, true/false
	private String us_yn;
	
	public String getUs_yn() {
		return us_yn;
	}
	public void setUs_yn(String us_yn) {
		this.us_yn = us_yn;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public boolean isOpen() {
		return open;
	}
	public void setOpen(boolean open) {
		this.open = open;
	}
	public boolean isParent() {
		return isParent;
	}
	public void setParent(boolean isParent) {
		this.isParent = isParent;
	}
	public String getMnu_nm() {
		return mnu_nm;
	}
	public void setMnu_nm(String mnu_nm) {
		this.mnu_nm = mnu_nm;
	}
	public int getId() {
		return id;
	}
	public String getIsSaved() {
		return isSaved;
	}
	public void setIsSaved(String isSaved) {
		this.isSaved = isSaved;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getpId() {
		return pId;
	}
	public void setpId(int pId) {
		this.pId = pId;
	}
	public String getTmpl_url() {
		return tmpl_url;
	}
	public void setTmpl_url(String tmpl_url) {
		this.tmpl_url = tmpl_url;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getTmpl_tp_cd() {
		return tmpl_tp_cd;
	}
	public void setTmpl_tp_cd(String tmpl_tp_cd) {
		this.tmpl_tp_cd = tmpl_tp_cd;
	}
	public String getMnu_seq() {
		return mnu_seq;
	}
	public void setMnu_seq(String mnu_seq) {
		this.mnu_seq = mnu_seq;
	}
	public int getMnu_dph() {
		return mnu_dph;
	}
	public void setMnu_dph(int mnu_dph) {
		this.mnu_dph = mnu_dph;
	}
	public int getDsply_no() {
		return dsply_no;
	}
	public void setDsply_no(int dsply_no) {
		this.dsply_no = dsply_no;
	}
	public String getDsply_yn() {
		return dsply_yn;
	}
	public void setDsply_yn(String dsply_yn) {
		this.dsply_yn = dsply_yn;
	}
	public String getChd_yn() {
		return chd_yn;
	}
	public void setChd_yn(String chd_yn) {
		this.chd_yn = chd_yn;
	}
	public String getMnu_yn() {
		return mnu_yn;
	}
	public void setMnu_yn(String mnu_yn) {
		this.mnu_yn = mnu_yn;
	}
	public String getUpp_tmpl_tp_cd() {
		return upp_tmpl_tp_cd;
	}
	public void setUpp_tmpl_tp_cd(String upp_tmpl_tp_cd) {
		this.upp_tmpl_tp_cd = upp_tmpl_tp_cd;
	}
	
}
