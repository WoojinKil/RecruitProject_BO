package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTmbrUsrLgnInf - ValueObject class for table [TMBR_USR_LGN_INF].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
public class BaseTmbrUsrLgnInf extends CommonBean
{
	/** usr_id (USR_ID) */
	private String usr_id;
	/** lgn_dttm (LGN_DTTM) */
	private Timestamp lgn_dttm;
	/** lgo_dttm (LGO_DTTM) */
	private Timestamp lgo_dttm;
	/** ip_addr (IP_ADDR) */
	private String ip_addr;
	/** lgo_caus_cd (LGO_CAUS_CD) */
	private String lgo_caus_cd;
	/** crtr_id (CRTR_ID) */
	private String crtr_id;
	/** crt_dttm (CRT_DTTM) */
	private Timestamp crt_dttm;
	/** updr_id (UPDR_ID) */
	private String updr_id;
	/** upd_dttm (UPD_DTTM) */
	private Timestamp upd_dttm;
	// 2019-03-11 중복 로그인 키값 추가
	private String lgn_unq_key;
	// 2019-08-29 사이트 구분 추가
	private String sys_cd;
	
	private String lgo_caus_nm;
    private String mngr_tp_cd;
    private String mngr_tp_nm;
    private String sys_nm;
	 
	
	
	
	public BaseTmbrUsrLgnInf()
	{
		super();
	}




	public String getUsr_id() {
		return usr_id;
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




	public Timestamp getLgo_dttm() {
		return lgo_dttm;
	}




	public void setLgo_dttm(Timestamp lgo_dttm) {
		this.lgo_dttm = lgo_dttm;
	}




	public String getIp_addr() {
		return ip_addr;
	}




	public void setIp_addr(String ip_addr) {
		this.ip_addr = ip_addr;
	}




	public String getLgo_caus_cd() {
		return lgo_caus_cd;
	}




	public void setLgo_caus_cd(String lgo_caus_cd) {
		this.lgo_caus_cd = lgo_caus_cd;
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




	public String getLgn_unq_key() {
		return lgn_unq_key;
	}




	public void setLgn_unq_key(String lgn_unq_key) {
		this.lgn_unq_key = lgn_unq_key;
	}




	public String getSys_cd() {
		return sys_cd;
	}




	public void setSys_cd(String sys_cd) {
		this.sys_cd = sys_cd;
	}


	public String getLgo_caus_nm() {
		return lgo_caus_nm;
	}

	public void setLgo_caus_nm(String lgo_caus_nm) {
		this.lgo_caus_nm = lgo_caus_nm;
	}

	public String getMngr_tp_cd() {
		return mngr_tp_cd;
	}




	public void setMngr_tp_cd(String mngr_tp_cd) {
		this.mngr_tp_cd = mngr_tp_cd;
	}




	public String getMngr_tp_nm() {
		return mngr_tp_nm;
	}




	public void setMngr_tp_nm(String mngr_tp_nm) {
		this.mngr_tp_nm = mngr_tp_nm;
	}




	public String getSys_nm() {
		return sys_nm;
	}




	public void setSys_nm(String sys_nm) {
		this.sys_nm = sys_nm;
	}

	
	/**
	 * getter, setter
	 */

	
	
}