package kr.co.ta9.pandora3.psys.manager;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.entry.UserInfo;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.MD5Util;
import kr.co.ta9.pandora3.pcommon.dto.TmbrAdmLgnInf;
import kr.co.ta9.pandora3.pmbr.dao.TmbrAdmLgnInfDao;

/**
 * <pre>
 * 1. 클래스명 : Psys1014Mgr
 * 2. 설명 : BO정보 변경 서비스
 * 3. 작성일 : 2018-04-11
 * 4. 작성자 : TANINE
 * </pre>
 */

@Service
public class Psys1014Mgr {
	@Autowired
	private TmbrAdmLgnInfDao tmbrAdmLgnInfDao;


	/**
	 * BO 사용자 정보 수정 전 비밀번호 재확인
	 * @param parameterMap
	 * @return String
	 * @throws Exception
	 */
	public String selectTmbrAdmLgnInfLgnPw(ParameterMap parameterMap) throws Exception{
		// result 선언
		String result = "N";


		UserInfo usrInfo = parameterMap.getUserInfo();
		if(usrInfo != null){
			TmbrAdmLgnInf tmbrAdmLgnInf = null;
			parameterMap.put("usr_id", usrInfo.getUser_id());
			tmbrAdmLgnInf = tmbrAdmLgnInfDao.selectTmbrAdmLgnInfInfo(parameterMap);
			if(tmbrAdmLgnInf.getLgn_pwd().equals(new MD5Util().hexDigest(parameterMap.getValue("lgn_pwd"))))
				result = "Y";
		}
		return result;
	}

	/**
	 * BO 사용자 정보 수정 시 회원정보 조회
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTmbrAdmLgnInf(ParameterMap parameterMap) throws Exception{
		// result 선언
		JSONObject json = new JSONObject();

		UserInfo usrInfo = parameterMap.getUserInfo();
		if(usrInfo != null){
			parameterMap.addProperty("usr_id", usrInfo.getUser_id());
			json = tmbrAdmLgnInfDao.selectTmbrAdmLgnInf(parameterMap);
		}


		return json;
	}

	/**
	 * BO 사용자 정보 조회 (One)
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public TmbrAdmLgnInf selectTmbrAdmLgnInfInfo(ParameterMap parameterMap) throws Exception{
		return tmbrAdmLgnInfDao.selectTmbrAdmLgnInfInfo(parameterMap);
	}

	/**
	 * BO 사용자 정보 수정
	 * @param tmbrAdmLgnInf
	 * @return int
	 * @throws Exception
	 */
	public int updateTmbrAdmLgnInf(TmbrAdmLgnInf tmbrAdmLgnInf) throws Exception{
		return tmbrAdmLgnInfDao.update(tmbrAdmLgnInf);
	}

}
