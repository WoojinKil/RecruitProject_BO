package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTbPdrCmpnyUseSysH - ValueObject class for table [TB_PDR_CMPNY_USE_SYS_H].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
public class BaseTbPdrCmpnyUseSysH extends CommonBean
{
	/** cmpny_cd (CMPNY_CD) */
	private String cmpny_cd;

	/** sys_cd (SYS_CD) */
	private String sys_cd;
//	/** tpic_nm (TPIC_NM) */
	private String tpic_nm;	
	
	/** prd_gbcd (PRD_GBCD) */
	private String prd_gbcd;
	/** cntrt_sta_dy (CNTRT_STA_DY) */
	private String cntrt_sta_dy;
	/** cntrt_end_dy (CNTRT_END_DY) */
	private String cntrt_end_dy;
	/** crt_dtm (CRT_DTM) */
	private Timestamp crt_dtm;
	/** crt_id (CRT_ID) */
	private String crt_id;
	/** mdf_dtm (MDF_DTM) */
	private Timestamp mdf_dtm;
	/** mdf_id (MDF_ID) */
	private String mdf_id;

	public BaseTbPdrCmpnyUseSysH()
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

	public String getSys_cd() { 
		return sys_cd; 
	}
	public void setSys_cd(String sys_cd) {
		this.sys_cd = sys_cd; 
	}

	public String getPrd_gbcd() { 
		return prd_gbcd; 
	}
	public void setPrd_gbcd(String prd_gbcd) {
		this.prd_gbcd = prd_gbcd; 
	}

	public String getCntrt_sta_dy() { 
		return cntrt_sta_dy; 
	}
	public void setCntrt_sta_dy(String cntrt_sta_dy) {
		this.cntrt_sta_dy = cntrt_sta_dy; 
	}

	public String getCntrt_end_dy() { 
		return cntrt_end_dy; 
	}
	public void setCntrt_end_dy(String cntrt_end_dy) {
		this.cntrt_end_dy = cntrt_end_dy; 
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

	public String getTpic_nm() {
		return tpic_nm;
	}

	public void setTpic_nm(String tpic_nm) {
		this.tpic_nm = tpic_nm;
	}

}