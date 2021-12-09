package kr.co.ta9.pandora3.pbbs.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TbbsTmpDocInf;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTbbsTmpDocInfDao - BASE DAO(Base Data Access Object) class for table [TBBS_TMP_DOC_INF].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class BaseTbbsTmpDocInfDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TbbsTmpDocInf
	 * @throws Exception
	 */
	public TbbsTmpDocInf getTbbsTmpDocInf(ParameterMap parameterMap) throws Exception {
		return (TbbsTmpDocInf) getSqlSession().selectOne("TbbsTmpDocInf.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTbbsTmpDocInfMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TbbsTmpDocInf.selectMap", parameterMap);
	}	

}