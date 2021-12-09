package kr.co.ta9.pandora3.meta.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaPjtUsrM;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTbMetaPjtUsrMDao - BASE DAO(Base Data Access Object) class for table [TB_META_PJT_USR_M].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaPjtUsrMDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TbMetaPjtUsrM
	 * @throws Exception
	 */
	public TbMetaPjtUsrM getTbMetaPjtUsrM(ParameterMap parameterMap) throws Exception {
		return (TbMetaPjtUsrM) getSqlSession().selectOne("TbMetaPjtUsrM.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTbMetaPjtUsrMMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TbMetaPjtUsrM.selectMap", parameterMap);
	}	

}