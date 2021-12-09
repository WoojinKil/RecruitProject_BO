package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTbPdrStafM - ValueObject class for table [TB_PDR_STAF_M].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 21
 */
public class BaseTbPdrStafM extends CommonBean
{
	/** cmpny_cd (CMPNY_CD) */
	private String cmpny_cd;
	/** empno (EMPNO) */
	private String empno;
	/** emp_nm (EMP_NM) */
	private String emp_nm;
	/** bir_day (BIR_DAY) */
	private String bir_day;
	/** emp_gndr_gbcd (EMP_GNDR_GBCD) */
	private String emp_gndr_gbcd;
	/** tel_1_val (TEL_1_VAL) */
	private String tel_1_val;
	/** tel_2_val (TEL_2_VAL) */
	private String tel_2_val;
	/** em_tel_val (EM_TEL_VAL) */
	private String em_tel_val;
	/** rsd_zipcd (RSD_ZIPCD) */
	private String rsd_zipcd;
	/** rsd_adrs (RSD_ADRS) */
	private String rsd_adrs;
	/** rsd_dtl_adrs (RSD_DTL_ADRS) */
	private String rsd_dtl_adrs;
	/** div_cd (DIV_CD) */
	private String div_cd;
	/** staflevel_cd (STAFLEVEL_CD) */
	private String staflevel_cd;
	/** staflevel_val (STAFLEVEL_VAL) */
	private String staflevel_val;
	/** stafduty_cd (STAFDUTY_CD) */
	private String stafduty_cd;
	/** tech_stafjob_cd (TECH_STAFJOB_CD) */
	private String tech_stafjob_cd;
	/** tech_grd_cd (TECH_GRD_CD) */
	private String tech_grd_cd;
	/** staf_stafjob_cd (STAF_STAFJOB_CD) */
	private String staf_stafjob_cd;
	/** staf_email (STAF_EMAIL) */
	private String staf_email;
	/** ho_stat_gbcd (HO_STAT_GBCD) */
	private String ho_stat_gbcd;
	/** jc_day (JC_DAY) */
	private String jc_day;
	/** la_day (LA_DAY) */
	private String la_day;
	/** lc_day (LC_DAY) */
	private String lc_day;
	/** crt_dtm (CRT_DTM) */
	private Timestamp crt_dtm;
	/** crt_id (CRT_ID) */
	private String crt_id;
	/** mdf_dtm (MDF_DTM) */
	private Timestamp mdf_dtm;
	/** mdf_id (MDF_ID) */
	private String mdf_id;

	public BaseTbPdrStafM()
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

	public String getEmpno() { 
		return empno; 
	}
	public void setEmpno(String empno) {
		this.empno = empno; 
	}

	public String getEmp_nm() { 
		return emp_nm; 
	}
	public void setEmp_nm(String emp_nm) {
		this.emp_nm = emp_nm; 
	}

	public String getBir_day() { 
		return bir_day; 
	}
	public void setBir_day(String bir_day) {
		this.bir_day = bir_day; 
	}

	public String getEmp_gndr_gbcd() { 
		return emp_gndr_gbcd; 
	}
	public void setEmp_gndr_gbcd(String emp_gndr_gbcd) {
		this.emp_gndr_gbcd = emp_gndr_gbcd; 
	}

	public String getTel_1_val() { 
		return tel_1_val; 
	}
	public void setTel_1_val(String tel_1_val) {
		this.tel_1_val = tel_1_val; 
	}

	public String getTel_2_val() { 
		return tel_2_val; 
	}
	public void setTel_2_val(String tel_2_val) {
		this.tel_2_val = tel_2_val; 
	}

	public String getEm_tel_val() { 
		return em_tel_val; 
	}
	public void setEm_tel_val(String em_tel_val) {
		this.em_tel_val = em_tel_val; 
	}

	public String getRsd_zipcd() { 
		return rsd_zipcd; 
	}
	public void setRsd_zipcd(String rsd_zipcd) {
		this.rsd_zipcd = rsd_zipcd; 
	}

	public String getRsd_adrs() { 
		return rsd_adrs; 
	}
	public void setRsd_adrs(String rsd_adrs) {
		this.rsd_adrs = rsd_adrs; 
	}

	public String getRsd_dtl_adrs() { 
		return rsd_dtl_adrs; 
	}
	public void setRsd_dtl_adrs(String rsd_dtl_adrs) {
		this.rsd_dtl_adrs = rsd_dtl_adrs; 
	}

	public String getDiv_cd() { 
		return div_cd; 
	}
	public void setDiv_cd(String div_cd) {
		this.div_cd = div_cd; 
	}

	public String getStaflevel_cd() { 
		return staflevel_cd; 
	}
	public void setStaflevel_cd(String staflevel_cd) {
		this.staflevel_cd = staflevel_cd; 
	}

	public String getStaflevel_val() { 
		return staflevel_val; 
	}
	public void setStaflevel_val(String staflevel_val) {
		this.staflevel_val = staflevel_val; 
	}

	public String getStafduty_cd() { 
		return stafduty_cd; 
	}
	public void setStafduty_cd(String stafduty_cd) {
		this.stafduty_cd = stafduty_cd; 
	}

	public String getTech_stafjob_cd() { 
		return tech_stafjob_cd; 
	}
	public void setTech_stafjob_cd(String tech_stafjob_cd) {
		this.tech_stafjob_cd = tech_stafjob_cd; 
	}

	public String getTech_grd_cd() { 
		return tech_grd_cd; 
	}
	public void setTech_grd_cd(String tech_grd_cd) {
		this.tech_grd_cd = tech_grd_cd; 
	}

	public String getStaf_stafjob_cd() { 
		return staf_stafjob_cd; 
	}
	public void setStaf_stafjob_cd(String staf_stafjob_cd) {
		this.staf_stafjob_cd = staf_stafjob_cd; 
	}

	public String getStaf_email() { 
		return staf_email; 
	}
	public void setStaf_email(String staf_email) {
		this.staf_email = staf_email; 
	}

	public String getHo_stat_gbcd() { 
		return ho_stat_gbcd; 
	}
	public void setHo_stat_gbcd(String ho_stat_gbcd) {
		this.ho_stat_gbcd = ho_stat_gbcd; 
	}

	public String getJc_day() { 
		return jc_day; 
	}
	public void setJc_day(String jc_day) {
		this.jc_day = jc_day; 
	}

	public String getLa_day() { 
		return la_day; 
	}
	public void setLa_day(String la_day) {
		this.la_day = la_day; 
	}

	public String getLc_day() { 
		return lc_day; 
	}
	public void setLc_day(String lc_day) {
		this.lc_day = lc_day; 
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