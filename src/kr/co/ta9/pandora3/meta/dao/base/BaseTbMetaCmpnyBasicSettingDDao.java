package kr.co.ta9.pandora3.meta.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaCmpnyBasicSettingD;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTbMetaCmpnyBasicSettingDDao - BASE DAO(Base Data Access Object) class for table [TB_META_CMPNY_BASIC_SETTING_D].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaCmpnyBasicSettingDDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TbMetaCmpnyBasicSettingD
	 * @throws Exception
	 */
	public TbMetaCmpnyBasicSettingD getTbMetaCmpnyBasicSettingD(ParameterMap parameterMap) throws Exception {
		return (TbMetaCmpnyBasicSettingD) getSqlSession().selectOne("TbMetaCmpnyBasicSettingD.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTbMetaCmpnyBasicSettingDMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TbMetaCmpnyBasicSettingD.selectMap", parameterMap);
	}	

}