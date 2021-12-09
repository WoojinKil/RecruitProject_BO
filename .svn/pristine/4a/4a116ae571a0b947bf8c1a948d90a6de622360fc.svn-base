package kr.co.ta9.pandora3.pbbs.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TbbsDocAddItmInf;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTbbsDocAddItmInfDao - BASE DAO(Base Data Access Object) class for table [TBBS_DOC_ADD_ITM_INF].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class BaseTbbsDocAddItmInfDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TbbsDocAddItmInf
	 * @throws Exception
	 */
	public TbbsDocAddItmInf getTbbsDocAddItmInf(ParameterMap parameterMap) throws Exception {
		return (TbbsDocAddItmInf) getSqlSession().selectOne("TbbsDocAddItmInf.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTbbsDocAddItmInfMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TbbsDocAddItmInf.selectMap", parameterMap);
	}	

}