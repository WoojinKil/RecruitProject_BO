package kr.co.ta9.pandora3.pdsp.manager;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pcommon.dto.TdspTmplInf;
import kr.co.ta9.pandora3.pdsp.dao.TdspTmplInfDao;

/**
* <pre>
* 1. 클래스명 : Pdsp1001Mgr
* 2. 설명 : 템플릿 통합 조회
* 3. 작성일 : 2018-03-28
* 4.작성자   : TANINE
* </pre>
*/
@Service
public class Pdsp1001Mgr {
	
	@Autowired
	private TdspTmplInfDao tdspTmplInfDao;
	
	
	/**
	 * 템플릿 목록 조회(그리드형)
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTdspTmplInfGridList(ParameterMap parameterMap) throws Exception {
		return tdspTmplInfDao.selectTdspTmplInfGridList(parameterMap);
	}
	
	/**
	 * 템플릿 등록/수정/삭제 (복수)
	 * : 등록/수정은 미사용
	 * @param  parameterMap
	 * @throws Exception
	 */
	public void saveTdspTmplInf(ParameterMap parameterMap) throws Exception {
		//List<TdspTmplInf> insertList = new ArrayList<TdspTmplInf>();
		//List<TdspTmplInf> updateList = new ArrayList<TdspTmplInf>();
		List<TdspTmplInf> deleteList = new ArrayList<TdspTmplInf>();
		parameterMap.populates(TdspTmplInf.class, null, null, deleteList);
		
		//TdspTmplInf[] insert = insertList.toArray(new TdspTmplInf[insertList.size()]);
		//TdspTmplInf[] update = updateList.toArray(new TdspTmplInf[updateList.size()]);
		TdspTmplInf[] delete = deleteList.toArray(new TdspTmplInf[deleteList.size()]);
		
		//tdspTmplInfDaoTrx.insertMany(insert);
		//tdspTmplInfDaoTrx.updateMany(update);
		tdspTmplInfDao.deleteMany(delete);
	}
	
}
