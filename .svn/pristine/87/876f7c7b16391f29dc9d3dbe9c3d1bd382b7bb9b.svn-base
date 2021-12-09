package kr.co.ta9.pandora3.meta.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaDbmsCdM;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTbMetaDbmsCdMDao - BASE DAO(Base Data Access Object) class for table [TB_META_DBMS_CD_M].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaDbmsCdMDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TbMetaDbmsCdM
	 * @throws Exception
	 */
	public TbMetaDbmsCdM getTbMetaDbmsCdM(ParameterMap parameterMap) throws Exception {
		return (TbMetaDbmsCdM) getSqlSession().selectOne("TbMetaDbmsCdM.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTbMetaDbmsCdMMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TbMetaDbmsCdM.selectMap", parameterMap);
	}	

}