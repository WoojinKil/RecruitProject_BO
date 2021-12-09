package kr.co.ta9.pandora3.pmbr.dao;

import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pcommon.dto.TmbrUsrLgnInf;

/**
 * TmbrUsrLgnInfDao - DAO(Data Access Object) class for table [TMBR_USR_LGN_INF].
 *
 * <pre>
 *   Generated by CodeProcessor. You can freely modify this generated file.
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class TmbrUsrLgnInfDao extends BaseDao {

	/**
	 * 마지막 사용자 로그인 조회
	 * @param  parameterMap
	 * @return TmbrUsrLgnInf
	 * @throws Exception
	 */
	public TmbrUsrLgnInf selectTmbrUsrLgnInfAtLast(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectOne("TmbrUsrLgnInf.selectTmbrUsrLgnInfAtLast", parameterMap);
	}

	/**
	 * 로그인이력 그리드 목록 조회
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTmbrUsrLgnInfList(ParameterMap parameterMap) throws Exception{
		return queryForGrid("TmbrUsrLgnInf.selectTmbrUsrLgnInfList", parameterMap);
	}

	/**
	 * 로그인이력 그리드 목록 조회
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public List<TmbrUsrLgnInf> selectTmbrUsrLgnInfArrayList(ParameterMap parameterMap) throws Exception{
		return getSqlSession().selectList("TmbrUsrLgnInf.selectTmbrUsrLgnInfList", parameterMap);
	}

	/**
	 * 중복 로그인 방지를 위한 최신 유니크 키값 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public TmbrUsrLgnInf selectTmbrUsrLgnInfUnqKey(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectOne("TmbrUsrLgnInf.selectTmbrUsrLgnInfUnqKey", parameterMap);
	}

}