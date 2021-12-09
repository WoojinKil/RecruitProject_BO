package kr.co.ta9.pandora3.pwzn.manager;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspDtl;
import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspMnInf;
import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspMst;
import kr.co.ta9.pandora3.pwzn.dao.TbbsWbznDspDtlDao;
import kr.co.ta9.pandora3.pwzn.dao.TbbsWbznDspMnInfDao;
import kr.co.ta9.pandora3.pwzn.dao.TbbsWbznDspMstDao;

/**
* <pre>
* 1. 클래스명 : Pwzn1006Mgr
* 2. 설명 : 웹진프론트 서비스
* 3. 작성일 : 2018-04-23
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class Pwzn1006Mgr {
	
	
	@Autowired
	private TbbsWbznDspMstDao tbbsWbznDspMstDao;
	@Autowired
	private TbbsWbznDspDtlDao tbbsWbznDspDtlDao;
	@Autowired
	private TbbsWbznDspMnInfDao tbbsWbznDspMnInfDao;
	
	/**
	 * 최근 웹진아이디 추출
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public String selectTbbsWbznDspMstWbznSeq(ParameterMap parameterMap) throws Exception {
		return tbbsWbznDspMstDao.selectTbbsWbznDspMstWbznSeq(parameterMap);
	}
	
	/**
	 * 웹진 콤보 정보 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public List<TbbsWbznDspMst> selectTbbsWbznDspMstComboInf(ParameterMap parameterMap) throws Exception {
		return tbbsWbznDspMstDao.selectTbbsWbznDspMstComboInf(parameterMap);
	}
	
	/**
	 * 웹진 메인 목록
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public List<TbbsWbznDspMnInf> selectTbbsWbznDspMnInfList(ParameterMap parameterMap) throws Exception {
		return tbbsWbznDspMnInfDao.selectTbbsWbznDspMnInfList(parameterMap);
	}
	
	/**
	 * 웹진 상세 목록
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public List<TbbsWbznDspDtl> selectTbbsWbznDspDtlList(ParameterMap parameterMap) throws Exception {
		return tbbsWbznDspDtlDao.selectTbbsWbznDspDtlList(parameterMap);
	}
}
