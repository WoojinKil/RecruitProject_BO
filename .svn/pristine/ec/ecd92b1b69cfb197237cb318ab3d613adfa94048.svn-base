package kr.co.ta9.pandora3.pdsp.manager;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mysql.jdbc.StringUtils;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.BeanUtil;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.pcommon.dto.TdspTmplInf;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmMnu;
import kr.co.ta9.pandora3.pdsp.dao.TdspTmplInfDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmMnuDao;
/**
* <pre>
* 1. 클래스명 : Pdsp1004Mgr
* 2. 설명: 메뉴전시관리
* 3. 작성일 : 2018-03-29
* 4.작성자   : TANINE
* </pre>
*/
@Service
public class Pdsp1004Mgr {
	@Autowired
	private TdspTmplInfDao tdspTmplInfDao;
	@Autowired
	private TsysAdmMnuDao tsysAdmMnuDao;

	/**
	 * 템플릿 리스트 조회 (메뉴 매핑여부 포함)
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public JSONObject selectTdspTmplInfMpnList() throws Exception {
		List<TdspTmplInf> dataList       = tdspTmplInfDao.selectTdspTmplInfMpnList();
		List<Map<String,Object>> mapList = convertObjectToMapList(dataList);
		JSONObject json = new JSONObject();
		json.put("mapList", mapList);
		return json;
	}

	/**
	 * 템플릿 목록 조회(그리드형)
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectTdspTmplInfGridList(ParameterMap parameterMap) throws Exception {
		return tdspTmplInfDao.selectTdspTmplInfGridList(parameterMap);
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
		List<Field> fields        = BeanUtil.getAllDeclaredFields(object.getClass());
		for (Field field : fields) {
			field.setAccessible(true);
			result.put(field.getName(), field.get(object));
		}
		return result;
	}

	/**
	 * 템플릿 전시 트리 조회
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public JSONObject selectTdspTmplInfDispTreeList(ParameterMap parameterMap) throws Exception {
		List<TdspTmplInf> dataList       = tdspTmplInfDao.selectTdspTmplInfDispTreeList(parameterMap);
		List<Map<String,Object>> mapList = convertObjectToMapList(dataList);
		JSONObject json = new JSONObject();
		json.put("mapList", mapList);
		return json;
	}

	/**
	 * BO : 전시메뉴 (복사메뉴 등록 : 템플릿 포함)
	 * @param parameterMap
	 * @throws Exception
	 */
	public int saveTdspTmplInfInfo(ParameterMap parameterMap, List<TdspTmplInf> topTemList,
									List<TdspTmplInf> midTemList, List<TdspTmplInf> btmTemList) throws Exception {
		// 최상위 템플릿 등록 & 메뉴 등록 & 매핑
		int top_tmpl_seq = 0;
		if(topTemList != null && topTemList.size() > 0) {
			for(TdspTmplInf temp : topTemList) {
				// 최상위 템플릿 등록
				temp = getDispTempForCopy(parameterMap, temp, 0);
				tdspTmplInfDao.insertTdspTmplInfCpy(temp);
				top_tmpl_seq = temp.getTmpl_seq();

				// 메뉴 등록
				TsysAdmMnu frontMenu = getDispMenuForCopy(parameterMap, null);
				tsysAdmMnuDao.insertTsysAdmMnuFrnt(frontMenu);

				// Template & Menu Mapping
				temp.setMnu_seq(frontMenu.getMnu_seq());
				temp.setDsply_yn(parameterMap.getValue("dsply_yn"));
				temp.setDsply_no(Integer.parseInt(parameterMap.getValue("dsply_no")));
				tdspTmplInfDao.update(temp);
			}
			if(midTemList != null && midTemList.size() > 0) {
				int mid_tmpl_seq = 0;
				for(TdspTmplInf temp : midTemList) {
					// 중간 템플릿 등록
					temp = getDispTempForCopy(parameterMap, temp, top_tmpl_seq);
					tdspTmplInfDao.insertTdspTmplInfCpy(temp);
					mid_tmpl_seq = temp.getTmpl_seq();

					// 메뉴 등록
					TsysAdmMnu frontMenu = getDispMenuForCopy(parameterMap, temp);
					tsysAdmMnuDao.insertTsysAdmMnuFrnt(frontMenu);

					// Template & Menu Mapping
					temp.setMnu_seq(frontMenu.getMnu_seq());
					tdspTmplInfDao.update(temp);
				}
				if(btmTemList != null && btmTemList.size() > 0) {
					for(TdspTmplInf temp : btmTemList) {
						// 최하위 템플릿 등록
						temp = getDispTempForCopy(parameterMap, temp, mid_tmpl_seq);
						tdspTmplInfDao.insertTdspTmplInfCpy(temp);

						// 메뉴 등록
						TsysAdmMnu frontMenu = getDispMenuForCopy(parameterMap, temp);
						tsysAdmMnuDao.insertTsysAdmMnuFrnt(frontMenu);

						// Template & Menu Mapping
						temp.setMnu_seq(frontMenu.getMnu_seq());
						tdspTmplInfDao.update(temp);
					}
				}
			}
		}
		return top_tmpl_seq;
	}

	/**
	 * BO : 전시메뉴 (하위메뉴 수정/삭제)
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTdspTmplInf(ParameterMap parameterMap) throws Exception {
		// 템플릿 정보 갱신
		List<TdspTmplInf> insertList1 = new ArrayList<TdspTmplInf>();
		List<TdspTmplInf> updateList1 = new ArrayList<TdspTmplInf>();
		List<TdspTmplInf> deleteList1 = new ArrayList<TdspTmplInf>();
		parameterMap.populates(TdspTmplInf.class, insertList1, updateList1, deleteList1);

		TdspTmplInf[] insert1 = insertList1.toArray(new TdspTmplInf[insertList1.size()]);
		TdspTmplInf[] update1 = updateList1.toArray(new TdspTmplInf[updateList1.size()]);
//		Template[] delete1 = deleteList1.toArray(new Template[deleteList1.size()]);

		// 템플릿 URL은 고정값
		for(int i=0; i<update1.length; i++) {
			update1[i].setTmpl_url(null);
		}

		tdspTmplInfDao.insertMany(insert1);
		tdspTmplInfDao.updateMany(update1);
//		tdspTmplInfDao.deleteMany(delete1);

		// 삭제 대상 추출
		String[] mnu_seq_arr = parameterMap.getArray("mnu_seq_arr[]");
		String chgFlag = parameterMap.getValue("chgFlag");

		if("DELETE".equals(chgFlag)) {
			HashMap<String, Object> param = new HashMap<String, Object>();
			String updr_id = parameterMap.getValue("updr_id");
			for(int i=0; i<mnu_seq_arr.length; i++) {
				param.put("updr_id", updr_id);
				param.put("mnu_seq", mnu_seq_arr[i]);
				// 메뉴 정보 삭제
				tsysAdmMnuDao.deleteTsysAdmMnuMappingAll(param);
				// 템플릿 정보 초기화
				tdspTmplInfDao.updateTdspTmplInfMpn(param);
			}
		}

		// 메뉴 정보 갱신
		List<TsysAdmMnu> insertList2 = new ArrayList<TsysAdmMnu>();
		List<TsysAdmMnu> updateList2 = new ArrayList<TsysAdmMnu>();
		List<TsysAdmMnu> deleteList2 = new ArrayList<TsysAdmMnu>();
		parameterMap.populates(TsysAdmMnu.class, insertList2, updateList2, deleteList2);

		TsysAdmMnu[] insert2 = insertList2.toArray(new TsysAdmMnu[insertList2.size()]);
		TsysAdmMnu[] update2 = updateList2.toArray(new TsysAdmMnu[updateList2.size()]);
//		TsysAdmMnu[] delete2 = deleteList2.toArray(new TsysAdmMnu[deleteList2.size()]);
		tsysAdmMnuDao.insertMany(insert2);
		tsysAdmMnuDao.updateMany(update2);
//		tsysAdmMnuDaoTrx.deleteMany(delete2);
	}

	/**
	 * 전시메뉴 > 등록 및 수정
	 * @param parameterMap
	 * @return mnu_seq
	 * @throws Exception
	 */
	@Transactional
	public int updateMenuDispInfo(ParameterMap parameterMap) throws Exception {
		TsysAdmMnu frontMenu = (TsysAdmMnu)parameterMap.populate(TsysAdmMnu.class);

		// Front 메뉴 등록 & 수정
		if (TextUtil.isEmpty(parameterMap.getValue("mnu_seq")))  {
			tsysAdmMnuDao.insertTsysAdmMnuFrnt(frontMenu);
		} else {
//
			tsysAdmMnuDao.update(frontMenu);
		}

		// Template & Menu Mapping
		TdspTmplInf tdspTmplInf = new TdspTmplInf();
		
		tdspTmplInf.setUpdr_id(parameterMap.getValue("updr_id"));
		tdspTmplInf.setMnu_seq(frontMenu.getMnu_seq());
		tdspTmplInf.setTmpl_seq(Integer.parseInt(parameterMap.getValue("tmpl_seq")));
		tdspTmplInf.setUp_tmpl_seq(frontMenu.getUp_tmpl_seq());
		tdspTmplInf.setDsply_yn(parameterMap.getValue("dsply_yn"));
		
		if(!StringUtils.isNullOrEmpty(parameterMap.getValue("dsply_no")))
			tdspTmplInf.setDsply_no(Integer.parseInt(parameterMap.getValue("dsply_no")));

		// 템플릿 매핑 초기화2(템플릿 변경 전 나머지 리셋 )
		tdspTmplInfDao.updateTdspTmplInfMpnMnu(parameterMap);
		// 템플릿 업데이트
		tdspTmplInfDao.update(tdspTmplInf);

		return tdspTmplInf.getMnu_seq();
	}

	/**
	 * BO : 전시메뉴 (하위메뉴 조회)
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectTdspTmplInfDwnDspMnuGridList(ParameterMap parameterMap) throws Exception {
		return tdspTmplInfDao.selectTdspTmplInfDwnDspMnuGridList(parameterMap);
	}

	/**
	 * 전시메뉴 복사 매핑용 템플릿 정보 취득
	 * @param parameterMap
	 * @param template
	 * @return
	 * @throws Exception
	 */
	private TdspTmplInf getDispTempForCopy(ParameterMap parameterMap, TdspTmplInf tdspTmplInf, int upp_tmp_seq) throws Exception {
		tdspTmplInf.setCrtr_id(parameterMap.getValue("crtr_id"));
		tdspTmplInf.setUpdr_id(parameterMap.getValue("updr_id"));
		tdspTmplInf.setTmpl_url(tdspTmplInf.getTmpl_url());
		if(upp_tmp_seq != 0)	tdspTmplInf.setUp_tmpl_seq(upp_tmp_seq);

		return tdspTmplInf;
	}
	/**
	 * 전시메뉴 복사 매핑용 메뉴정보 취득
	 * @param parameterMap
	 * @param template
	 * @return
	 * @throws Exception
	 */
	private TsysAdmMnu getDispMenuForCopy(ParameterMap parameterMap, TdspTmplInf tdspTmplInf) throws Exception {
		// 메뉴 등록
		TsysAdmMnu frontMenu = new TsysAdmMnu();
		frontMenu.setFrnt_yn("Y");
		frontMenu.setCrtr_id(parameterMap.getValue("crtr_id"));
		frontMenu.setUpdr_id(parameterMap.getValue("updr_id"));
		if(tdspTmplInf == null) {
			frontMenu.setMnu_nm(parameterMap.getValue("mnu_nm"));
			frontMenu.setMnu_yn(parameterMap.getValue("mnu_yn"));
			frontMenu.setSys_cd(parameterMap.getValue("sys_cd"));
			if(!StringUtils.isNullOrEmpty(parameterMap.getValue("tmpl_url"))) frontMenu.setUrl(parameterMap.getValue("tmpl_url"));
		} else {
			frontMenu.setMnu_nm(tdspTmplInf.getMnu_nm());
			frontMenu.setMnu_yn(tdspTmplInf.getMnu_yn());
			frontMenu.setUp_mnu_seq(tdspTmplInf.getUp_tmpl_seq());
			frontMenu.setUp_tmpl_seq(tdspTmplInf.getUp_tmpl_seq());
		}

		return frontMenu;
	}
}
