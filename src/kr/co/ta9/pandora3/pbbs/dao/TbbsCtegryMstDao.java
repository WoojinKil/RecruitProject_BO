package kr.co.ta9.pandora3.pbbs.dao;

import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TbbsCtegryMst;

/**
 * TcmnCdmstDao - DAO(Data Access Object) class for table [TCMN_CD_MST].
 *
 * <pre>
 * 1. 패키지명 : kr.co.ta9.pandora3.psys.dao
 * 2. 타입명 : class
 * 3. 작성일 : 2018-02-18
 * 4. 작성자 : TA9
 * 5. 설명 : 시스템 코드 마스터 DAO(조회 쿼리 호출)
 * </pre>
 */
@Repository
public class TbbsCtegryMstDao extends BaseDao {
	
	
	/**
	 * 마스터코드 리스트 조회 
	 * @param parameterMap
	 * @return List<SysCdmst>
	 * @throws Exception
	 */	
	public List<TbbsCtegryMst> selectTbbsCtegryMstList(ParameterMap parameterMap) {
		return getSqlSession().selectList("TbbsCtegryMst.selectTbbsCtegryMstList", parameterMap);
	}
	
	/**
	 * 마스터코드 리스트 조회 (그리드형)
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */	
	public JSONObject selectTbbsCtegryMstGridList(ParameterMap parameterMap) throws Exception {
		return queryForGrid("TbbsCtegryMst.selectTbbsCtegryMstGridList", parameterMap);
	}
	
	/**
	 * 엑셀다운로드
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */	
	public JSONObject excelTbbsCtegryMstGridList(ParameterMap parameterMap) throws Exception {
		return queryForGrid("TbbsCtegryMst.excelTbbsCtegryMstGridList", parameterMap);
	}
	
	/**
	 * 키중복 체크
	 */
	public int selectTbbsCtegryMstCnt(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectOne("TbbsCtegryMst.selectTbbsCtegryMstCnt", parameterMap);
	}
	
	/**
	 * Sample 리스트 조회 (그리드형)
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */	
	public JSONObject selectSampleGridList(ParameterMap parameterMap, JSONObject json) throws Exception {
//		if		("TYPE1".equals(parameterMap.getValue("sch_type"))) json = queryForGrid("TbbsCtegryMst.selectTbbsCtegryMstGridList", parameterMap);
//		else if ("TYPE2".equals(parameterMap.getValue("sch_type"))) json = queryForGrid("TbbsCtegryMst.selectTbbsCtegryMstGridList", parameterMap);
		if( ("TYPE1".equals(parameterMap.getValue("sch_type"))) || ("TYPE2".equals(parameterMap.getValue("sch_type"))) ) json = queryForGrid("TbbsCtegryMst.selectTbbsCtegryMstGridList", parameterMap);
		return json;
	}
	
	

	/**
	 * 시스템 코드 마스터 삭제
	 * @param cmnCdmsts
	 * @return int
	 * @throws Exception 
	 */
	public int deleteTbbsCtegryDtl(TbbsCtegryMst... bBcpcCtegrymsts) throws Exception {
		int count = 0;
		if (bBcpcCtegrymsts != null) {
			for (TbbsCtegryMst bBcpcCtegrymst : bBcpcCtegrymsts) {
				count += getSqlSession().delete("TbbsCtegryMst.deleteTbbsCtegryDtl", bBcpcCtegrymst);
			}
		}
		return count;
	}
	
}