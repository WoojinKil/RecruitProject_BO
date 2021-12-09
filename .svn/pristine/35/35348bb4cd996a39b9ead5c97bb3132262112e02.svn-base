package kr.co.ta9.pandora3.psys.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TsysUsrRol;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTsysUsrRolDao - BASE DAO(Base Data Access Object) class for table [TSYS_USR_ROL].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class BaseTsysUsrRolDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TsysUsrRol
	 * @throws Exception
	 */
	public TsysUsrRol getTsysUsrRol(ParameterMap parameterMap) throws Exception {
		return (TsysUsrRol) getSqlSession().selectOne("TsysUsrRol.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTsysUsrRolMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TsysUsrRol.selectMap", parameterMap);
	}	

}