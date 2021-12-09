package kr.co.ta9.pandora3.pcommon.dto;

import kr.co.ta9.pandora3.pcommon.dto.base.BaseTsysAdmMnuRtnn;

/**
 * TsysAdmMnuRtnn - ValueObject Extended class for table [TSYS_ADM_MNU_RTNN].
 *
 * <pre>
 * 1. 클래스명 : TsysAdmMnuRtnn
 * 2. 설명 : 권리자메뉴할당 DTO
 * 3. 작성일 : 2019-03-12
 * 4. 작성자 : TANINE
 * </pre>
 *
 * @since 2019. 03. 12
 */
public class TsysAdmMnuRtnn extends BaseTsysAdmMnuRtnn {

	private int up_mnu_seq;
	private String up_mnu_nm;
	private String mnu_nm;
	private String pgm_id;
	private String appl_btn_list;
	private String sys_cd;
	private String sys_nm;
	
	
	
	
	public String getSys_cd() {
		return sys_cd;
	}
	public void setSys_cd(String sys_cd) {
		this.sys_cd = sys_cd;
	}
	public String getSys_nm() {
		return sys_nm;
	}
	public void setSys_nm(String sys_nm) {
		this.sys_nm = sys_nm;
	}
	public String getAppl_btn_list() {
		return appl_btn_list;
	}
	public void setAppl_btn_list(String appl_btn_list) {
		this.appl_btn_list = appl_btn_list;
	}
	
	public int getUp_mnu_seq() {
		return up_mnu_seq;
	}
	public void setUp_mnu_seq(int up_mnu_seq) {
		this.up_mnu_seq = up_mnu_seq;
	}
	public String getUp_mnu_nm() {
		return up_mnu_nm;
	}
	public void setUp_mnu_nm(String up_mnu_nm) {
		this.up_mnu_nm = up_mnu_nm;
	}
	public String getMnu_nm() {
		return mnu_nm;
	}
	public void setMnu_nm(String mnu_nm) {
		this.mnu_nm = mnu_nm;
	}
	public String getPgm_id() {
		return pgm_id;
	}
	public void setPgm_id(String pgm_id) {
		this.pgm_id = pgm_id;
	}
	
}