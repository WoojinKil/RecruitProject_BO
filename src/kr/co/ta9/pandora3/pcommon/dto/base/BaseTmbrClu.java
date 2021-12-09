package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTmbrClu - ValueObject class for table [TMBR_CLU].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
public class BaseTmbrClu extends CommonBean
{
	/** clu_seq (CLU_SEQ) */
	private int clu_seq;
	private Integer obj_clu_seq;
	/** clu_cls_cd (CLU_CLS_CD) */
	private String clu_cls_cd;
	/** clu_tp_cd (CLU_TP_CD) */
	private String clu_tp_cd;
	/** clu_cts (CLU_CTS) */
	private String clu_cts;
	/** us_yn (US_YN) */
	private String us_yn;
	/** crtr_id (CRTR_ID) */
	private String crtr_id;
	/** crt_dttm (CRT_DTTM) */
	private Timestamp crt_dttm;
	/** updr_id (UPDR_ID) */
	private String updr_id;
	/** upd_dttm (UPD_DTTM) */
	private Timestamp upd_dttm;

	public BaseTmbrClu()
	{
		super();

	}

	/**
	 * getter, setter
	 */
	public int getClu_seq() { 
		return clu_seq; 
	}
	public Integer getObj_clu_seq() {
		return obj_clu_seq; 
	}
	
	public void setClu_seq(int clu_seq) {
		this.clu_seq = clu_seq;
		this.obj_clu_seq = clu_seq;
	}

	public String getClu_cls_cd() { 
		return clu_cls_cd; 
	}
	public void setClu_cls_cd(String clu_cls_cd) {
		this.clu_cls_cd = clu_cls_cd; 
	}

	public String getClu_tp_cd() { 
		return clu_tp_cd; 
	}
	public void setClu_tp_cd(String clu_tp_cd) {
		this.clu_tp_cd = clu_tp_cd; 
	}

	public String getClu_cts() { 
		return clu_cts; 
	}
	public void setClu_cts(String clu_cts) {
		this.clu_cts = clu_cts; 
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