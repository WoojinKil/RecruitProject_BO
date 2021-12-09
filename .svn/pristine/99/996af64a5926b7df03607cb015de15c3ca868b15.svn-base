package kr.co.ta9.pandora3.meta.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaBasicSettingM;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTbMetaBasicSettingMDao - BASE DAO(Base Data Access Object) class for table [TB_META_BASIC_SETTING_M].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaBasicSettingMDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TbMetaBasicSettingM
	 * @throws Exception
	 */
	public TbMetaBasicSettingM getTbMetaBasicSettingM(ParameterMap parameterMap) throws Exception {
		return (TbMetaBasicSettingM) getSqlSession().selectOne("TbMetaBasicSettingM.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTbMetaBasicSettingMMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TbMetaBasicSettingM.selectMap", parameterMap);
	}	

}