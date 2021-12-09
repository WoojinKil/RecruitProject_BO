package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTbPdrCmpnyStaflevelD - ValueObject class for table [TB_PDR_CMPNY_STAFLEVEL_D].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 21
 */
public class BaseTbPdrCmpnyStaflevelD extends CommonBean
{
	/** cmpny_cd (CMPNY_CD) */
	private String cmpny_cd;
	/** staflevel_cd (STAFLEVEL_CD) */
	private String staflevel_cd;
	/** staflevel_nm (STAFLEVEL_NM) */
	private String staflevel_nm;
	/** staflevel_rmk (STAFLEVEL_RMK) */
	private String staflevel_rmk;
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

	public BaseTbPdrCmpnyStaflevelD()
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

	public String getStaflevel_cd() { 
		return staflevel_cd; 
	}
	public void setStaflevel_cd(String staflevel_cd) {
		this.staflevel_cd = staflevel_cd; 
	}

	public String getStaflevel_nm() { 
		return staflevel_nm; 
	}
	public void setStaflevel_nm(String staflevel_nm) {
		this.staflevel_nm = staflevel_nm; 
	}

	public String getStaflevel_rmk() { 
		return staflevel_rmk; 
	}
	public void setStaflevel_rmk(String staflevel_rmk) {
		this.staflevel_rmk = staflevel_rmk; 
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