package kr.co.ta9.pandora3.psys.manager;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.util.CommonUtil;
import kr.co.ta9.pandora3.common.util.BeanUtil;
import kr.co.ta9.pandora3.pcmn.dao.TcmnCdDtlDao;
import kr.co.ta9.pandora3.pcommon.dto.TmbrUsrLgnInf;
import kr.co.ta9.pandora3.pmbr.dao.TmbrUsrLgnInfDao;

/**
 * <pre>
 * 1. 클래스명 : Psys1021Mgr
 * 2. 설명: 로그인이력 서비스
 * 3. 작성일 : 2018-04-24
 * 4. 작성자 : TANINE
 * </pre>
 */

@Service
public class Psys1021Mgr {
	
	@Autowired
	private TmbrUsrLgnInfDao tmbrUsrLgnInfDao;
	
	@Autowired
	private TcmnCdDtlDao tcmnCdDtlDao;

	/**
	 * 로그인이력 그리드리스트
	 * @param parameterMap
	 * @throws Exception
	 */
	public JSONObject selectTmbrUsrLgnInfList(ParameterMap parameterMap) throws Exception {
		return tmbrUsrLgnInfDao.selectTmbrUsrLgnInfList(parameterMap);
	}

	/**
	 * 로그인이력 그리드리스트
	 * @param parameterMap
	 * @throws Exception
	 */
	public JSONObject selectTmbrUsrLgnInfArrayList(ParameterMap parameterMap) throws Exception {
		
		//로그인 이력이 적재되는 사이트 목록 조회 // 공통코드에서 관리한다.
		List<String> sitArr = tcmnCdDtlDao.selectTcmnCdDtlSitLog();
		
		parameterMap.put("sitArr", sitArr);
		
		System.out.println("-------------------------------------------------------------------");
		System.out.println(sitArr);
		System.out.println("-------------------------------------------------------------------");
		
		List<TmbrUsrLgnInf> listMap = tmbrUsrLgnInfDao.selectTmbrUsrLgnInfArrayList(parameterMap);

		ArrayList<TmbrUsrLgnInf> listMbrLgn =   new ArrayList<TmbrUsrLgnInf> ();
		 for (TmbrUsrLgnInf tmbrUsrLgnInf : listMap) {
				 String ipAddr = CommonUtil.getIpMasking(tmbrUsrLgnInf.getIp_addr());
				 tmbrUsrLgnInf.setIp_addr(ipAddr);
				 listMbrLgn.add(tmbrUsrLgnInf);
			}

			List<Map<String,Object>> mapList = BeanUtil.convertObjectToMapList(listMbrLgn);
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
