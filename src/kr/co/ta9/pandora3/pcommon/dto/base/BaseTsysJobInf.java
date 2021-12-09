package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTsysJobInf - ValueObject class for table [TSYS_JOB_INF].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 11. 04
 */
public class BaseTsysJobInf extends CommonBean
{
	private String job_cd;
	private String job_nm;
	private int srt_seq;
	private String sys_cd;
	private String us_yn;
	private String crtr_id;
	private Timestamp crt_dttm;
	private String updr_id;
	private Timestamp upd_dttm;
	

	public BaseTsysJobInf()
	{
		super();

	}


	public String getJob_cd() {
		return job_cd;
	}


	public void setJob_cd(String job_cd) {
		this.job_cd = job_cd;
	}


	public String getJbfn_nm() {
		return job_nm;
	}


	public void setJbfn_nm(String job_nm) {
		this.job_nm = job_nm;
	}


	public int getSrt_seq() {
		return srt_seq;
	}


	public void setSrt_seq(int srt_seq) {
		this.srt_seq = srt_seq;
	}


	public String getSys_cd() {
		return sys_cd;
	}


	public void setSys_cd(String sys_cd) {
		this.sys_cd = sys_cd;
	}


	public String getUs_yn() {
		return us_yn;
	}


	public void setUs_yn(String us_yn) {
		this.us_yn = us_yn;
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