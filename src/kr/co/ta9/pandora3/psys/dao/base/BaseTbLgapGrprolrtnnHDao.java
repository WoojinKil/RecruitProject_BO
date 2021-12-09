package kr.co.ta9.pandora3.psys.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pcommon.dto.TbLgapGrprolrtnnH;

/**
 * BaseTbLgapGrprolrtnnHDao - BASE DAO(Base Data Access Object) class for table [TB_LGAP_GRPROLRTNN_H].
 *
 * <pre>
 *   Do not modify this file
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 11. 28
 */
@Repository
public class BaseTbLgapGrprolrtnnHDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TbLgapGrprolrtnnH
	 * @throws Exception
	 */
	public TbLgapGrprolrtnnH getTbLgapGrprolrtnnH(ParameterMap parameterMap) throws Exception {
		return (TbLgapGrprolrtnnH) getSqlSession().selectOne("TbLgapGrprolrtnnH.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTbLgapGrprolrtnnHMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TbLgapGrprolrtnnH.selectMap", parameterMap);
	}	

}