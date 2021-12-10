package kr.co.ta9.pandora3.psys.manager;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pcmn.dao.TcmnCdDtlDao;
import kr.co.ta9.pandora3.pcmn.dao.TcmnCdMstDao;
import kr.co.ta9.pandora3.pcommon.dto.TcmnCdDtl;
import kr.co.ta9.pandora3.pcommon.dto.TcmnCdMst;

/**
* <pre>
* 1. 클래스명 : Psys1005Mgr
* 2. 설명 : 코드관리 서비스
* 3. 작성일 : 2018-03-27
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class Psys1005Mgr {

	@Autowired
	private TcmnCdMstDao tcmnCdMstDao;
	@Autowired
	private TcmnCdDtlDao tcmnCdDtlDao;

	/**
	 * 마스터코드 리스트 조회
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTcmnCdMstGridList(ParameterMap parameterMap) throws Exception {
		return tcmnCdMstDao.selectTcmnCdMstGridList(parameterMap);
	}

	/**
	 * 코드 입력/수정/삭제
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTcmnCdMst(ParameterMap parameterMap) throws Exception {
		int cnt = 0;
		List<TcmnCdMst> insertList = new ArrayList<TcmnCdMst>();
		List<TcmnCdMst> updateList = new ArrayList<TcmnCdMst>();
		List<TcmnCdMst> deleteList = new ArrayList<TcmnCdMst>();
		parameterMap.populates(TcmnCdMst.class, insertList, updateList, deleteList);

		TcmnCdMst[] insert = insertList.toArray(new TcmnCdMst[0]);
		TcmnCdMst[] update = updateList.toArray(new TcmnCdMst[0]);
		TcmnCdMst[] delete = deleteList.toArray(new TcmnCdMst[0]);

		if (!insertList.isEmpty()) {
			for (TcmnCdMst tcmnCdMst : insertList) {
				parameterMap.put("mst_cd", tcmnCdMst.getMst_cd());
				cnt = tcmnCdMstDao.selectTcmnCdMstCnt(parameterMap);
			}
		}
		if(cnt != 0) {
			parameterMap.put("MSG", "이미 같은 ID가 존재합니다.");
			//throw new Exception();
		}else{
			tcmnCdMstDao.insertMany(insert);
//			tcmnCdMstDao.insertMany(TcmnCdMst.class，insert);
			tcmnCdMstDao.updateMany("TcmnCdMst.update", update);
			tcmnCdMstDao.deleteMany("TcmnCdMst.delete", delete);
			tcmnCdMstDao.deleteTcmnCdDtl(delete);
		}
	}

	/**
	 * 코드상세 리스트 조회
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTcmnCdDtlGridList(ParameterMap parameterMap) throws Exception {
		return tcmnCdDtlDao.selectTcmnCdDtlGridList(parameterMap);
	}

	/**
	 * 코드상세 입력/수정/삭제
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTcmnCdDtl(ParameterMap parameterMap) throws Exception {
		
		List<TcmnCdDtl> insertList = new ArrayList<TcmnCdDtl>();
		List<TcmnCdDtl> updateList = new ArrayList<TcmnCdDtl>();
		List<TcmnCdDtl> deleteList = new ArrayList<TcmnCdDtl>();

		parameterMap.populates(TcmnCdDtl.class, insertList, updateList, deleteList);

		TcmnCdDtl[] insert = insertList.toArray(new TcmnCdDtl[0]);
		TcmnCdDtl[] update = updateList.toArray(new TcmnCdDtl[0]);
		TcmnCdDtl[] delete = deleteList.toArray(new TcmnCdDtl[0]);
		

		tcmnCdDtlDao.insertMany(TcmnCdDtl.class, insert);
		tcmnCdDtlDao.updateMany("TcmnCdDtl.update", update);
		tcmnCdDtlDao.deleteMany("TcmnCdDtl.delete", delete);
	}

	/**
	 * 코드상세 입력/수정/삭제
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTcmnAlll(ParameterMap parameterMap) throws Exception {
		List<TcmnCdMst> insertList = new ArrayList<TcmnCdMst>();
		List<TcmnCdMst> updateList = new ArrayList<TcmnCdMst>();
		List<TcmnCdMst> deleteList = new ArrayList<TcmnCdMst>();
		parameterMap.populates(TcmnCdMst.class, insertList, updateList, deleteList,"masterdata");

		System.out.println("saveTcmnAlll에서의 parameter값"+ parameterMap);
		
		//Map<String,String> resultMap = new HashMap<String,String>();
		//resultMap = parameterMap.parseFormData("formdata");

		/*if (insertList.size() > 0) {
			for (SysCdDtl sysCdDtl : insertList) {
				parameterMap.put("mst_cd", sysCdDtl.getMst_cd());
				parameterMap.put("cd", sysCdDtl.getCd());
				cnt = tcmnCdDtlDao.selectTcmnCdDtlCnt(parameterMap);
			}
		}

		if(cnt != 0) {
			parameterMap.put("MSG", "이미 같은 ID가 존재합니다.");
		}*/

		TcmnCdMst[] insert = insertList.toArray(new TcmnCdMst[0]);
		TcmnCdMst[] update = updateList.toArray(new TcmnCdMst[0]);
		TcmnCdMst[] delete = deleteList.toArray(new TcmnCdMst[0]);

		System.out.println("insert 값은"+insert);
		
		tcmnCdMstDao.insertMany("TcmnCdMst.insert", insert);
		tcmnCdMstDao.updateMany("TcmnCdMst.update", update);
		tcmnCdMstDao.deleteMany("TcmnCdMst.delete", delete);
		tcmnCdMstDao.deleteTcmnCdDtl(delete);


		List<TcmnCdDtl> insertDtlList = new ArrayList<TcmnCdDtl>();
		List<TcmnCdDtl> updateDtlList = new ArrayList<TcmnCdDtl>();
		List<TcmnCdDtl> deleteDtlList = new ArrayList<TcmnCdDtl>();

		parameterMap.populates(TcmnCdDtl.class, insertDtlList, updateDtlList, deleteDtlList,"dtldata");

		TcmnCdDtl[] insertDtl = insertDtlList.toArray(new TcmnCdDtl[0]);
		TcmnCdDtl[] updateDtl = updateDtlList.toArray(new TcmnCdDtl[0]);
		TcmnCdDtl[] deleteDtl = deleteDtlList.toArray(new TcmnCdDtl[0]);
		tcmnCdDtlDao.insertMany("TcmnCdDtl.insert", insertDtl);
		tcmnCdDtlDao.updateMany("TcmnCdDtl.update", updateDtl);
		tcmnCdDtlDao.deleteMany("TcmnCdDtl.delete", deleteDtl);
	}
}
