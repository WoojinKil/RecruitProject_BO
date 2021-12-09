package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTbPdrStafCarrH - ValueObject class for table [TB_PDR_STAF_CARR_H].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 21
 */
public class BaseTbPdrStafCarrH extends CommonBean
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
	/** jc_day (JC_DAY) */
	private String jc_day;
	/** lc_day (LC_DAY) */
	private String lc_day;
	/** cmpny_nm (CMPNY_NM) */
	private String cmpny_nm;
	/** staflevel_cd (STAFLEVEL_CD) */
	private String staflevel_cd;
	/** carr_reflct_yn (CARR_REFLCT_YN) */
	private String carr_reflct_yn;
	/** carr_cert_fl_seq (CARR_CERT_FL_SEQ) */
	private int carr_cert_fl_seq;
	private Integer obj_carr_cert_fl_seq;
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

	public BaseTbPdrStafCarrH()
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

	public String getJc_day() { 
		return jc_day; 
	}
	public void setJc_day(String jc_day) {
		this.jc_day = jc_day; 
	}

	public String getLc_day() { 
		return lc_day; 
	}
	public void setLc_day(String lc_day) {
		this.lc_day = lc_day; 
	}

	public String getCmpny_nm() { 
		return cmpny_nm; 
	}
	public void setCmpny_nm(String cmpny_nm) {
		this.cmpny_nm = cmpny_nm; 
	}

	public String getStaflevel_cd() { 
		return staflevel_cd; 
	}
	public void setStaflevel_cd(String staflevel_cd) {
		this.staflevel_cd = staflevel_cd; 
	}

	public String getCarr_reflct_yn() { 
		return carr_reflct_yn; 
	}
	public void setCarr_reflct_yn(String carr_reflct_yn) {
		this.carr_reflct_yn = carr_reflct_yn; 
	}

	public int getCarr_cert_fl_seq() { 
		return carr_cert_fl_seq; 
	}
	public Integer getObj_carr_cert_fl_seq() {
		return obj_carr_cert_fl_seq; 
	}
	
	public void setCarr_cert_fl_seq(int carr_cert_fl_seq) {
		this.carr_cert_fl_seq = carr_cert_fl_seq;
		this.obj_carr_cert_fl_seq = carr_cert_fl_seq;
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