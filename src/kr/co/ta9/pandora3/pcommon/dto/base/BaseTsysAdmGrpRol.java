package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTsysAdmGrpRol - ValueObject class for table [tsys_adm_grp_rol].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 10. 28
 */
public class BaseTsysAdmGrpRol extends CommonBean
{
	/** grp_rol_id (grp_rol_id) */
	private String grp_rol_id;
	/** grp_rol_nm (grp_rol_nm) */
	private String grp_rol_nm;
	/** us_yn (us_yn) */
	private String us_yn;
	/** apl_st_dt (apl_st_dt) */
	private String apl_st_dt;
	/** apl_ed_dt (apl_ed_dt) */
	private String apl_ed_dt;
	/** crtr_id (crtr_id) */
	private String crtr_id;
	/** crt_dttm (crt_dttm) */
	private Timestamp crt_dttm;
	/** updr_id (updr_id) */
	private String updr_id;
	/** upd_dttm (upd_dttm) */
	private Timestamp upd_dttm;

	public BaseTsysAdmGrpRol()
	{
		super();

	}

	/**
	 * getter, setter
	 */
	public String getGrp_rol_id() { 
		return grp_rol_id; 
	}
	public void setGrp_rol_id(String grp_rol_id) {
		this.grp_rol_id = grp_rol_id; 
	}

	public String getGrp_rol_nm() { 
		return grp_rol_nm; 
	}
	public void setGrp_rol_nm(String grp_rol_nm) {
		this.grp_rol_nm = grp_rol_nm; 
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