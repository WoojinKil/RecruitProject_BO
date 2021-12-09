package kr.co.ta9.pandora3.sample;

import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.BeanUtil;
import kr.co.ta9.pandora3.pcommon.dto.usrdef.TsysAdmMnuTree;

@Repository
public class SampleDao extends BaseDao {



	/**
	 * 코드상세 리스트 조회 (그리드형)
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectAdminMnu(ParameterMap parameterMap) throws Exception {
		return queryForGrid("Sample2.selectAdminMnu", parameterMap);
	}


	/**
	 * 샘플 고객별 정보 조회 조회 (그리드형)
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTmbrAdmLgnInfGridList(ParameterMap parameterMap) throws Exception {
		return queryForGrid("Sample1.selectTmbrAdmLgnInfGridList", parameterMap);
	}

	/**
	 * 샘플 대시보드 > 팀별 실적 현황
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectTeamResultDataGridList(ParameterMap parameterMap) throws Exception {
		return queryForGrid("Sample1.selectTeamResultDataGridList", parameterMap);
	}



	/**
	 * 권한목록 조회(그리드형)
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTsysAdmRolGridList(ParameterMap parameterMap) throws Exception {
		return queryForGrid("Sample1.selectTsysAdmRolGridList", parameterMap);
	}


	/**
	 * 권한개수 조회
	 * @param parameterMap
	 * @return int
	 * @throws Exception
	 */
	public int selectTsysAdmRolCnt(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectOne("TsysAdmRol.selectTsysAdmRolCnt", parameterMap);
	}


	/**
	 * 샘플 > 타겟 템플릿 관리
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public List<TsysAdmMnuTree> selectTsysAdmMnuTestGridTreeList(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectList("Sample1.selectTsysAdmMnuGridTreeList", parameterMap);
	}

	/**
	 * 샘플 > 그리드 그룹핑 샘플
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectGroupingList(ParameterMap parameterMap) throws Exception {
		return queryForGrid("Sample1.selectGroupingList", parameterMap);
	}

	/**
	 * 시스템 사용자 리스트 조회 (그리드형)
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTmbrAdmLgnInfGridSampleList(ParameterMap parameterMap) throws Exception {
		return queryForGrid("Sample1.selectTmbrAdmLgnInfGridSampleList", parameterMap);
	}

	/**
	 * 일반 컨텐츠
	 * BOARD TYPE1/TYPE2 : 게시판 모듈 목록 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public JSONObject selectTbbsModlInfCommonList(ParameterMap parameterMap) throws Exception {
		List<Object> dataList = getSqlSession().selectList("TbbsModlInf.selectTbbsModlInfCommonList", parameterMap);
		List<Map<String,Object>> mapList = BeanUtil.convertObjectToMapList(dataList);
		JSONObject json = new JSONObject();
		json.put("boardModuleList", mapList);
		return json;
	}


	public JSONObject selectRolList(ParameterMap parameterMap) throws Exception {
		return queryForGrid("Sample1.selectTsysRolList", parameterMap);
	}

	public List<ParameterMap>   selectTsysAdmGrpRolList(ParameterMap parameterMap) throws Exception {
		List<ParameterMap> dataList =getSqlSession().selectList("Sample1.selectTsysAdmGrpRolList", parameterMap);
		return dataList;
	}



}