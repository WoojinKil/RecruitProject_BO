package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * TsysAdmMnuRolRtnn - ValueObject class for table [TSYS_ADM_MNU_ROL_RTNN].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
public class BaseTsysAdmMnuRolRtnn extends CommonBean
{
	/** mnu_seq (MNU_SEQ) */
	private int mnu_seq;
	private Integer obj_mnu_seq;
	/** rol_id (ROL_ID) */
	private String rol_id;
	/** rol_desc (ROL_DESC) */
	private String rol_desc;
	/** crtr_id (CRTR_ID) */
	private String crtr_id;
	/** crt_dttm (CRT_DTTM) */
	private Timestamp crt_dttm;
	/** updr_id (UPDR_ID) */
	private String updr_id;
	/** upd_dttm (UPD_DTTM) */
	private Timestamp upd_dttm;

	public BaseTsysAdmMnuRolRtnn()
	{
		super();

	}

	/**
	 * getter, setter
	 */
	public int getMnu_seq() { 
		return mnu_seq; 
	}
	public Integer getObj_mnu_seq() {
		return obj_mnu_seq; 
	}
	
	public void setMnu_seq(int mnu_seq) {
		this.mnu_seq = mnu_seq;
		this.obj_mnu_seq = mnu_seq;
	}

	public String getRol_id() { 
		return rol_id; 
	}
	public void setRol_id(String rol_id) {
		this.rol_id = rol_id; 
	}

	public String getRol_desc() { 
		return rol_desc; 
	}
	public void setRol_desc(String rol_desc) {
		this.rol_desc = rol_desc; 
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