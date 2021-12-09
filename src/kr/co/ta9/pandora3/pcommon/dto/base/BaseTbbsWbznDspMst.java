package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTbbsWbznDspMst - ValueObject class for table [TBBS_WBZN_DSP_MST].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
public class BaseTbbsWbznDspMst extends CommonBean
{
	/** wbzn_seq (WBZN_SEQ) */
	private int wbzn_seq;
	private Integer obj_wbzn_seq;
	/** wbzn_nm (WBZN_NM) */
	private String wbzn_nm;
	/** tmp_seq (TMP_SEQ) */
	private int tmp_seq;
	private Integer obj_tmp_seq;
	/** y_no (Y_NO) */
	private String y_no;
	/** m_no (M_NO) */
	private String m_no;
	/** thumb_fpath (THUMB_FPATH) */
	private String thumb_fpath;
	/** pdf_nm (PDF_NM) */
	private String pdf_nm;
	/** pdf_fpath (PDF_FPATH) */
	private String pdf_fpath;
	/** crtr_id (CRTR_ID) */
	private String crtr_id;
	/** crt_dttm (CRT_DTTM) */
	private Timestamp crt_dttm;
	/** updr_id (UPDR_ID) */
	private String updr_id;
	/** upd_dttm (UPD_DTTM) */
	private Timestamp upd_dttm;

	public BaseTbbsWbznDspMst()
	{
		super();

	}

	/**
	 * getter, setter
	 */
	public int getWbzn_seq() { 
		return wbzn_seq; 
	}
	public Integer getObj_wbzn_seq() {
		return obj_wbzn_seq; 
	}
	
	public void setWbzn_seq(int wbzn_seq) {
		this.wbzn_seq = wbzn_seq;
		this.obj_wbzn_seq = wbzn_seq;
	}

	public String getWbzn_nm() { 
		return wbzn_nm; 
	}
	public void setWbzn_nm(String wbzn_nm) {
		this.wbzn_nm = wbzn_nm; 
	}

	public int getTmp_seq() { 
		return tmp_seq; 
	}
	public Integer getObj_tmp_seq() {
		return obj_tmp_seq; 
	}
	
	public void setTmp_seq(int tmp_seq) {
		this.tmp_seq = tmp_seq;
		this.obj_tmp_seq = tmp_seq;
	}

	public String getY_no() { 
		return y_no; 
	}
	public void setY_no(String y_no) {
		this.y_no = y_no; 
	}

	public String getM_no() { 
		return m_no; 
	}
	public void setM_no(String m_no) {
		this.m_no = m_no; 
	}

	public String getThumb_fpath() { 
		return thumb_fpath; 
	}
	public void setThumb_fpath(String thumb_fpath) {
		this.thumb_fpath = thumb_fpath; 
	}

	public String getPdf_nm() { 
		return pdf_nm; 
	}
	public void setPdf_nm(String pdf_nm) {
		this.pdf_nm = pdf_nm; 
	}

	public String getPdf_fpath() { 
		return pdf_fpath; 
	}
	public void setPdf_fpath(String pdf_fpath) {
		this.pdf_fpath = pdf_fpath; 
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