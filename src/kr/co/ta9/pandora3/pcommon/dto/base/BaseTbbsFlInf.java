package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTbbsFlInf - ValueObject class for table [TBBS_FL_INF].
 *
 * <pre>
 * 1. 패키지명 : kr.co.ta9.pandora3.pcommon.dto.base
 * 2. 타입명 : class
 * 3. 작성일 : 2018-02-18
 * 4. 작성자 : TA9
 * 5. 설명 : 파일 기본 DTO
 * </pre>
 */
public class BaseTbbsFlInf extends CommonBean
{
	/** fl_seq (FL_SEQ) */
	private int fl_seq;
	private Integer obj_fl_seq;
	/** doc_seq (DOC_SEQ) */
	private int doc_seq;
	private Integer obj_doc_seq;
	/** upl_trg_tp (UPL_TRG_TP) */
	private String upl_trg_tp;
	/** modl_seq (MODL_SEQ) */
	private int modl_seq;
	private Integer obj_modl_seq;
	/** usr_id (USR_ID) */
	private String usr_id;
	/** dwld_cnt (DWLD_CNT) */
	private int dwld_cnt;
	private Integer obj_dwld_cnt;
	/** ori_fl_nm (ORI_FL_NM) */
	private String ori_fl_nm;
	/** upl_fl_nm (UPL_FL_NM) */
	private String upl_fl_nm;
	/** fl_ext (FL_EXT) */
	private String fl_ext;
	/** fl_size (FL_SIZE) */
	private int fl_size;
	private Integer obj_fl_size;
	/** cmt (CMT) */
	private String cmt;
	/** vld_yn (VLD_YN) */
	private String vld_yn;
	/** ip_addr (IP_ADDR) */
	private String ip_addr;
	/** sid (SID) */
	private String sid;
	/** drc_dwld_yn (DRC_DWLD_YN) */
	private String drc_dwld_yn;
	/** thumb_yn (THUMB_YN) */
	private String thumb_yn;
	/** crtr_id (CRTR_ID) */
	private String crtr_id;
	/** crt_dttm (CRT_DTTM) */
	private Timestamp crt_dttm;
	/** updr_id (UPDR_ID) */
	private String updr_id;
	/** upd_dttm (UPD_DTTM) */
	private Timestamp upd_dttm;

	public BaseTbbsFlInf()
	{
		super();

	}

	/**
	 * getter, setter
	 */
	public int getFl_seq() { 
		return fl_seq; 
	}
	public Integer getObj_fl_seq() {
		return obj_fl_seq; 
	}
	
	public void setFl_seq(int fl_seq) {
		this.fl_seq = fl_seq;
		this.obj_fl_seq = fl_seq;
	}

	public int getDoc_seq() { 
		return doc_seq; 
	}
	public Integer getObj_doc_seq() {
		return obj_doc_seq; 
	}
	
	public void setDoc_seq(int doc_seq) {
		this.doc_seq = doc_seq;
		this.obj_doc_seq = doc_seq;
	}

	public String getUpl_trg_tp() { 
		return upl_trg_tp; 
	}
	public void setUpl_trg_tp(String upl_trg_tp) {
		this.upl_trg_tp = upl_trg_tp; 
	}

	public int getModl_seq() { 
		return modl_seq; 
	}
	public Integer getObj_modl_seq() {
		return obj_modl_seq; 
	}
	
	public void setModl_seq(int modl_seq) {
		this.modl_seq = modl_seq;
		this.obj_modl_seq = modl_seq;
	}

	public String getUsr_id() { 
		return usr_id; 
	}
	public void setUsr_id(String usr_id) {
		this.usr_id = usr_id; 
	}

	public int getDwld_cnt() { 
		return dwld_cnt; 
	}
	public Integer getObj_dwld_cnt() {
		return obj_dwld_cnt; 
	}
	
	public void setDwld_cnt(int dwld_cnt) {
		this.dwld_cnt = dwld_cnt;
		this.obj_dwld_cnt = dwld_cnt;
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

	public String getFl_ext() { 
		return fl_ext; 
	}
	public void setFl_ext(String fl_ext) {
		this.fl_ext = fl_ext; 
	}

	public int getFl_size() { 
		return fl_size; 
	}
	public Integer getObj_fl_size() {
		return obj_fl_size; 
	}
	
	public void setFl_size(int fl_size) {
		this.fl_size = fl_size;
		this.obj_fl_size = fl_size;
	}

	public String getCmt() { 
		return cmt; 
	}
	public void setCmt(String cmt) {
		this.cmt = cmt; 
	}

	public String getVld_yn() { 
		return vld_yn; 
	}
	public void setVld_yn(String vld_yn) {
		this.vld_yn = vld_yn; 
	}

	public String getIp_addr() { 
		return ip_addr; 
	}
	public void setIp_addr(String ip_addr) {
		this.ip_addr = ip_addr; 
	}

	public String getSid() { 
		return sid; 
	}
	public void setSid(String sid) {
		this.sid = sid; 
	}

	public String getDrc_dwld_yn() { 
		return drc_dwld_yn; 
	}
	public void setDrc_dwld_yn(String drc_dwld_yn) {
		this.drc_dwld_yn = drc_dwld_yn; 
	}

	public String getThumb_yn() { 
		return thumb_yn; 
	}
	public void setThumb_yn(String thumb_yn) {
		this.thumb_yn = thumb_yn; 
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