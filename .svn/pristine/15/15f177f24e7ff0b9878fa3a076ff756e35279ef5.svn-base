package kr.co.ta9.pandora3.meta.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaCmpnyObjD;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTbMetaCmpnyObjDDao - BASE DAO(Base Data Access Object) class for table [TB_META_CMPNY_OBJ_D].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaCmpnyObjDDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TbMetaCmpnyObjD
	 * @throws Exception
	 */
	public TbMetaCmpnyObjD getTbMetaCmpnyObjD(ParameterMap parameterMap) throws Exception {
		return (TbMetaCmpnyObjD) getSqlSession().selectOne("TbMetaCmpnyObjD.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTbMetaCmpnyObjDMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TbMetaCmpnyObjD.selectMap", parameterMap);
	}	

}