package kr.co.ta9.pandora3.pwzn.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspDtl;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTbbsWbznDspDtlDao - BASE DAO(Base Data Access Object) class for table [TBBS_WBZN_DSP_DTL].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class BaseTbbsWbznDspDtlDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TbbsWbznDspDtl
	 * @throws Exception
	 */
	public TbbsWbznDspDtl getTbbsWbznDspDtl(ParameterMap parameterMap) throws Exception {
		return (TbbsWbznDspDtl) getSqlSession().selectOne("TbbsWbznDspDtl.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTbbsWbznDspDtlMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TbbsWbznDspDtl.selectMap", parameterMap);
	}	

}