package kr.co.ta9.pandora3.psys.manager;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.BeanUtil;
import kr.co.ta9.pandora3.common.util.NumUtil;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.pcommon.dto.TmbrAdmLgnInf;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmRolRtnn;
import kr.co.ta9.pandora3.pmbr.dao.TmbrAdmLgnInfDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmRolRtnnDao;
import kr.co.ta9.pandora3.psys.dao.TsysOrgDao;

/**
 * <pre>
 * 1. 클래스명 : Psys1009Mgr
 * 2. 설명: BO사용자 추가 서비스
 * 3. 작성일 : 2018-03-27
 * 4. 작성자 : TANINE
 * </pre>
 **/

@Service
public class Psys1009Mgr {
	
	
	@Autowired
	private TsysAdmRolRtnnDao tsysAdmRolRtnnDao;
	
	@Autowired
	private TmbrAdmLgnInfDao tmbrAdmLgnInfDao;
	
	@Autowired
	private TsysOrgDao tsysOrgDao;
	
	/**
	 * BO사용자 추가
	 * @param parameterMap
	 * @throws Exception
	 */
	public String savePsys1009(ParameterMap parameterMap) throws Exception {
		TmbrAdmLgnInf tmbrAdmLgnInf = (TmbrAdmLgnInf)parameterMap.populate(TmbrAdmLgnInf.class);
				
		// Key 파라미터(p_user_id)가 넘어오지 않은 경우 신규 회원으로 등록 / 그 외에는 수정
		if (TextUtil.isEmpty(parameterMap.getValue("p_usr_id")))  {
			tmbrAdmLgnInf.setUsr_id("C" + NumUtil.getRamdomUsrId(29));

			tmbrAdmLgnInfDao.insert(tmbrAdmLgnInf);
		} else {
			tmbrAdmLgnInfDao.update(tmbrAdmLgnInf);
		}
		
		// 회원 권한 등록
		int roleCnt = parameterMap.getArray("rol_id") == null? 0 : parameterMap.getArray("rol_id").length;
		TsysAdmRolRtnn[] tsysAdmRolRtnn = (TsysAdmRolRtnn[])BeanUtil.array(TsysAdmRolRtnn.class, roleCnt);
		parameterMap.populates(tsysAdmRolRtnn);
		
		tsysAdmRolRtnnDao.deleteTsysAdmRolRtnnByUsrId(tmbrAdmLgnInf.getUsr_id());
		
		for (int i = 0; i < tsysAdmRolRtnn.length; i++) {
			tsysAdmRolRtnn[i].setUsr_id(tmbrAdmLgnInf.getUsr_id());
			tsysAdmRolRtnnDao.insertTsysAdmRolRtnn(tsysAdmRolRtnn[i]);
		}
		
		return tmbrAdmLgnInf.getUsr_id();
	}
	
	/**
	 * 회원아이디 유효성 확인(중복/금지어)
	 * @param lgn_id
	 * @return
	 * @throws Exception
	 */
	public String getTmbrAdmLgnInfDupLgnId(String lgn_id) throws Exception {
		return tmbrAdmLgnInfDao.getTmbrAdmLgnInfDupLgnId(lgn_id);
	}
	
	/**
	 * 이메일 중복 확인
	 * @param usr_eml_addr
	 * @return
	 * @throws Exception
	 */
	public String getTmbrAdmLgnInfDupUsrEmlAdr(String usr_eml_addr) throws Exception {
		return tmbrAdmLgnInfDao.getTmbrAdmLgnInfDupUsrEmlAdr(usr_eml_addr);
	}
	
	/**
	 * 상하위 조직 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject getPsysOrgList(ParameterMap parameterMap) throws Exception {
		return tsysOrgDao.selectTsysOrgGridList(parameterMap);
	}
}
