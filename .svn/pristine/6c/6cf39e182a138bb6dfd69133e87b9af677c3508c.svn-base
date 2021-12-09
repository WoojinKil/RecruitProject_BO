package kr.co.ta9.pandora3.pbbs.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TbbsDocUsrRtnn;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTbbsDocUsrRtnnDao - BASE DAO(Base Data Access Object) class for table [TBBS_DOC_USR_RTNN].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class BaseTbbsDocUsrRtnnDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TbbsDocUsrRtnn
	 * @throws Exception
	 */
	public TbbsDocUsrRtnn getTbbsDocUsrRtnn(ParameterMap parameterMap) throws Exception {
		return (TbbsDocUsrRtnn) getSqlSession().selectOne("TbbsDocUsrRtnn.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTbbsDocUsrRtnnMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TbbsDocUsrRtnn.selectMap", parameterMap);
	}	

}