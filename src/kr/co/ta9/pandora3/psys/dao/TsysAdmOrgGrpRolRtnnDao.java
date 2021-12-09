package kr.co.ta9.pandora3.psys.dao;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmOrgGrpRolRtnn;
import kr.co.ta9.pandora3.psys.dao.base.BaseTsysAdmOrgGrpRolRtnnDao;

import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

/**
 * TsysAdmOrgGrpRolRtnnDao - DAO(Data Access Object) class for table [TSYS_ADM_ORG_GRP_ROL_RTNN].
 *
 * <pre>
 *   Generated by CodeProcessor. You can freely modify this generated file.
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 10. 29
 */
@Repository
public class TsysAdmOrgGrpRolRtnnDao extends BaseTsysAdmOrgGrpRolRtnnDao {
	
	/**
	 * 조직별 권한 그룹 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectPsysOrgGrpRolRtnnGridList(ParameterMap parameterMap) throws Exception {
		return queryForGrid("TsysAdmOrgGrpRolRtnn.selectPsysOrgGrpRolRtnnGridList", parameterMap);
	}

	/**
	 * 상위 조직에 따른 하위 조직 권한 그룹 모두 검색
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public List<TsysAdmOrgGrpRolRtnn> selectTsysOrgGrpRolAllList(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectList("TsysAdmOrgGrpRolRtnn.selectTsysOrgGrpRolAllList", parameterMap);
	}

}