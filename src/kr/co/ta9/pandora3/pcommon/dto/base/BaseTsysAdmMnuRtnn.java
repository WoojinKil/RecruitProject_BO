package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * TsysAdmMnuRtnn - ValueObject class for table [TSYS_ADM_MNU_RTNN].
 *
 * <pre>
 * 1. 클래스명 : TsysAdmMnuRtnn
 * 2. 설명 : BASE, 권리자메뉴할당 DTO
 * 3. 작성일 : 2019-03-12
 * 4. 작성자 : TANINE
 * </pre>
 *
 * @since 2019. 03. 12
 */
public class BaseTsysAdmMnuRtnn extends CommonBean
{
	/** usr_id (USR_ID) */
	private String usr_id;
	/** mnu_seq (MNU_SEQ) */
	private int mnu_seq;
	private Integer obj_mnu_seq;
	/** crtr_id (CRTR_ID) */
	private String crtr_id;
	/** crt_dttm (CRT_DTTM) */
	private Timestamp crt_dttm;
	/** updr_id (UPDR_ID) */
	private String updr_id;
	/** upd_dttm (UPD_DTTM) */
	private Timestamp upd_dttm;

	public BaseTsysAdmMnuRtnn()
	{
		super();
	}

	/**
	 * getter, setter
	 */
	public String getUsr_id() { 
		return usr_id; 
	}
	public void setUsr_id(String usr_id) {
		this.usr_id = usr_id; 
	}

	public int getMnu_seq() { 
		return mnu_seq; 
	}
	public Integer getObj_mnu_seq() {
		return obj_mnu_seq; 
	}
	
	public void setMnu_seq(int mnu_seq) {
		this.mnu_seq = mnu_seq;
		this.obj_mnu_seq = mnu_seq;
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