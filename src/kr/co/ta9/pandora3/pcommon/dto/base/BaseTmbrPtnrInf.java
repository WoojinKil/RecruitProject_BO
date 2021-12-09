package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTmbrPtnrInf - ValueObject class for table [TMBR_PTNR_INF].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
public class BaseTmbrPtnrInf extends CommonBean
{
	/** ptnr_seq (PTNR_SEQ) */
	private int ptnr_seq;
	private Integer obj_ptnr_seq;
	/** corp_nm (CORP_NM) */
	private String corp_nm;
	/** proj_nm (PROJ_NM) */
	private String proj_nm;
	/** st_ym (ST_YM) */
	private String st_ym;
	/** ed_ym (ED_YM) */
	private String ed_ym;
	/** ptnr_img_url (PTNR_IMG_URL) */
	private String ptnr_img_url;
	/** ptnr_cts (PTNR_CTS) */
	private String ptnr_cts;
	/** crtr_id (CRTR_ID) */
	private String crtr_id;
	/** crt_dttm (CRT_DTTM) */
	private Timestamp crt_dttm;
	/** updr_id (UPDR_ID) */
	private String updr_id;
	/** upd_dttm (UPD_DTTM) */
	private Timestamp upd_dttm;

	public BaseTmbrPtnrInf()
	{
		super();
	}

	/**
	 * getter, setter
	 */
	public int getPtnr_seq() { 
		return ptnr_seq; 
	}
	public Integer getObj_ptnr_seq() {
		return obj_ptnr_seq; 
	}
	
	public void setPtnr_seq(int ptnr_seq) {
		this.ptnr_seq = ptnr_seq;
		this.obj_ptnr_seq = ptnr_seq;
	}

	public String getCorp_nm() { 
		return corp_nm; 
	}
	public void setCorp_nm(String corp_nm) {
		this.corp_nm = corp_nm; 
	}

	public String getProj_nm() { 
		return proj_nm; 
	}
	public void setProj_nm(String proj_nm) {
		this.proj_nm = proj_nm; 
	}

	public String getSt_ym() { 
		return st_ym; 
	}
	public void setSt_ym(String st_ym) {
		this.st_ym = st_ym; 
	}

	public String getEd_ym() { 
		return ed_ym; 
	}
	public void setEd_ym(String ed_ym) {
		this.ed_ym = ed_ym; 
	}

	public String getPtnr_img_url() { 
		return ptnr_img_url; 
	}
	public void setPtnr_img_url(String ptnr_img_url) {
		this.ptnr_img_url = ptnr_img_url; 
	}

	public String getPtnr_cts() { 
		return ptnr_cts; 
	}
	public void setPtnr_cts(String ptnr_cts) {
		this.ptnr_cts = ptnr_cts; 
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