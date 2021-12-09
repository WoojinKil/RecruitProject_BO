package kr.co.ta9.pandora3.psys.manager;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.util.CommonUtil;
import kr.co.ta9.pandora3.common.util.BeanUtil;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.pcommon.dto.TbLgapMnuH;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmMnu;
import kr.co.ta9.pandora3.pcommon.dto.usrdef.TsysAdmMnuTree;
import kr.co.ta9.pandora3.psys.dao.TbLgapMnuHDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmMnuDao;

/**
* <pre>
* 1. 클래스명 : PsysCommonMgr
* 2. 설명 : Psys 공통 서비스
* 3. 작성일 : 2018-03-27
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class Psys1002Mgr {

	//private final Log log = LogFactory.getLog(Psys1002Mgr.class);

	@Autowired
	private TsysAdmMnuDao tsysAdmMnuDao;
	
	@Autowired
	private TbLgapMnuHDao tbLgapMnuHDao;

	/**
	 * 메뉴 트리조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public  JSONObject  selectTsysAdmMnuGridTreeList(ParameterMap parameterMap) throws Exception {
		//return tsysAdmMnuDao.selectTsysAdmMnuGridTreeList(parameterMap);
		List<TsysAdmMnuTree> dataList = tsysAdmMnuDao.selectTsysAdmMnuGridTreeList(parameterMap);
		List<Map<String,Object>> mapList = convertObjectToMapList(dataList);
		JSONObject json = new JSONObject();
		json.put("mapList", mapList);
		return json;
	}

	/**
	 * 메뉴 (하위메뉴 조회)
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectTsysAdmMnuDownGridList(ParameterMap parameterMap) throws Exception {
		return tsysAdmMnuDao.selectTsysAdmMnuDownGridList(parameterMap);
	}


	/**
	 * 메뉴 > 등록 및 수정
	 * @param parameterMap
	 * @return menu_id
	 * @throws Exception
	 */
	@Transactional
	public int updateTsysAdmMnuInfo(ParameterMap parameterMap) throws Exception {
		TsysAdmMnu tsysAdmMnu = (TsysAdmMnu)parameterMap.populate(TsysAdmMnu.class);
		// 메뉴 등록 & 수정
		if (TextUtil.isEmpty(parameterMap.getValue("mnu_seq")))  {
			tsysAdmMnuDao.insert(tsysAdmMnu);

			parameterMap.put("mnu_seq", tsysAdmMnu.getMnu_seq());
			parameterMap.put("hist_stat_cd", 10);

			/*
			 * TbLgapMnuH tbLgapMnuH = tsysAdmMnuDao.selectTsysAdmMnuInfo(parameterMap);
			 * if(tbLgapMnuH != null) { tbLgapMnuHDaoTrx.insert(tbLgapMnuH); }
			 */

		} else {
			tsysAdmMnuDao.update(tsysAdmMnu);
			parameterMap.put("mnu_seq", tsysAdmMnu.getMnu_seq());
			parameterMap.put("hist_stat_cd", 30);

			/*
			 * TbLgapMnuH tbLgapMnuH = tsysAdmMnuDao.selectTsysAdmMnuInfo(parameterMap);
			 * if(tbLgapMnuH != null) { tbLgapMnuHDaoTrx.insert(tbLgapMnuH); }
			 */

		}
		return tsysAdmMnu.getMnu_seq();
	}


	/**
	 * 메뉴 (복사메뉴 등록)
	 * @param parameterMap
	 * @throws Exception
	 */
	public int saveTsysAdmMnuCopyInfo(ParameterMap parameterMap, List<TsysAdmMnu> topMenuList,
									List<TsysAdmMnu> midMenuList, List<TsysAdmMnu> btmMenuList) throws Exception {
		// 최상위  메뉴 등록
		int top_menu_id = 0;
		String crtrId = parameterMap.getValue("crtr_id");
		String updrId = parameterMap.getValue("updr_id");
		String sysCd =  parameterMap.getValue("sys_cd");
		if(topMenuList != null && !topMenuList.isEmpty()) {
			for(TsysAdmMnu topMenu : topMenuList) {
				topMenu.setCrtr_id(crtrId);
				topMenu.setUpdr_id(updrId);
				topMenu.setSys_cd(sysCd);

				if(topMenu.getMnu_dpth()==1){
					topMenu.setUp_mnu_seq(0);
				}
				tsysAdmMnuDao.insertTsysAdmMnuCopy(topMenu);
				top_menu_id = topMenu.getMnu_seq();

				Map<String,Object> tbMnuHMap = CommonUtil.convertObjectToMap(topMenu);
				parameterMap.put("mnu_seq", topMenu.getMnu_seq());
				parameterMap.put("hist_stat_cd", 10);
				TbLgapMnuH tbLgapMnuH = tsysAdmMnuDao.selectTsysAdmMnuInfo(tbMnuHMap);
				if(tbLgapMnuH != null) {
					tbLgapMnuHDao.insert(tbLgapMnuH);
				}


			}
			if(midMenuList != null && !midMenuList.isEmpty()) {
				int mid_menu_id = 0;
				for(TsysAdmMnu midMenu : midMenuList) {
					// 중간 메뉴 등록
					midMenu.setCrtr_id(crtrId);
					midMenu.setUpdr_id(updrId);
					midMenu.setUp_mnu_seq(top_menu_id);
					midMenu.setSys_cd(sysCd);
					tsysAdmMnuDao.insertTsysAdmMnuCopy(midMenu);

					Map<String,Object> tbMnuHMap = CommonUtil.convertObjectToMap(midMenu);
					parameterMap.put("mnu_seq", midMenu.getMnu_seq());
					parameterMap.put("hist_stat_cd", 10);
					TbLgapMnuH tbLgapMnuH = tsysAdmMnuDao.selectTsysAdmMnuInfo(tbMnuHMap);
					if(tbLgapMnuH != null) {
						tbLgapMnuHDao.insert(tbLgapMnuH);
					}

					mid_menu_id = midMenu.getMnu_seq();
					String midGrpId = midMenu.getMid_group();
					if(btmMenuList != null && !btmMenuList.isEmpty()) {
						for(TsysAdmMnu btmMenu : btmMenuList) {
							// 하위 템플릿 등록
							if(midGrpId.equals(btmMenu.getMid_group())){
								btmMenu.setCrtr_id(crtrId);
								btmMenu.setUpdr_id(updrId);
								btmMenu.setUp_mnu_seq(mid_menu_id);
								btmMenu.setSys_cd(sysCd);
								tsysAdmMnuDao.insertTsysAdmMnuCopy(btmMenu);

								Map<String,Object> tbMnuHBMap = CommonUtil.convertObjectToMap(btmMenu);
								parameterMap.put("mnu_seq", btmMenu.getMnu_seq());
								parameterMap.put("hist_stat_cd", 10);
								TbLgapMnuH tbLgapBMnuH = tsysAdmMnuDao.selectTsysAdmMnuInfo(tbMnuHBMap);
								if(tbLgapBMnuH != null) {
									tbLgapMnuHDao.insert(tbLgapBMnuH);
								}

							}

						}
					}
				}
			}
		}

		return top_menu_id;
	}

	/**
	 * 메뉴 (하위메뉴 수정/삭제)
	 * @param parameterMap
	 * @throws Exception
	 */
	public void savePsys100203(ParameterMap parameterMap) throws Exception {
		// 템플릿 정보 갱신
		List<TsysAdmMnu> insertList1 = new ArrayList<TsysAdmMnu>();
		List<TsysAdmMnu> updateList1 = new ArrayList<TsysAdmMnu>();
		List<TsysAdmMnu> deleteList1 = new ArrayList<TsysAdmMnu>();
		parameterMap.populates(TsysAdmMnu.class, insertList1, updateList1, deleteList1);

		TsysAdmMnu[] insert1 = insertList1.toArray(new TsysAdmMnu[0]);
		TsysAdmMnu[] update1 = updateList1.toArray(new TsysAdmMnu[0]);

		//  URL은 고정값
		for(int i=0; i<update1.length; i++) {
			update1[i].setUrl(null);
		}
		tsysAdmMnuDao.insertMany(insert1);
		tsysAdmMnuDao.updateMany(update1);

		// 삭제 대상 추출
		String[] menu_id_arr = parameterMap.getArray("mnu_seq_arr[]");
		String chgFlag = parameterMap.getValue("chgFlag");

		if("DELETE".equals(chgFlag)) {
			HashMap<String, Object> param = new HashMap<String, Object>();
			String mod_id = parameterMap.getValue("mod_id");
			for(int i=0; i<menu_id_arr.length; i++) {
				param.put("mod_id", mod_id);
				param.put("mnu_seq", menu_id_arr[i]);
				// 메뉴 정보 삭제
				param.put("hist_stat_cd", 20);
				param.put("crtr_id", parameterMap.getUserInfo().getUser_id());
				param.put("updr_id", parameterMap.getUserInfo().getUser_id());
				TbLgapMnuH tbLgapMnuH = tsysAdmMnuDao.selectTsysAdmMnuOneInfo(param);

				tsysAdmMnuDao.deleteTsysAdmMnuMappingAll(param);

/*				if(tbLgapMnuH != null) {     //이력테이블 없음
					tbLgapMnuHDaoTrx.insert(tbLgapMnuH);
				}*/
			}
		}

		// 메뉴 정보 갱신
		List<TsysAdmMnu> insertList2 = new ArrayList<TsysAdmMnu>();
		List<TsysAdmMnu> updateList2 = new ArrayList<TsysAdmMnu>();
		List<TsysAdmMnu> deleteList2 = new ArrayList<TsysAdmMnu>();
		parameterMap.populates(TsysAdmMnu.class, insertList2, updateList2, deleteList2);

		TsysAdmMnu[] insert2 = insertList2.toArray(new TsysAdmMnu[0]);
		TsysAdmMnu[] update2 = updateList2.toArray(new TsysAdmMnu[0]);
		tsysAdmMnuDao.insertMany(insert2);
		tsysAdmMnuDao.updateMany(update2);
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
	 * Object to Map
	 * @param String
	 * @return
	 * @throws Exception
	 */
	public List<TsysAdmMnu> url(String url) throws Exception{
		return tsysAdmMnuDao.url(url);
	}
}
