package kr.co.ta9.pandora3.psys.manager;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.util.CommonUtil;
import kr.co.ta9.pandora3.common.util.BeanUtil;
import kr.co.ta9.pandora3.pcommon.dto.TsysLogInf;
import kr.co.ta9.pandora3.psys.dao.TsysLogInfDao;

/**
 * <pre>
 * 1. 클래스명 : Psys1022Mgr
 * 2. 설명: 메뉴접속이력 서비스
 * 3. 작성일 : 2018-04-24
 * 4.작성자   : TANINE
 * </pre>
 */

@Service
public class Psys1022Mgr {
	@Autowired
	private TsysLogInfDao tsysLogInfDao;

	/**
	 * 로그인이력 그리드리스트
	 * @param parameterMap
	 * @throws Exception
	 */
	public JSONObject selectTsysLogInfList(ParameterMap parameterMap) throws Exception {
		return tsysLogInfDao.selectTsysLogInfList(parameterMap);
	}

	/**
	 * 로그인이력 리스트 Array
	 * @param parameterMap
	 * @throws Exception
	 */
	public JSONObject selectTsysLogInfArrayList(ParameterMap parameterMap) throws Exception {
		//
		List<TsysLogInf> listMap = tsysLogInfDao.selectTsysLogInfArrayList(parameterMap);

		ArrayList<TsysLogInf> listMnuAccess =   new ArrayList<TsysLogInf> ();
		 for (TsysLogInf tsysLogInf : listMap) {
				 String ipAddr = CommonUtil.getIpMasking(tsysLogInf.getIp_addr());
				 tsysLogInf.setIp_addr(ipAddr);
				 listMnuAccess.add(tsysLogInf);
			}

			List<Map<String,Object>> mapList = BeanUtil.convertObjectToMapList(listMnuAccess);
			long totalCount = 0;
			int totalPage = 0;
			if (!mapList.isEmpty()) {
				totalCount = mapList.get(0).get("TOTAL_COUNT") == null? 0 : Long.valueOf(String.valueOf(mapList.get(0).get("TOTAL_COUNT")));
				totalPage = mapList.get(0).get("TOTAL_PAGE") == null? 0 : Integer.valueOf(String.valueOf(mapList.get(0).get("TOTAL_PAGE")));
			}
			JSONObject json = new JSONObject();
			json.put("records", totalCount);
			json.put("total", totalPage);
			json.put("page", parameterMap.getInt("page"));
			//json.put("rows", parameterMap.getValue("rows"));
			json.put("rows", mapList);

		return json;
	}




}
