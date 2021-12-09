package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTbMetaCmpnyTbTypD - ValueObject class for table [TB_META_CMPNY_TB_TYP_D].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
public class BaseTbMetaCmpnyTbTypD extends CommonBean
{
	/** cmpny_cd (CMPNY_CD) */
	private String cmpny_cd;
	/** sys_cd (SYS_CD) */
	private String sys_cd;
	/** tb_typ_gbcd (TB_TYP_GBCD) */
	private String tb_typ_gbcd;
	/** tb_typ_cnts (TB_TYP_CNTS) */
	private String tb_typ_cnts;
	/** sufx_cd (SUFX_CD) */
	private String sufx_cd;
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

	public BaseTbMetaCmpnyTbTypD()
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

	public String getTb_typ_gbcd() { 
		return tb_typ_gbcd; 
	}
	public void setTb_typ_gbcd(String tb_typ_gbcd) {
		this.tb_typ_gbcd = tb_typ_gbcd; 
	}

	public String getTb_typ_cnts() { 
		return tb_typ_cnts; 
	}
	public void setTb_typ_cnts(String tb_typ_cnts) {
		this.tb_typ_cnts = tb_typ_cnts; 
	}

	public String getSufx_cd() { 
		return sufx_cd; 
	}
	public void setSufx_cd(String sufx_cd) {
		this.sufx_cd = sufx_cd; 
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