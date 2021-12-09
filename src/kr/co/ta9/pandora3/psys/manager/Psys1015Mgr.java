package kr.co.ta9.pandora3.psys.manager;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.exception.AuthorityException;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.pcommon.dto.TmbrClu;
import kr.co.ta9.pandora3.pmbr.dao.TmbrCluDao;

/**
 * <pre>
 * 1. 클래스명 : Psys1015Mgr
 * 2. 설명: BO가입약관 관리 서비스
 * 3. 작성일 : 2018-04-11
 * 4. 작성자 : TANINE
 * </pre>
 */

@Service
public class Psys1015Mgr {
	
	@Autowired
	private TmbrCluDao tmbrCluDao;
	
	/**
	 * 가입약관 조회
	 * @param parameterMap
	 * @throws Exception
	 */
	public JSONObject getTmbrCluList(ParameterMap parameterMap)throws Exception{
		return tmbrCluDao.getTmbrCluList(parameterMap);
	}
	
	/**
	 * 가입약관 등록/수정 (단건)
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTmbrClu(ParameterMap parameterMap) throws Exception {
		
		TmbrClu tmbrClu = (TmbrClu)parameterMap.populate(TmbrClu.class);
		
		/* throw new AuthorityException("Login required !"); */
		
		// 에디터 사용
		tmbrClu.setClu_cts(TextUtil.removeXss(tmbrClu.getClu_cts()));
		
		if("Y".equals(parameterMap.getValue("insert_yn"))) {

			String existYn = tmbrCluDao.getTmbrCluExistYN(parameterMap);

			if("Y".equals(existYn))
				throw new AuthorityException("이미존재하는 약관입니다.");

			tmbrCluDao.insert(tmbrClu);
			tmbrCluDao.insertTmbrCluHst(tmbrClu);

		} else {
			tmbrCluDao.update(tmbrClu);
			tmbrCluDao.insertTmbrCluHst(tmbrClu);
		}
	
	}
	
}
