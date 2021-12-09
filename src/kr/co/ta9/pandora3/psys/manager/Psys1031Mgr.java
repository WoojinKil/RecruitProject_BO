package kr.co.ta9.pandora3.psys.manager;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pcommon.dto.TmbrAdmLgnInf;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmOrgGrpRolRtnn;
import kr.co.ta9.pandora3.pcommon.dto.TsysOrg;
import kr.co.ta9.pandora3.pcommon.dto.TsysOrgRolRtnn;
import kr.co.ta9.pandora3.pmbr.dao.TmbrAdmLgnInfDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmGrpRolDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmOrgGrpRolRtnnDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmOrgGrpRolRtnnDaoTrx;
import kr.co.ta9.pandora3.psys.dao.TsysOrgDao;
import kr.co.ta9.pandora3.psys.dao.TsysOrgRolRtnnDao;
import kr.co.ta9.pandora3.psys.dao.TsysOrgRolRtnnDaoTrx;

/**
* <pre>
* 1. 클래스명 : Psys1031Mgr
* 2. 설명 : 조직별권한관리
* 3. 작성일 : 2019-03-12
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class Psys1031Mgr {

	@Autowired
	private TsysOrgDao tsysOrgDao;
	
	@Autowired
	private TsysOrgRolRtnnDaoTrx tsysOrgRolRtnnDaoTrx;
	
	@Autowired
	private TsysOrgRolRtnnDao tsysOrgRolRtnnDao;
	
	@Autowired
	private TmbrAdmLgnInfDao tmbrAdmLgnInfDao;
	
	@Autowired
	private TsysAdmOrgGrpRolRtnnDao tsysAdmOrgGrpRolRtnnDao;
	
	@Autowired
	private TsysAdmOrgGrpRolRtnnDaoTrx tsysAdmOrgGrpRolRtnnDaoTrx;
	
	@Autowired
	private TsysAdmGrpRolDao tsysAdmGrpRolDao;
	
	/**
	 * 조직별권한관리 > 조직 트리 조회
	 * @param parameterMap
	 * @return List<Map<String,Object>> 
	 * @throws Exception
	 */
	public List<TsysOrg> selectTsysOrgTreeList(ParameterMap parameterMap) throws Exception {
		return tsysOrgDao.selectTsysOrgTreeList(parameterMap);
	}

	/**
	 * 조직별권한관리 > 하위 조직 조회
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTsysOrgList(ParameterMap parameterMap) throws Exception {
		return tsysOrgDao.selectTsysOrgList(parameterMap);
	}

	/**
	 * 조직별권한관리 > 조직별 권한 저장
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public void saveTsysOrgRolRtnn(ParameterMap parameterMap) throws Exception {
		
		List<TsysOrgRolRtnn> insertList = new ArrayList<TsysOrgRolRtnn>();
		List<TsysOrgRolRtnn> updateList = new ArrayList<TsysOrgRolRtnn>();
		List<TsysOrgRolRtnn> deleteList = new ArrayList<TsysOrgRolRtnn>();
		
		parameterMap.populates(TsysOrgRolRtnn.class, insertList, updateList, deleteList);
		
		TsysOrgRolRtnn[] insert = insertList.toArray(new TsysOrgRolRtnn[0]);
		TsysOrgRolRtnn[] update = updateList.toArray(new TsysOrgRolRtnn[0]);
		TsysOrgRolRtnn[] delete = deleteList.toArray(new TsysOrgRolRtnn[0]);
		
		tsysOrgRolRtnnDaoTrx.insertMany(insert);
		tsysOrgRolRtnnDaoTrx.updateMany(update);
		tsysOrgRolRtnnDaoTrx.deleteMany(delete);
		
	}
	
	/**
	 * 조직별권한관리 > 조직별 시스템 회원 리스트 조회
	 * @param parameterMap
	 * @return 
	 * @throws Exception
	 */
	public JSONObject selectTsysOrgAdmList(ParameterMap parameterMap) throws Exception {
		return tmbrAdmLgnInfDao.selectTsysOrgAdmList(parameterMap);
	}

	/**
	 * 조직별권한관리 > 조직별 시스템 회원 목록 저장
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTsysAdmList(ParameterMap parameterMap) throws Exception {
		List<TmbrAdmLgnInf> insertList = new ArrayList<TmbrAdmLgnInf>();
		List<TmbrAdmLgnInf> updateList = new ArrayList<TmbrAdmLgnInf>();
		List<TmbrAdmLgnInf> deleteList = new ArrayList<TmbrAdmLgnInf>();
		parameterMap.populates(TmbrAdmLgnInf.class, insertList, updateList, deleteList);
		
		TmbrAdmLgnInf[] insert = insertList.toArray(new TmbrAdmLgnInf[0]);
		TmbrAdmLgnInf[] update = updateList.toArray(new TmbrAdmLgnInf[0]);
		TmbrAdmLgnInf[] delete = deleteList.toArray(new TmbrAdmLgnInf[0]);
		
		for(int i = 0; i <insert.length; i++) {
			tmbrAdmLgnInfDao.updateTmbrAdmLgnInfOrgSeq(insert[i]);
		}
		
		for(int i = 0; i <update.length; i++) {
			tmbrAdmLgnInfDao.updateTmbrAdmLgnInfOrgSeq(update[i]);
		}
		
		for(int i = 0; i <delete.length; i++) {
			delete[i].setOrg_cd(null);
			tmbrAdmLgnInfDao.updateTmbrAdmLgnInfOrgSeq(delete[i]);
		}
		
	}
	
	
	/**
	 * 권한 그룹 그리드 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectTsysAdmGrpRolGridList(ParameterMap parameterMap) throws Exception {
		return tsysAdmGrpRolDao.selectTsysAdmGrpRolGridList(parameterMap);
	}

	/**
	 * 조직별 권한 그룹 매핑
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTsysAdmOrgGrpRolRtnn(ParameterMap parameterMap) throws Exception {
		
		//먼저 기존의 조직의 권한 그룹 삭제
		tsysAdmOrgGrpRolRtnnDaoTrx.deleteTsysAdmOrgGrpRolRtnn(parameterMap);
		
		if (!"".equals(parameterMap.getValue("grp_rol_id"))) {
			//현재 조직을 기준으로 하위 조직 전체 검색
			List<TsysAdmOrgGrpRolRtnn> list = tsysAdmOrgGrpRolRtnnDao.selectTsysOrgGrpRolAllList(parameterMap);
			
			for (TsysAdmOrgGrpRolRtnn tsysAdmOrgGrpRolRtnn : list) {
				
				if(tsysAdmOrgGrpRolRtnn.getGrp_rol_id() == null) {
					parameterMap.put("org_cd", tsysAdmOrgGrpRolRtnn.getHr_org_cd());
					//그 후 새로운 조직에 권한 그룹 추가
					tsysAdmOrgGrpRolRtnnDaoTrx.saveTsysAdmOrgGrpRolRtnn(parameterMap);
				}
			}
		}
		
		
	}

	/**
	 * 조직 권한 그룹 삭제
	 * @param parameterMap
	 * @throws Exception
	 */
	public void deleteTsysAdmOrgGrpRolRtnn(ParameterMap parameterMap) throws Exception {
		tsysAdmOrgGrpRolRtnnDaoTrx.deleteTsysAdmOrgGrpRolRtnn(parameterMap);
	}
	
}
