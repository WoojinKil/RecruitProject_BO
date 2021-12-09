package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTcmnCdMst - ValueObject class for table [TCMN_CD_MST].
 *
 * <pre>
 * 1. 패키지명 : kr.co.ta9.pandora3.pcommon.dto.base
 * 2. 타입명 : class
 * 3. 작성일 : 2018-02-18
 * 4. 작성자 : TA9
 * 5. 설명 : 시스템 코드 마스터 기본 DTO
 * </pre>
 */
public class BaseTcmnCdMst extends CommonBean
{
	/** mst_cd (MST_CD) */
	private String mst_cd;
	/** mst_cd_nm (MST_CD_NM) */
	private String mst_cd_nm;
	/** mst_cd_desc (MST_CD_DESC) */
	private String mst_cd_desc;
	/** srt_seq (SRT_SEQ) */
	private int srt_seq;
	private Integer obj_srt_seq;
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

	public BaseTcmnCdMst()
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

	public String getMst_cd_nm() { 
		return mst_cd_nm; 
	}
	public void setMst_cd_nm(String mst_cd_nm) {
		this.mst_cd_nm = mst_cd_nm; 
	}

	public String getMst_cd_desc() { 
		return mst_cd_desc; 
	}
	public void setMst_cd_desc(String mst_cd_desc) {
		this.mst_cd_desc = mst_cd_desc; 
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