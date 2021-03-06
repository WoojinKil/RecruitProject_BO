package kr.co.ta9.pandora3.pcommon.dto;

import kr.co.ta9.pandora3.pcommon.dto.base.BaseTmbrPtnrInf;

/**
 * TmbrPtnrInf - ValueObject Extended class for table [TMBR_PTNR_INF].
 *
 * <pre>
 *     Generated by CodeProcessor. Yon can freely modify this generated file.
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
public class TmbrPtnrInf extends BaseTmbrPtnrInf {

	private String f_st_ym;
	private String f_ed_ym;
	private String f_crt_dttm;
	private int fl_seq;
	private String ori_fl_nm;
	private String upl_fl_nm;
	private String hdn_org_img_name;
	private String hdn_del_yn;
	private String uploaded_filename;
	
	public String getF_st_ym() {
		return f_st_ym;
	}
	public void setF_st_ym(String f_st_ym) {
		this.f_st_ym = f_st_ym;
	}
	public String getF_ed_ym() {
		return f_ed_ym;
	}
	public void setF_ed_ym(String f_ed_ym) {
		this.f_ed_ym = f_ed_ym;
	}
	public String getF_crt_dttm() {
		return f_crt_dttm;
	}
	public void setF_crt_dttm(String f_crt_dttm) {
		this.f_crt_dttm = f_crt_dttm;
	}
	public int getFl_seq() {
		return fl_seq;
	}
	public void setFl_seq(int fl_seq) {
		this.fl_seq = fl_seq;
	}
	public String getSrc_fl_nm() {
		return ori_fl_nm;
	}
	public void setSrc_fl_nm(String ori_fl_nm) {
		this.ori_fl_nm = ori_fl_nm;
	}
	public String getUpl_fl_nm() {
		return upl_fl_nm;
	}
	public void setUpl_fl_nm(String upl_fl_nm) {
		this.upl_fl_nm = upl_fl_nm;
	}
	public String getHdn_org_img_name() {
		return hdn_org_img_name;
	}
	public void setHdn_org_img_name(String hdn_org_img_name) {
		this.hdn_org_img_name = hdn_org_img_name;
	}
	public String getHdn_del_yn() {
		return hdn_del_yn;
	}
	public void setHdn_del_yn(String hdn_del_yn) {
		this.hdn_del_yn = hdn_del_yn;
	}
	public String getUploaded_filename() {
		return uploaded_filename;
	}
	public void setUploaded_filename(String uploaded_filename) {
		this.uploaded_filename = uploaded_filename;
	}
	
	
}