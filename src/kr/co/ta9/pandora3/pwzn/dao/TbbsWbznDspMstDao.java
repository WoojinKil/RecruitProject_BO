package kr.co.ta9.pandora3.pwzn.dao;

import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspMst;
import kr.co.ta9.pandora3.pwzn.dao.base.BaseTbbsWbznDspMstDao;

/**
 * TbbsWbznDspMstDao - DAO(Data Access Object) class for table [TBBS_WBZN_DSP_MST].
 *
 * <pre>
 * 1. 패키지명 : kr.co.ta9.pandora3.pwzn.dao
 * 2. 타입명    : class
 * 3. 작성일    : 2017-11-22
 * 4. 설명       : 웹진 dao
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class TbbsWbznDspMstDao extends BaseTbbsWbznDspMstDao {
	
	/**
	 * 인사이트 최근 웹진아이디 추출
	 * @param parameterMap
	 * @return String
	 * @throws Exception
	 */	
	public String selectTbbsWbznDspMstWbznSeq(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectOne("TbbsWbznDspMst.selectTbbsWbznDspMstWbznSeq", parameterMap);
	}
	
	/**
	 * 인사이트 웹진 콤보 정보 조회
	 * @param parameterMap
	 * @return String
	 * @throws Exception
	 */	
	public List<TbbsWbznDspMst> selectTbbsWbznDspMstComboInf(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectList("TbbsWbznDspMst.selectTbbsWbznDspMstComboInf", parameterMap);
	}
	
	/**
	 * 웹진 PDF 파일 다운로드 파일 아이디 조회
	 * @param parameterMap
	 * @return String
	 * @throws Exception
	 */	
	public String selectTbbsWbznDspMstFileInfo(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectOne("TbbsWbznDspMst.selectTbbsWbznDspMstFileInfo", parameterMap);
	}

	/**
	 * 웹진 목록 조회(그리드형)
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectTbbsWbznDspMstGridList(ParameterMap parameterMap) throws Exception {
		return queryForGrid("TbbsWbznDspMst.selectTbbsWbznDspMstGridList", parameterMap);
	}
	
	/**
	 * 웹진 마스터 정보 조회 및  웹진 PDF 업로드 파일명 취득
	 * 2019-02-18 pandora3.1 BaseWebzineDisp.xml 3개의 웹진화면조회 쿼리 하나로 통합 (selectWebzineDispMstInfo, selectWebzDispMstInfo, selectWebzDispMstPdfName)
	 * @param  parameterMap
	 * @return WebzineDispMst
	 * @throws Exception
	 */
	public TbbsWbznDspMst selectTbbsWbznDspMstInf(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectOne("TbbsWbznDspMst.selectTbbsWbznDspMstInf", parameterMap);
	}

}