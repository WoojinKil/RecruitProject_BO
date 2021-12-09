package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * TsysAdmMnu - ValueObject class for table [TSYS_ADM_MNU].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
public class BaseTsysAdmMnu extends CommonBean
{
	/** mnu_seq (MNU_SEQ) */
	private int mnu_seq;
	private Integer obj_mnu_seq;
	/** up_mnu_seq (UP_MNU_SEQ) */
	private int up_mnu_seq;
	private Integer obj_up_mnu_seq;
	/** mnu_nm (MNU_NM) */
	private String mnu_nm;
	/** mnu_dpth (MNU_DPTH) */
	private int mnu_dpth;
	private Integer obj_mnu_dpth;
	/** frnt_yn (FRNT_YN) */
	private String frnt_yn;
	/** stf_only_yn (STF_ONLY_YN) */
	private String stf_only_yn;
	/** url (URL) */
	private String url;
	/** mnu_tp_cd (MNU_TP_CD) */
	private String mnu_tp_cd;
	/** mnu_yn (MNU_YN) */
	private String mnu_yn;
	/** us_yn (US_YN) */
	private String us_yn;
	/** lst_mnu_yn (LST_MNU_YN) */
	private String lst_mnu_yn;
	/** srt_seq (SRT_SEQ) */
	private int srt_seq;
	private Integer obj_srt_seq;
	/** mnul_id (MNUL_ID) */
	private String mnul_id;
	/** mnu_desc (MNU_DESC) */
	private String mnu_desc;
	/** pgm_id (PGM_ID) */
	private String pgm_id;
	/** sys_cd (SYS_CD) */
	private String sys_cd;
	/** crtr_id (CRTR_ID) */
	private String crtr_id;
	/** crt_dttm (CRT_DTTM) */
	private Timestamp crt_dttm;
	/** updr_id (UPDR_ID) */
	private String updr_id;
	/** upd_dttm (UPD_DTTM) */
	private Timestamp upd_dttm;
	/** prn_inf_scrn_yn (PRN_INF_SCRN_YN) */
	private String prn_inf_scrn_yn;
	/** vdi_scrn_yn (VDI_SCRN_YN) */
	private String vdi_scrn_yn;
	

	public BaseTsysAdmMnu()
	{
		super();

	}

	/**
	 * getter, setter
	 */
	
	
	
	public int getMnu_seq() { 
		return mnu_seq; 
	}
	public String getPrn_inf_scrn_yn() {
		return prn_inf_scrn_yn;
	}

	public void setPrn_inf_scrn_yn(String prn_inf_scrn_yn) {
		this.prn_inf_scrn_yn = prn_inf_scrn_yn;
	}

	public String getVdi_scrn_yn() {
		return vdi_scrn_yn;
	}

	public void setVdi_scrn_yn(String vdi_scrn_yn) {
		this.vdi_scrn_yn = vdi_scrn_yn;
	}

	public Integer getObj_mnu_seq() {
		return obj_mnu_seq; 
	}
	
	public void setMnu_seq(int mnu_seq) {
		this.mnu_seq = mnu_seq;
		this.obj_mnu_seq = mnu_seq;
	}

	public int getUp_mnu_seq() { 
		return up_mnu_seq; 
	}
	public Integer getObj_up_mnu_seq() {
		return obj_up_mnu_seq; 
	}
	
	public void setUp_mnu_seq(int up_mnu_seq) {
		this.up_mnu_seq = up_mnu_seq;
		this.obj_up_mnu_seq = up_mnu_seq;
	}

	public String getMnu_nm() { 
		return mnu_nm; 
	}
	public void setMnu_nm(String mnu_nm) {
		this.mnu_nm = mnu_nm; 
	}

	public int getMnu_dpth() { 
		return mnu_dpth; 
	}
	public Integer getObj_mnu_dpth() {
		return obj_mnu_dpth; 
	}
	
	public void setMnu_dpth(int mnu_dpth) {
		this.mnu_dpth = mnu_dpth;
		this.obj_mnu_dpth = mnu_dpth;
	}

	public String getFrnt_yn() { 
		return frnt_yn; 
	}
	public void setFrnt_yn(String frnt_yn) {
		this.frnt_yn = frnt_yn; 
	}

	public String getStf_only_yn() { 
		return stf_only_yn; 
	}
	public void setStf_only_yn(String stf_only_yn) {
		this.stf_only_yn = stf_only_yn; 
	}

	public String getUrl() { 
		return url; 
	}
	public void setUrl(String url) {
		this.url = url; 
	}

	public String getMnu_tp_cd() { 
		return mnu_tp_cd; 
	}
	public void setMnu_tp_cd(String mnu_tp_cd) {
		this.mnu_tp_cd = mnu_tp_cd; 
	}

	public String getMnu_yn() { 
		return mnu_yn; 
	}
	public void setMnu_yn(String mnu_yn) {
		this.mnu_yn = mnu_yn; 
	}

	public String getUs_yn() { 
		return us_yn; 
	}
	public void setUs_yn(String us_yn) {
		this.us_yn = us_yn; 
	}

	public String getLst_mnu_yn() { 
		return lst_mnu_yn; 
	}
	public void setLst_mnu_yn(String lst_mnu_yn) {
		this.lst_mnu_yn = lst_mnu_yn; 
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

	public String getMnul_id() { 
		return mnul_id; 
	}
	public void setMnul_id(String mnul_id) {
		this.mnul_id = mnul_id; 
	}

	public String getMnu_desc() { 
		return mnu_desc; 
	}
	public void setMnu_desc(String mnu_desc) {
		this.mnu_desc = mnu_desc; 
	}

	public String getPgm_id() { 
		return pgm_id; 
	}
	public void setPgm_id(String pgm_id) {
		this.pgm_id = pgm_id; 
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

	public String getSys_cd() {
		return sys_cd;
	}

	public void setSys_cd(String sys_cd) {
		this.sys_cd = sys_cd;
	}
}