package kr.co.ta9.pandora3.psys.manager;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.util.MD5Util;
import kr.co.ta9.pandora3.common.util.PasswdUtil;
import kr.co.ta9.pandora3.pcommon.dto.TmbrAdmLgnInf;
import kr.co.ta9.pandora3.pmbr.dao.TmbrAdmLgnInfDao;

/**
 * <pre>
 * 1. 클래스명 : Psys1011Mgr
 * 2. 설명: BO 비밀번호 찾기 서비스
 * 3. 작성일 : 2018-03-27
 * 4. 작성자 : TANINE
 * </pre>
 */

@Service
public class Psys1011Mgr {
	@Autowired
	private TmbrAdmLgnInfDao tmbrAdmLgnInfDao;

	/**
	 * 임시 비밀번호 전송
	 * 작성일 : 2018-03-28
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public String updateTmbrAdmLgnInfPwChg(ParameterMap parameterMap, HttpServletRequest request)throws Exception {


		
		TmbrAdmLgnInf tmbrAdmLgnInf = null;
		

		// 실제 회원정보 조회
		tmbrAdmLgnInf = tmbrAdmLgnInfDao.selectTmbrAdmLgnInfInfo(parameterMap);

		if(tmbrAdmLgnInf == null)
			return "NO_USER";

		// 회원정보 Object (Update 용)
		TmbrAdmLgnInf updTmbrAdmLgnInf = new TmbrAdmLgnInf();

		// 유저 KEY 회원정보 Object에 담기
		updTmbrAdmLgnInf.setUsr_id(tmbrAdmLgnInf.getUsr_id());
		updTmbrAdmLgnInf.setUpdr_id(tmbrAdmLgnInf.getUsr_id());

		// 인증키 생성
		String millis = String.valueOf(System.currentTimeMillis());
		String certKey = "";
		certKey = new MD5Util().hexDigest(millis);

		// 10자리의 임시 비밀번호 생성
		String tmp_pw = PasswdUtil.getRamdomPassword(10);
		String tmp_pw_encd = new MD5Util().hexDigest(tmp_pw);


		// 암호화된 임시 비밀번호를 회원정보 Object에 담기
		updTmbrAdmLgnInf.setPw_chg(tmp_pw_encd);

		// 임시 비밀번호 발급
		tmbrAdmLgnInfDao.updateTmbrAdmLgnInfPwChg(updTmbrAdmLgnInf);

		// 계정찾기 인증키를 회원정보 Object에 담기FND_CTF_KEY
		updTmbrAdmLgnInf.setFnd_ctf_key(certKey);
		updTmbrAdmLgnInf.setFnd_ctf_key_dttm(new Timestamp(System.currentTimeMillis()));

		tmbrAdmLgnInfDao.update(updTmbrAdmLgnInf);
		String result = Const.BOOLEAN_SUCCESS;

		return result;
	}

}
