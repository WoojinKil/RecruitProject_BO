package kr.co.ta9.pandora3.meta.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaDbmsVerCdM;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTbMetaDbmsVerCdMDao - BASE DAO(Base Data Access Object) class for table [TB_META_DBMS_VER_CD_M].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaDbmsVerCdMDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TbMetaDbmsVerCdM
	 * @throws Exception
	 */
	public TbMetaDbmsVerCdM getTbMetaDbmsVerCdM(ParameterMap parameterMap) throws Exception {
		return (TbMetaDbmsVerCdM) getSqlSession().selectOne("TbMetaDbmsVerCdM.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTbMetaDbmsVerCdMMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TbMetaDbmsVerCdM.selectMap", parameterMap);
	}	

}