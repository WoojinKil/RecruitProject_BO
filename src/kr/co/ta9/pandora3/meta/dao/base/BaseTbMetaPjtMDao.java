package kr.co.ta9.pandora3.meta.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaPjtM;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTbMetaPjtMDao - BASE DAO(Base Data Access Object) class for table [TB_META_PJT_M].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaPjtMDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TbMetaPjtM
	 * @throws Exception
	 */
	public TbMetaPjtM getTbMetaPjtM(ParameterMap parameterMap) throws Exception {
		return (TbMetaPjtM) getSqlSession().selectOne("TbMetaPjtM.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTbMetaPjtMMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TbMetaPjtM.selectMap", parameterMap);
	}	

}