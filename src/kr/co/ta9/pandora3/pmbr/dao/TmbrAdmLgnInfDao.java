package kr.co.ta9.pandora3.pmbr.dao;

import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.BeanUtil;
import kr.co.ta9.pandora3.pcommon.dto.TmbrAdmLgnInf;



/**
 * TmbrAdmLgnInfDao - DAO(Data Access Object) class for table [TMBR_ADM_LGN_INF].
 *
 * <pre>
 * 1. 패키지명 : kr.co.ta9.pandora3.pmbr.dao.base
 * 2. 타입명 : class
 * 3. 작성일 : 2018-02-18
 * 4. 작성자 : TA9
 * 5. 설명 : BO 회원 DAO(조회 쿼리 호출)
 * </pre>
 */
@Repository
public class TmbrAdmLgnInfDao extends BaseDao {
	/**
	 * 회원 아이디 찾기 조회
	 * @param login_id
	 * @return
	 * @throws Exception
	 */
	public String getTmbrAdmLgnInfLgnId(ParameterMap parameterMap) throws Exception {
		String res="";
		res = getSqlSession().selectOne("TmbrAdmLgnInf.getTmbrAdmLgnInfLgnId", parameterMap);

		if(res==null ||"".equals(res)){
			res = "";
			return res;

		}else{
			return res;
		}
	}
	
	/**
	 * 이메일 인증 회원 체크 (이메일 중복 체크)
	 * @param login_id
	 * @return
	 * @throws Exception
	 */
	public String getTmbrAdmLgnInfUsrId(ParameterMap parameterMap) throws Exception{
		
		String usrId = "";
		String result = "";
		
		usrId = getSqlSession().selectOne("TmbrAdmLgnInf.getTmbrAdmLgnInfUsrId", parameterMap);
		
		if(usrId == null || "".equals(usrId)){
			result = "";
		}else{
			result = usrId;
		}
		
		return result;
	}

	/**
	 * BO 사용자 리스트 조회
	 * @param parameterMap
	 * @return SysUser
	 * @throws Exception
	 */
	public JSONObject selectTmbrAdmLgnInf(ParameterMap parameterMap) throws Exception{
		List<Object> dataList = getSqlSession().selectList("TmbrAdmLgnInf.selectTmbrAdmLgnInf", parameterMap);
		List<Map<String,Object>> mapList = BeanUtil.convertObjectToMapList(dataList);
		JSONObject json = new JSONObject();
		json.put("AdminInfo", mapList);
		return json;
	}

	/** 중복된 메소드 호출 추후 확인 후 삭제!!
	 * One User
	 * @param parameterMap
	 * @return SysUser
	 * @throws Exception
	 */
//	public TmbrAdmLgnInf selectTmbrAdmLgnInfList(ParameterMap parameterMap) throws Exception {
//		return getSqlSession().selectOne("TmbrAdmLgnInf.selectTmbrAdmLgnInfList", parameterMap);
//	}

	/**
	 * 회원가입 > 회원아이디 유효성 확인(중복/금지어)
	 * @param login_id
	 * @return
	 * @throws Exception
	 */
	public String getTmbrAdmLgnInfDupLgnId(String lgn_id) throws Exception {
		return getSqlSession().selectOne("TmbrAdmLgnInf.getTmbrAdmLgnInfDupLgnId", lgn_id);
	}

	/**
	 * Check Email Overlap
	 * @param email
	 * @return
	 */
	public String getTmbrAdmLgnInfDupUsrEmlAdr(String usr_eml_addr) throws Exception {
		return getSqlSession().selectOne("TmbrAdmLgnInf.getTmbrAdmLgnInfDupUsrEmlAdr", usr_eml_addr);
	}


	/**
	 * 시스템 사용자 list
	 * @param parameterMap
	 * @return List<TmbrAdmLgnInf>
	 * @throws Exception
	 */
	public List<TmbrAdmLgnInf> selectTmbrAdmLgnInfList(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectList("TmbrAdmLgnInf.selectTmbrAdmLgnInfList", parameterMap);
	}

	/**
	 * 시스템 사용자 리스트 조회 (그리드형)
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTmbrAdmLgnInfGridList(ParameterMap parameterMap) throws Exception {
		return queryForGrid("TmbrAdmLgnInf.selectTmbrAdmLgnInfGridList", parameterMap);
	}

	/**
	 * 시스템 사용자(One)
	 * @param parameterMap
	 * @return TmbrAdmLgnInf
	 * @throws Exception
	 */
	public TmbrAdmLgnInf selectTmbrAdmLgnInfInfo(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectOne("TmbrAdmLgnInf.selectTmbrAdmLgnInfList", parameterMap);
	}
	
	/**
	 * 유저 아이디 시스템 사용자(One)
	 * @param parameterMap
	 * @return TmbrAdmLgnInf
	 * @throws Exception
	 */
	public TmbrAdmLgnInf selectTmbrUsrIdAdmLgnInfInfo(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectOne("TmbrAdmLgnInf.selectTmbrUsrIdAdmLgnInfList", parameterMap);
	}

	/**
	 * 키중복 체크
	 */
	public int selectTmbrAdmLgnInfCnt(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectOne("TmbrAdmLgnInf.selectTmbrAdmLgnInfCnt", parameterMap);
	}

	/**
	 * 조직별권한관리 > 조직별 시스템 회원 리스트 조회
	 * @param parameterMap
	 * @throws Exception
	 */
	public JSONObject selectTsysOrgAdmList(ParameterMap parameterMap) throws Exception {
		return queryForGrid("TmbrAdmLgnInf.selectTsysOrgAdmList", parameterMap);
	}

	/**
	 * 사원관리 > 외부 사원 승인 관리
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectExtnTmbrAdmLgnInfGridList(ParameterMap parameterMap) throws Exception {
		return queryForGrid("TmbrAdmLgnInf.selectExtnTmbrAdmLgnInfGridList", parameterMap);
	}

	/**
	 * 사원관리 > 외부 사원 권한
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectExtnTmbrAdmLgnInfPocGridList(ParameterMap parameterMap) throws Exception {
		return queryForGrid("TmbrAdmLgnInf.selectExtnTmbrAdmLgnInfPocGridList", parameterMap);
	}

	/**
	 * 사원관리 > 사용자별 권한 조회 > 사원조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectTmbrAdmLgnInfRolList(ParameterMap parameterMap) throws Exception {
		return queryForGrid("TmbrAdmLgnInf.selectTmbrAdmLgnInfRolList", parameterMap);
	}

	
	/**
	 * 패스워드 변경
	 * @param parameterMap
	 * @throws Exception
	 */
	public int updateTmbrAdmLgnInfPwChg(TmbrAdmLgnInf tmbrAdmLgnInf) throws Exception {
		return getSqlSession().update("TmbrAdmLgnInf.updateTmbrAdmLgnInfPwChg", tmbrAdmLgnInf);
	}

	/**
	 * 패스워드 변경
	 * @param parameterMap
	 * @throws Exception
	 */
	public int updateTmbrAdmLgnInfInitAdminPwInfo(TmbrAdmLgnInf tmbrAdmLgnInf) throws Exception {
		return getSqlSession().update("TmbrAdmLgnInf.updateTmbrAdmLgnInfInitAdminPwInfo", tmbrAdmLgnInf);
	}
	
	/**
	 * 시스템 회원 조직 시퀀스 변경
	 * @param parameterMap
	 * @throws Exception
	 */
	public int updateTmbrAdmLgnInfOrgSeq(TmbrAdmLgnInf tmbrAdmLgnInf) throws Exception {
		return getSqlSession().update("TmbrAdmLgnInf.updateTmbrAdmLgnInfOrgSeq", tmbrAdmLgnInf);
	}

	/**
	 * 로그인 팝업 > 사용자 UsrApvl 허용 처리
	 * @param parameterMap
	 * @throws Exception
	 */
	public int updateUsrApvl(ParameterMap parameterMap) throws Exception {
		return getSqlSession().update("TmbrAdmLgnInf.updateUsrApvl", parameterMap);
	}

	/**
	 * 외부 사용자 승인 관리
	 * @param tmbrAdmLgnInf
	 * @throws Exception
	 */
	public int updateExtnTmbrAdmLgnInfApvl(TmbrAdmLgnInf tmbrAdmLgnInf) throws Exception {
		return getSqlSession().update("TmbrAdmLgnInf.updateExtnTmbrAdmLgnInfApvl", tmbrAdmLgnInf);
	}

	public int deleteExtnTmbrAdmLgnInfApvl(TmbrAdmLgnInf tmbrAdmLgnInf) throws Exception {
		return getSqlSession().delete("TmbrAdmLgnInf.deleteExtnTmbrAdmLgnInfApvl", tmbrAdmLgnInf);
	}

	/**
	 * 사용자 접점 서비스 변경
	 * @param tmbrAdmLgnInf
	 * @throws Exception
	 */
	public int updateExtnTmbrAdmLgnInfPocCds(TmbrAdmLgnInf tmbrAdmLgnInf) throws Exception {
		return getSqlSession().update("TmbrAdmLgnInf.updateExtnTmbrAdmLgnInfPocCds", tmbrAdmLgnInf);
	}
}