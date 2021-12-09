package kr.co.ta9.pandora3.pcommon.dto;

import kr.co.ta9.pandora3.pcommon.dto.base.BaseTbbsCmtInf;

/**
 * TbbsCmtInf - ValueObject Extended class for table [TBBS_CMT_INF].
 *
 * <pre>
 * 1. 패키지명 : kr.co.ta9.pandora3.pcommon.dto
 * 2. 타입명    : class
 * 3. 작성일    : 2018-01-10
 * 4. 설명       : 댓글 DTO
 * </pre>
 *
 * @since 2019. 02. 16
 */
public class TbbsCmtInf extends BaseTbbsCmtInf {
	
	private String tgt_id;
	private String lgn_id;
	private String f_crt_dttm;
	private String mod_able_yn;
	
	public String getTgt_id() {
		return tgt_id;
	}
	public void setTgt_id(String tgt_id) {
		this.tgt_id = tgt_id;
	}
	public String getLgn_id() {
		return lgn_id;
	}
	public void setLgn_id(String lgn_id) {
		this.lgn_id = lgn_id;
	}
	public String getF_crt_dttm() {
		return f_crt_dttm;
	}
	public void setF_crt_dttm(String f_crt_dttm) {
		this.f_crt_dttm = f_crt_dttm;
	}
	public String getMod_able_yn() {
		return mod_able_yn;
	}
	public void setMod_able_yn(String mod_able_yn) {
		this.mod_able_yn = mod_able_yn;
	}
	
	
}