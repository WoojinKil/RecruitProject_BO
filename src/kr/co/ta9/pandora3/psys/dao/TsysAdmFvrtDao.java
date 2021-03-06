package kr.co.ta9.pandora3.psys.dao;


import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmFvrt;

/**
 * TsysAdmFvrtDao - DAO(Data Access Object) class for table [TSYS_ADM_FVRT].
 *
 * <pre>
 *   Generated by CodeProcessor. You can freely modify this generated file.
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 03. 12
 */
@Repository
public class TsysAdmFvrtDao extends BaseDao {

	/**
	 * 메뉴 리스트 조회 (그리드형)
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public String  selectExistTsysAdmFvrt(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectOne("TsysAdmFvrt.selectExistTsysAdmFvrt", parameterMap);
	}
	
	/**
	 *즐겨찾기 목록 조회
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject getTsysAdmFvrtList(ParameterMap parameterMap) throws Exception {
		return this.queryForGrid("TsysAdmFvrt.getTsysAdmFvrtList", parameterMap);
	}
	
	/**
	 * 즐겨찾기 등록
	 * @param tsysAdmFvrt
	 * @return
	 * @throws Exception
	 */
	public int insertTsysAdmFvrt(TsysAdmFvrt tsysAdmFvrt) throws Exception {
		return getSqlSession().insert("TsysAdmFvrt.insertTsysAdmFvrt", tsysAdmFvrt);
	}
	
	/**
	 * 즐겨찾기 상위메뉴별삭제
	 * @param parameterMap
	 * @throws Exception
	 */
	public int deleteUpMnuTsysAdmFvrt(TsysAdmFvrt tsysAdmFvrt) throws Exception {
		return getSqlSession().delete("TsysAdmFvrt.deleteUpMnuTsysAdmFvrt", tsysAdmFvrt);
	}
}