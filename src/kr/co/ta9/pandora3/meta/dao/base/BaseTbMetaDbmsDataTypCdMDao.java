package kr.co.ta9.pandora3.meta.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaDbmsDataTypCdM;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTbMetaDbmsDataTypCdMDao - BASE DAO(Base Data Access Object) class for table [TB_META_DBMS_DATA_TYP_CD_M].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaDbmsDataTypCdMDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TbMetaDbmsDataTypCdM
	 * @throws Exception
	 */
	public TbMetaDbmsDataTypCdM getTbMetaDbmsDataTypCdM(ParameterMap parameterMap) throws Exception {
		return (TbMetaDbmsDataTypCdM) getSqlSession().selectOne("TbMetaDbmsDataTypCdM.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTbMetaDbmsDataTypCdMMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TbMetaDbmsDataTypCdM.selectMap", parameterMap);
	}	

}