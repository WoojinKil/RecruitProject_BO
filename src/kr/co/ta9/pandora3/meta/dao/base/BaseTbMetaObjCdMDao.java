package kr.co.ta9.pandora3.meta.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaObjCdM;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTbMetaObjCdMDao - BASE DAO(Base Data Access Object) class for table [TB_META_OBJ_CD_M].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaObjCdMDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TbMetaObjCdM
	 * @throws Exception
	 */
	public TbMetaObjCdM getTbMetaObjCdM(ParameterMap parameterMap) throws Exception {
		return (TbMetaObjCdM) getSqlSession().selectOne("TbMetaObjCdM.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTbMetaObjCdMMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TbMetaObjCdM.selectMap", parameterMap);
	}	

}