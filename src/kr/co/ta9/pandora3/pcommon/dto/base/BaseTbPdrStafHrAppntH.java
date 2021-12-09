package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTbPdrStafHrAppntH - ValueObject class for table [TB_PDR_STAF_HR_APPNT_H].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 21
 */
public class BaseTbPdrStafHrAppntH extends CommonBean
{
	/** cmpny_cd (CMPNY_CD) */
	private String cmpny_cd;
	/** empno (EMPNO) */
	private String empno;
	/** reg_day (REG_DAY) */
	private String reg_day;
	/** reg_seq (REG_SEQ) */
	private int reg_seq;
	private Integer obj_reg_seq;
	/** appnt_day (APPNT_DAY) */
	private String appnt_day;
	/** hr_alt_clfi_nm (HR_ALT_CLFI_NM) */
	private String hr_alt_clfi_nm;
	/** alt_cnts_gbcd (ALT_CNTS_GBCD) */
	private String alt_cnts_gbcd;
	/** alt_rsn_gbcd (ALT_RSN_GBCD) */
	private String alt_rsn_gbcd;
	/** alt_rsn_cnts (ALT_RSN_CNTS) */
	private String alt_rsn_cnts;
	/** actv_yn (ACTV_YN) */
	private String actv_yn;
	/** crt_dtm (CRT_DTM) */
	private Timestamp crt_dtm;
	/** crt_id (CRT_ID) */
	private String crt_id;
	/** mdf_dtm (MDF_DTM) */
	private Timestamp mdf_dtm;
	/** mdf_id (MDF_ID) */
	private String mdf_id;

	public BaseTbPdrStafHrAppntH()
	{
		super();

	}

	/**
	 * getter, setter
	 */
	public String getCmpny_cd() { 
		return cmpny_cd; 
	}
	public void setCmpny_cd(String cmpny_cd) {
		this.cmpny_cd = cmpny_cd; 
	}

	public String getEmpno() { 
		return empno; 
	}
	public void setEmpno(String empno) {
		this.empno = empno; 
	}

	public String getReg_day() { 
		return reg_day; 
	}
	public void setReg_day(String reg_day) {
		this.reg_day = reg_day; 
	}

	public int getReg_seq() { 
		return reg_seq; 
	}
	public Integer getObj_reg_seq() {
		return obj_reg_seq; 
	}
	
	public void setReg_seq(int reg_seq) {
		this.reg_seq = reg_seq;
		this.obj_reg_seq = reg_seq;
	}

	public String getAppnt_day() { 
		return appnt_day; 
	}
	public void setAppnt_day(String appnt_day) {
		this.appnt_day = appnt_day; 
	}

	public String getHr_alt_clfi_nm() { 
		return hr_alt_clfi_nm; 
	}
	public void setHr_alt_clfi_nm(String hr_alt_clfi_nm) {
		this.hr_alt_clfi_nm = hr_alt_clfi_nm; 
	}

	public String getAlt_cnts_gbcd() { 
		return alt_cnts_gbcd; 
	}
	public void setAlt_cnts_gbcd(String alt_cnts_gbcd) {
		this.alt_cnts_gbcd = alt_cnts_gbcd; 
	}

	public String getAlt_rsn_gbcd() { 
		return alt_rsn_gbcd; 
	}
	public void setAlt_rsn_gbcd(String alt_rsn_gbcd) {
		this.alt_rsn_gbcd = alt_rsn_gbcd; 
	}

	public String getAlt_rsn_cnts() { 
		return alt_rsn_cnts; 
	}
	public void setAlt_rsn_cnts(String alt_rsn_cnts) {
		this.alt_rsn_cnts = alt_rsn_cnts; 
	}

	public String getActv_yn() { 
		return actv_yn; 
	}
	public void setActv_yn(String actv_yn) {
		this.actv_yn = actv_yn; 
	}

	public Timestamp getCrt_dtm() { 
		return crt_dtm; 
	}
	public void setCrt_dtm(Timestamp crt_dtm) {
		this.crt_dtm = crt_dtm; 
	}

	public String getCrt_id() { 
		return crt_id; 
	}
	public void setCrt_id(String crt_id) {
		this.crt_id = crt_id; 
	}

	public Timestamp getMdf_dtm() { 
		return mdf_dtm; 
	}
	public void setMdf_dtm(Timestamp mdf_dtm) {
		this.mdf_dtm = mdf_dtm; 
	}

	public String getMdf_id() { 
		return mdf_id; 
	}
	public void setMdf_id(String mdf_id) {
		this.mdf_id = mdf_id; 
	}

}