package kr.co.ta9.pandora3.psys.manager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pmbr.dao.TmbrAdmLgnInfDao;

/**
 * <pre>
 * 1. 클래스명 : Psys1013Mgr
 * 2. 설명 : BO인증 서비스
 * 3. 작성일 : 2018-04-11
 * 4. 작성자 : TANINE
 * </pre>
 */

@Service
public class Psys1013Mgr {
	@Autowired
	private TmbrAdmLgnInfDao tmbrAdmLgnInfDao;
	
	/**
	 * Email인증 > 회원정보 조회
	 * @param login_id
	 * @return
	 * @throws Exception
	 */
	public String getTmbrAdmLgnInfUsrId(ParameterMap parameterMap) throws Exception {
		return tmbrAdmLgnInfDao.getTmbrAdmLgnInfUsrId(parameterMap);
	}
}
