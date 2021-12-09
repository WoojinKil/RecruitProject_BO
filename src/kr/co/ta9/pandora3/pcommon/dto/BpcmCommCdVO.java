package kr.co.ta9.pandora3.pcommon.dto;

import kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * TbbsCmtInf - ValueObject Extended class for table [TBBS_CMT_INF].
 *
 * <pre>
 * 1. 패키지명 : kr.co.ta9.pandora3.pcommon.dto
 * 2. 타입명    : class
 * 3. 작성일    : 2018-01-10
 * 4. 설명       : 팝업 DTO
 * </pre>
 *
 * @since 2019. 02. 16
 */
public class BpcmCommCdVO extends CommonBean {
	 

    private String dtl_cd;       /**공통코드*/
    private String dtl_cd_nm;    /**공통코드명*/

    
	public String getDtl_cd() {
		return dtl_cd;
	}
	public void setDtl_cd(String dtl_cd) {
		this.dtl_cd = dtl_cd;
	}
	public String getDtl_cd_nm() {
		return dtl_cd_nm;
	}
	public void setDtl_cd_nm(String dtl_cd_nm) {
		this.dtl_cd_nm = dtl_cd_nm;
	}
}