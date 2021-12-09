package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTbPdrStafLcnsH - ValueObject class for table [TB_PDR_STAF_LCNS_H].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 21
 */
public class BaseTbPdrStafLcnsH extends CommonBean
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
	/** lcns_gbcd (LCNS_GBCD) */
	private String lcns_gbcd;
	/** lcns_nm (LCNS_NM) */
	private String lcns_nm;
	/** aqrm_day (AQRM_DAY) */
	private String aqrm_day;
	/** inst_nm (INST_NM) */
	private String inst_nm;
	/** lcns_fl_seq (LCNS_FL_SEQ) */
	private int lcns_fl_seq;
	private Integer obj_lcns_fl_seq;
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

	public BaseTbPdrStafLcnsH()
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

	public String getLcns_gbcd() { 
		return lcns_gbcd; 
	}
	public void setLcns_gbcd(String lcns_gbcd) {
		this.lcns_gbcd = lcns_gbcd; 
	}

	public String getLcns_nm() { 
		return lcns_nm; 
	}
	public void setLcns_nm(String lcns_nm) {
		this.lcns_nm = lcns_nm; 
	}

	public String getAqrm_day() { 
		return aqrm_day; 
	}
	public void setAqrm_day(String aqrm_day) {
		this.aqrm_day = aqrm_day; 
	}

	public String getInst_nm() { 
		return inst_nm; 
	}
	public void setInst_nm(String inst_nm) {
		this.inst_nm = inst_nm; 
	}

	public int getLcns_fl_seq() { 
		return lcns_fl_seq; 
	}
	public Integer getObj_lcns_fl_seq() {
		return obj_lcns_fl_seq; 
	}
	
	public void setLcns_fl_seq(int lcns_fl_seq) {
		this.lcns_fl_seq = lcns_fl_seq;
		this.obj_lcns_fl_seq = lcns_fl_seq;
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