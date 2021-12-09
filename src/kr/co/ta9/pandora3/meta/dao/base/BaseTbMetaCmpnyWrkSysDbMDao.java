package kr.co.ta9.pandora3.meta.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaCmpnyWrkSysDbM;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTbMetaCmpnyWrkSysDbMDao - BASE DAO(Base Data Access Object) class for table [TB_META_CMPNY_WRK_SYS_DB_M].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaCmpnyWrkSysDbMDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TbMetaCmpnyWrkSysDbM
	 * @throws Exception
	 */
	public TbMetaCmpnyWrkSysDbM getTbMetaCmpnyWrkSysDbM(ParameterMap parameterMap) throws Exception {
		return (TbMetaCmpnyWrkSysDbM) getSqlSession().selectOne("TbMetaCmpnyWrkSysDbM.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTbMetaCmpnyWrkSysDbMMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TbMetaCmpnyWrkSysDbM.selectMap", parameterMap);
	}	

}