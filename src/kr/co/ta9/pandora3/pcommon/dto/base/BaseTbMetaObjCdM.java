package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTbMetaObjCdM - ValueObject class for table [TB_META_OBJ_CD_M].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
public class BaseTbMetaObjCdM extends CommonBean
{
	/** cmpny_cd (CMPNY_CD) */
	private String cmpny_cd;
	/** obj_gbcd (OBJ_GBCD) */
	private String obj_gbcd;
	/** nmg_max_wdh (NMG_MAX_WDH) */
	private int nmg_max_wdh;
	private Integer obj_nmg_max_wdh;
	/** prfx_cd (PRFX_CD) */
	private String prfx_cd;
	/** regrt_empno (REGRT_EMPNO) */
	private String regrt_empno;
	/** reg_dy (REG_DY) */
	private String reg_dy;
	/** us_yn (US_YN) */
	private String us_yn;
	/** crt_dtm (CRT_DTM) */
	private Timestamp crt_dtm;
	/** crt_id (CRT_ID) */
	private String crt_id;
	/** mdf_dtm (MDF_DTM) */
	private Timestamp mdf_dtm;
	/** mdf_id (MDF_ID) */
	private String mdf_id;

	public BaseTbMetaObjCdM()
	{
		super();

	}

	/**
	 * getter, setter
	 */
	public String getCmpny_cd() { 
		return cmpny_cd; 
	}
	public void setCmpny_cd(String cmpny_cd) {
		this.cmpny_cd = cmpny_cd; 
	}

	public String getObj_gbcd() { 
		return obj_gbcd; 
	}
	public void setObj_gbcd(String obj_gbcd) {
		this.obj_gbcd = obj_gbcd; 
	}

	public int getNmg_max_wdh() { 
		return nmg_max_wdh; 
	}
	public Integer getObj_nmg_max_wdh() {
		return obj_nmg_max_wdh; 
	}
	
	public void setNmg_max_wdh(int nmg_max_wdh) {
		this.nmg_max_wdh = nmg_max_wdh;
		this.obj_nmg_max_wdh = nmg_max_wdh;
	}

	public String getPrfx_cd() { 
		return prfx_cd; 
	}
	public void setPrfx_cd(String prfx_cd) {
		this.prfx_cd = prfx_cd; 
	}

	public String getRegrt_empno() { 
		return regrt_empno; 
	}
	public void setRegrt_empno(String regrt_empno) {
		this.regrt_empno = regrt_empno; 
	}

	public String getReg_dy() { 
		return reg_dy; 
	}
	public void setReg_dy(String reg_dy) {
		this.reg_dy = reg_dy; 
	}

	public String getUs_yn() { 
		return us_yn; 
	}
	public void setUs_yn(String us_yn) {
		this.us_yn = us_yn; 
	}

	public Timestamp getCrt_dtm() { 
		return crt_dtm; 
	}
	public void setCrt_dtm(Timestamp crt_dtm) {
		this.crt_dtm = crt_dtm; 
	}

	public String getCrt_id() { 
		return crt_id; 
	}
	public void setCrt_id(String crt_id) {
		this.crt_id = crt_id; 
	}

	public Timestamp getMdf_dtm() { 
		return mdf_dtm; 
	}
	public void setMdf_dtm(Timestamp mdf_dtm) {
		this.mdf_dtm = mdf_dtm; 
	}

	public String getMdf_id() { 
		return mdf_id; 
	}
	public void setMdf_id(String mdf_id) {
		this.mdf_id = mdf_id; 
	}

}