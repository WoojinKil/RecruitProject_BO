package kr.co.ta9.pandora3.pcommon.dao;

import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pcommon.dto.usrdef.CommonInfo;

/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.pcommon.dao
* 2. 타입명   : class
* 3. 작성일   : 2019.08.16
* 4. 작성자   : TANINE
* 5. 설명     : 공통 데이터 정보 Dao
* </pre>
*/

@Repository
public class PsysCommonDao extends BaseDao {

	/**
	 * 코드 리스트 조회
	 * @param  parameterMap
	 * @return List<SysCdDtl>
	 * @throws Exception
	 */
	public List<CommonInfo> selectPsysCommonInfoList(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectList("PsysCommon."+parameterMap.getValue("sel_id"), parameterMap);
	}

	/**
	 * 코드상세 리스트 조회 (그리드형)
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTcmnCdDtlGridList(ParameterMap parameterMap) throws Exception {
		return queryForGrid("TcmnCdDtl.selectTcmnCdDtlGridList", parameterMap);
	}
	
	/**
	 * 파라미터 시간 유효성 검사 (10분)
	 * @param checkTime
	 * @return int
	 * @throws Exception
	 */
	public int selectAvailabilityTime(String checkTime) throws Exception {
		return getSqlSession().selectOne("PsysCommon.selectAvailabilityTime", checkTime);
	}

	/**
	 * 현재 시간 DB에서 조회
	 * @return String
	 * @throws Exception
	 */
	public String selectNowTime() throws Exception {
		return getSqlSession().selectOne("PsysCommon.selectNowTime");
	}
	

	/**
	 * D.bot SLO 매장등급 조회
	 * @param parameterMap
	 * @return
	 */
	public String selectShopGrdeCdOne(ParameterMap parameterMap) {
		return getSqlSession().selectOne("PsysCommon.selectShopGrdeCdOne", parameterMap);
	}

}