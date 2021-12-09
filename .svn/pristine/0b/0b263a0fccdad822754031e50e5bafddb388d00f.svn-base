package kr.co.ta9.pandora3.psys.dao.base;

import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pcommon.dto.TsysOrgRolRtnn;

/**
 * BaseTsysOrgRolRtnnDao - BASE DAO(Base Data Access Object) class for table [TSYS_ORG_ROL_RTNN].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 03. 22
 */
@Repository
public abstract class BaseTsysOrgRolRtnnDao extends BaseDao {
	
	/**
	 * @param parameterMap
	 * @return TsysOrgRolRtnn
	 * @throws DataAccessException
	 */
	public final TsysOrgRolRtnn getTsysOrgRolRtnn(ParameterMap parameterMap) throws DataAccessException{
		return (TsysOrgRolRtnn) getSqlSession().selectOne("TsysOrgRolRtnn.getTsysOrgRolRtnn", parameterMap);
	}
	
	/**
	 * @param parameterMap
	 * @return java.util.Map
	 * @throws DataAccessException
	 */
	public final Map getTsysOrgRolRtnnMap(ParameterMap parameterMap) throws DataAccessException{
		return (Map) getSqlSession().selectOne("TsysOrgRolRtnn.getTsysOrgRolRtnnMap", parameterMap);
	}	

}