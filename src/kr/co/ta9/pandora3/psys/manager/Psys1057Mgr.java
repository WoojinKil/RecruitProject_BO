package kr.co.ta9.pandora3.psys.manager;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.BeanUtil;
import kr.co.ta9.pandora3.pcommon.dto.TbBcpcLoginTot;
import kr.co.ta9.pandora3.psys.dao.TbBcpcLoginTotDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmGrpRolDao;

/**
 * <pre>
 * 1. 클래스명 : Psys1057Mgr
 * 2. 설명: 사용자 통계 > 시스템별 접속자 수
 * 3. 작성일 : 2020-04-06
 * 4.작성자   : TANINE
 * </pre>
 */

@Service
public class Psys1057Mgr {
	
	@Autowired
	private TbBcpcLoginTotDao tbBcpcLoginTotDao;
	
	@Autowired
	private TsysAdmGrpRolDao tsysAdmGrpRolDaoDao;
	
	
	
	/**
	 * 사용자 통계 > 시스템별 접속자 수
	 * @param parameterMap
	 * @throws Exception
	 */
	public JSONObject selectTbBcpcLoginTotList(ParameterMap parameterMap) throws Exception {
		return tbBcpcLoginTotDao.selectTbBcpcLoginTotList(parameterMap);
	}

	/**
	 * 사용자 통계 > 시스템별 접속자 수 > 통합 그룹 권한 목록
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectTsysAdmGrpRolList(ParameterMap parameterMap) throws Exception {
		return tsysAdmGrpRolDaoDao.selectTsysAdmGrpRolList(parameterMap);
	}

	/**
	 * 그리드 내에 엑셀 다운로드 
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject getPsys1057XlsxDwld(ParameterMap parameterMap) throws Exception {
		
		List<TbBcpcLoginTot> gridList = new ArrayList<TbBcpcLoginTot>();
		parameterMap.populatesForForceUpdate(TbBcpcLoginTot.class, gridList);
		
		List<Map<String,Object>> mapList = BeanUtil.convertObjectToMapList(gridList);		
		
		JSONObject json = new JSONObject();		
		json.put("rows", mapList);
		
		
		return json;
	}
}
