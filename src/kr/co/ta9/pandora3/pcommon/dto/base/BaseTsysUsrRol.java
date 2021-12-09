package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTsysUsrRol - ValueObject class for table [TSYS_USR_ROL].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
public class BaseTsysUsrRol extends CommonBean
{
	/** rol_id (ROL_ID) */
	private String rol_id;
	/** rol_nm (ROL_NM) */
	private String rol_nm;
	/** us_yn (US_YN) */
	private String us_yn;
	/** apl_st_dt (APL_ST_DT) */
	private String apl_st_dt;
	/** apl_ed_dt (APL_ED_DT) */
	private String apl_ed_dt;
	/** crtr_id (CRTR_ID) */
	private String crtr_id;
	/** crt_dttm (CRT_DTTM) */
	private Timestamp crt_dttm;
	/** updr_id (UPDR_ID) */
	private String updr_id;
	/** upd_dttm (UPD_DTTM) */
	private Timestamp upd_dttm;

	public BaseTsysUsrRol()
	{
		super();

	}

	/**
	 * getter, setter
	 */
	public String getRol_id() { 
		return rol_id; 
	}
	public void setRol_id(String rol_id) {
		this.rol_id = rol_id; 
	}

	public String getRol_nm() { 
		return rol_nm; 
	}
	public void setRol_nm(String rol_nm) {
		this.rol_nm = rol_nm; 
	}

	public String getUs_yn() { 
		return us_yn; 
	}
	public void setUs_yn(String us_yn) {
		this.us_yn = us_yn; 
	}

	public String getApl_st_dt() { 
		return apl_st_dt; 
	}
	public void setApl_st_dt(String apl_st_dt) {
		this.apl_st_dt = apl_st_dt; 
	}

	public String getApl_ed_dt() { 
		return apl_ed_dt; 
	}
	public void setApl_ed_dt(String apl_ed_dt) {
		this.apl_ed_dt = apl_ed_dt; 
	}

	public String getCrtr_id() { 
		return crtr_id; 
	}
	public void setCrtr_id(String crtr_id) {
		this.crtr_id = crtr_id; 
	}

	public Timestamp getCrt_dttm() { 
		return crt_dttm; 
	}
	public void setCrt_dttm(Timestamp crt_dttm) {
		this.crt_dttm = crt_dttm; 
	}

	public String getUpdr_id() { 
		return updr_id; 
	}
	public void setUpdr_id(String updr_id) {
		this.updr_id = updr_id; 
	}

	public Timestamp getUpd_dttm() { 
		return upd_dttm; 
	}
	public void setUpd_dttm(Timestamp upd_dttm) {
		this.upd_dttm = upd_dttm; 
	}

}