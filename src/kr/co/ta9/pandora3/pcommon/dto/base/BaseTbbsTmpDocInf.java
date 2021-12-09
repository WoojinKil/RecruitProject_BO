package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTbbsTmpDocInf - ValueObject class for table [TBBS_TMP_DOC_INF].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
public class BaseTbbsTmpDocInf extends CommonBean
{
	/** doc_seq (DOC_SEQ) */
	private int doc_seq;
	private Integer obj_doc_seq;
	/** modl_seq (MODL_SEQ) */
	private int modl_seq;
	private Integer obj_modl_seq;
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

	public BaseTbbsTmpDocInf()
	{
		super();

	}

	/**
	 * getter, setter
	 */
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