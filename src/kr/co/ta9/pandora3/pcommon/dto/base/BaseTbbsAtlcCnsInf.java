package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * <pre>
 * 1. 클래스명 : BaseTbbsAtlcCnsInf
 * 2. 테이블 : TBBS_ATLC_CNS_INF
 * 3. 설명 : 
 * 4. 작성일 : 2019. 03. 28
 * 5. 작성자 : 
 * 6. 변경사항 : 2019. 03. 28, 최초작성
 * </pre>
 */
public class BaseTbbsAtlcCnsInf extends CommonBean
{
	/** atlc_cns_seq (ATLC_CNS_SEQ) */
	private int atlc_cns_seq;
	private Integer obj_atlc_cns_seq;
	/** cns_tp_cd (CNS_TP_CD) */
	private String cns_tp_cd;
	/** cns_st_dttm (CNS_ST_DTTM) */
	private String cns_st_dttm;
	/** cns_ed_dttm (CNS_ED_DTTM) */
	private String cns_ed_dttm;
	/** atlc_usr_nm (ATLC_USR_NM) */
	private String atlc_usr_nm;
	/** atlc_usr_mbl_no_1 (ATLC_USR_MBL_NO_1) */
	private String atlc_usr_mbl_no_1;
	/** atlc_usr_mbl_no_2 (ATLC_USR_MBL_NO_2) */
	private String atlc_usr_mbl_no_2;
	/** atlc_usr_mbl_no_3 (ATLC_USR_MBL_NO_3) */
	private String atlc_usr_mbl_no_3;
	/** atlc_usr_eml_adr (ATLC_USR_EML_ADR) */
	private String atlc_usr_eml_adr;
	/** hop_edc_crs (HOP_EDC_CRS) */
	private String hop_edc_crs;
	/** cns_cts (CNS_CTS) */
	private String cns_cts;
	/** crt_dttm (CRT_DTTM) */
	private Timestamp crt_dttm;
	/** upd_dttm (UPD_DTTM) */
	private Timestamp upd_dttm;
	private String updr_id;
	private String cns_ss_cd;

	public BaseTbbsAtlcCnsInf()
	{
		super();
	}

	/**
	 * getter, setter
	 */
	public int getAtlc_cns_seq() { 
		return atlc_cns_seq; 
	}
	public Integer getObj_atlc_cns_seq() {
		return obj_atlc_cns_seq; 
	}
	public void setAtlc_cns_seq(int atlc_cns_seq) {
		this.atlc_cns_seq = atlc_cns_seq;
		this.obj_atlc_cns_seq = atlc_cns_seq;
	}
	public String getCns_tp_cd() { 
		return cns_tp_cd; 
	}
	public void setCns_tp_cd(String cns_tp_cd) {
		this.cns_tp_cd = cns_tp_cd; 
	}
	public String getCns_st_dttm() { 
		return cns_st_dttm; 
	}
	public void setCns_st_dttm(String cns_st_dttm) {
		this.cns_st_dttm = cns_st_dttm; 
	}
	public String getCns_ed_dttm() { 
		return cns_ed_dttm; 
	}
	public void setCns_ed_dttm(String cns_ed_dttm) {
		this.cns_ed_dttm = cns_ed_dttm; 
	}
	public String getAtlc_usr_nm() { 
		return atlc_usr_nm; 
	}
	public void setAtlc_usr_nm(String atlc_usr_nm) {
		this.atlc_usr_nm = atlc_usr_nm; 
	}
	public String getAtlc_usr_mbl_no_1() { 
		return atlc_usr_mbl_no_1; 
	}
	public void setAtlc_usr_mbl_no_1(String atlc_usr_mbl_no_1) {
		this.atlc_usr_mbl_no_1 = atlc_usr_mbl_no_1; 
	}
	public String getAtlc_usr_mbl_no_2() { 
		return atlc_usr_mbl_no_2; 
	}
	public void setAtlc_usr_mbl_no_2(String atlc_usr_mbl_no_2) {
		this.atlc_usr_mbl_no_2 = atlc_usr_mbl_no_2; 
	}
	public String getAtlc_usr_mbl_no_3() { 
		return atlc_usr_mbl_no_3; 
	}
	public void setAtlc_usr_mbl_no_3(String atlc_usr_mbl_no_3) {
		this.atlc_usr_mbl_no_3 = atlc_usr_mbl_no_3; 
	}
	public String getAtlc_usr_eml_adr() { 
		return atlc_usr_eml_adr; 
	}
	public void setAtlc_usr_eml_adr(String atlc_usr_eml_adr) {
		this.atlc_usr_eml_adr = atlc_usr_eml_adr; 
	}
	public String getHop_edc_crs() { 
		return hop_edc_crs; 
	}
	public void setHop_edc_crs(String hop_edc_crs) {
		this.hop_edc_crs = hop_edc_crs; 
	}
	public String getCns_cts() { 
		return cns_cts; 
	}
	public void setCns_cts(String cns_cts) {
		this.cns_cts = cns_cts; 
	}
	public Timestamp getCrt_dttm() { 
		return crt_dttm; 
	}
	public void setCrt_dttm(Timestamp crt_dttm) {
		this.crt_dttm = crt_dttm; 
	}
	public Timestamp getUpd_dttm() { 
		return upd_dttm; 
	}
	public void setUpd_dttm(Timestamp upd_dttm) {
		this.upd_dttm = upd_dttm; 
	}

	public String getUpdr_id() {
		return updr_id;
	}

	public void setUpdr_id(String updr_id) {
		this.updr_id = updr_id;
	}

	public String getCns_ss_cd() {
		return cns_ss_cd;
	}

	public void setCns_ss_cd(String cns_ss_cd) {
		this.cns_ss_cd = cns_ss_cd;
	}
}