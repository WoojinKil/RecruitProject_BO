package kr.co.ta9.pandora3.pcommon.dto;

import kr.co.ta9.pandora3.pcommon.dto.base.BaseTbbsDocInf;

/**
 * TbbsDocInf - ValueObject Extended class for table [TBBS_DOC_INF].
 *
 * <pre>
 *     Generated by CodeProcessor. Yon can freely modify this generated file.
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
public class TbbsDocInf extends BaseTbbsDocInf {
	private int fl_seq;
	private int fl_size;
	private String ori_fl_nm;
	private String fl_ext;
	private String fl_cnt;
	private String author;
	private String pbl_date;
	private String treatment_cd;
	private String total_page_num;
	private String contents_table;
	private String usr_nm;
	private String f_crt_dttm;
	private String treatment;
	private String tp;
	private String f_y;
	private String f_y_nm;
	private String modl_tp_cd;
	private String modl_nm;
	private String tmp_seq;
	private String upl_fl_nm;
	private String fl_srl;
	private String cd_nm;
	private String ref_1;
	private String upl_img_fl_nm;
	private String tmpl_seq;
	private String row_num;
	private String thumb_yn;
	private String doc_itm_val;
	private String eid;
	private String lang_cd;
	private String cd;
	private String var_idx;
	private String f_upd_dttm;
	private String ip_addr;
	private String usr_id;
	private String vld_yn;
	private String dwld_cnt;
	private String drc_dwld_yn;

	private String ctegry_mst_nm;
	private String ctegry_dtl_nm;
	private String f_dsply_st_dttm;
	private String f_dsply_ed_dttm;
	
	private String f_crt_dttm_2;

	private String sys_nm;
	
	private String dsply_stat;
	private String titl2;
	

	public String getDsply_stat() {
		return dsply_stat;
	}
	public void setDsply_stat(String dsply_stat) {
		this.dsply_stat = dsply_stat;
	}
	public String getF_dsply_st_dttm() {
		return f_dsply_st_dttm;
	}
	public void setF_dsply_st_dttm(String f_dsply_st_dttm) {
		this.f_dsply_st_dttm = f_dsply_st_dttm;
	}
	public String getF_dsply_ed_dttm() {
		return f_dsply_ed_dttm;
	}
	public void setF_dsply_ed_dttm(String f_dsply_ed_dttm) {
		this.f_dsply_ed_dttm = f_dsply_ed_dttm;
	}
	public String getFl_srl() {
		return fl_srl;
	}
	public void setFl_srl(String fl_srl) {
		this.fl_srl = fl_srl;
	}
	public String getFl_cnt() {
		return fl_cnt;
	}
	public void setFl_cnt(String fl_cnt) {
		this.fl_cnt = fl_cnt;
	}
	public String getTreatment_cd() {
		return treatment_cd;
	}
	public void setTreatment_cd(String treatment_cd) {
		this.treatment_cd = treatment_cd;
	}
	public String getF_y() {
		return f_y;
	}
	public void setF_y(String f_y) {
		this.f_y = f_y;
	}
	public String getF_y_nm() {
		return f_y_nm;
	}
	public void setF_y_nm(String f_y_nm) {
		this.f_y_nm = f_y_nm;
	}
	public String getUpl_img_fl_nm() {
		return upl_img_fl_nm;
	}
	public void setUpl_img_fl_nm(String upl_img_fl_nm) {
		this.upl_img_fl_nm = upl_img_fl_nm;
	}
	public String getLang_cd() {
		return lang_cd;
	}
	public void setLang_cd(String lang_cd) {
		this.lang_cd = lang_cd;
	}
	public String getThumb_yn() {
		return thumb_yn;
	}
	public void setThumb_yn(String thumb_yn) {
		this.thumb_yn = thumb_yn;
	}
	public int getFl_size() {
		return fl_size;
	}
	public void setFl_size(int fl_size) {
		this.fl_size = fl_size;
	}
	public String getDoc_itm_val() {
		return doc_itm_val;
	}
	public void setDoc_itm_val(String doc_itm_val) {
		this.doc_itm_val = doc_itm_val;
	}
	public String getEid() {
		return eid;
	}
	public void setEid(String eid) {
		this.eid = eid;
	}
	public String getCd() {
		return cd;
	}
	public void setCd(String cd) {
		this.cd = cd;
	}
	public String getVar_idx() {
		return var_idx;
	}
	public void setVar_idx(String var_idx) {
		this.var_idx = var_idx;
	}
	public String getF_upd_dttm() {
		return f_upd_dttm;
	}
	public void setF_upd_dttm(String f_upd_dttm) {
		this.f_upd_dttm = f_upd_dttm;
	}
	public String getIp_addr() {
		return ip_addr;
	}
	public void setIp_addr(String ip_addr) {
		this.ip_addr = ip_addr;
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
	public String getFl_ext() {
		return fl_ext;
	}
	public void setFl_ext(String fl_ext) {
		this.fl_ext = fl_ext;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getPbl_date() {
		return pbl_date;
	}
	public void setPbl_date(String pbl_date) {
		this.pbl_date = pbl_date;
	}
	public String getTotal_page_num() {
		return total_page_num;
	}
	public void setTotal_page_num(String total_page_num) {
		this.total_page_num = total_page_num;
	}
	public String getContents_table() {
		return contents_table;
	}
	public void setContents_table(String contents_table) {
		this.contents_table = contents_table;
	}
	public String getUsr_nm() {
		return usr_nm;
	}
	public void setUsr_nm(String usr_nm) {
		this.usr_nm = usr_nm;
	}
	public String getF_crt_dttm() {
		return f_crt_dttm;
	}
	public void setF_crt_dttm(String f_crt_dttm) {
		this.f_crt_dttm = f_crt_dttm;
	}
	public String getTreatment() {
		return treatment;
	}
	public void setTreatment(String treatment) {
		this.treatment = treatment;
	}
	public String getTp() {
		return tp;
	}
	public void setTp(String tp) {
		this.tp = tp;
	}
	public String getModl_tp_cd() {
		return modl_tp_cd;
	}
	public void setModl_tp_cd(String modl_tp_cd) {
		this.modl_tp_cd = modl_tp_cd;
	}
	public String getModl_nm() {
		return modl_nm;
	}
	public void setModl_nm(String modl_nm) {
		this.modl_nm = modl_nm;
	}
	public String getTmp_seq() {
		return tmp_seq;
	}
	public void setTmp_seq(String tmp_seq) {
		this.tmp_seq = tmp_seq;
	}
	public String getUpl_fl_nm() {
		return upl_fl_nm;
	}
	public void setUpl_fl_nm(String upl_fl_nm) {
		this.upl_fl_nm = upl_fl_nm;
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
	public String getTmpl_seq() {
		return tmpl_seq;
	}
	public void setTmpl_seq(String tmpl_seq) {
		this.tmpl_seq = tmpl_seq;
	}
	public String getRow_num() {
		return row_num;
	}
	public void setRow_num(String row_num) {
		this.row_num = row_num;
	}
	public String getUsr_id() {
		return usr_id;
	}
	public void setUsr_id(String usr_id) {
		this.usr_id = usr_id;
	}
	public String getVld_yn() {
		return vld_yn;
	}
	public void setVld_yn(String vld_yn) {
		this.vld_yn = vld_yn;
	}
	public String getDwld_cnt() {
		return dwld_cnt;
	}
	public String getCtegry_mst_nm() {
		return ctegry_mst_nm;
	}
	public void setCtegry_mst_nm(String ctegry_mst_nm) {
		this.ctegry_mst_nm = ctegry_mst_nm;
	}
	public void setDwld_cnt(String dwld_cnt) {
		this.dwld_cnt = dwld_cnt;
	}
	public String getDrc_dwld_yn() {
		return drc_dwld_yn;
	}
	public void setDrc_dwld_yn(String drc_dwld_yn) {
		this.drc_dwld_yn = drc_dwld_yn;
	}
	public String getCtegry_dtl_nm() {
		return ctegry_dtl_nm;
	}
	public void setCtegry_dtl_nm(String ctegry_dtl_nm) {
		this.ctegry_dtl_nm = ctegry_dtl_nm;
	}
	public String getTitl2() {
		return titl2;
	}
	public void setTitl2(String titl2) {
		this.titl2 = titl2;
	}
	public String getSys_nm() {
		return sys_nm;
	}
	public void setSys_nm(String sys_nm) {
		this.sys_nm = sys_nm;
	}
	public String getF_crt_dttm_2() {
		return f_crt_dttm_2;
	}
	public void setF_crt_dttm_2(String f_crt_dttm_2) {
		this.f_crt_dttm_2 = f_crt_dttm_2;
	}
	
	
	
	

}