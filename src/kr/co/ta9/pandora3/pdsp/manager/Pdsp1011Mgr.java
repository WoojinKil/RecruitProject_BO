package kr.co.ta9.pandora3.pdsp.manager;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pcommon.dto.TdspSysInf;
import kr.co.ta9.pandora3.pdsp.dao.TdspSysInfDao;
/**
* <pre>
* 1. 클래스명 : Pdsp1011Mgr
* 2. 설명: 사이트 조회
* 3. 작성일 : 2018-04-23
* 4. 작성자   : TANINE
* </pre>
*/
@Service
public class Pdsp1011Mgr {
	@Autowired
	private TdspSysInfDao tdspSysInfDao;

	/**
	 * 사이트 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectTdspSysInfList(ParameterMap parameterMap) throws Exception {
		return tdspSysInfDao.selectTdspSysInfList(parameterMap);
	}

	/**
	 * 사이트 등록/수정/삭제
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTdspSysInf(ParameterMap parameterMap) throws Exception {

		List<TdspSysInf> insertList = new ArrayList<TdspSysInf>();
		List<TdspSysInf> updateList = new ArrayList<TdspSysInf>();
		List<TdspSysInf> deleteList = new ArrayList<TdspSysInf>();
		parameterMap.populates(TdspSysInf.class, insertList, updateList, deleteList);

		TdspSysInf[] insert = insertList.toArray(new TdspSysInf[0]);
		TdspSysInf[] update = updateList.toArray(new TdspSysInf[0]);
		TdspSysInf[] delete = deleteList.toArray(new TdspSysInf[0]);

		tdspSysInfDao.insertMany(insert);
		tdspSysInfDao.updateMany(update);
		tdspSysInfDao.deleteMany(delete);
	}

	/**
	 * 사이트 콤보 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectTdspSysInfComboList(ParameterMap parameterMap) throws Exception {
		return tdspSysInfDao.selectTdspSysInfComboList(parameterMap);
	}
	
	/**
	 * 로그인 이력 적재 가능 사이트  조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectTdspSysInfLogComboList(ParameterMap parameterMap) throws Exception {
		return tdspSysInfDao.selectTdspSysInfLogComboList(parameterMap);
	}

	/**
	 * 접근 가능한 사이트 정보 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject getAccessSitList(ParameterMap parameterMap) throws Exception {
		return tdspSysInfDao.getAccessSitList(parameterMap);
	}


	/**
	 * 디봇접속가능여부
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public int getAccessSitCnt(ParameterMap parameterMap) throws Exception {
		return tdspSysInfDao.getAccessSitCnt(parameterMap);
	}

}
