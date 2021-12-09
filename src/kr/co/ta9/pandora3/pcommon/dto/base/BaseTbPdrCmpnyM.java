package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTbPdrCmpnyM - ValueObject class for table [TB_PDR_CMPNY_M].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
public class BaseTbPdrCmpnyM extends CommonBean
{
	/** cmpny_cd (CMPNY_CD) */
	private String cmpny_cd;
	/** cmpny_nm (CMPNY_NM) */
	private String cmpny_nm;
	/** biz_reg_no_val (BIZ_REG_NO_VAL) */
	private String biz_reg_no_val;
	/** cmpny_no_val (CMPNY_NO_VAL) */
	private String cmpny_no_val;
	/** rprsnt_nm (RPRSNT_NM) */
	private String rprsnt_nm;
	/** biztp_val (BIZTP_VAL) */
	private String biztp_val;
	/** bizitm_val (BIZITM_VAL) */
	private String bizitm_val;
	/** rep_telno (REP_TELNO) */
	private String rep_telno;
	/** rep_fax_telno (REP_FAX_TELNO) */
	private String rep_fax_telno;
	/** cmpny_stat_gbcd (CMPNY_STAT_GBCD) */
	private String cmpny_stat_gbcd;
	/** use_cntrt_dy (USE_CNTRT_DY) */
	private String use_cntrt_dy;
	/** fee_typ_cd (FEE_TYP_CD) */
	private String fee_typ_cd;
	/** adrs_gbcd (ADRS_GBCD) */
	private String adrs_gbcd;
	/** zipcd (ZIPCD) */
	private String zipcd;
	/** bizplc_1_adrs (BIZPLC_1_ADRS) */
	private String bizplc_1_adrs;
	/** bizplc_2_adrs (BIZPLC_2_ADRS) */
	private String bizplc_2_adrs;
	/** tpic_nm (TPIC_NM) */
	private String tpic_nm;
	/** tpic_email (TPIC_EMAIL) */
	private String tpic_email;
	/** cntrt_sta_dy (CNTRT_STA_DY) */
	private String cntrt_sta_dy;
	/** cntrt_end_dy (CNTRT_END_DY) */
	private String cntrt_end_dy;
	/** opr_mngr_pswd (OPR_MNGR_PSWD) */
	private String opr_mngr_pswd;
	/** crt_dtm (CRT_DTM) */
	private Timestamp crt_dtm;
	/** crt_id (CRT_ID) */
	private String crt_id;
	/** mdf_dtm (MDF_DTM) */
	private Timestamp mdf_dtm;
	/** mdf_id (MDF_ID) */
	private String mdf_id;

	public BaseTbPdrCmpnyM()
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

	public String getCmpny_nm() { 
		return cmpny_nm; 
	}
	public void setCmpny_nm(String cmpny_nm) {
		this.cmpny_nm = cmpny_nm; 
	}

	public String getBiz_reg_no_val() { 
		return biz_reg_no_val; 
	}
	public void setBiz_reg_no_val(String biz_reg_no_val) {
		this.biz_reg_no_val = biz_reg_no_val; 
	}

	public String getCmpny_no_val() { 
		return cmpny_no_val; 
	}
	public void setCmpny_no_val(String cmpny_no_val) {
		this.cmpny_no_val = cmpny_no_val; 
	}

	public String getRprsnt_nm() { 
		return rprsnt_nm; 
	}
	public void setRprsnt_nm(String rprsnt_nm) {
		this.rprsnt_nm = rprsnt_nm; 
	}

	public String getBiztp_val() { 
		return biztp_val; 
	}
	public void setBiztp_val(String biztp_val) {
		this.biztp_val = biztp_val; 
	}

	public String getBizitm_val() { 
		return bizitm_val; 
	}
	public void setBizitm_val(String bizitm_val) {
		this.bizitm_val = bizitm_val; 
	}

	public String getRep_telno() { 
		return rep_telno; 
	}
	public void setRep_telno(String rep_telno) {
		this.rep_telno = rep_telno; 
	}

	public String getRep_fax_telno() { 
		return rep_fax_telno; 
	}
	public void setRep_fax_telno(String rep_fax_telno) {
		this.rep_fax_telno = rep_fax_telno; 
	}

	public String getCmpny_stat_gbcd() { 
		return cmpny_stat_gbcd; 
	}
	public void setCmpny_stat_gbcd(String cmpny_stat_gbcd) {
		this.cmpny_stat_gbcd = cmpny_stat_gbcd; 
	}

	public String getUse_cntrt_dy() { 
		return use_cntrt_dy; 
	}
	public void setUse_cntrt_dy(String use_cntrt_dy) {
		this.use_cntrt_dy = use_cntrt_dy; 
	}

	public String getFee_typ_cd() { 
		return fee_typ_cd; 
	}
	public void setFee_typ_cd(String fee_typ_cd) {
		this.fee_typ_cd = fee_typ_cd; 
	}

	public String getAdrs_gbcd() { 
		return adrs_gbcd; 
	}
	public void setAdrs_gbcd(String adrs_gbcd) {
		this.adrs_gbcd = adrs_gbcd; 
	}

	public String getZipcd() { 
		return zipcd; 
	}
	public void setZipcd(String zipcd) {
		this.zipcd = zipcd; 
	}

	public String getBizplc_1_adrs() { 
		return bizplc_1_adrs; 
	}
	public void setBizplc_1_adrs(String bizplc_1_adrs) {
		this.bizplc_1_adrs = bizplc_1_adrs; 
	}

	public String getBizplc_2_adrs() { 
		return bizplc_2_adrs; 
	}
	public void setBizplc_2_adrs(String bizplc_2_adrs) {
		this.bizplc_2_adrs = bizplc_2_adrs; 
	}

	public String getTpic_nm() { 
		return tpic_nm; 
	}
	public void setTpic_nm(String tpic_nm) {
		this.tpic_nm = tpic_nm; 
	}

	public String getTpic_email() { 
		return tpic_email; 
	}
	public void setTpic_email(String tpic_email) {
		this.tpic_email = tpic_email; 
	}

	public String getCntrt_sta_dy() { 
		return cntrt_sta_dy; 
	}
	public void setCntrt_sta_dy(String cntrt_sta_dy) {
		this.cntrt_sta_dy = cntrt_sta_dy; 
	}

	public String getCntrt_end_dy() { 
		return cntrt_end_dy; 
	}
	public void setCntrt_end_dy(String cntrt_end_dy) {
		this.cntrt_end_dy = cntrt_end_dy; 
	}

	public String getOpr_mngr_pswd() { 
		return opr_mngr_pswd; 
	}
	public void setOpr_mngr_pswd(String opr_mngr_pswd) {
		this.opr_mngr_pswd = opr_mngr_pswd; 
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