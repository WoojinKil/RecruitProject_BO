package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTbbsCtegryDtl - ValueObject class for table [TBBS_CTEGRY_DTL].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 12. 16
 */
public class BaseTbbsCtegryDtl extends CommonBean
{
	/** ctegry_mst_cd (ctegry_mst_cd) */
	private String ctegry_mst_cd;
	/** ctegry_dtl_cd (ctegry_dtl_cd) */
	private String ctegry_dtl_cd;
	/** ctegry_dtl_nm (ctegry_dtl_nm) */
	private String ctegry_dtl_nm;
	/** ref_val1 (ref_val1) */
	private String ref_val1;
	/** ref_val2 (ref_val2) */
	private String ref_val2;
	/** ref_val3 (ref_val3) */
	private String ref_val3;
	/** srt_seq (srt_seq) */
	private int srt_seq;
	/** us_yn (us_yn) */
	private String us_yn;
	/** crtr_id (crtr_id) */
	private String crtr_id;
	/** crt_dttm (crt_dttm) */
	private Timestamp crt_dttm;
	/** updr_id (updr_id) */
	private String updr_id;
	/** upd_dttm (upd_dttm) */
	private Timestamp upd_dttm;

	public BaseTbbsCtegryDtl()
	{
		super();

	}

	/**
	 * getter, setter
	 */
	public String getCtegry_mst_cd() { 
		return ctegry_mst_cd; 
	}
	public void setCtegry_mst_cd(String ctegry_mst_cd) {
		this.ctegry_mst_cd = ctegry_mst_cd; 
	}

	public String getCtegry_dtl_cd() { 
		return ctegry_dtl_cd; 
	}
	public void setCtegry_dtl_cd(String ctegry_dtl_cd) {
		this.ctegry_dtl_cd = ctegry_dtl_cd; 
	}

	public String getCtegry_dtl_nm() { 
		return ctegry_dtl_nm; 
	}
	public void setCtegry_dtl_nm(String ctegry_dtl_nm) {
		this.ctegry_dtl_nm = ctegry_dtl_nm; 
	}

	public String getRef_val1() { 
		return ref_val1; 
	}
	public void setRef_val1(String ref_val1) {
		this.ref_val1 = ref_val1; 
	}

	public String getRef_val2() { 
		return ref_val2; 
	}
	public void setRef_val2(String ref_val2) {
		this.ref_val2 = ref_val2; 
	}

	public String getRef_val3() { 
		return ref_val3; 
	}
	public void setRef_val3(String ref_val3) {
		this.ref_val3 = ref_val3; 
	}

	public int getSrt_seq() { 
		return srt_seq; 
	}
	
	public void setSrt_seq(int srt_seq) {
		this.srt_seq = srt_seq;
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