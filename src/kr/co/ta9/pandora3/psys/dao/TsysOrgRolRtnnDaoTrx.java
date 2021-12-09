package kr.co.ta9.pandora3.psys.dao;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.pcommon.dto.TsysOrgRolRtnn;
import kr.co.ta9.pandora3.psys.dao.base.BaseTsysOrgRolRtnnDaoTrx;

/**
 * TsysOrgRolRtnnDaoTrx - Transactional DAO(Data Access Object) class for table
 * [TSYS_ORG_ROL_RTNN].
 *
 * <pre>
 *  Generated by CodeProcessor. You can freely modify this generated file.
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 03. 22
 */
@Repository
public class TsysOrgRolRtnnDaoTrx extends BaseTsysOrgRolRtnnDaoTrx {

	public int deleteAll(TsysOrgRolRtnn tsysOrgRolRtnn) throws Exception {
		return getSqlSession().delete("TsysOrgRolRtnnTrx.deleteAll", tsysOrgRolRtnn);
	}



}