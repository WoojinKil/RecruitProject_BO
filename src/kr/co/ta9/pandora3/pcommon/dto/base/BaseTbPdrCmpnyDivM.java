package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTbPdrCmpnyDivM - ValueObject class for table [TB_PDR_CMPNY_DIV_M].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
public class BaseTbPdrCmpnyDivM extends CommonBean
{
	/** cmpny_cd (CMPNY_CD) */
	private String cmpny_cd;
	/** div_cd (DIV_CD) */
	private String div_cd;
	/** div_nm (DIV_NM) */
	private String div_nm;
	/** div_rprsnt_empno (DIV_RPRSNT_EMPNO) */
	private String div_rprsnt_empno;
	/** div_cnts (DIV_CNTS) */
	private String div_cnts;
	/** upr_div_cd (UPR_DIV_CD) */
	private String upr_div_cd;
	/** prft_mng_yn (PRFT_MNG_YN) */
	private String prft_mng_yn;
	/** reflct_dy (REFLCT_DY) */
	private String reflct_dy;
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

	public BaseTbPdrCmpnyDivM()
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

	public String getDiv_cd() { 
		return div_cd; 
	}
	public void setDiv_cd(String div_cd) {
		this.div_cd = div_cd; 
	}

	public String getDiv_nm() { 
		return div_nm; 
	}
	public void setDiv_nm(String div_nm) {
		this.div_nm = div_nm; 
	}

	public String getDiv_rprsnt_empno() { 
		return div_rprsnt_empno; 
	}
	public void setDiv_rprsnt_empno(String div_rprsnt_empno) {
		this.div_rprsnt_empno = div_rprsnt_empno; 
	}

	public String getDiv_cnts() { 
		return div_cnts; 
	}
	public void setDiv_cnts(String div_cnts) {
		this.div_cnts = div_cnts; 
	}

	public String getUpr_div_cd() { 
		return upr_div_cd; 
	}
	public void setUpr_div_cd(String upr_div_cd) {
		this.upr_div_cd = upr_div_cd; 
	}

	public String getPrft_mng_yn() { 
		return prft_mng_yn; 
	}
	public void setPrft_mng_yn(String prft_mng_yn) {
		this.prft_mng_yn = prft_mng_yn; 
	}

	public String getReflct_dy() { 
		return reflct_dy; 
	}
	public void setReflct_dy(String reflct_dy) {
		this.reflct_dy = reflct_dy; 
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