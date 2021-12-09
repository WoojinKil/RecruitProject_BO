package kr.co.ta9.pandora3.psys.manager;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.util.CommonUtil;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmGrpRol;
import kr.co.ta9.pandora3.psys.dao.TbLgapRolHDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmGrpRolDao;

/**
* <pre>
* 1. 클래스명 : Psys1006Mgr
* 2. 설명 : 권한관리 서비스
* 3. 작성일 : 2018-03-28
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class Psys1037Mgr {

	@Autowired
	private TsysAdmGrpRolDao tsysAdmGrpRolDao;
	
	@Autowired
	private TbLgapRolHDao tbLgapRolHDao;

	/**
	 * 그룹 권한 목록
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTsysAdmGrpRolGridList(ParameterMap parameterMap) throws Exception {
		return tsysAdmGrpRolDao.selectTsysAdmGrpRolGridList(parameterMap);
	}

	/**
	 * 그룹 권한 저장
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTsysAdmGrpRolList(ParameterMap parameterMap) throws Exception {
		int cnt = 0;
		List<TsysAdmGrpRol> insertList = new ArrayList<TsysAdmGrpRol>();
		List<TsysAdmGrpRol> updateList = new ArrayList<TsysAdmGrpRol>();
		List<TsysAdmGrpRol> deleteList = new ArrayList<TsysAdmGrpRol>();
		parameterMap.populates(TsysAdmGrpRol.class, insertList, updateList, deleteList);

		TsysAdmGrpRol[] insert = insertList.toArray(new TsysAdmGrpRol[0]);
		TsysAdmGrpRol[] update = updateList.toArray(new TsysAdmGrpRol[0]);
		TsysAdmGrpRol[] delete = deleteList.toArray(new TsysAdmGrpRol[0]);

		if (!insertList.isEmpty()) {
			for (TsysAdmGrpRol sysAdminGroRole : insertList) {
				parameterMap.put("grp_rol_id", sysAdminGroRole.getGrp_rol_id());
				cnt = tsysAdmGrpRolDao.selectTsysAdmGrpRolCnt(parameterMap);
			}
		}

		if(cnt != 0) {
			parameterMap.put("MSG", "이미 같은 ID가 존재합니다.");
			//throw new Exception();
		}else{
			// 신규 생성 (로그를 위해)
			for(TsysAdmGrpRol tsysAdmGrpRol : insert) {

				tsysAdmGrpRolDao.insert(tsysAdmGrpRol);


				Map<String,Object> tsysAdmGrpRolMap = CommonUtil.convertObjectToMap(tsysAdmGrpRol);


				tsysAdmGrpRolMap.put("rol_id", tsysAdmGrpRolMap.get("grp_rol_id"));
				tsysAdmGrpRolMap.put("rol_nm", tsysAdmGrpRolMap.get("grp_rol_nm"));
				tsysAdmGrpRolMap.put("rol_type", "GRP_ROL");
				tsysAdmGrpRolMap.put("rol_stat_cd", "10");
				tsysAdmGrpRolMap.put("rol_stat_nm", "추가");

				//권한 이력 insert
				//tbLgapRolHDao.insertTbLgapRolH(tsysAdmGrpRolMap);
			}

		}


		// 수정 (로그를 위해)
		for(TsysAdmGrpRol tsysAdmGrpRol : update) {


			Map<String,Object> tsysAdmGrpRolMap = CommonUtil.convertObjectToMap(tsysAdmGrpRol);

			tsysAdmGrpRolMap.put("rol_id", tsysAdmGrpRolMap.get("grp_rol_id"));
			tsysAdmGrpRolMap.put("rol_nm", tsysAdmGrpRolMap.get("grp_rol_nm"));
			tsysAdmGrpRolMap.put("rol_type", "GRP_ROL");
			tsysAdmGrpRolMap.put("rol_stat_cd", "30");
			tsysAdmGrpRolMap.put("rol_stat_nm", "수정");


			tsysAdmGrpRolDao.update(tsysAdmGrpRol);

			//tbLgapRolHDao.insertTbLgapRolH(tsysAdmGrpRolMap);
		}
		// 삭제 (로그를 위해) but.. 삭제는 update로 변경 필요 .
		for(TsysAdmGrpRol tsysAdmGrpRol : delete) {

			Map<String,Object> tsysAdmGrpRolMap = CommonUtil.convertObjectToMap(tsysAdmGrpRol);

			tsysAdmGrpRolMap.put("rol_id", tsysAdmGrpRolMap.get("grp_rol_id"));
			tsysAdmGrpRolMap.put("rol_nm", tsysAdmGrpRolMap.get("grp_rol_nm"));
			tsysAdmGrpRolMap.put("rol_type", "GRP_ROL");
			tsysAdmGrpRolMap.put("rol_stat_cd", "20");
			tsysAdmGrpRolMap.put("rol_stat_nm", "삭제");


			tsysAdmGrpRolDao.delete(tsysAdmGrpRol);

			//tbLgapRolHDao.insertTbLgapRolH(tsysAdmGrpRolMap);
		}

	}
}

