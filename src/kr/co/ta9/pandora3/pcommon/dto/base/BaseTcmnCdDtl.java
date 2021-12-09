package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTcmnCdDtl - ValueObject class for table [TCMN_CD_DTL].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
public class BaseTcmnCdDtl extends CommonBean
{
	/** mst_cd (MST_CD) */
	private String mst_cd;
	/** cd (CD) */
	private String cd;
	/** cd_nm (CD_NM) */
	private String cd_nm;
	/** ref_1 (REF_1) */
	private String ref_1;
	/** ref_2 (REF_2) */
	private String ref_2;
	/** ref_3 (REF_3) */
	private String ref_3;
	/** us_yn (US_YN) */
	private String us_yn;
	/** srt_seq (SRT_SEQ) */
	private int srt_seq;
	private Integer obj_srt_seq;
	/** cd_desc (CD_DESC) */
	private String cd_desc;
	/** crtr_id (CRTR_ID) */
	private String crtr_id;
	/** crt_dttm (CRT_DTTM) */
	private Timestamp crt_dttm;
	/** updr_id (UPDR_ID) */
	private String updr_id;
	/** upd_dttm (UPD_DTTM) */
	private Timestamp upd_dttm;

	public BaseTcmnCdDtl()
	{
		super();

	}

	/**
	 * getter, setter
	 */
	public String getMst_cd() { 
		return mst_cd; 
	}
	public void setMst_cd(String mst_cd) {
		this.mst_cd = mst_cd; 
	}

	public String getCd() { 
		return cd; 
	}
	public void setCd(String cd) {
		this.cd = cd; 
	}

	public String getCd_nm() { 
		return cd_nm; 
	}
	public void setCd_nm(String cd_nm) {
		this.cd_nm = cd_nm; 
	}

	public String getRef_1() { 
		return ref_1; 
	}
	public void setRef_1(String ref_1) {
		this.ref_1 = ref_1; 
	}

	public String getRef_2() { 
		return ref_2; 
	}
	public void setRef_2(String ref_2) {
		this.ref_2 = ref_2; 
	}

	public String getRef_3() { 
		return ref_3; 
	}
	public void setRef_3(String ref_3) {
		this.ref_3 = ref_3; 
	}

	public String getUs_yn() { 
		return us_yn; 
	}
	public void setUs_yn(String us_yn) {
		this.us_yn = us_yn; 
	}

	public int getSrt_sqn() { 
		return srt_seq; 
	}
	public Integer getObj_srt_seq() {
		return obj_srt_seq; 
	}
	
	public void setSrt_sqn(int srt_seq) {
		this.srt_seq = srt_seq;
		this.obj_srt_seq = srt_seq;
	}

	public String getCd_desc() { 
		return cd_desc; 
	}
	public void setCd_desc(String cd_desc) {
		this.cd_desc = cd_desc; 
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