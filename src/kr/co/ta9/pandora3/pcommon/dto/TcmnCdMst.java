package kr.co.ta9.pandora3.pcommon.dto;

import kr.co.ta9.pandora3.pcommon.dto.base.BaseTcmnCdMst;

/**
 * TcmnCdMst - ValueObject Extended class for table [TCMN_CD_MST].
 *
 * <pre>
 * 1. 패키지명 : kr.co.ta9.pandora3.pcommon.dto
 * 2. 타입명 : class
 * 3. 작성일 : 2018-02-18
 * 4. 작성자 : TA9
 * 5. 설명 : 시스템 코드 마스터 DTO
 * </pre>
 */
public class TcmnCdMst extends BaseTcmnCdMst {

	private String F_UPD_DTTM;

	public String getF_UPD_DTTM() {
		return F_UPD_DTTM;
	}

	public void setF_UPD_DTTM(String f_UPD_DTTM) {
		F_UPD_DTTM = f_UPD_DTTM;
	}


	
}