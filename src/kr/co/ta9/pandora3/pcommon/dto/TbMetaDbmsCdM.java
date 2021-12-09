package kr.co.ta9.pandora3.pcommon.dto;

import kr.co.ta9.pandora3.pcommon.dto.base.BaseTbMetaDbmsCdM;

/**
 * TbMetaDbmsCdM - ValueObject Extended class for table [TB_META_DBMS_CD_M].
 *
 * <pre>
 *     Generated by CodeProcessor. Yon can freely modify this generated file.
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
public class TbMetaDbmsCdM extends BaseTbMetaDbmsCdM {
	/** crtr_id (CRTR_ID) */
	private String crtr_id;
	
	/** updr_id (UPDR_ID) */
	private String updr_id;

	public String getCrtr_id() {
		return crtr_id;
	}

	public void setCrtr_id(String crtr_id) {
		this.crtr_id = crtr_id;
	}

	public String getUpdr_id() {
		return updr_id;
	}

	public void setUpdr_id(String updr_id) {
		this.updr_id = updr_id;
	}
}