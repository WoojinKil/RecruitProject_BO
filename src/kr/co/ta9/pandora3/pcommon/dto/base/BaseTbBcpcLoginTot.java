package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTbBcpcLoginTot - ValueObject class for table [TB_BCPC_LOGIN_TOT].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 04. 06
 */
public class BaseTbBcpcLoginTot extends CommonBean
{
	/** tot_dt (tot_dt) */
	private String tot_dt;
	/** sys_cd (sys_cd) */
	private String sys_cd;
	/** grp_rol_id (grp_rol_id) */
	private String grp_rol_id;
	/** usr_id (usr_id) */
	private String usr_id;
	/** login_mbr_id_cnt (login_mbr_id_cnt) */
	private int login_mbr_id_cnt;
	private Integer obj_login_mbr_id_cnt;
	/** vst_cust_cnt (vst_cust_cnt) */
	private int vst_cust_cnt;
	private Integer obj_vst_cust_cnt;
	/** crtr_id (crtr_id) */
	private String crtr_id;
	/** rgst_dtm (rgst_dtm) */
	private Timestamp rgst_dtm;
	/** updr_id (updr_id) */
	private String updr_id;
	/** mdf_dtm (mdf_dtm) */
	private Timestamp mdf_dtm;

	public BaseTbBcpcLoginTot()
	{
		super();

	}

	/**
	 * getter, setter
	 */
	public String getTot_dt() { 
		return tot_dt; 
	}
	public void setTot_dt(String tot_dt) {
		this.tot_dt = tot_dt; 
	}

	public String getSys_cd() {
		return sys_cd;
	}

	public void setSys_cd(String sys_cd) {
		this.sys_cd = sys_cd;
	}

	public String getGrp_rol_id() { 
		return grp_rol_id; 
	}
	public void setGrp_rol_id(String grp_rol_id) {
		this.grp_rol_id = grp_rol_id; 
	}

	public String getUsr_id() { 
		return usr_id; 
	}
	public void setUsr_id(String usr_id) {
		this.usr_id = usr_id; 
	}

	public int getLogin_mbr_id_cnt() { 
		return login_mbr_id_cnt; 
	}
	public Integer getObj_login_mbr_id_cnt() {
		return obj_login_mbr_id_cnt; 
	}
	
	public void setLogin_mbr_id_cnt(int login_mbr_id_cnt) {
		this.login_mbr_id_cnt = login_mbr_id_cnt;
		this.obj_login_mbr_id_cnt = login_mbr_id_cnt;
	}

	public int getVst_cust_cnt() { 
		return vst_cust_cnt; 
	}
	public Integer getObj_vst_cust_cnt() {
		return obj_vst_cust_cnt; 
	}
	
	public void setVst_cust_cnt(int vst_cust_cnt) {
		this.vst_cust_cnt = vst_cust_cnt;
		this.obj_vst_cust_cnt = vst_cust_cnt;
	}

	public String getCrtr_id() { 
		return crtr_id; 
	}
	public void setCrtr_id(String crtr_id) {
		this.crtr_id = crtr_id; 
	}

	public Timestamp getRgst_dtm() { 
		return rgst_dtm; 
	}
	public void setRgst_dtm(Timestamp rgst_dtm) {
		this.rgst_dtm = rgst_dtm; 
	}

	public String getUpdr_id() { 
		return updr_id; 
	}
	public void setUpdr_id(String updr_id) {
		this.updr_id = updr_id; 
	}

	public Timestamp getMdf_dtm() { 
		return mdf_dtm; 
	}
	public void setMdf_dtm(Timestamp mdf_dtm) {
		this.mdf_dtm = mdf_dtm; 
	}

}