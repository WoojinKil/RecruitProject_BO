package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import org.apache.commons.net.ntp.TimeStamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTsysOrg - ValueObject class for table [TSYS_ORG].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 03. 14
 */
public class BaseTsysOrg extends CommonBean
{

	private String org_cd;
	private String org_nm;
	private String up_org_cd;
	private String org_dpth;
	private String org_stat_cd;
	private String srt_seq;
	private String co_cd;
	private String org_cls_cd;
	private String loc_cd;
	private String org_abrv_nm;
	private String sys_cd;
	private String crtr_id;
	private TimeStamp crt_dttm;
	private String updr_id;
	private TimeStamp upd_dttm;
	
	public String getOrg_cd() {
		return org_cd;
	}
	public void setOrg_cd(String org_cd) {
		this.org_cd = org_cd;
	}
	public String getOrg_nm() {
		return org_nm;
	}
	public void setOrg_nm(String org_nm) {
		this.org_nm = org_nm;
	}
	public String getUp_org_cd() {
		return up_org_cd;
	}
	public void setUp_org_cd(String up_org_cd) {
		this.up_org_cd = up_org_cd;
	}
	public String getOrg_dpth() {
		return org_dpth;
	}
	public void setOrg_dpth(String org_dpth) {
		this.org_dpth = org_dpth;
	}
	public String getOrg_stat_cd() {
		return org_stat_cd;
	}
	public void setOrg_stat_cd(String org_stat_cd) {
		this.org_stat_cd = org_stat_cd;
	}
	public String getSrt_sqn() {
		return srt_seq;
	}
	public void setSrt_sqn(String srt_seq) {
		this.srt_seq = srt_seq;
	}
	public String getCo_cd() {
		return co_cd;
	}
	public void setCo_cd(String co_cd) {
		this.co_cd = co_cd;
	}
	public String getOrg_cls_cd() {
		return org_cls_cd;
	}
	public void setOrg_cls_cd(String org_cls_cd) {
		this.org_cls_cd = org_cls_cd;
	}
	public String getLoc_cd() {
		return loc_cd;
	}
	public void setLoc_cd(String loc_cd) {
		this.loc_cd = loc_cd;
	}
	public String getOrg_abrv_nm() {
		return org_abrv_nm;
	}
	public void setOrg_abrv_nm(String org_abrv_nm) {
		this.org_abrv_nm = org_abrv_nm;
	}
	public String getCrtr_id() {
		return crtr_id;
	}
	public void setCrtr_id(String crtr_id) {
		this.crtr_id = crtr_id;
	}
	public TimeStamp getCrt_dttm() {
		return crt_dttm;
	}
	public void setCrt_dttm(TimeStamp crt_dttm) {
		this.crt_dttm = crt_dttm;
	}
	public String getUpdr_id() {
		return updr_id;
	}
	public void setUpdr_id(String updr_id) {
		this.updr_id = updr_id;
	}
	public TimeStamp getUpd_dttm() {
		return upd_dttm;
	}
	public void setUpd_dttm(TimeStamp upd_dttm) {
		this.upd_dttm = upd_dttm;
	}
	public String getSys_cd() {
		return sys_cd;
	}
	public void setSys_cd(String sys_cd) {
		this.sys_cd = sys_cd;
	}
	
	
	
}