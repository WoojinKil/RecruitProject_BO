package kr.co.ta9.pandora3.psys.manager;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.pmbr.dao.TmbrAdmLgnInfDao;
import kr.co.ta9.pandora3.psys.dao.TsysJobInfDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmGrpRolDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmRolDao;

/**
 * <pre>
 * 1. 클래스명 : Psys1008Mgr
 * 2. 설명 : 시스템사용자권한관리 서비스
 * 3. 작성일 : 2018-03-28
 * 4. 작성자 : TANINE
 * </pre>
 */

@Service
public class Psys1061Mgr {
	
	
	@Autowired
	private TmbrAdmLgnInfDao tmbrAdmLgnInfDao;
	
	@Autowired
	private TsysAdmRolDao tsysAdmRolDao;
	
	@Autowired
	private TsysJobInfDao tsysJobInfDao;
	
	@Autowired
	private TsysAdmGrpRolDao tsysAdmGrpRolDao;
	
	/**
	 * 사원관리 > 사용자별 권한 조회 > 사원조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectTmbrAdmLgnInfRolList(ParameterMap parameterMap) throws Exception {
		JSONObject json = tmbrAdmLgnInfDao.selectTmbrAdmLgnInfRolList(parameterMap);
		
		List<Map<String,Object>> mapList = (List<Map<String,Object>>)json.get("rows");
		
		for(Map<String,Object> map : mapList) {
			if(TextUtil.isEmpty(map.get("JOB_CD"))){
				map.put("JOB_NM", "-");
			} else {
				ArrayList<String> hrJobArr = new ArrayList<String>();
				String[] hr_job_tmp = map.get("JOB_CD").toString().split(",");
				for(String hr_job : hr_job_tmp) {
					hrJobArr.add(hr_job);
				}
				parameterMap.put("job_cd", hrJobArr);
				String job_nm = tsysJobInfDao.selectTsysJobInfNms(parameterMap);
				if(TextUtil.isEmpty(job_nm)){
					map.put("JOB_NM", "-");
				} else {
					map.put("JOB_NM", job_nm);
				}
				
			}
			if(TextUtil.isEmpty(map.get("GRP_ROL_ID"))){
				map.put("GRP_ROL_NM", "권한없음");
			} else {
				ArrayList<String> grpRolIdArr = new ArrayList<String>();
				String[] grp_rol_id_tmp = map.get("GRP_ROL_ID").toString().split(",");
				for(String grp_rol_id : grp_rol_id_tmp) {
					if(!grpRolIdArr.contains(grp_rol_id)) {
						grpRolIdArr.add(grp_rol_id);
					}
				}
				parameterMap.put("grp_rol_id", grpRolIdArr);
				String grp_rol_nm = tsysAdmGrpRolDao.selectTsysAdmGrpRolNms(parameterMap);
				if(TextUtil.isEmpty(grp_rol_nm)){
					map.put("GRP_ROL_NM", "권한없음");
				} else {
					map.put("GRP_ROL_NM", grp_rol_nm);
				}
				
			}
			
			
		}
		
		return json;
	}

	/**
	 * 사원관리 > 사용자별 권한조회 > 사원별 권한 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectTmbrAdmLgnInfRolRtnnList(ParameterMap parameterMap) throws Exception {
		return tsysAdmRolDao.selectTmbrAdmLgnInfRolRtnnList(parameterMap);
	}


}
