package kr.co.ta9.pandora3.pbbs.manager;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.BeanUtil;
import kr.co.ta9.pandora3.pbbs.dao.TbbsCtegryDtlDao;
import kr.co.ta9.pandora3.pbbs.dao.TbbsCtegryMstDao;
import kr.co.ta9.pandora3.pcommon.dto.TbbsCtegryDtl;
import kr.co.ta9.pandora3.pcommon.dto.TbbsCtegryMst;

/**
 * <pre>
* 1. 클래스명 : Pbbs1019Mgr
* 2. 설명 : 코드관리 서비스
* 3. 작성일 : 2019-12-17
* 4. 작성자 : TANINE
 * </pre>
 */
@Service
public class Pbbs1019Mgr {

	@Autowired
	private TbbsCtegryMstDao tbbsCtegryMstDao;
	@Autowired
	private TbbsCtegryDtlDao tbbsCtegryDtlDao;

	/**
	 * 마스터코드 리스트 조회(그리드)
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTbbsCtegryMstGridList(ParameterMap parameterMap) throws Exception {
		return tbbsCtegryMstDao.selectTbbsCtegryMstGridList(parameterMap);
	}

	/**
	 * 엑셀다운로드
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject excelTbbsCtegryMstGridList(ParameterMap parameterMap) throws Exception {
		return tbbsCtegryMstDao.excelTbbsCtegryMstGridList(parameterMap);
	}

	/**
	 * 마스터코드 리스트 조회
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTbbsCtegryMstList(ParameterMap parameterMap) throws Exception {

		List<TbbsCtegryMst> tbbsCtegryMstList = tbbsCtegryMstDao.selectTbbsCtegryMstList(parameterMap);
		List<Map<String,Object>> mapList = null;
		JSONObject json = new JSONObject();
		if(tbbsCtegryMstList != null) {
			mapList = BeanUtil.convertObjectToMapList(tbbsCtegryMstList);
		}

		json.put("ctegrymstList", mapList);
		return json;
	}

	/**
	 * 코드 입력/수정/삭제
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTbbsCtegryMst(ParameterMap parameterMap) throws Exception {
		int cnt = 0;
		List<TbbsCtegryMst> insertList = new ArrayList<TbbsCtegryMst>();
		List<TbbsCtegryMst> updateList = new ArrayList<TbbsCtegryMst>();
		List<TbbsCtegryMst> deleteList = new ArrayList<TbbsCtegryMst>();
		parameterMap.populates(TbbsCtegryMst.class, insertList, updateList, deleteList);



		if (!(insertList.isEmpty())) {
			for (TbbsCtegryMst tbbsCtegryMst : insertList) {
				parameterMap.put("mst_cd", tbbsCtegryMst.getCtegry_mst_cd());
				cnt = tbbsCtegryMstDao.selectTbbsCtegryMstCnt(parameterMap);
			}
		}
		if(cnt != 0) {
			parameterMap.put("MSG", "이미 같은 ID가 존재합니다.");
			//throw new Exception("이미 같은 ID가 존재합니다.");
		}else{
			TbbsCtegryMst[] insert = insertList.toArray(new TbbsCtegryMst[0]);
			tbbsCtegryMstDao.insertMany(insert);
		}
		TbbsCtegryMst[] update = updateList.toArray(new TbbsCtegryMst[0]);
		TbbsCtegryMst[] delete = deleteList.toArray(new TbbsCtegryMst[0]);

		tbbsCtegryMstDao.updateMany(update);
		tbbsCtegryMstDao.deleteMany(delete);
		tbbsCtegryMstDao.deleteTbbsCtegryDtl(delete);
	}

	/**
	 * 코드상세 리스트 조회
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTbbsCtegryDtlGridList(ParameterMap parameterMap) throws Exception {
		return tbbsCtegryDtlDao.selectTbbsCtegryDtlGridList(parameterMap);
	}

	/**
	 * 코드상세 입력/수정/삭제
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTbbsCtegryDtl(ParameterMap parameterMap) throws Exception {
		List<TbbsCtegryDtl> insertList = new ArrayList<TbbsCtegryDtl>();
		List<TbbsCtegryDtl> updateList = new ArrayList<TbbsCtegryDtl>();
		List<TbbsCtegryDtl> deleteList = new ArrayList<TbbsCtegryDtl>();

		parameterMap.populates(TbbsCtegryDtl.class, insertList, updateList, deleteList);

		/*if (insertList.size() > 0) {
			for (SysCdDtl sysCdDtl : insertList) {
				parameterMap.put("mst_cd", sysCdDtl.getMst_cd());
				parameterMap.put("cd", sysCdDtl.getCd());
				cnt = tbbsCtegryDtlDao.selectTbbsCtegryDtlCnt(parameterMap);
			}
		}

		if(cnt != 0) {
			parameterMap.put("MSG", "이미 같은 ID가 존재합니다.");
		}*/

//		TbbsCtegryDtl[] insert = insertList.toArray(new TbbsCtegryDtl[insertList.size()]);
//		TbbsCtegryDtl[] update = updateList.toArray(new TbbsCtegryDtl[updateList.size()]);
//		TbbsCtegryDtl[] delete = deleteList.toArray(new TbbsCtegryDtl[deleteList.size()]);
		TbbsCtegryDtl[] insert = insertList.toArray(new TbbsCtegryDtl[0]);
		TbbsCtegryDtl[] update = updateList.toArray(new TbbsCtegryDtl[0]);
		TbbsCtegryDtl[] delete = deleteList.toArray(new TbbsCtegryDtl[0]);

		tbbsCtegryDtlDao.insertMany(insert);
		tbbsCtegryDtlDao.updateMany(update);
		tbbsCtegryDtlDao.deleteMany(delete);
	}

	/**
	 * 코드정보 일괄저장
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTcmnAlll(ParameterMap parameterMap) throws Exception {
		List<TbbsCtegryMst> insertList = new ArrayList<TbbsCtegryMst>();
		List<TbbsCtegryMst> updateList = new ArrayList<TbbsCtegryMst>();
		List<TbbsCtegryMst> deleteList = new ArrayList<TbbsCtegryMst>();
		//jsp에서 정의한 파라미터명 추가
		parameterMap.populates(TbbsCtegryMst.class, insertList, updateList, deleteList,"masterdata");

//		Map<String,String> resultMap = new HashMap<String,String>();

		/*if (insertList.size() > 0) {
			for (SysCdDtl sysCdDtl : insertList) {
				parameterMap.put("mst_cd", sysCdDtl.getMst_cd());
				parameterMap.put("cd", sysCdDtl.getCd());
				cnt = tbbsCtegryDtlDao.selectTbbsCtegryDtlCnt(parameterMap);
			}
		}

		if(cnt != 0) {
			parameterMap.put("MSG", "이미 같은 ID가 존재합니다.");
		}*/

//		TbbsCtegryMst[] insert = insertList.toArray(new TbbsCtegryMst[insertList.size()]);
//		TbbsCtegryMst[] update = updateList.toArray(new TbbsCtegryMst[updateList.size()]);
//		TbbsCtegryMst[] delete = deleteList.toArray(new TbbsCtegryMst[deleteList.size()]);
		TbbsCtegryMst[] insert = insertList.toArray(new TbbsCtegryMst[0]);
		TbbsCtegryMst[] update = updateList.toArray(new TbbsCtegryMst[0]);
		TbbsCtegryMst[] delete = deleteList.toArray(new TbbsCtegryMst[0]);

		tbbsCtegryMstDao.insertMany(insert);
		tbbsCtegryMstDao.updateMany(update);
		tbbsCtegryMstDao.deleteMany(delete);
		tbbsCtegryMstDao.deleteTbbsCtegryDtl(delete);


		List<TbbsCtegryDtl> insertDtlList = new ArrayList<TbbsCtegryDtl>();
		List<TbbsCtegryDtl> updateDtlList = new ArrayList<TbbsCtegryDtl>();
		List<TbbsCtegryDtl> deleteDtlList = new ArrayList<TbbsCtegryDtl>();

		parameterMap.populates(TbbsCtegryDtl.class, insertDtlList, updateDtlList, deleteDtlList,"dtldata");

//		TbbsCtegryDtl[] insertDtl = insertDtlList.toArray(new TbbsCtegryDtl[insertDtlList.size()]);
//		TbbsCtegryDtl[] updateDtl = updateDtlList.toArray(new TbbsCtegryDtl[updateDtlList.size()]);
//		TbbsCtegryDtl[] deleteDtl = deleteDtlList.toArray(new TbbsCtegryDtl[deleteDtlList.size()]);
		TbbsCtegryDtl[] insertDtl = insertDtlList.toArray(new TbbsCtegryDtl[0]);
		TbbsCtegryDtl[] updateDtl = updateDtlList.toArray(new TbbsCtegryDtl[0]);
		TbbsCtegryDtl[] deleteDtl = deleteDtlList.toArray(new TbbsCtegryDtl[0]);
		tbbsCtegryDtlDao.insertMany(insertDtl);
		tbbsCtegryDtlDao.updateMany(updateDtl);
		tbbsCtegryDtlDao.deleteMany(deleteDtl);
	}
}
