package kr.co.ta9.pandora3.pbbs.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TmbrPtnrInf;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTmbrPtnrInfDao - BASE DAO(Base Data Access Object) class for table [TMBR_PTNR_INF].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class BaseTmbrPtnrInfDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TmbrPtnrInf
	 * @throws Exception
	 */
	public TmbrPtnrInf getTmbrPtnrInf(ParameterMap parameterMap) throws Exception {
		return (TmbrPtnrInf) getSqlSession().selectOne("TmbrPtnrInf.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTmbrPtnrInfMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TmbrPtnrInf.selectMap", parameterMap);
	}	

}