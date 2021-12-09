package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTsysBatchLog - ValueObject class for table [TSYS_BATCH_LOG].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 05. 27
 */
public class BaseTsysBatchLog extends CommonBean
{
	/** log_seq (LOG_SEQ) */
	private int log_seq;
	private Integer obj_log_seq;
	/** batch_seq (BATCH_SEQ) */
	private int batch_seq;
	private Integer obj_batch_seq;
	/** batch_rslt_cd (BATCH_RSLT_CD) */
	private String batch_rslt_cd;
	/** batch_log_1_cts (BATCH_LOG_1_CTS) */
	private String batch_log_1_cts;
	/** batch_log_2_cts (BATCH_LOG_2_CTS) */
	private String batch_log_2_cts;
	/** batch_st_dt (BATCH_ST_DT) */
	private Timestamp batch_st_dt;
	/** batch_ed_dt (BATCH_ED_DT) */
	private Timestamp batch_ed_dt;
	/** batch_wrk_st_dt (BATCH_WRK_ST_DT) */
	private String batch_wrk_st_dt;
	/** batch_wrk_ed_dt (BATCH_WRK_ED_DT) */
	private String batch_wrk_ed_dt;
	/** select_cnt (SELECT_CNT) */
	private int select_cnt;
	private Integer obj_select_cnt;
	/** update_cnt (UPDATE_CNT) */
	private int update_cnt;
	private Integer obj_update_cnt;
	/** delete_cnt (DELETE_CNT) */
	private int delete_cnt;
	private Integer obj_delete_cnt;
	/** insert_cnt (INSERT_CNT) */
	private int insert_cnt;
	private Integer obj_insert_cnt;
	/** crtr_id (CRTR_ID) */
	private String crtr_id;
	/** crt_dttm (CRT_DTTM) */
	private Timestamp crt_dttm;
	/** updr_id (UPDR_ID) */
	private String updr_id;
	/** upd_dttm (UPD_DTTM) */
	private Timestamp upd_dttm;

	public BaseTsysBatchLog()
	{
		super();

	}

	/**
	 * getter, setter
	 */
	public int getLog_seq() { 
		return log_seq; 
	}
	public Integer getObj_log_seq() {
		return obj_log_seq; 
	}
	
	public void setLog_seq(int log_seq) {
		this.log_seq = log_seq;
		this.obj_log_seq = log_seq;
	}

	public int getBatch_seq() { 
		return batch_seq; 
	}
	public Integer getObj_batch_seq() {
		return obj_batch_seq; 
	}
	
	public void setBatch_seq(int batch_seq) {
		this.batch_seq = batch_seq;
		this.obj_batch_seq = batch_seq;
	}

	public String getBatch_rslt_cd() { 
		return batch_rslt_cd; 
	}
	public void setBatch_rslt_cd(String batch_rslt_cd) {
		this.batch_rslt_cd = batch_rslt_cd; 
	}

	public String getBatch_log_1_cts() { 
		return batch_log_1_cts; 
	}
	public void setBatch_log_1_cts(String batch_log_1_cts) {
		this.batch_log_1_cts = batch_log_1_cts; 
	}

	public String getBatch_log_2_cts() { 
		return batch_log_2_cts; 
	}
	public void setBatch_log_2_cts(String batch_log_2_cts) {
		this.batch_log_2_cts = batch_log_2_cts; 
	}

	public Timestamp getBatch_st_dt() { 
		return batch_st_dt; 
	}
	public void setBatch_st_dt(Timestamp batch_st_dt) {
		this.batch_st_dt = batch_st_dt; 
	}

	public Timestamp getBatch_ed_dt() { 
		return batch_ed_dt; 
	}
	public void setBatch_ed_dt(Timestamp batch_ed_dt) {
		this.batch_ed_dt = batch_ed_dt; 
	}

	public String getBatch_wrk_st_dt() { 
		return batch_wrk_st_dt; 
	}
	public void setBatch_wrk_st_dt(String batch_wrk_st_dt) {
		this.batch_wrk_st_dt = batch_wrk_st_dt; 
	}

	public String getBatch_wrk_ed_dt() { 
		return batch_wrk_ed_dt; 
	}
	public void setBatch_wrk_ed_dt(String batch_wrk_ed_dt) {
		this.batch_wrk_ed_dt = batch_wrk_ed_dt; 
	}

	public int getSelect_cnt() { 
		return select_cnt; 
	}
	public Integer getObj_select_cnt() {
		return obj_select_cnt; 
	}
	
	public void setSelect_cnt(int select_cnt) {
		this.select_cnt = select_cnt;
		this.obj_select_cnt = select_cnt;
	}

	public int getUpdate_cnt() { 
		return update_cnt; 
	}
	public Integer getObj_update_cnt() {
		return obj_update_cnt; 
	}
	
	public void setUpdate_cnt(int update_cnt) {
		this.update_cnt = update_cnt;
		this.obj_update_cnt = update_cnt;
	}

	public int getDelete_cnt() { 
		return delete_cnt; 
	}
	public Integer getObj_delete_cnt() {
		return obj_delete_cnt; 
	}
	
	public void setDelete_cnt(int delete_cnt) {
		this.delete_cnt = delete_cnt;
		this.obj_delete_cnt = delete_cnt;
	}

	public int getInsert_cnt() { 
		return insert_cnt; 
	}
	public Integer getObj_insert_cnt() {
		return obj_insert_cnt; 
	}
	
	public void setInsert_cnt(int insert_cnt) {
		this.insert_cnt = insert_cnt;
		this.obj_insert_cnt = insert_cnt;
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