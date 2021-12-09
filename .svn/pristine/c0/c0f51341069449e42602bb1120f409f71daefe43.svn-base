package kr.co.ta9.pandora3.psys.manager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.entry.UserInfo;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.util.MD5Util;
import kr.co.ta9.pandora3.pcommon.dto.TmbrAdmLgnInf;
import kr.co.ta9.pandora3.pmbr.dao.TmbrAdmLgnInfDao;

/**
 * <pre>
 * 1. 클래스명 : Psys1012Mgr
 * 2. 설명 : BO 비밀번호 변경 서비스
 * 3. 작성일 : 2018-04-11
 * 4. 작성자 : TANINE
 * </pre>
 */

@Service
public class Psys1012Mgr {
	@Autowired
	private TmbrAdmLgnInfDao tmbrAdmLgnInfDao;

	public String updateTmbrAdmLgnInfPwChg(ParameterMap parameterMap) throws Exception{

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		UserInfo usrInfo = parameterMap.getUserInfo();
		if(usrInfo != null){
			parameterMap.put("usr_id", usrInfo.getUser_id());
		}

		TmbrAdmLgnInf tmbrAdmLgnInf = tmbrAdmLgnInfDao.selectTmbrAdmLgnInfInfo(parameterMap);

		if(!tmbrAdmLgnInf.getLgn_pwd().equals(new MD5Util().hexDigest(parameterMap.getValue("curr_pwd"))))
			result = "P1";

		if(tmbrAdmLgnInf.getLgn_pwd().equals(new MD5Util().hexDigest(parameterMap.getValue("new_pwd"))))
			result = "P2";

		if(result.equals(Const.BOOLEAN_SUCCESS))
		{
			tmbrAdmLgnInf.setUsr_id(usrInfo.getUser_id());
			tmbrAdmLgnInf.setPw_chg(new MD5Util().hexDigest(parameterMap.getValue("new_pwd")));
			tmbrAdmLgnInfDao.updateTmbrAdmLgnInfPwChg(tmbrAdmLgnInf);
		}

		return result;
	}
}
