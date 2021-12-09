package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTbPdrCmpnyStafjobD - ValueObject class for table [TB_PDR_CMPNY_STAFJOB_D].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 21
 */
public class BaseTbPdrCmpnyStafjobD extends CommonBean
{
	/** cmpny_cd (CMPNY_CD) */
	private String cmpny_cd;
	/** stafjob_cd (STAFJOB_CD) */
	private String stafjob_cd;
	/** stafjob_nm (STAFJOB_NM) */
	private String stafjob_nm;
	/** stafjob_rmk (STAFJOB_RMK) */
	private String stafjob_rmk;
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

	public BaseTbPdrCmpnyStafjobD()
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

	public String getStafjob_cd() { 
		return stafjob_cd; 
	}
	public void setStafjob_cd(String stafjob_cd) {
		this.stafjob_cd = stafjob_cd; 
	}

	public String getStafjob_nm() { 
		return stafjob_nm; 
	}
	public void setStafjob_nm(String stafjob_nm) {
		this.stafjob_nm = stafjob_nm; 
	}

	public String getStafjob_rmk() { 
		return stafjob_rmk; 
	}
	public void setStafjob_rmk(String stafjob_rmk) {
		this.stafjob_rmk = stafjob_rmk; 
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