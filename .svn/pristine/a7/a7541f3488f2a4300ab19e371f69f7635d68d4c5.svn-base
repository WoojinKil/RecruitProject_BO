package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTmbrConnLog - ValueObject class for table [TMBR_CONN_LOG].
 *
 * <pre>
 * 1. 패키지명 : kr.co.ta9.pandora3.pcommon.dto.base
 * 2. 타입명 : class
 * 3. 작성일 : 2018-02-18
 * 4. 작성자 : TA9
 * 5. 설명 : 사용자 접속 LOG 기본 DTO
 * </pre>
 *
 * @since 2019. 02. 15
 */
public class BaseTmbrConnLog extends CommonBean
{
	/** conn_seq (CONN_SEQ) */
	private int conn_seq;
	private Integer obj_conn_seq;
	/** ip_addr (IP_ADDR) */
	private String ip_addr;
	/** usr_agt (USR_AGT) */
	private String usr_agt;
	/** crtr_id (CRTR_ID) */
	private String crtr_id;
	/** crt_dttm (CRT_DTTM) */
	private Timestamp crt_dttm;

	public BaseTmbrConnLog()
	{
		super();

	}

	/**
	 * getter, setter
	 */
	public int getConn_seq() { 
		return conn_seq; 
	}
	public Integer getObj_conn_seq() {
		return obj_conn_seq; 
	}
	
	public void setConn_seq(int conn_seq) {
		this.conn_seq = conn_seq;
		this.obj_conn_seq = conn_seq;
	}

	public String getIp_addr() { 
		return ip_addr; 
	}
	public void setIp_addr(String ip_addr) {
		this.ip_addr = ip_addr; 
	}

	public String getUsr_agt() { 
		return usr_agt; 
	}
	public void setUsr_agt(String usr_agt) {
		this.usr_agt = usr_agt; 
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

}