package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTbbsScdInf - ValueObject class for table [TBBS_SCD_INF].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
public class BaseTbbsScdInf extends CommonBean
{
	/** scd_seq (SCD_SEQ) */
	private int scd_seq;
	private Integer obj_scd_seq;
	/** scd_nm (SCD_NM) */
	private String scd_nm;
	/** st_dttm (ST_DTTM) */
	private String st_dttm;
	/** ed_dttm (ED_DTTM) */
	private String ed_dttm;
	/** lct (LCT) */
	private String lct;
	/** cts (CTS) */
	private String cts;
	/** ady_yn (ADY_YN) */
	private String ady_yn;
	/** crtr_id (CRTR_ID) */
	private String crtr_id;
	/** crt_dttm (CRT_DTTM) */
	private Timestamp crt_dttm;
	/** updr_id (UPDR_ID) */
	private String updr_id;
	/** upd_dttm (UPD_DTTM) */
	private Timestamp upd_dttm;
	private String scd_cl_cd;
	private String cstr_cd;

	public BaseTbbsScdInf()
	{
		super();
	}

	/**
	 * getter, setter
	 */
	
	public int getScd_seq() { 
		return scd_seq; 
	}
	public String getScd_cl_cd() {
		return scd_cl_cd;
	}

	public void setScd_cl_cd(String scd_cl_cd) {
		this.scd_cl_cd = scd_cl_cd;
	}

	public String getCstr_cd() {
		return cstr_cd;
	}

	public void setCstr_cd(String cstr_cd) {
		this.cstr_cd = cstr_cd;
	}

	public Integer getObj_scd_seq() {
		return obj_scd_seq; 
	}
	
	public void setScd_seq(int scd_seq) {
		this.scd_seq = scd_seq;
		this.obj_scd_seq = scd_seq;
	}

	public String getScd_nm() { 
		return scd_nm; 
	}
	public void setScd_nm(String scd_nm) {
		this.scd_nm = scd_nm; 
	}

	public String getSt_dttm() { 
		return st_dttm; 
	}
	public void setSt_dttm(String st_dttm) {
		this.st_dttm = st_dttm; 
	}

	public String getEd_dttm() { 
		return ed_dttm; 
	}
	public void setEd_dttm(String ed_dttm) {
		this.ed_dttm = ed_dttm; 
	}

	public String getLct() { 
		return lct; 
	}
	public void setLct(String lct) {
		this.lct = lct; 
	}

	public String getCts() { 
		return cts; 
	}
	public void setCts(String cts) {
		this.cts = cts; 
	}

	public String getAdy_yn() { 
		return ady_yn; 
	}
	public void setAdy_yn(String ady_yn) {
		this.ady_yn = ady_yn; 
	}

	public String getCrtr_id() { 
		return crtr_id; 
	}
	public void setCrtr_id(String crtr_id) {
		this.crtr_id = crtr_id; 
	}

	public Timestamp getCrt_dttm() { 
		return crt_dttm; 
	}
	public void setCrt_dttm(Timestamp crt_dttm) {
		this.crt_dttm = crt_dttm; 
	}

	public String getUpdr_id() { 
		return updr_id; 
	}
	public void setUpdr_id(String updr_id) {
		this.updr_id = updr_id; 
	}

	public Timestamp getUpd_dttm() { 
		return upd_dttm; 
	}
	public void setUpd_dttm(Timestamp upd_dttm) {
		this.upd_dttm = upd_dttm; 
	}

}