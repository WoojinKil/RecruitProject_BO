package kr.co.ta9.pandora3.pbbs.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pbbs.dao.base.BaseTbbsCmtInfDao;
import kr.co.ta9.pandora3.pcommon.dto.TbbsCmtInf;

/**
 * TbbsCmtInfDao - DAO(Data Access Object) class for table [TBBS_CMT_INF].
 *
 * <pre>
 * 1. 패키지명 : kr.co.ta9.pandora3.content.dao
 * 2. 타입명   : class
 * 3. 작성일   : 2018-01-10
 * 4. 설명     : 댓글 DAO
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class TbbsCmtInfDao extends BaseTbbsCmtInfDao {
	
	/**
	 * 댓글 목록 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public List<TbbsCmtInf> selectTbbsCmtInfList(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectList("TbbsCmtInf.selectTbbsCmtInfList", parameterMap);
	}
	
	/**
	 * 댓글 현재 페이지 정보 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public int selectTbbsCmtInfCurPageInfo(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectOne("TbbsCmtInf.selectTbbsCmtInfCurPageInfo", parameterMap);
	}
	
	/**
	 * 댓글 현재 페이지 정보 조회2
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public int selectTbbsCmtInfCurPageInfo2(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectOne("TbbsCmtInf.selectTbbsCmtInfCurPageInfo2", parameterMap);
	}

}