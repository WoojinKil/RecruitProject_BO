package kr.co.ta9.pandora3.psys.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmOrgGrpRolRtnn;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTsysAdmOrgGrpRolRtnnDao - BASE DAO(Base Data Access Object) class for table [TSYS_ADM_ORG_GRP_ROL_RTNN].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 10. 29
 */
@Repository
public class BaseTsysAdmOrgGrpRolRtnnDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TsysAdmOrgGrpRolRtnn
	 * @throws Exception
	 */
	public TsysAdmOrgGrpRolRtnn getTsysAdmOrgGrpRolRtnn(ParameterMap parameterMap) throws Exception {
		return (TsysAdmOrgGrpRolRtnn) getSqlSession().selectOne("TsysAdmOrgGrpRolRtnn.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTsysAdmOrgGrpRolRtnnMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TsysAdmOrgGrpRolRtnn.selectMap", parameterMap);
	}	

}