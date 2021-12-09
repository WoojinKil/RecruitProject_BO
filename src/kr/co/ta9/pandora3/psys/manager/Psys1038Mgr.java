package kr.co.ta9.pandora3.psys.manager;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.util.CommonUtil;
import kr.co.ta9.pandora3.pcommon.dto.TdspSysInf;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmGrpRolRtnn;
import kr.co.ta9.pandora3.pdsp.dao.TdspSysInfDao;
import kr.co.ta9.pandora3.psys.dao.TbLgapGrprolrtnnHDaoTrx;
import kr.co.ta9.pandora3.psys.dao.TsysAdmGrpRolRtnnDao;

/**
* <pre>
* 1. 클래스명 : Psys1006Mgr
* 2. 설명 : 권한관리 서비스
* 3. 작성일 : 2018-03-28
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class Psys1038Mgr {

	@Autowired
	private TsysAdmGrpRolRtnnDao tsysAdmGrpRolRtnnDao;
	
	@Autowired
	private TbLgapGrprolrtnnHDaoTrx tbLgapGrprolrtnnHDaoTrx;

	@Autowired
	private TdspSysInfDao tdspSysInfDao;



	/**
	 * 그룹 권한 매핑 목록
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTsysAdmGrpRolRtnnGridList(ParameterMap parameterMap) throws Exception {
		return tsysAdmGrpRolRtnnDao.selectTsysAdmGrpRolRtnnGridList(parameterMap);
	}

	/**
	 * 그룹 권한 매핑 권한 저장
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTsysAdmGrpRolRtnnList(ParameterMap parameterMap) throws Exception {
		//JQGRIDDATA
		String jsonString = parameterMap.getValue("JQGRIDDATA",false);
		JSONParser jsonParser = new JSONParser();
		Object jsonObject = jsonParser.parse(jsonString);
		JSONArray jsonArray = (JSONArray)jsonObject;
		String strSite ="";
		ParameterMap siteParam = new ParameterMap();
		siteParam.put("rol_yn", "Y");
		List<TdspSysInf> listSysInfo = tdspSysInfDao.selectSitList(siteParam);
		for(TdspSysInf  tdspSysInf : listSysInfo) {
			strSite = strSite .concat(tdspSysInf.getSys_abrv() +",");
		}


		ArrayList<TsysAdmGrpRolRtnn> arGrpRolRtnn = new ArrayList<TsysAdmGrpRolRtnn>();
		for (int i = 0; i < jsonArray.size(); i++) {
			JSONObject json = (JSONObject)jsonArray.get(i);
			TsysAdmGrpRolRtnn tmpTsysAdmGrpRolRtnn  = new TsysAdmGrpRolRtnn();
			String grpRolId=String.valueOf(json.get("GRP_ROL_ID"));
			tmpTsysAdmGrpRolRtnn.setGrp_rol_id(grpRolId);
			String[] arSite = strSite.split(",");
			for(int k=0; k < arSite.length; k++){
				String tmpRolId="";
				TsysAdmGrpRolRtnn tsysAdmGrpRolRtnn  = new TsysAdmGrpRolRtnn();
				if(json.get(arSite[k]) != null && String.valueOf(json.get(arSite[k]))!="" && ! "0".equals(String.valueOf(json.get(arSite[k])))){
					tmpRolId = String.valueOf(json.get(arSite[k]));
					tsysAdmGrpRolRtnn.setGrp_rol_id(grpRolId);
					tsysAdmGrpRolRtnn.setRol_id(tmpRolId);
					arGrpRolRtnn.add(tsysAdmGrpRolRtnn);
					//arGrpRolRtnn.add
				}
			}

			tmpTsysAdmGrpRolRtnn.setUsr_id(parameterMap.getValue("user_id"));
			//현재 등록된 권한 그룹에 대한 이력및 삭제처리를 위한 조회
			List<TsysAdmGrpRolRtnn> tsysAdmGrpRols = tsysAdmGrpRolRtnnDao.selectTsysAdmGrpRolRtnnList(tmpTsysAdmGrpRolRtnn);

			for(TsysAdmGrpRolRtnn  tsysAdmGrpRol : tsysAdmGrpRols) {

				Map<String,Object> tsysAdmGrpRolRtnnMap = CommonUtil.convertObjectToMap(tsysAdmGrpRol);

				tsysAdmGrpRolRtnnMap.put("hist_stat_cd", "20");
				tsysAdmGrpRolRtnnMap.put("hist_stat_nm", "삭제");
				tbLgapGrprolrtnnHDaoTrx.insertTbLgapGrprolrtnnH(tsysAdmGrpRolRtnnMap);
			}

			tsysAdmGrpRolRtnnDao.deleteGrpId(tmpTsysAdmGrpRolRtnn);


		}

		for(int i=0; i < arGrpRolRtnn.size(); i++){
			TsysAdmGrpRolRtnn tmpGrpRolRtnn = (TsysAdmGrpRolRtnn)arGrpRolRtnn.get(i);
			if(tmpGrpRolRtnn.getRol_id()!=null && tmpGrpRolRtnn.getRol_id()!="" ){   //권한값이 있는경우에만 저장을 함
				tmpGrpRolRtnn.setUsr_id(parameterMap.getValue("user_id"));
				tsysAdmGrpRolRtnnDao.insertGrpRolRtnn(tmpGrpRolRtnn);
				Map<String,Object> tsysAdmGrpRolRtnnMap = CommonUtil.convertObjectToMap(tsysAdmGrpRolRtnnDao.selectTsysAdmGrpRolRtnn(tmpGrpRolRtnn));
				tsysAdmGrpRolRtnnMap.put("hist_stat_cd", "10");
				tsysAdmGrpRolRtnnMap.put("hist_stat_nm", "추가");
				tbLgapGrprolrtnnHDaoTrx.insertTbLgapGrprolrtnnH(tsysAdmGrpRolRtnnMap);

			}

		}








	}

	/**
	 * 그룹 권한 매핑 권한 저장
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTsysAdmGrpRolRtnnList2(ParameterMap parameterMap) throws Exception {
		List<TsysAdmGrpRolRtnn> insertList = new ArrayList<TsysAdmGrpRolRtnn>();
		List<TsysAdmGrpRolRtnn> updateList = new ArrayList<TsysAdmGrpRolRtnn>();
		List<TsysAdmGrpRolRtnn> deleteList = new ArrayList<TsysAdmGrpRolRtnn>();
		parameterMap.populates(TsysAdmGrpRolRtnn.class, insertList, updateList, deleteList);

		//(TsysAdmGrpRol) grid update - >(TsysAdmGrpRolRtnn) 신규 테이블 입력 insert 작업 필요
		TsysAdmGrpRolRtnn[] update = updateList.toArray(new TsysAdmGrpRolRtnn[0]);

		for(TsysAdmGrpRolRtnn tsysAdmGrpRolRtnn : update) {

			tsysAdmGrpRolRtnn.setUsr_id(parameterMap.getValue("user_id"));
			//현재 등록된 권한 그룹에 대한 이력및 삭제처리를 위한 조회
			List<TsysAdmGrpRolRtnn> tsysAdmGrpRols = tsysAdmGrpRolRtnnDao.selectTsysAdmGrpRolRtnnList(tsysAdmGrpRolRtnn);

			// 이력 관련
			for(TsysAdmGrpRolRtnn  tsysAdmGrpRol : tsysAdmGrpRols) {

				Map<String,Object> tsysAdmGrpRolRtnnMap = CommonUtil.convertObjectToMap(tsysAdmGrpRol);

				tsysAdmGrpRolRtnnMap.put("hist_stat_cd", "20");
				tsysAdmGrpRolRtnnMap.put("hist_stat_nm", "삭제");
				tbLgapGrprolrtnnHDaoTrx.insertTbLgapGrprolrtnnH(tsysAdmGrpRolRtnnMap);
			}
			// 실제 권한 삭제
			tsysAdmGrpRolRtnnDao.deleteGrpId(tsysAdmGrpRolRtnn);

			if(!"".equals(tsysAdmGrpRolRtnn.getGrp_rol_ids())) {

				String[] rol_ids = tsysAdmGrpRolRtnn.getGrp_rol_ids().split(",");

				for(String rol_id : rol_ids) {

					tsysAdmGrpRolRtnn.setRol_id(rol_id);


					tsysAdmGrpRolRtnnDao.insertGrpRolRtnn(tsysAdmGrpRolRtnn);

					Map<String,Object> tsysAdmGrpRolRtnnMap = CommonUtil.convertObjectToMap(tsysAdmGrpRolRtnnDao.selectTsysAdmGrpRolRtnn(tsysAdmGrpRolRtnn));

					tsysAdmGrpRolRtnnMap.put("hist_stat_cd", "10");
					tsysAdmGrpRolRtnnMap.put("hist_stat_nm", "추가");
					tbLgapGrprolrtnnHDaoTrx.insertTbLgapGrprolrtnnH(tsysAdmGrpRolRtnnMap);

				}
			}


		}
	}


	/**
	 *시스템권한목록 전체조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectRolListAll(ParameterMap parameterMap) throws Exception {
		return tsysAdmGrpRolRtnnDao.selectRolListAll(parameterMap);
	}

	/**
	 *통합그룹 시스템 그룹 매핑 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectTsysAdmGrpRolList(ParameterMap parameterMap) throws Exception {
		List<ParameterMap> dataList =tsysAdmGrpRolRtnnDao.selectTsysAdmGrpRolList(parameterMap);

//		List<HashMap<String,Object> > makeList = new ArrayList<HashMap<String,Object> >();
		JSONArray jArray = new JSONArray();//배열이 필요할때
		for(int i =0; i<dataList.size(); i++){
			ParameterMap tmpMap = (ParameterMap)dataList.get(i);
			String grpRolId= tmpMap.getValue("GRP_ROL_ID");
			String rolId= tmpMap.getValue("ROL_ID");
			//String rolNm= tmpMap.get("ROL_NM").toString();
			//String sitSeq= tmpMap.getValue("SYS_CD");
			String grpRolNm= tmpMap.getValue("GRP_ROL_NM");
			String sitAbrv= tmpMap.getValue("SYS_ABRV");
			JSONObject sObject = new JSONObject();//배열 내에 들어갈 jso
			sObject.put("GRP_ROL_ID", grpRolId);
			sObject.put("GRP_ROL_NM", grpRolNm);
			String[] arSitAbrv = sitAbrv.split(",");
			String[] arRolId = rolId.split(",");
			for(int k =0; k<arSitAbrv.length; k++){
				sObject.put(arSitAbrv[k], arRolId[k]);
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
		//if (!makeList.isEmpty()) {
			/*
			totalCount = makeList.get(0).get("TOTAL_COUNT") == null? 0 : Long.valueOf(String.valueOf(makeList.get(0).get("TOTAL_COUNT")));
			totalPage = makeList.get(0).get("TOTAL_PAGE") == null? 0 : Integer.valueOf(String.valueOf(makeList.get(0).get("TOTAL_PAGE")));
			*/
		//}
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

