package kr.co.ta9.pandora3.pmbr.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TmbrAdmLastLgnInf;

/**
 * TmbrAdmLastLgnInfDao - DAO(Data Access Object) class for table [TMBR_ADM_LAST_LGN_INF].
 *
 * <pre>
 *   Generated by CodeProcessor. You can freely modify this generated file.
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 11. 13
 */
@Repository
public class TmbrAdmLastLgnInfDao extends BaseDao {

	
	/**
	 * 마지막 로그인 접속 시간 및 아이피 유무
	 * @param userInfo
	 * @return int
	 * @throws Exception
	 */
	public int selectTmbrAdmLastLgnInfCount(TmbrAdmLastLgnInf tmbrAdmLastLgnInf) throws Exception {
		return getSqlSession().selectOne("TmbrAdmLastLgnInf.selectAdmLastLgnInfCount", tmbrAdmLastLgnInf);
	}

	/**
	 * 마지막 로그인 시간 가져오기.
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public String selectLastLgnInTime(Map<String, Object> map) throws Exception {
		
		return getSqlSession().selectOne("TmbrAdmLastLgnInf.selectLastLgnInTime", map);
	}
	
	/**
	 * 현재 정보가 있을 경우 ip 및 마지막 접속 시간 update
	 * @param tmbrAdmLastLgnInf
	 * @throws Exception
	 */
	public void updateTmbrAdmLastLgnInf(TmbrAdmLastLgnInf tmbrAdmLastLgnInf) throws Exception{
		getSqlSession().update("TmbrAdmLastLgnInfTrx.updateTmbrAdmLastLgnInf", tmbrAdmLastLgnInf);
	}
	
	/**
	 * 현재 정보가 없을 경우 ip 및 마지막 접속 insert
	 * @param tmbrAdmLastLgnInf
	 * @throws Exception
	 */
	public void insertTmbrAdmLastLgnInf(TmbrAdmLastLgnInf tmbrAdmLastLgnInf) throws Exception{
		getSqlSession().insert("TmbrAdmLastLgnInfTrx.insertTmbrAdmLastLgnInf", tmbrAdmLastLgnInf);
		
	}

}