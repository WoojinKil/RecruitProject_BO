/**
* <pre>
* 1. 프로젝트명 : 판도라 패키징
* 2. 패키지명 : kr.co.ta9.pandora3.front.main.manager
* 3. 파일명 : MainMgr
* 4. 작성일 : 2019-04-04
* </pre>
*/
package kr.co.ta9.pandora3.front.main.manager;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.front.main.dao.MainDao;
import kr.co.ta9.pandora3.pcommon.dto.TdspMnPop;
import kr.co.ta9.pandora3.pcommon.dto.usrdef.Main;
import kr.co.ta9.pandora3.pdsp.dao.TdspMnPopDao;
/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.front.main.manager
* 2. 타입명 : class
* 3. 작성일 : 2019-04-04
* 4. 설명 : 메인 매니저
* </pre>
*/
@Service
public class FrontMainMgr {
	
	@Autowired
	private TdspMnPopDao tdspMnPopDao;
	
	@Autowired
	private MainDao mainDao;
	
	/**
	 * 메인팝업 목록 조회
	 * @param  frnt_yn
	 * @return List<TdspMnPop>
	 * @throws Exception
	 */
	public List<TdspMnPop> selectMnPopList() throws Exception {
		return tdspMnPopDao.selectTdspMnPopList(Const.BOOLEAN_TRUE);
	}
	
	/**
	 * 메인전시목록 조회
	 * @return List<Main>
	 * @throws Exception
	 */
	public List<Main> selectMnDispDocList(ParameterMap parameterMap) throws Exception {
		List<Main> mnDispDocList = mainDao.selectMnDispDocList(parameterMap);
		for(Main main : mnDispDocList) {
			if(!"MBNNR".equals(main.getModl_tp_cd())) main.setUrl_info(TextUtil.replaceString(main.getUrl_info(), "%", "?"));
			if(!"NOTI".equals(main.getModl_tp_cd())) main.setCts(TextUtil.removeXss(TextUtil.removeTag(main.getCts())));
		}
		return mnDispDocList;
	}
	
	/**
	 * 공지사항 기타 정보 조회
	 * @return Main
	 * @throws Exception
	 */
	public Main selectNotiEtcInf() throws Exception {
		Main notiEtcInf = mainDao.selectNotiEtcInf();
		notiEtcInf.setUrl_info(TextUtil.replaceString(notiEtcInf.getUrl_info(), "%", "?"));
		return notiEtcInf;
	}
	
}
