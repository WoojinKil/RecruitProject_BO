package kr.co.ta9.pandora3.pwzn.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspMst;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTbbsWbznDspMstDao - BASE DAO(Base Data Access Object) class for table [TBBS_WBZN_DSP_MST].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class BaseTbbsWbznDspMstDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TbbsWbznDspMst
	 * @throws Exception
	 */
	public TbbsWbznDspMst getTbbsWbznDspMst(ParameterMap parameterMap) throws Exception {
		return (TbbsWbznDspMst) getSqlSession().selectOne("TbbsWbznDspMst.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTbbsWbznDspMstMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TbbsWbznDspMst.selectMap", parameterMap);
	}	

}