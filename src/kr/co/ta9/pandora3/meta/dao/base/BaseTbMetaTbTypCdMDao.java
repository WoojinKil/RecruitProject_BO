package kr.co.ta9.pandora3.meta.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaTbTypCdM;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTbMetaTbTypCdMDao - BASE DAO(Base Data Access Object) class for table [TB_META_TB_TYP_CD_M].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaTbTypCdMDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TbMetaTbTypCdM
	 * @throws Exception
	 */
	public TbMetaTbTypCdM getTbMetaTbTypCdM(ParameterMap parameterMap) throws Exception {
		return (TbMetaTbTypCdM) getSqlSession().selectOne("TbMetaTbTypCdM.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTbMetaTbTypCdMMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TbMetaTbTypCdM.selectMap", parameterMap);
	}	

}