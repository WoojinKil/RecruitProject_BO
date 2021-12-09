package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTsysOrgRolRtnn - ValueObject class for table [TSYS_ORG_ROL_RTNN].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 03. 22
 */
public abstract class BaseTsysOrgRolRtnn extends CommonBean
{
	/** org_cd (ORG_CD) */
	private String org_cd;
	/** rol_id (ROL_ID) */
	private String rol_id;
	/** crtr_id (CRTR_ID) */
	private String crtr_id;
	/** crt_dttm (CRT_DTTM) */
	private Timestamp crt_dttm;
	/** updr_id (UPDR_ID) */
	private String updr_id;
	/** upd_dttm (UPD_DTTM) */
	private Timestamp upd_dttm;

	public BaseTsysOrgRolRtnn()
	{
		super();

	}

	/**
	 * getter, setter
	 */
	
	
	public String getRol_id() { 
		return rol_id; 
	}
	public String getHr_org_cd() {
		return org_cd;
	}

	public void setHr_org_cd(String org_cd) {
		this.org_cd = org_cd;
	}

	public void setRol_id(String rol_id) {
		this.rol_id = rol_id; 
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