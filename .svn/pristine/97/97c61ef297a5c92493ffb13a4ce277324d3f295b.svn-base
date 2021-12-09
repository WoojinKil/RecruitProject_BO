package kr.co.ta9.pandora3.psys.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pcommon.dto.TbLgapVmsprinfschH;

/**
 * BaseTbLgapVmsprinfschHDao - BASE DAO(Base Data Access Object) class for table [TB_LGAP_VMSPRINFSCH_H].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 12. 09
 */
@Repository
public class BaseTbLgapVmsprinfschHDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TbLgapVmsprinfschH
	 * @throws Exception
	 */
	public TbLgapVmsprinfschH getTbLgapVmsprinfschH(ParameterMap parameterMap) throws Exception {
		return (TbLgapVmsprinfschH) getSqlSession().selectOne("TbLgapVmsprinfschH.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTbLgapVmsprinfschHMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TbLgapVmsprinfschH.selectMap", parameterMap);
	}	

}