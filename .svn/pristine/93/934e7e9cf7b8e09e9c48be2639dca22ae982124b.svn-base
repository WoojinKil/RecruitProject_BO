package kr.co.ta9.pandora3.pbbs.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TbbsCmtInf;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTbbsCmtInfDao - BASE DAO(Base Data Access Object) class for table [TBBS_CMT_INF].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class BaseTbbsCmtInfDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TbbsCmtInf
	 * @throws Exception
	 */
	public TbbsCmtInf getTbbsCmtInf(ParameterMap parameterMap) throws Exception {
		return (TbbsCmtInf) getSqlSession().selectOne("TbbsCmtInf.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTbbsCmtInfMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TbbsCmtInf.selectMap", parameterMap);
	}	

}