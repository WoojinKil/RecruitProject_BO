package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTbLgjbAdmlgninfH - ValueObject class for table [TB_LGJB_ADMLGNINF_H].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 12. 26
 */
public class BaseTbLgjbAdmlgninfH extends CommonBean
{
	/** hist_no (hist_no) */
	private int hist_no;
	private Integer obj_hist_no;
	/** usr_id (usr_id) */
	private String usr_id;
	/** lgn_id (lgn_id) */
	private String lgn_id;
	/** mngr_tp_cd (mngr_tp_cd) */
	private String mngr_tp_cd;
	/** actv_yn (actv_yn) */
	private String actv_yn;
	/** usr_stat_cd (usr_stat_cd) */
	private String usr_stat_cd;
	/** usr_ss_nm (usr_ss_nm) */
	private String usr_ss_nm;
	/** usr_mbl_no_1 (usr_mbl_no_1) */
	private String usr_mbl_no_1;
	/** usr_mbl_no_2 (usr_mbl_no_2) */
	private String usr_mbl_no_2;
	/** usr_mbl_no_3 (usr_mbl_no_3) */
	private String usr_mbl_no_3;
	/** hp_tel_no (hp_tel_no) */
	private String hp_tel_no;
	/** etsn_tel_no (etsn_tel_no) */
	private String etsn_tel_no;
	/** fxl_tel_no (fxl_tel_no) */
	private String fxl_tel_no;
	/** org_cd (org_cd) */
	private String org_cd;
	/** grde_cd (grde_cd) */
	private String grde_cd;
	/** pos_cd (pos_cd) */
	private String pos_cd;
	/** job_cd (job_cd) */
	private String job_cd;
	/** blco_nm (blco_nm) */
	private String blco_nm;
	/** apvl_yn (apvl_yn) */
	private String apvl_yn;
	/** apvl_rfs_rsn (apvl_rfs_rsn) */
	private String apvl_rfs_rsn;
	/** ctf_yn (ctf_yn) */
	private String ctf_yn;
	/** ctf_key_crt_dttm (ctf_key_crt_dttm) */
	private Timestamp ctf_key_crt_dttm;
	/** hist_stat_cd (hist_stat_cd) */
	private String hist_stat_cd;
	/** hist_stat_nm (hist_stat_nm) */
	private String hist_stat_nm;
	/** crtr_id (crtr_id) */
	private String crtr_id;
	/** crt_dttm (crt_dttm) */
	private Timestamp crt_dttm;
	/** updr_id (updr_id) */
	private String updr_id;
	/** upd_dttm (upd_dttm) */
	private Timestamp upd_dttm;

	public BaseTbLgjbAdmlgninfH()
	{
		super();

	}

	/**
	 * getter, setter
	 */
	
	public int getHist_no() { 
		return hist_no; 
	}
	public String getUsr_ss_nm() {
		return usr_ss_nm;
	}

	public void setUsr_ss_nm(String usr_ss_nm) {
		this.usr_ss_nm = usr_ss_nm;
	}

	public Integer getObj_hist_no() {
		return obj_hist_no; 
	}
	
	public void setHist_no(int hist_no) {
		this.hist_no = hist_no;
		this.obj_hist_no = hist_no;
	}

	public String getUsr_id() { 
		return usr_id; 
	}
	public void setUsr_id(String usr_id) {
		this.usr_id = usr_id; 
	}

	public String getLgn_id() { 
		return lgn_id; 
	}
	public void setLgn_id(String lgn_id) {
		this.lgn_id = lgn_id; 
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

	public String getUsr_ss_cd() { 
		return usr_stat_cd; 
	}
	public void setUsr_ss_cd(String usr_stat_cd) {
		this.usr_stat_cd = usr_stat_cd; 
	}

	public String getUsr_mbl_no_1() { 
		return usr_mbl_no_1; 
	}
	public void setUsr_mbl_no_1(String usr_mbl_no_1) {
		this.usr_mbl_no_1 = usr_mbl_no_1; 
	}

	public String getUsr_mbl_no_2() { 
		return usr_mbl_no_2; 
	}
	public void setUsr_mbl_no_2(String usr_mbl_no_2) {
		this.usr_mbl_no_2 = usr_mbl_no_2; 
	}

	public String getUsr_mbl_no_3() { 
		return usr_mbl_no_3; 
	}
	public void setUsr_mbl_no_3(String usr_mbl_no_3) {
		this.usr_mbl_no_3 = usr_mbl_no_3; 
	}

	public String getHr_hp_tel_no() { 
		return hp_tel_no; 
	}
	public void setHr_hp_tel_no(String hp_tel_no) {
		this.hp_tel_no = hp_tel_no; 
	}

	public String getHr_etsn_tel_no() { 
		return etsn_tel_no; 
	}
	public void setHr_etsn_tel_no(String etsn_tel_no) {
		this.etsn_tel_no = etsn_tel_no; 
	}

	public String getHr_fxl_tel_no() { 
		return fxl_tel_no; 
	}
	public void setHr_fxl_tel_no(String fxl_tel_no) {
		this.fxl_tel_no = fxl_tel_no; 
	}

	public String getHr_org_cd() { 
		return org_cd; 
	}
	public void setHr_org_cd(String org_cd) {
		this.org_cd = org_cd; 
	}

	public String getHr_emp_grde_cd() { 
		return grde_cd; 
	}
	public void setHr_emp_grde_cd(String grde_cd) {
		this.grde_cd = grde_cd; 
	}

	public String getHr_emp_pos_cd() { 
		return pos_cd; 
	}
	public void setHr_emp_pos_cd(String pos_cd) {
		this.pos_cd = pos_cd; 
	}

	public String getHr_job_id() { 
		return job_cd; 
	}
	public void setHr_job_id(String job_cd) {
		this.job_cd = job_cd; 
	}

	public String getBlco_nm() { 
		return blco_nm; 
	}
	public void setBlco_nm(String blco_nm) {
		this.blco_nm = blco_nm; 
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

	public Timestamp getAuth_key_crt_dttm() { 
		return ctf_key_crt_dttm; 
	}
	public void setAuth_key_crt_dttm(Timestamp ctf_key_crt_dttm) {
		this.ctf_key_crt_dttm = ctf_key_crt_dttm; 
	}

	public String getHist_stat_cd() { 
		return hist_stat_cd; 
	}
	public void setHist_stat_cd(String hist_stat_cd) {
		this.hist_stat_cd = hist_stat_cd; 
	}

	public String getHist_stat_nm() { 
		return hist_stat_nm; 
	}
	public void setHist_stat_nm(String hist_stat_nm) {
		this.hist_stat_nm = hist_stat_nm; 
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