package kr.co.ta9.pandora3.psys.manager;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.util.CommonUtil;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmRol;
import kr.co.ta9.pandora3.psys.dao.TbLgapRolHDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmRolDao;

/**
* <pre>
* 1. 클래스명 : Psys1006Mgr
* 2. 설명 : 권한관리 서비스
* 3. 작성일 : 2018-03-28
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class Psys1006Mgr {

	@Autowired
	private TsysAdmRolDao tsysAdmRolDao;
	
	@Autowired
	private TbLgapRolHDao tbLgapRolHDao;

	/**
	 * 권한 목록
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTsysAdmRolGridList(ParameterMap parameterMap) throws Exception {
		return tsysAdmRolDao.selectTsysAdmRolGridList(parameterMap);
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

		TsysAdmRol[] insert = insertList.toArray(new TsysAdmRol[0]);
		TsysAdmRol[] update = updateList.toArray(new TsysAdmRol[0]);
		TsysAdmRol[] delete = deleteList.toArray(new TsysAdmRol[0]);

		if (!insertList.isEmpty()) {
			for (TsysAdmRol sysAdminRole : insertList) {
				parameterMap.put("rol_id", sysAdminRole.getRol_id());
				cnt = tsysAdmRolDao.selectTsysAdmRolCnt(parameterMap);
			}
		}

		if(cnt != 0) {
			parameterMap.put("MSG", "이미 같은 ID가 존재합니다.");

		}else{
			for (TsysAdmRol tsysAdmRol : insert) {
				tsysAdmRolDao.insert(tsysAdmRol);

				Map<String,Object> tsysAdmRolMap = CommonUtil.convertObjectToMap(tsysAdmRol);

				tsysAdmRolMap.put("rol_type", "SIT_ROL");
				tsysAdmRolMap.put("rol_stat_cd", "10");
				tsysAdmRolMap.put("rol_stat_nm", "추가");

				//권한 이력 insert
//				tbLgapRolHDaoTrx.insertTbLgapRolH(tsysAdmRolMap);
			}
		}

		for (TsysAdmRol tsysAdmRol : update) {
			Map<String,Object> tsysAdmRolMap = CommonUtil.convertObjectToMap(tsysAdmRol);
			tsysAdmRolMap.put("rol_type", "SIT_ROL");
			tsysAdmRolMap.put("rol_stat_cd", "30");
			tsysAdmRolMap.put("rol_stat_nm", "수정");


			tsysAdmRolDao.update(tsysAdmRol);

//			tbLgapRolHDaoTrx.insertTbLgapRolH(tsysAdmRolMap);
		}

		for (TsysAdmRol tsysAdmRol : delete) {

			Map<String,Object> tsysAdmRolMap = CommonUtil.convertObjectToMap(tsysAdmRol);

			tsysAdmRolMap.put("rol_type", "SIT_ROL");
			tsysAdmRolMap.put("rol_stat_cd", "20");
			tsysAdmRolMap.put("rol_stat_nm", "삭제");


			tsysAdmRolDao.delete(tsysAdmRol);
//			tbLgapRolHDaoTrx.insertTbLgapRolH(tsysAdmRolMap);
		}

	}
}

