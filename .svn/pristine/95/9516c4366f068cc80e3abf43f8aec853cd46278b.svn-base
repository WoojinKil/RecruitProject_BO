package kr.co.ta9.pandora3.meta.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaCmpnyWrkSysM;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTbMetaCmpnyWrkSysMDao - BASE DAO(Base Data Access Object) class for table [TB_META_CMPNY_WRK_SYS_M].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaCmpnyWrkSysMDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TbMetaCmpnyWrkSysM
	 * @throws Exception
	 */
	public TbMetaCmpnyWrkSysM getTbMetaCmpnyWrkSysM(ParameterMap parameterMap) throws Exception {
		return (TbMetaCmpnyWrkSysM) getSqlSession().selectOne("TbMetaCmpnyWrkSysM.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTbMetaCmpnyWrkSysMMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TbMetaCmpnyWrkSysM.selectMap", parameterMap);
	}	

}