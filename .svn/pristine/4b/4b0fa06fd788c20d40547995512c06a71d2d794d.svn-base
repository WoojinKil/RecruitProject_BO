package kr.co.ta9.pandora3.pbbs.manager;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pbbs.dao.TbbsScdInfDao;
import kr.co.ta9.pandora3.pbbs.dao.TbbsScdInfDaoTrx;
import kr.co.ta9.pandora3.pcommon.dto.TbbsScdInf;

/**
* <pre>
* 1. 클래스명 : Pbbs1016Mgr
* 2. 설명 : 스케쥴 서비스
* 3. 작성일 : 2018-04-11
* 4.작성자   : TANINE
* </pre>
*/
@Service
public class Pbbs1016Mgr {

	@Autowired
	private TbbsScdInfDao tbbsScdInfDao;
	@Autowired
	private TbbsScdInfDaoTrx tbbsScdInfDaoTrx;
	
	/**
	 * 스캐줄 조회
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTbbsScdInfList(ParameterMap parameterMap) throws Exception {
		return tbbsScdInfDao.selectTbbsScdInfList(parameterMap);
	}
	
	/**
	 * 스캐줄 등록
	 * @param parameterMap
	 * @throws Exception
	 */
	public void insertTbbsScdInf(ParameterMap parameterMap) throws Exception {
		// 스캐줄 등록
		TbbsScdInf tbbsScdInf = (TbbsScdInf)parameterMap.populate(TbbsScdInf.class);
		tbbsScdInfDaoTrx.insert(tbbsScdInf);
	}
	
	/**
	 * 스캐줄 수정
	 * @param parameterMap
	 * @throws Exception
	 */
	public void updateTbbsScdInf(ParameterMap parameterMap) throws Exception {
		// 스캐줄 수정
		TbbsScdInf tbbsScdInf = (TbbsScdInf)parameterMap.populate(TbbsScdInf.class);
		tbbsScdInfDaoTrx.update(tbbsScdInf);
	}
	
	/**
	 * 스캐줄 등록/수정/삭제
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTbbsScdInf(ParameterMap parameterMap) throws Exception {
		String chg_flag = parameterMap.getValue("chg_flag");
		// 스캐줄 등록/수정/삭제
		TbbsScdInf tbbsScdInf = (TbbsScdInf)parameterMap.populate(TbbsScdInf.class);
		if("insert".equals(chg_flag)) {
			tbbsScdInfDaoTrx.insert(tbbsScdInf);
		}else if("update".equals(chg_flag)) {
			tbbsScdInfDaoTrx.update(tbbsScdInf);
		}else if("delete".equals(chg_flag)) {
			tbbsScdInfDaoTrx.delete(tbbsScdInf);
		}
	}
	
}
