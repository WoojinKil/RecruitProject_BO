package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTbMetaPjtUsrM - ValueObject class for table [TB_META_PJT_USR_M].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
public class BaseTbMetaPjtUsrM extends CommonBean
{
	/** cmpny_cd (CMPNY_CD) */
	private String cmpny_cd;
	/** pjt_cd (PJT_CD) */
	private String pjt_cd;
	/** staf_empno (STAF_EMPNO) */
	private String staf_empno;
	/** orzn_gbcd (ORZN_GBCD) */
	private String orzn_gbcd;
	/** orzn_cmpny_nm (ORZN_CMPNY_NM) */
	private String orzn_cmpny_nm;
	/** staf_gbcd (STAF_GBCD) */
	private String staf_gbcd;
	/** pjt_role_gbcd (PJT_ROLE_GBCD) */
	private String pjt_role_gbcd;
	/** sys_role_gbcd (SYS_ROLE_GBCD) */
	private String sys_role_gbcd;
	/** use_sta_dy (USE_STA_DY) */
	private String use_sta_dy;
	/** use_end_dy (USE_END_DY) */
	private String use_end_dy;
	/** crt_dtm (CRT_DTM) */
	private Timestamp crt_dtm;
	/** crt_id (CRT_ID) */
	private String crt_id;
	/** mdf_dtm (MDF_DTM) */
	private Timestamp mdf_dtm;
	/** mdf_id (MDF_ID) */
	private String mdf_id;

	public BaseTbMetaPjtUsrM()
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

	public String getPjt_cd() { 
		return pjt_cd; 
	}
	public void setPjt_cd(String pjt_cd) {
		this.pjt_cd = pjt_cd; 
	}

	public String getStaf_empno() { 
		return staf_empno; 
	}
	public void setStaf_empno(String staf_empno) {
		this.staf_empno = staf_empno; 
	}

	public String getOrzn_gbcd() { 
		return orzn_gbcd; 
	}
	public void setOrzn_gbcd(String orzn_gbcd) {
		this.orzn_gbcd = orzn_gbcd; 
	}

	public String getOrzn_cmpny_nm() { 
		return orzn_cmpny_nm; 
	}
	public void setOrzn_cmpny_nm(String orzn_cmpny_nm) {
		this.orzn_cmpny_nm = orzn_cmpny_nm; 
	}

	public String getStaf_gbcd() { 
		return staf_gbcd; 
	}
	public void setStaf_gbcd(String staf_gbcd) {
		this.staf_gbcd = staf_gbcd; 
	}

	public String getPjt_role_gbcd() { 
		return pjt_role_gbcd; 
	}
	public void setPjt_role_gbcd(String pjt_role_gbcd) {
		this.pjt_role_gbcd = pjt_role_gbcd; 
	}

	public String getSys_role_gbcd() { 
		return sys_role_gbcd; 
	}
	public void setSys_role_gbcd(String sys_role_gbcd) {
		this.sys_role_gbcd = sys_role_gbcd; 
	}

	public String getUse_sta_dy() { 
		return use_sta_dy; 
	}
	public void setUse_sta_dy(String use_sta_dy) {
		this.use_sta_dy = use_sta_dy; 
	}

	public String getUse_end_dy() { 
		return use_end_dy; 
	}
	public void setUse_end_dy(String use_end_dy) {
		this.use_end_dy = use_end_dy; 
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