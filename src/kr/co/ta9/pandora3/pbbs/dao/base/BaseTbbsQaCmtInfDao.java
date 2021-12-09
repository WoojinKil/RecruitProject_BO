package kr.co.ta9.pandora3.pbbs.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TbbsQaCmtInf;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTbbsQaCmtInfDao - BASE DAO(Base Data Access Object) class for table [TBBS_QA_CMT_INF].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class BaseTbbsQaCmtInfDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TbbsQaCmtInf
	 * @throws Exception
	 */
	public TbbsQaCmtInf getTbbsQaCmtInf(ParameterMap parameterMap) throws Exception {
		return (TbbsQaCmtInf) getSqlSession().selectOne("TbbsQaCmtInf.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTbbsQaCmtInfMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TbbsQaCmtInf.selectMap", parameterMap);
	}	

}