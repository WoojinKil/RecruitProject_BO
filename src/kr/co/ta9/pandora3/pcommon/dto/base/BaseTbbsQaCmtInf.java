package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTbbsQaCmtInf - ValueObject class for table [TBBS_QA_CMT_INF].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
public class BaseTbbsQaCmtInf extends CommonBean
{
	/** cmt_seq (CMT_SEQ) */
	private int cmt_seq;
	private Integer obj_cmt_seq;
	/** modl_seq (MODL_SEQ) */
	private int modl_seq;
	private Integer obj_modl_seq;
	/** doc_seq (DOC_SEQ) */
	private int doc_seq;
	private Integer obj_doc_seq;
	/** scrt_yn (SCRT_YN) */
	private String scrt_yn;
	/** cts (CTS) */
	private String cts;
	/** lgn_id (LGN_ID) */
	private String lgn_id;
	/** ip_addr (IP_ADDR) */
	private String ip_addr;
	/** crtr_id (CRTR_ID) */
	private String crtr_id;
	/** crt_dttm (CRT_DTTM) */
	private Timestamp crt_dttm;
	/** updr_id (UPDR_ID) */
	private String updr_id;
	/** upd_dttm (UPD_DTTM) */
	private Timestamp upd_dttm;

	public BaseTbbsQaCmtInf()
	{
		super();

	}

	/**
	 * getter, setter
	 */
	public int getCmt_seq() { 
		return cmt_seq; 
	}
	public Integer getObj_cmt_seq() {
		return obj_cmt_seq; 
	}
	
	public void setCmt_seq(int cmt_seq) {
		this.cmt_seq = cmt_seq;
		this.obj_cmt_seq = cmt_seq;
	}

	public int getModl_seq() { 
		return modl_seq; 
	}
	public Integer getObj_modl_seq() {
		return obj_modl_seq; 
	}
	
	public void setModl_seq(int modl_seq) {
		this.modl_seq = modl_seq;
		this.obj_modl_seq = modl_seq;
	}

	public int getDoc_seq() { 
		return doc_seq; 
	}
	public Integer getObj_doc_seq() {
		return obj_doc_seq; 
	}
	
	public void setDoc_seq(int doc_seq) {
		this.doc_seq = doc_seq;
		this.obj_doc_seq = doc_seq;
	}

	public String getScrt_yn() { 
		return scrt_yn; 
	}
	public void setScrt_yn(String scrt_yn) {
		this.scrt_yn = scrt_yn; 
	}

	public String getCts() { 
		return cts; 
	}
	public void setCts(String cts) {
		this.cts = cts; 
	}

	public String getLgn_id() { 
		return lgn_id; 
	}
	public void setLgn_id(String lgn_id) {
		this.lgn_id = lgn_id; 
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