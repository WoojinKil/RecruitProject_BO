package kr.co.ta9.pandora3.psys.manager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pmbr.dao.TmbrAdmLgnInfDao;

/**
 * <pre>
 * 1. 클래스명 : Psys1010Mgr
 * 2. 설명 : BO 아이디 찾기 서비스
 * 3. 작성일 : 2018-03-28
 * 4. 작성자 : TANINE
 * </pre>
 **/

@Service
public class Psys1010Mgr {

	@Autowired
	private TmbrAdmLgnInfDao tmbrAdmLgnInfDao;

	/**
	 * 회원아이디 찾기
	 * @param login_id
	 * @return
	 * @throws Exception
	 */
	public String getTmbrAdmLgnInfLgnId(ParameterMap parameterMap) throws Exception {
		String lgnId = tmbrAdmLgnInfDao.getTmbrAdmLgnInfLgnId(parameterMap); // DB BO아이디 조회

		String maskingId = "";	// *로 마스킹 처리한 ID

		maskingId = lgnId.substring(0, (lgnId.length()/2));

		// 아이디 절반 마스킹* 처리
		double half = Math.round((lgnId.length()/2.0));
		StringBuilder sb = new StringBuilder();
		sb.append(maskingId);
		for(int i=0 ; i<half ; i++) {
			//maskingId += "*";
			sb.append("*");
		}

		return sb.toString();
	}
}
