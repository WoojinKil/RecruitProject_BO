package kr.co.ta9.pandora3.meta.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaCmpnyTbTypD;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTbMetaCmpnyTbTypDDao - BASE DAO(Base Data Access Object) class for table [TB_META_CMPNY_TB_TYP_D].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaCmpnyTbTypDDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TbMetaCmpnyTbTypD
	 * @throws Exception
	 */
	public TbMetaCmpnyTbTypD getTbMetaCmpnyTbTypD(ParameterMap parameterMap) throws Exception {
		return (TbMetaCmpnyTbTypD) getSqlSession().selectOne("TbMetaCmpnyTbTypD.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTbMetaCmpnyTbTypDMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TbMetaCmpnyTbTypD.selectMap", parameterMap);
	}	

}