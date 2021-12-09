package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTmbrConnStts - ValueObject class for table [TMBR_CONN_STTS].
 *
 * <pre>
 * 1. 패키지명 : kr.co.ta9.pandora3.pcommon.dto.base
 * 2. 타입명 : class
 * 3. 작성일 : 2018-02-18
 * 4. 작성자 : TA9
 * 5. 설명 : 사용자 접속 상태 기본 DTO
 * </pre>
 */
public class BaseTmbrConnStts extends CommonBean
{
	/** crt_dttm (CRT_DTTM) */
	private int crt_dttm;
	private Integer obj_crt_dttm;
	/** visr_cnt (VISR_CNT) */
	private int visr_cnt;
	private Integer obj_visr_cnt;
	/** scrn_acs_cnt (SCRN_ACS_CNT) */
	private int scrn_acs_cnt;
	private Integer obj_scrn_acs_cnt;

	public BaseTmbrConnStts()
	{
		super();

	}

	/**
	 * getter, setter
	 */
	public int getCrt_dttm() { 
		return crt_dttm; 
	}
	public Integer getObj_crt_dttm() {
		return obj_crt_dttm; 
	}
	
	public void setCrt_dttm(int crt_dttm) {
		this.crt_dttm = crt_dttm;
		this.obj_crt_dttm = crt_dttm;
	}

	public int getVisr_cnt() { 
		return visr_cnt; 
	}
	public Integer getObj_visr_cnt() {
		return obj_visr_cnt; 
	}
	
	public void setVisr_cnt(int visr_cnt) {
		this.visr_cnt = visr_cnt;
		this.obj_visr_cnt = visr_cnt;
	}

	public int getScrn_acs_cnt() { 
		return scrn_acs_cnt; 
	}
	public Integer getObj_scrn_acs_cnt() {
		return obj_scrn_acs_cnt; 
	}
	
	public void setScrn_acs_cnt(int scrn_acs_cnt) {
		this.scrn_acs_cnt = scrn_acs_cnt;
		this.obj_scrn_acs_cnt = scrn_acs_cnt;
	}

}