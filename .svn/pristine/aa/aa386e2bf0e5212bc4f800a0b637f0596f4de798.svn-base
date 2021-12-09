package kr.co.ta9.pandora3.sample;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.BeanUtil;
import kr.co.ta9.pandora3.pcommon.dto.TmbrConnLog;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmRol;
import kr.co.ta9.pandora3.pcommon.dto.usrdef.TsysAdmMnuTree;
import kr.co.ta9.pandora3.pmbr.dao.TmbrConnLogDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmRolDao;

/**
* <pre>
* 1. 클래스명 : Psys1005Mgr
* 2. 설명 : 코드관리 서비스
* 3. 작성일 : 2018-03-27
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class SampleMgr {

	@Autowired
	private SampleDao sampleDao;

	/*@Autowired
	private TmbrCluHstDaoTrx sample1002Dao;*/

	@Autowired
	private TsysAdmRolDao sample1003Dao;


	@Autowired
	private TmbrConnLogDao tmbrConnLogDao;

	@Autowired
	private TsysAdmRolDao tsysAdmRolDao;





	/**
	 * 마스터코드 리스트 조회
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectAdminMnu(ParameterMap parameterMap) throws Exception {
		return sampleDao.selectAdminMnu(parameterMap);
	}

	public void saveSample1002(ParameterMap parameterMap) throws Exception {
/*		TmbrCluHst tmbrCluHst = (TmbrCluHst)parameterMap.populate(TmbrCluHst.class);

		if("Y".equals(parameterMap.getValue("insert_yn"))){
			sample1002Dao.insert(tmbrCluHst);
		}else{
			sample1002Dao.update(tmbrCluHst);
		}*/
	}

	/**
	 * 샘플 고객별 정보 조회 조회 (그리드형)
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTmbrAdmLgnInfGridList(ParameterMap parameterMap) throws Exception {
		return sampleDao.selectTmbrAdmLgnInfGridList(parameterMap);
	}



	public JSONObject selectTeamResultDataGridList(ParameterMap parameterMap) throws Exception {
		return sampleDao.selectTeamResultDataGridList(parameterMap);
	}



	/**
	 * 권한 목록
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTsysAdmRolGridList(ParameterMap parameterMap) throws Exception {
		return sampleDao.selectTsysAdmRolGridList(parameterMap);
	}

	/**
	 * 권한 저장
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTsysAdmRolList(ParameterMap parameterMap) throws Exception {
		int cnt = 0;
		List<TsysAdmRol> insertList = new ArrayList<TsysAdmRol>();
		List<TsysAdmRol> updateList = new ArrayList<TsysAdmRol>();
		List<TsysAdmRol> deleteList = new ArrayList<TsysAdmRol>();
		parameterMap.populates(TsysAdmRol.class, insertList, updateList, deleteList);



		if (!insertList.isEmpty()) {
			for (TsysAdmRol sysAdminRole : insertList) {
				parameterMap.put("rol_id", sysAdminRole.getRol_id());
				cnt = sampleDao.selectTsysAdmRolCnt(parameterMap);
			}
		}

		if(cnt != 0) {
			parameterMap.put("MSG", "이미 같은 ID가 존재합니다.");
			throw new IllegalArgumentException("이미 같은 ID가 존재합니다.");
		}
		
		TsysAdmRol[] insert = insertList.toArray(new TsysAdmRol[0]);
		TsysAdmRol[] update = updateList.toArray(new TsysAdmRol[0]);
		TsysAdmRol[] delete = deleteList.toArray(new TsysAdmRol[0]);

		sample1003Dao.insertMany(insert);
		sample1003Dao.updateMany(update);
		sample1003Dao.deleteMany(delete);
	}

	/**
	 * 샘플 > 타겟 템플릿 관리
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public  JSONObject  selectTsysAdmMnuGridTreeList(ParameterMap parameterMap) throws Exception {
		//return tsysAdmMnuDao.selectTsysAdmMnuGridTreeList(parameterMap);
		List<TsysAdmMnuTree> dataList = sampleDao.selectTsysAdmMnuTestGridTreeList(parameterMap);
		List<Map<String,Object>> mapList = convertObjectToMapList(dataList);
		JSONObject json = new JSONObject();
		json.put("mapList", mapList);
		return json;
	}

	/**
	 * List to List Map
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public List<Map<String,Object>> convertObjectToMapList(List list) throws Exception {
		List<Map<String,Object>> results = new ArrayList<Map<String,Object>>();
		if (list == null) {
			return results;
		}
		for (Object object : list) {
			results.add(convertObjectToMap(object));
		}
		return results;
	}

	/**
	 * Object to Map
	 * @param object
	 * @return
	 * @throws Exception
	 */
	private Map<String,Object> convertObjectToMap(Object object) throws Exception {
		Map<String,Object> result = new HashMap<String,Object>();
		List<Field> fields = BeanUtil.getAllDeclaredFields(object.getClass());
		for (Field field : fields) {
			field.setAccessible(true);
			result.put(field.getName(), field.get(object));
		}
		return result;
	}

	/**
	 * 방문자수/페이지뷰수 조회 : 대시보드
	 * @param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public JSONObject selectVisitorPageviewCountList() throws Exception {
		List<TmbrConnLog> dataList = tmbrConnLogDao.selectTmbrConnSttsVisrAcsCntList();
		List<Map<String,Object>> mapList = this.convertObjectToMapList(dataList);
		JSONObject json = new JSONObject();
		json.put("mapList", mapList);
		return json;
	}

	/**
	 * 샘플 > 그리드 그룹핑 샘플
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectGroupingList(ParameterMap parameterMap) throws Exception {
		return sampleDao.selectGroupingList(parameterMap);
	}

	/**
	 * BO 사용자 리스트 조회
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTmbrAdmLgnInfGridSampleList(ParameterMap parameterMap) throws Exception {
		return sampleDao.selectTmbrAdmLgnInfGridSampleList(parameterMap);
	}


	/**
	 * 일반 컨텐츠
	 * BOARD TYPE1/TYPE2 : 게시판 모듈 목록 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 * 	public JSONObject selectTdspSysInfComboList(ParameterMap parameterMap) throws Exception {
		return TdspSysInfDao.selectTdspSysInfComboList(parameterMap);
	}
	 */
	public JSONObject selectTbbsModlInfCommonList(ParameterMap parameterMap) throws Exception {
		return sampleDao.selectTbbsModlInfCommonList(parameterMap);
	}

	public JSONObject getRolList(ParameterMap parameterMap) throws Exception {
		return sampleDao.selectRolList(parameterMap);
	}
	public JSONObject selectTsysAdmGrpRolList(ParameterMap parameterMap) throws Exception {
		List<ParameterMap> dataList =sampleDao.selectTsysAdmGrpRolList(parameterMap);

//		List<HashMap<String,Object> > makeList = new ArrayList<HashMap<String,Object> >();
//		String oriSitseq ="";
		JSONArray jArray = new JSONArray();//배열이 필요할때
		for(int i =0; i<dataList.size(); i++){
			ParameterMap tmpMap = (ParameterMap)dataList.get(i);
			String grpRolId= tmpMap.getValue("GRP_ROL_ID");
			String rolId= tmpMap.getValue("ROL_ID");
			//String rolNm= tmpMap.get("ROL_NM").toString();
//			String sitSeq= tmpMap.getValue("SYS_CD");
			String grpRolNm= tmpMap.getValue("GRP_ROL_NM");
			String sitPath= tmpMap.getValue("SYS_PTH");
			JSONObject sObject = new JSONObject();//배열 내에 들어갈 jso
			sObject.put("GRP_ROL_ID", grpRolId);
			sObject.put("GRP_ROL_NM", grpRolNm);
			String[] arSitPath = sitPath.split(",");
			String[] arRolId = rolId.split(",");
			for(int k =0; k<arSitPath.length; k++){
				sObject.put(arSitPath[k], arRolId[k]);
			}
			 jArray.add(sObject);

			/*
			HashMap<String,Object> tmpNewMap = new HashMap<String,Object> ();
			tmpNewMap.put("GRP_ROL_ID", grpRolId);
			tmpNewMap.put("GRP_ROL_NM", grpRolNm);
			String[] arSitPath = sitPath.split(",");
			String[] arRolId = rolId.split(",");
			for(int k =0; k<arSitPath.length; k++){
				tmpNewMap.put(arSitPath[k], arRolId[k]);
			}
			makeList.add(tmpNewMap);
			*/

			//tmpNewMap.put(oriSitSeq, "")


		}

		long totalCount = 0;
		int totalPage = 0;
//		if (makeList.size() > 0) {
//			/*
//			totalCount = makeList.get(0).get("TOTAL_COUNT") == null? 0 : Long.valueOf(String.valueOf(makeList.get(0).get("TOTAL_COUNT")));
//			totalPage = makeList.get(0).get("TOTAL_PAGE") == null? 0 : Integer.valueOf(String.valueOf(makeList.get(0).get("TOTAL_PAGE")));
//			*/
//		}
		//totalCount = makeList.size();
		//totalPage = totalCount/page
		//List<Map<String,Object>> mapList = BeanUtil.convertObjectToMapList(makeList);
		JSONObject json = new JSONObject();
		json.put("records", totalCount);
		json.put("total", totalPage);
		json.put("page", parameterMap.getInt("page"));
		//json.put("rows", parameterMap.getValue("rows"));
		json.put("rows", jArray);


		return json;
	}

}