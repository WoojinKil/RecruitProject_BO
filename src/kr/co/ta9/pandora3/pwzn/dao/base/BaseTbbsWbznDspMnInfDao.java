package kr.co.ta9.pandora3.pwzn.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspMnInf;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTbbsWbznDspMnInfDao - BASE DAO(Base Data Access Object) class for table [TBBS_WBZN_DSP_MN_INF].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class BaseTbbsWbznDspMnInfDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TbbsWbznDspMnInf
	 * @throws Exception
	 */
	public TbbsWbznDspMnInf getTbbsWbznDspMnInf(ParameterMap parameterMap) throws Exception {
		return (TbbsWbznDspMnInf) getSqlSession().selectOne("TbbsWbznDspMnInf.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTbbsWbznDspMnInfMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TbbsWbznDspMnInf.selectMap", parameterMap);
	}	

}