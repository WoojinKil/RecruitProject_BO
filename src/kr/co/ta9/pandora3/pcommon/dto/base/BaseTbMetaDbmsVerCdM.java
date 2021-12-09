package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTbMetaDbmsVerCdM - ValueObject class for table [TB_META_DBMS_VER_CD_M].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
public class BaseTbMetaDbmsVerCdM extends CommonBean
{
	/** cmpny_cd (cmpny_cd) */
	private String cmpny_cd;
	/** dbms_cd (DBMS_CD) */
	private String dbms_cd;
	/** dbms_ver_val (DBMS_VER_VAL) */
	private String dbms_ver_val;
	/** dbms_ver_cnts (dbms_ver_cnts) */
	private String dbms_ver_cnts;
	/** dbms_ver_rmk (dbms_ver_rmk) */
	private String dbms_ver_rmk;
	/** opsc_yn (OPSC_YN) */
	private String opsc_yn;
	/** regrt_empno (REGRT_EMPNO) */
	private String regrt_empno;
	/** reg_dtm (REG_DTM) */
	private Timestamp reg_dtm;
	/** us_yn (US_YN) */
	private String us_yn;
	/** crt_dtm (CRT_DTM) */
	private Timestamp crt_dtm;
	/** crt_id (CRT_ID) */
	private String crt_id;
	/** mdf_dtm (MDF_DTM) */
	private Timestamp mdf_dtm;
	/** mdf_id (MDF_ID) */
	private String mdf_id;

	public BaseTbMetaDbmsVerCdM()
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

	public String getDbms_cd() { 
		return dbms_cd; 
	}
	public void setDbms_cd(String dbms_cd) {
		this.dbms_cd = dbms_cd; 
	}

	public String getDbms_ver_val() { 
		return dbms_ver_val; 
	}
	public void setDbms_ver_val(String dbms_ver_val) {
		this.dbms_ver_val = dbms_ver_val; 
	}

	public String getDbms_ver_cnts() { 
		return dbms_ver_cnts; 
	}
	public void setDbms_ver_cnts(String dbms_ver_cnts) {
		this.dbms_ver_cnts = dbms_ver_cnts; 
	}

	public String getDbms_ver_rmk() { 
		return dbms_ver_rmk; 
	}
	public void setDbms_ver_rmk(String dbms_ver_rmk) {
		this.dbms_ver_rmk = dbms_ver_rmk; 
	}

	public String getOpsc_yn() { 
		return opsc_yn; 
	}
	public void setOpsc_yn(String opsc_yn) {
		this.opsc_yn = opsc_yn; 
	}

	public String getRegrt_empno() { 
		return regrt_empno; 
	}
	public void setRegrt_empno(String regrt_empno) {
		this.regrt_empno = regrt_empno; 
	}

	public Timestamp getReg_dtm() { 
		return reg_dtm; 
	}
	public void setReg_dtm(Timestamp reg_dtm) {
		this.reg_dtm = reg_dtm; 
	}

	public String getUs_yn() { 
		return us_yn; 
	}
	public void setUs_yn(String us_yn) {
		this.us_yn = us_yn; 
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