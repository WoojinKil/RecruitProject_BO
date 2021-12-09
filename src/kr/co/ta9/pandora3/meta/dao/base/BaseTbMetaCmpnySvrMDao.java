package kr.co.ta9.pandora3.meta.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaCmpnySvrM;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTbMetaCmpnySvrMDao - BASE DAO(Base Data Access Object) class for table [TB_META_CMPNY_SVR_M].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaCmpnySvrMDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TbMetaCmpnySvrM
	 * @throws Exception
	 */
	public TbMetaCmpnySvrM getTbMetaCmpnySvrM(ParameterMap parameterMap) throws Exception {
		return (TbMetaCmpnySvrM) getSqlSession().selectOne("TbMetaCmpnySvrM.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTbMetaCmpnySvrMMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TbMetaCmpnySvrM.selectMap", parameterMap);
	}	

}