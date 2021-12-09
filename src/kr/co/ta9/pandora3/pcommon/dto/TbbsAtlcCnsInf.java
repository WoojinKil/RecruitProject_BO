package kr.co.ta9.pandora3.pcommon.dto;

import kr.co.ta9.pandora3.pcommon.dto.base.BaseTbbsAtlcCnsInf;

/**
 * <pre>
 * 1. 클래스명 : TbbsAtlcCnsInf
 * 2. 테이블 : TBBS_ATLC_CNS_INF
 * 3. 설명 : 
 * 4. 작성일 : 2019. 03. 28
 * 5. 작성자 : 
 * 6. 변경사항 : 2019. 03. 28, 최초작성
 * </pre>
 */
public class TbbsAtlcCnsInf extends BaseTbbsAtlcCnsInf {
	private String f_cns_st_dttm;
	private String f_cns_ed_dttm;
	private String atlc_usr_mbl_no;
	private String cns_dttm;
	private String cns_tp_nm;
	
	public String getF_cns_st_dttm() {
		return f_cns_st_dttm;
	}
	public void setF_cns_st_dttm(String f_cns_st_dttm) {
		this.f_cns_st_dttm = f_cns_st_dttm;
	}
	public String getF_cns_ed_dttm() {
		return f_cns_ed_dttm;
	}
	public void setF_cns_ed_dttm(String f_cns_ed_dttm) {
		this.f_cns_ed_dttm = f_cns_ed_dttm;
	}
	public String getAtlc_usr_mbl_no() {
		return atlc_usr_mbl_no;
	}
	public void setAtlc_usr_mbl_no(String atlc_usr_mbl_no) {
		this.atlc_usr_mbl_no = atlc_usr_mbl_no;
	}
	public String getCns_dttm() {
		return cns_dttm;
	}
	public void setCns_dttm(String cns_dttm) {
		this.cns_dttm = cns_dttm;
	}
	public String getCns_tp_nm() {
		return cns_tp_nm;
	}
	public void setCns_tp_nm(String cns_tp_nm) {
		this.cns_tp_nm = cns_tp_nm;
	}
}