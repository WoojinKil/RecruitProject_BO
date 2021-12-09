package kr.co.ta9.pandora3.pdsp.manager;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pcommon.dto.TdspTmplInf;
import kr.co.ta9.pandora3.pdsp.dao.TdspTmplInfDao;
/**
* <pre>
* 1. 클래스명 : Pdsp1002Mgr
* 2. 설명: 템플릿상세조회
* 3. 작성일 : 2018-03-28
* 4.작성자   : TANINE
* </pre>
*/
@Service
public class Pdsp1002Mgr {
	
	@Autowired
	private TdspTmplInfDao tdspTmplInfDao;
	/**
	 * 템플릿 조회(단건)
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public Map getTdspTmplInfMap(ParameterMap parameterMap) throws Exception {
		return tdspTmplInfDao.selectMap(TdspTmplInf.class, parameterMap);
	}

	/**
	 * 템플릿 등록/수정 (단건)
	 * @param parameterMap
	 * @throws Exception
	 */
	public void update(ParameterMap parameterMap) throws Exception {
		TdspTmplInf tdspTmplInf = (TdspTmplInf)parameterMap.populate(TdspTmplInf.class);

		tdspTmplInfDao.update(tdspTmplInf);

	}
}
