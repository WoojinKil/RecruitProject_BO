package kr.co.ta9.pandora3.pdsp.manager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pcommon.dto.TdspTmplInf;
import kr.co.ta9.pandora3.pdsp.dao.TdspTmplInfDao;
/**
* <pre>
* 1. 클래스명 : Pdsp1003Mgr
* 2. 설명: 템플릿등록
* 3. 작성일 : 2018-03-28
* 4.작성자   : TANINE
* </pre>
*/
@Service
public class Pdsp1003Mgr {
	@Autowired
	private TdspTmplInfDao tdspTmplInfDao;
	/**
	 * 템플릿 등록/수정 (단건)
	 * @param parameterMap
	 * @throws Exception
	 */
	public void insert(ParameterMap parameterMap) throws Exception {
		TdspTmplInf tdspTmplInf = (TdspTmplInf)parameterMap.populate(TdspTmplInf.class);

		tdspTmplInfDao.insert(tdspTmplInf);
	}
}
