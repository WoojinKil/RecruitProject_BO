package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTbMetaPjtM - ValueObject class for table [TB_META_PJT_M].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
public class BaseTbMetaPjtM extends CommonBean
{
	/** cmpny_cd (CMPNY_CD) */
	private String cmpny_cd;
	/** pjt_cd (PJT_CD) */
	private String pjt_cd;
	/** pjt_sta_dy (PJT_STA_DY) */
	private String pjt_sta_dy;
	/** pjt_end_dy (PJT_END_DY) */
	private String pjt_end_dy;
	/** sys_cd (SYS_CD) */
	private String sys_cd;
	/** pjt_tpic_empno (PJT_TPIC_EMPNO) */
	private String pjt_tpic_empno;
	/** pjt_tpic_telno (PJT_TPIC_TELNO) */
	private String pjt_tpic_telno;
	/** pjt_tpic_email (PJT_TPIC_EMAIL) */
	private String pjt_tpic_email;
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

	public BaseTbMetaPjtM()
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

	public String getPjt_sta_dy() { 
		return pjt_sta_dy; 
	}
	public void setPjt_sta_dy(String pjt_sta_dy) {
		this.pjt_sta_dy = pjt_sta_dy; 
	}

	public String getPjt_end_dy() { 
		return pjt_end_dy; 
	}
	public void setPjt_end_dy(String pjt_end_dy) {
		this.pjt_end_dy = pjt_end_dy; 
	}

	public String getSys_cd() { 
		return sys_cd; 
	}
	public void setSys_cd(String sys_cd) {
		this.sys_cd = sys_cd; 
	}

	public String getPjt_tpic_empno() { 
		return pjt_tpic_empno; 
	}
	public void setPjt_tpic_empno(String pjt_tpic_empno) {
		this.pjt_tpic_empno = pjt_tpic_empno; 
	}

	public String getPjt_tpic_telno() { 
		return pjt_tpic_telno; 
	}
	public void setPjt_tpic_telno(String pjt_tpic_telno) {
		this.pjt_tpic_telno = pjt_tpic_telno; 
	}

	public String getPjt_tpic_email() { 
		return pjt_tpic_email; 
	}
	public void setPjt_tpic_email(String pjt_tpic_email) {
		this.pjt_tpic_email = pjt_tpic_email; 
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