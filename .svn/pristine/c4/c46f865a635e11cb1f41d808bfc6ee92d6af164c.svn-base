package kr.co.ta9.pandora3.pbbs.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.BeanUtil;
import kr.co.ta9.pandora3.pcommon.dto.TbbsFlInf;

/**
 * TbbsFlInfDao - DAO(Data Access Object) class for table [TBBS_FL_INF].
 *
 * <pre>
 * 1. 패키지명 : kr.co.ta9.pandora3.pbbs.dao
 * 2. 타입명 : class
 * 3. 작성일 : 2018-02-18
 * 4. 작성자 : TA9
 * 5. 설명 : 파일 DAO(조회 쿼리 호출)
 * </pre>
 */
@Repository
public class TbbsFlInfDao extends BaseDao {

	/**
	 * 파일 목록 조회 : 다건
	 * @param  parameterMap
	 * @return List<TbbsFlInf>
	 * @throws Exception
	 */
	public List<TbbsFlInf> selectTbbsFlInfList(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectList("TbbsFlInf.selectTbbsFlInfList", parameterMap);
	}
	
	/**
	 * BOARD TYPE3 : 질문답변형 게시판 상세 조회(파일)
	 * @param parameterMap
	 * @return List<Map<String, Object>>
	 */
	public List<Map<String, Object>> selectTbbsFlInfListMap(ParameterMap parameterMap) throws Exception {
		List<Object> dataList =  getSqlSession().selectList("TbbsFlInf.selectTbbsFlInfList", parameterMap);
		dataList.remove(logger);
		List<Map<String,Object>> mapList = BeanUtil.convertObjectToMapList(dataList);
		for(Map<String,Object> map : mapList) {
			if(map.containsKey("LOGGER")) {
				mapList.remove(map);
			}
		}
		return mapList;
	}
	
	/**
	 * 파일 정보 조회 : 단건
	 * @param  fl_seq
	 * @return TbbsFlInf
	 * @throws Exception
	 */
	public TbbsFlInf selectTbbsFlInfInfo(String fl_seq) throws Exception {
		return getSqlSession().selectOne("TbbsFlInf.selectTbbsFlInfInfo", fl_seq);
	}
	

	/**
	 * 파일 정보 매핑(게시글 BO 작성 시)
	 * @param parameterMap
	 * @return int
	 * @throws Exception
	 */
	public int updateTbbsFlInfList(ParameterMap parameterMap) throws Exception {
		return getSqlSession().update("TbbsFlInf.updateTbbsFlInfList", parameterMap);
	}

	/**
	 * 파일 정보 매핑(답변작성 시)
	 * @param parameterMap
	 * @return int
	 * @throws Exception
	 */
	public int updateTbbsFlInfQaCmtList(ParameterMap parameterMap) throws Exception {
		return getSqlSession().update("TbbsFlInf.updateTbbsFlInfQaCmtList", parameterMap);
	}




	/**
	 * 다운로드 횟수 증가
	 * @param fl_seq
	 * @return int
	 * @throws Exception
	 */
	public int updateTbbsFlInfDwldCnt(String fl_seq) throws Exception {
		return getSqlSession().update("TbbsFlInf.updateTbbsFlInfDwldCnt", Integer.parseInt(fl_seq));
	}
	
}