package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTmbrAdmLgnInf - ValueObject class for table [TMBR_ADM_LGN_INF].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
public class BaseTmbrAdmLgnInf extends CommonBean
{
	
	private String usr_id;
	private String usr_nm;
	private String lgn_id;
	private String lgn_pwd;
	private String mngr_tp_cd;
	private String actv_yn;
	private int pwd_fail_cnt;
	private Timestamp pwd_fail_dttm;
	private Timestamp pwd_upd_dttm;
	private String jn_ctf_key;
	private Timestamp jn_ctf_dttm;
	private String fnd_ctf_key;
	private Timestamp fnd_ctf_key_dttm;
	private String usr_eml_addr;
	private String usr_stat_cd;
	private String usr_zip_cd;
	private String rod_addr;
	private String lno_addr;
	private String dtl_addr;
	private String tem_eml_addr;
	private String eml_ctf_key;
	private Timestamp eml_ctf_dttm;
	private String hp_tel_no;
	private String etsn_tel_no;
	private String fxl_tel_no;
	private String org_cd;
	private String grde_cd;
	private String pos_cd;
	private String job_cd;
	private String apvl_yn;
	private String apvl_rfs_rsn;
	private String blco_nm;
	private String ctf_yn;
	private int ctf_fail_cnt;
	private String sys_cd;
	private String crtr_id;
	private Timestamp crt_dttm;
	private String updr_id;
	private Timestamp upd_dttm;


	
	public BaseTmbrAdmLgnInf()
	{
		super();

	}


	/**
	 * getter, setter
	 */
	
	public String getUsr_id() {
		return usr_id;
	}


	public String getUsr_zip_cd() {
		return usr_zip_cd;
	}


	public void setUsr_zip_cd(String usr_zip_cd) {
		this.usr_zip_cd = usr_zip_cd;
	}


	public void setUsr_id(String usr_id) {
		this.usr_id = usr_id;
	}
	public String getUsr_nm() {
		return usr_nm;
	}
	public void setUsr_nm(String usr_nm) {
		this.usr_nm = usr_nm;
	}
	public String getLgn_id() {
		return lgn_id;
	}
	public void setLgn_id(String lgn_id) {
		this.lgn_id = lgn_id;
	}
	public String getLgn_pwd() {
		return lgn_pwd;
	}
	public void setLgn_pwd(String lgn_pwd) {
		this.lgn_pwd = lgn_pwd;
	}
	public String getMngr_tp_cd() {
		return mngr_tp_cd;
	}
	public void setMngr_tp_cd(String mngr_tp_cd) {
		this.mngr_tp_cd = mngr_tp_cd;
	}
	public String getActv_yn() {
		return actv_yn;
	}
	public void setActv_yn(String actv_yn) {
		this.actv_yn = actv_yn;
	}
	public int getPwd_fail_cnt() {
		return pwd_fail_cnt;
	}
	public void setPwd_fail_cnt(int pwd_fail_cnt) {
		this.pwd_fail_cnt = pwd_fail_cnt;
	}
	
	public Timestamp getPwd_upd_dttm() {
		return pwd_upd_dttm;
	}
	public void setPwd_upd_dttm(Timestamp pwd_upd_dttm) {
		this.pwd_upd_dttm = pwd_upd_dttm;
	}
	public String getJn_ctf_key() {
		return jn_ctf_key;
	}
	public void setJn_ctf_key(String jn_ctf_key) {
		this.jn_ctf_key = jn_ctf_key;
	}
	public Timestamp getJn_ctf_dttm() {
		return jn_ctf_dttm;
	}
	public void setJn_ctf_dttm(Timestamp jn_ctf_dttm) {
		this.jn_ctf_dttm = jn_ctf_dttm;
	}
	public String getFnd_ctf_key() {
		return fnd_ctf_key;
	}
	public void setFnd_ctf_key(String fnd_ctf_key) {
		this.fnd_ctf_key = fnd_ctf_key;
	}
	public Timestamp getPwd_fail_dttm() {
		return pwd_fail_dttm;
	}
	public void setPwd_fail_dttm(Timestamp pwd_fail_dttm) {
		this.pwd_fail_dttm = pwd_fail_dttm;
	}

	public Timestamp getFnd_ctf_key_dttm() {
		return fnd_ctf_key_dttm;
	}
	public void setFnd_ctf_key_dttm(Timestamp fnd_ctf_key_dttm) {
		this.fnd_ctf_key_dttm = fnd_ctf_key_dttm;
	}
	public String getUsr_eml_addr() {
		return usr_eml_addr;
	}
	public void setUsr_eml_addr(String usr_eml_addr) {
		this.usr_eml_addr = usr_eml_addr;
	}
	public String getUsr_stat_cd() {
		return usr_stat_cd;
	}
	public void setUsr_stat_cd(String usr_stat_cd) {
		this.usr_stat_cd = usr_stat_cd;
	}
	public String getRod_addr() {
		return rod_addr;
	}
	public void setRod_addr(String rod_addr) {
		this.rod_addr = rod_addr;
	}
	public String getLno_addr() {
		return lno_addr;
	}
	public void setLno_addr(String lno_addr) {
		this.lno_addr = lno_addr;
	}
	public String getDtl_addr() {
		return dtl_addr;
	}
	public void setDtl_addr(String dtl_addr) {
		this.dtl_addr = dtl_addr;
	}
	public String getTem_eml_addr() {
		return tem_eml_addr;
	}
	public void setTem_eml_addr(String tem_eml_addr) {
		this.tem_eml_addr = tem_eml_addr;
	}
	public String getEml_ctf_key() {
		return eml_ctf_key;
	}
	public void setEml_ctf_key(String eml_ctf_key) {
		this.eml_ctf_key = eml_ctf_key;
	}
	public Timestamp getEml_ctf_dttm() {
		return eml_ctf_dttm;
	}
	public void setEml_ctf_dttm(Timestamp eml_ctf_dttm) {
		this.eml_ctf_dttm = eml_ctf_dttm;
	}
	public String getHp_tel_no() {
		return hp_tel_no;
	}
	public void setHp_tel_no(String hp_tel_no) {
		this.hp_tel_no = hp_tel_no;
	}
	public String getEtsn_tel_no() {
		return etsn_tel_no;
	}
	public void setEtsn_tel_no(String etsn_tel_no) {
		this.etsn_tel_no = etsn_tel_no;
	}
	public String getFxl_tel_no() {
		return fxl_tel_no;
	}
	public void setFxl_tel_no(String fxl_tel_no) {
		this.fxl_tel_no = fxl_tel_no;
	}
	public String getOrg_cd() {
		return org_cd;
	}
	public void setOrg_cd(String org_cd) {
		this.org_cd = org_cd;
	}
	public String getGrde_cd() {
		return grde_cd;
	}
	public void setGrde_cd(String grde_cd) {
		this.grde_cd = grde_cd;
	}
	public String getPos_cd() {
		return pos_cd;
	}
	public void setPos_cd(String pos_cd) {
		this.pos_cd = pos_cd;
	}
	public String getJob_cd() {
		return job_cd;
	}
	public void setJob_cd(String job_cd) {
		this.job_cd = job_cd;
	}
	public String getApvl_yn() {
		return apvl_yn;
	}
	public void setApvl_yn(String apvl_yn) {
		this.apvl_yn = apvl_yn;
	}
	public String getApvl_rfs_rsn() {
		return apvl_rfs_rsn;
	}
	public void setApvl_rfs_rsn(String apvl_rfs_rsn) {
		this.apvl_rfs_rsn = apvl_rfs_rsn;
	}
	public String getCtf_yn() {
		return ctf_yn;
	}
	public void setCtf_yn(String ctf_yn) {
		this.ctf_yn = ctf_yn;
	}
	public int getCtf_fail_cnt() {
		return ctf_fail_cnt;
	}
	public void setCtf_fail_cnt(int ctf_fail_cnt) {
		this.ctf_fail_cnt = ctf_fail_cnt;
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
	public String getSys_cd() {
		return sys_cd;
	}
	public void setSys_cd(String sys_cd) {
		this.sys_cd = sys_cd;
	}
}