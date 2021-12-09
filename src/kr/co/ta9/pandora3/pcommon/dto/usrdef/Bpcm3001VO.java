package kr.co.ta9.pandora3.pcommon.dto.usrdef;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTbbsCmtInf - ValueObject class for table [TBBS_CMT_INF].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
public class Bpcm3001VO extends CommonBean
{
	private String thku_evnt_no;            /*사은행사id*/
	private String thku_evnt_mdcls_cd;         /*사은행사유형코드*/
	private String thku_evnt_mdcls_nm;         /*사은행사유형명*/
	private String evnt_nm; 	            /*사은행사명*/
	private String evnt_dt; 	            /*행사일자*/
	private String evnt_smry_2_info;        /*요약정보*/
	private String thku_evnt_prgrs_stat_cd;        /*사은행사진행상태*/
	private String evnt_smry_1_info;
	
	public String getThku_evnt_no() {
		return thku_evnt_no;
	}
	public void setThku_evnt_no(String thku_evnt_no) {
		this.thku_evnt_no = thku_evnt_no;
	}
	public String getThku_evnt_mdcls_cd() {
		return thku_evnt_mdcls_cd;
	}
	public void setThku_evnt_mdcls_cd(String thku_evnt_mdcls_cd) {
		this.thku_evnt_mdcls_cd = thku_evnt_mdcls_cd;
	}
	public String getThku_evnt_mdcls_nm() {
		return thku_evnt_mdcls_nm;
	}
	public void setThku_evnt_mdcls_nm(String thku_evnt_mdcls_nm) {
		this.thku_evnt_mdcls_nm = thku_evnt_mdcls_nm;
	}
	public String getEvnt_nm() {
		return evnt_nm;
	}
	public void setEvnt_nm(String evnt_nm) {
		this.evnt_nm = evnt_nm;
	}
	public String getEvnt_dt() {
		return evnt_dt;
	}
	public void setEvnt_dt(String evnt_dt) {
		this.evnt_dt = evnt_dt;
	}
	public String getEvnt_smry_2_info() {
		return evnt_smry_2_info;
	}
	public void setEvnt_smry_2_info(String evnt_smry_2_info) {
		this.evnt_smry_2_info = evnt_smry_2_info;
	}
	public String getThku_evnt_prgrs_stat_cd() {
		return thku_evnt_prgrs_stat_cd;
	}
	public void setThku_evnt_prgrs_stat_cd(String thku_evnt_prgrs_stat_cd) {
		this.thku_evnt_prgrs_stat_cd = thku_evnt_prgrs_stat_cd;
	}
	public String getEvnt_smry_1_info() {
		return evnt_smry_1_info;
	}
	public void setEvnt_smry_1_info(String evnt_smry_1_info) {
		this.evnt_smry_1_info = evnt_smry_1_info;
	}
	
}