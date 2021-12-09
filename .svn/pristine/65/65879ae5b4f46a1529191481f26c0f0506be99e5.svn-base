package kr.co.ta9.pandora3.pbbs.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TbbsScdInf;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTbbsScdInfDao - BASE DAO(Base Data Access Object) class for table [TBBS_SCD_INF].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class BaseTbbsScdInfDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TbbsScdInf
	 * @throws Exception
	 */
	public TbbsScdInf getTbbsScdInf(ParameterMap parameterMap) throws Exception {
		return (TbbsScdInf) getSqlSession().selectOne("TbbsScdInf.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTbbsScdInfMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TbbsScdInf.selectMap", parameterMap);
	}	

}