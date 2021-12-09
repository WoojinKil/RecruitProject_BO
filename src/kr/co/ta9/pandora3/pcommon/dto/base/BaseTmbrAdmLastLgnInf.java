package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTmbrAdmLastLgnInf - ValueObject class for table [TMBR_ADM_LAST_LGN_INF].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 11. 13
 */
public class BaseTmbrAdmLastLgnInf extends CommonBean
{
	/** sys_cd (sys_cd) */
	private String sys_cd;
	/** usr_id (usr_id) */
	private String usr_id;
	/** lgn_dttm (lgn_dttm) */
	private Timestamp lgn_dttm;
	/** ip_addr (ip_addr) */
	private String ip_addr;
	/** crtr_id (crtr_id) */
	private String crtr_id;
	/** crt_dttm (crt_dttm) */
	private Timestamp crt_dttm;
	/** updr_id (updr_id) */
	private String updr_id;
	/** upd_dttm (upd_dttm) */
	private Timestamp upd_dttm;

	public BaseTmbrAdmLastLgnInf()
	{
		super();

	}

	/**
	 * getter, setter
	 */
	
	

	public String getUsr_id() { 
		return usr_id; 
	}
	public String getSys_cd() {
		return sys_cd;
	}

	public void setSys_cd(String sys_cd) {
		this.sys_cd = sys_cd;
	}

	public void setUsr_id(String usr_id) {
		this.usr_id = usr_id; 
	}

	public Timestamp getLgn_dttm() { 
		return lgn_dttm; 
	}
	public void setLgn_dttm(Timestamp lgn_dttm) {
		this.lgn_dttm = lgn_dttm; 
	}

	public String getIp_addr() { 
		return ip_addr; 
	}
	public void setIp_addr(String ip_addr) {
		this.ip_addr = ip_addr; 
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