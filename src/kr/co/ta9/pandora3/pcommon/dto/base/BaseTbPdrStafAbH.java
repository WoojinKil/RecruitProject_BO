package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTbPdrStafAbH - ValueObject class for table [TB_PDR_STAF_AB_H].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 21
 */
public class BaseTbPdrStafAbH extends CommonBean
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
	/** ab_gbcd (AB_GBCD) */
	private String ab_gbcd;
	/** dgr_gbcd (DGR_GBCD) */
	private String dgr_gbcd;
	/** acdm_nm (ACDM_NM) */
	private String acdm_nm;
	/** adms_day (ADMS_DAY) */
	private String adms_day;
	/** grdt_day (GRDT_DAY) */
	private String grdt_day;
	/** grdt_gbcd (GRDT_GBCD) */
	private String grdt_gbcd;
	/** grdt_cert_fl_seq (GRDT_CERT_FL_SEQ) */
	private int grdt_cert_fl_seq;
	private Integer obj_grdt_cert_fl_seq;
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

	public BaseTbPdrStafAbH()
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

	public String getAb_gbcd() { 
		return ab_gbcd; 
	}
	public void setAb_gbcd(String ab_gbcd) {
		this.ab_gbcd = ab_gbcd; 
	}

	public String getDgr_gbcd() { 
		return dgr_gbcd; 
	}
	public void setDgr_gbcd(String dgr_gbcd) {
		this.dgr_gbcd = dgr_gbcd; 
	}

	public String getAcdm_nm() { 
		return acdm_nm; 
	}
	public void setAcdm_nm(String acdm_nm) {
		this.acdm_nm = acdm_nm; 
	}

	public String getAdms_day() { 
		return adms_day; 
	}
	public void setAdms_day(String adms_day) {
		this.adms_day = adms_day; 
	}

	public String getGrdt_day() { 
		return grdt_day; 
	}
	public void setGrdt_day(String grdt_day) {
		this.grdt_day = grdt_day; 
	}

	public String getGrdt_gbcd() { 
		return grdt_gbcd; 
	}
	public void setGrdt_gbcd(String grdt_gbcd) {
		this.grdt_gbcd = grdt_gbcd; 
	}

	public int getGrdt_cert_fl_seq() { 
		return grdt_cert_fl_seq; 
	}
	public Integer getObj_grdt_cert_fl_seq() {
		return obj_grdt_cert_fl_seq; 
	}
	
	public void setGrdt_cert_fl_seq(int grdt_cert_fl_seq) {
		this.grdt_cert_fl_seq = grdt_cert_fl_seq;
		this.obj_grdt_cert_fl_seq = grdt_cert_fl_seq;
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