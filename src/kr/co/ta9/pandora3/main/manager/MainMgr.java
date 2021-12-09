package kr.co.ta9.pandora3.main.manager;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.conf.AppConst;
import kr.co.ta9.pandora3.app.dao.CommonDao;
import kr.co.ta9.pandora3.app.entry.UserInfo;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.util.CodeUtil;
import kr.co.ta9.pandora3.app.util.CommonUtil;
import kr.co.ta9.pandora3.common.conf.Config;
import kr.co.ta9.pandora3.common.conf.Configuration;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.exception.UtilException;
import kr.co.ta9.pandora3.common.util.CryptUtil;
import kr.co.ta9.pandora3.common.util.DateUtil;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.pcmn.dao.TcmnCdDtlDao;
import kr.co.ta9.pandora3.pcmn.dao.TcmnPopupInfDao;
import kr.co.ta9.pandora3.pcommon.dao.PsysCommonDao;
import kr.co.ta9.pandora3.pcommon.dto.TcmnCdDtl;
import kr.co.ta9.pandora3.pcommon.dto.TcmnPopupInf;
import kr.co.ta9.pandora3.pcommon.dto.TdspSysInf;
import kr.co.ta9.pandora3.pcommon.dto.TmbrAdmLastLgnInf;
import kr.co.ta9.pandora3.pcommon.dto.TmbrAdmLgnInf;
import kr.co.ta9.pandora3.pcommon.dto.TmbrConnLog;
import kr.co.ta9.pandora3.pcommon.dto.TmbrUsrLgnInf;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmMnu;
import kr.co.ta9.pandora3.pdsp.dao.TdspSysInfDao;
import kr.co.ta9.pandora3.pmbr.dao.TmbrAdmLastLgnInfDao;
import kr.co.ta9.pandora3.pmbr.dao.TmbrAdmLgnInfDao;
import kr.co.ta9.pandora3.pmbr.dao.TmbrConnLogDao;
import kr.co.ta9.pandora3.pmbr.dao.TmbrUsrLgnInfDao;
import kr.co.ta9.pandora3.psys.dao.TbBcpcAthrAppDao;
import kr.co.ta9.pandora3.psys.dao.TbLgapAthrappHDao;
import kr.co.ta9.pandora3.psys.dao.TbLgapRolrtnnHDao;
import kr.co.ta9.pandora3.psys.dao.TbLgjbAdmlgninfHDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmMnuDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmRolDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmRolRtnnDao;

@Service
public class MainMgr  {

	private final Log log = LogFactory.getLog(MainMgr.class);


	@Autowired
	private TmbrAdmLgnInfDao tmbrAdmLgnInfDao;

	@Autowired
	private TsysAdmMnuDao tsysAdmMnuDao;

	@Autowired
	private TmbrConnLogDao tmbrConnLogDao;

	@Autowired
	private CommonDao commonDao;

	@Autowired
	private TcmnPopupInfDao tcmnPopupInfDao;

	@Autowired
	private TmbrUsrLgnInfDao tmbrUsrLgnInfDao;

	@Autowired
	private TsysAdmRolDao tsysAdmRolDao;

	@Autowired
	private PsysCommonDao psysCommonDao;
	
	@Autowired
	private TmbrAdmLastLgnInfDao tmbrAdmLastLgnInfDao;

	@Autowired
	private TbBcpcAthrAppDao tbBcpcAthrAppDao;

	@Autowired
	private TbLgapAthrappHDao tbLgapAthrappHDao;

	@Autowired
	private TsysAdmRolRtnnDao tsysAdmRolRtnnDao;

	@Autowired
	private TbLgapRolrtnnHDao tbLgapRolrtnnHDao;

	@Autowired
	private TcmnCdDtlDao tcmnCdDtlDao;

	@Autowired
	private TdspSysInfDao tdspSysInfDao;

	@Autowired
	private TbLgjbAdmlgninfHDao tbLgjbAdmlgninfHDao;



	/**
	 * 유저 아이디 로그인 처리
	 * @param parameterMap
	 * @return UserInfo
	 * @throws Exception
	 */
	public UserInfo userIdAdminLogin(ParameterMap parameterMap) throws Exception {
		UserInfo userInfo = new UserInfo();
		log.debug("----------userIdAdminLogin-----------");
		TmbrAdmLgnInf tmbrAdmLgnInf = tmbrAdmLgnInfDao.selectTmbrUsrIdAdmLgnInfInfo(parameterMap);
		userInfo.setLogin_result(UserInfo.LOGIN_SUCCESS);
		if(tmbrAdmLgnInf !=null) {

			// DB 데이터 취득 : 로그인 설정값
			TcmnCdDtl[] loginProp = CodeUtil.getTcmnCdDtlList("LOGIN_PROP", null, null, null, Const.BOOLEAN_TRUE);

			int userPwWrongCntStd = Config.getInt("user.passwd.wrong.cnt");
			int login_term = 0;
			String pw_wrong_yn = "";
			// 사용자 설정값 취득 : 패스워드 무한대입 방지
			for(int i=0; i<loginProp.length; i++) {
				if("PW_WRONG".equals(loginProp[i].getCd())) {
					userPwWrongCntStd = Integer.parseInt(loginProp[i].getRef_2());
				}
				if("PW_WRONG_YN".equals(loginProp[i].getCd())) {
					pw_wrong_yn = loginProp[i].getRef_2();
				}
				if("LOGIN_TERM".equals(loginProp[i].getCd())) {
					login_term = Integer.parseInt(loginProp[i].getRef_2());
				}
			}

			// 비빌번호 5번 이상 틀린 계정에 대해 일정 시간 후 자동 잠금 해제
			if(tmbrAdmLgnInf.getPwd_fail_cnt() == userPwWrongCntStd && tmbrAdmLgnInf.getPwd_fail_dttm() != null && (!"".equals(tmbrAdmLgnInf.getPwd_fail_dttm()))) {

				Date[] dateArrey = chkLoginTerm(tmbrAdmLgnInf.getF_pwd_fail_dttm(), login_term);

				if(dateArrey[0].after(dateArrey[1])) {

					tmbrAdmLgnInf.setActv_yn(Const.BOOLEAN_TRUE);
					tmbrAdmLgnInfDao.updateTmbrAdmLgnInfInitAdminPwInfo(tmbrAdmLgnInf);

					//재 검색
					tmbrAdmLgnInf = tmbrAdmLgnInfDao.selectTmbrAdmLgnInfInfo(parameterMap);
				}
			}

			if("3".equals(tmbrAdmLgnInf.getUsr_stat_cd())) {
				userInfo.setLogin_result(UserInfo.LOGIN_UNCERT_USER); // 미인증 회원(13)
				insertTmbrUsrLgnInf(parameterMap, tmbrAdmLgnInf, "94");
			}else if ("2".equals(tmbrAdmLgnInf.getUsr_stat_cd())) {
				userInfo.setLogin_result(UserInfo.LOGIN_LEAVE_USER); // 탈퇴 회원(12)
				insertTmbrUsrLgnInf(parameterMap, tmbrAdmLgnInf, "93");
			}else if (!Const.BOOLEAN_TRUE.equals(tmbrAdmLgnInf.getActv_yn())) {
				userInfo.setLogin_result(UserInfo.LOGIN_ID_INACTIVE); // 사용자 비활성화 됨
				insertTmbrUsrLgnInf(parameterMap, tmbrAdmLgnInf, "92");
				if(tmbrAdmLgnInf.getPwd_fail_dttm() != null && (!"".equals(tmbrAdmLgnInf.getPwd_fail_dttm()))) {
					Date[] dateArrey = chkLoginTerm(tmbrAdmLgnInf.getF_pwd_fail_dttm(), login_term);
					userInfo.setLast_access_dy(DateUtil.format(dateArrey[1], "yyyy-MM-dd HH:mm:ss"));
				}

			}else {

				if (tmbrAdmLgnInf.getLgn_pwd() != null && tmbrAdmLgnInf.getUsr_id().equals(parameterMap.getValue("usr_id"))) {
					if("1".equals(tmbrAdmLgnInf.getUsr_stat_cd())){ //회원 인증 여부 판단.
						// 정상 로그인 시 비밀번호 초기화
						if(tmbrAdmLgnInf.getPwd_fail_cnt() > 0) {
							// 로그인 허용시간 취득
							Date[] dateArr = chkLoginTerm(tmbrAdmLgnInf.getF_pwd_fail_dttm(), login_term);
							if(tmbrAdmLgnInf.getPwd_fail_cnt() == userPwWrongCntStd && login_term > 0 && dateArr[0].before(dateArr[1])) {
								userInfo.setLogin_result(UserInfo.PASSWD_WRONG_TERM);
								userInfo.setLast_access_dy(DateUtil.format(dateArr[1], "yyyy-MM-dd HH:mm:ss"));
							} else {
								tmbrAdmLgnInfDao.updateTmbrAdmLgnInfInitAdminPwInfo(tmbrAdmLgnInf);
							}
						}

						// 사용자 비밀번호 변경 공지
						if (Integer.parseInt(tmbrAdmLgnInf.getPw_upd_tr()) >= Config.getInt("user.passwd.change.cycle.day")) {
							userInfo.setLogin_result(UserInfo.PASSWD_CHANGE_NOTICE);
							// 변경가능한날 카운트다운
							userInfo.setLogin_pw_remain((Config.getInt("user.passwd.change.cycle.day") + Config.getInt("user.passwd.change.can.day")) - Integer.parseInt(tmbrAdmLgnInf.getPw_upd_tr()) );

							// 사용자 비밀번호 변경 공지도 지나면
							if (Integer.parseInt(tmbrAdmLgnInf.getPw_upd_tr())  >= (Config.getInt("user.passwd.change.cycle.day") + Config.getInt("user.passwd.change.can.day"))) {
								userInfo.setLogin_result(UserInfo.PASSWD_EXCEED_MAXDAYS);

								// 사용자 inactive
								tmbrAdmLgnInf.setActv_yn(Const.BOOLEAN_FALSE);
								tmbrAdmLgnInfDao.update(tmbrAdmLgnInf);
							}
						}
					}else{
						userInfo.setLogin_result(UserInfo.LOGIN_UNCERT_USER);// 미인증시 결과값
					}
				}else {
					insertTmbrUsrLgnInf(parameterMap, tmbrAdmLgnInf, "95"); // slo 로그인 실패 기록
					// 사용자 설정값이 설정 되었을 때 : 비밀번호 오류횟수 체크(설정값이 0 초과)
					if("Y".equals(pw_wrong_yn) && userPwWrongCntStd > 0) {
						// 사용자 비밀번호 오류 횟수 저장(프로퍼티 OR 공통코드)
						userInfo.setPw_wrong_cnt(userPwWrongCntStd);
						// 로그인 시도 횟수 제한시간 확인
						if (tmbrAdmLgnInf.getPwd_fail_cnt() == userPwWrongCntStd) {
							Date[] dateArr = chkLoginTerm(tmbrAdmLgnInf.getF_pwd_fail_dttm(), login_term);
							if(login_term > 0 && dateArr[0].before(dateArr[1])) {
								// 사용자 비밀번호 입력 제한시간 적용
								userInfo.setLogin_result(UserInfo.PASSWD_WRONG_TERM);
								userInfo.setLast_access_dy(DateUtil.format(dateArr[1], "yyyy-MM-dd HH:mm:ss"));
							} else {
								// 사용자 비밀번호 N회 오류
								userInfo.setLogin_result(UserInfo.PASSWD_WRONG_EXCEED);

								// 사용자 inactive
								tmbrAdmLgnInf.setActv_yn(Const.BOOLEAN_FALSE);
								tmbrAdmLgnInfDao.update(tmbrAdmLgnInf);
							}
						}
						else {
							// 사용자 비밀번호 오류
							userInfo.setLogin_result(UserInfo.LOGIN_INVALID);
							tmbrAdmLgnInf.setPwd_fail_cnt(tmbrAdmLgnInf.getPwd_fail_cnt() + 1);
							tmbrAdmLgnInf.setF_pwd_fail_dttm(DateUtil.today("yyyyMMddHHmmss"));

							tmbrAdmLgnInfDao.update(tmbrAdmLgnInf);
						}
					} else {
						// 사용자 비밀번호 오류 :: UserInfo에만 설정값 설정
						userInfo.setLogin_result(UserInfo.LOGIN_INVALID);
					}
				}
			}
		}else {
			// 사용자 정보 없음
			userInfo.setLogin_result(UserInfo.LOGIN_INVALID);
		}

		if ((userInfo.getLogin_result() == UserInfo.LOGIN_SUCCESS ||
				userInfo.getLogin_result() == UserInfo.PASSWD_CHANGE_NOTICE || userInfo.getLogin_result() == UserInfo.LOGIN_UNCERT_USER) && tmbrAdmLgnInf != null) {
			
				tmbrAdmLgnInf.setLgn_pwd("");
				String lgn_unq_key = insertTmbrUsrLgnInf(parameterMap, tmbrAdmLgnInf, AppConst.LOGOUT_CASUS_CD_LOGIN);

				// useInfo 설정
				userInfo.setLogin(Const.BOOLEAN_TRUE);
				userInfo.setLogin_id(tmbrAdmLgnInf.getLgn_id());
				userInfo.setUser_id(tmbrAdmLgnInf.getUsr_id());
				userInfo.setUser_nm(tmbrAdmLgnInf.getUsr_nm());
				userInfo.setEmail(tmbrAdmLgnInf.getUsr_eml_addr());
				userInfo.setUsr_stat_cd(tmbrAdmLgnInf.getUsr_stat_cd());
				userInfo.setLast_access_ip_addr(parameterMap.getValue("ip_addr"));
				// 2019-03-11 중복 로그인 방지 처리를 위한 유니크 키값 추가
				userInfo.setLgn_unq_key(lgn_unq_key);
				// 조직 정보 추가
				userInfo.setMngr_tp_cd(tmbrAdmLgnInf.getMngr_tp_cd());
				//userInfo.setUser_auth_type(tmbrAdmLgnInf.getUser_auth_type());

	        	userInfo.setPos_cd(tmbrAdmLgnInf.getPos_cd());
	        	userInfo.setPos_nm(tmbrAdmLgnInf.getPos_nm());
	        	userInfo.setJob_cd(tmbrAdmLgnInf.getJob_cd());
	        	userInfo.setOrg_cd(tmbrAdmLgnInf.getOrg_cd());
	        	userInfo.setOrg_nm(tmbrAdmLgnInf.getOrg_nm());
	        	userInfo.setApvl_yn(tmbrAdmLgnInf.getApvl_yn());
	        	userInfo.setPos_cd(tmbrAdmLgnInf.getPos_cd());
	        	userInfo.setGrp_rol_nm(tmbrAdmLgnInf.getGrp_rol_nm());
	        	userInfo.setGrp_rol_id(tmbrAdmLgnInf.getGrp_rol_id());
	        	userInfo.setSys_cls_cd(tmbrAdmLgnInf.getSys_cls_cd());
	        	userInfo.setExcv_yn(tmbrAdmLgnInf.getExcv_yn());
	        	
	        	userInfo.setLgn_access_dy(tmbrAdmLgnInf.getLgn_access_dy());	

				parameterMap.put("user_id", tmbrAdmLgnInf.getUsr_id());

			}

		return userInfo;
	}




	/**
	 * 시스템 사용자 로그인 > 로그인 처리
	 * @param parameterMap
	 * @return UserInfo
	 * @throws Exception
	 */
	public UserInfo registAdminLogin(ParameterMap parameterMap) throws Exception {
		log.debug("----------registAdminLogin-----------");
		UserInfo userInfo = new UserInfo();
		TmbrAdmLgnInf tmbrAdmLgnInf = tmbrAdmLgnInfDao.selectTmbrAdmLgnInfInfo(parameterMap);
		userInfo.setLogin_result(UserInfo.LOGIN_SUCCESS);

		if(tmbrAdmLgnInf !=null) {

			// DB 데이터 취득 : 로그인 설정값
			TcmnCdDtl[] loginProp = CodeUtil.getTcmnCdDtlList("LOGIN_PROP", null, null, null, Const.BOOLEAN_TRUE);
			int userPwWrongCntStd = Config.getInt("user.passwd.wrong.cnt");
			int login_term = 0;
			String pw_wrong_yn = "";
			// 사용자 설정값 취득 : 패스워드 무한대입 방지
			for(int i=0; i<loginProp.length; i++) {
				if("PW_WRONG".equals(loginProp[i].getCd())) {
					userPwWrongCntStd = Integer.parseInt(loginProp[i].getRef_2());
				}
				if("PW_WRONG_YN".equals(loginProp[i].getCd())) {
					pw_wrong_yn = loginProp[i].getRef_2();
				}
				if("LOGIN_TERM".equals(loginProp[i].getCd())) {
					login_term = Integer.parseInt(loginProp[i].getRef_2());
				}
			}

			// 비빌번호 5번 이상 틀린 계정에 대해 일정 시간 후 자동 잠금 해제
			if(tmbrAdmLgnInf.getPwd_fail_cnt() == userPwWrongCntStd && tmbrAdmLgnInf.getPwd_fail_dttm() != null && (!"".equals(tmbrAdmLgnInf.getPwd_fail_dttm()))) {

				Date[] dateArrey = chkLoginTerm(tmbrAdmLgnInf.getF_pwd_fail_dttm(), login_term);

				if(dateArrey[0].after(dateArrey[1])) {

					tmbrAdmLgnInf.setActv_yn(Const.BOOLEAN_TRUE);
					tmbrAdmLgnInfDao.updateTmbrAdmLgnInfInitAdminPwInfo(tmbrAdmLgnInf);

					//사용자 잠금 자동 해제
					insertTbLgjbAdmlgninfH(tmbrAdmLgnInf);

					//재 검색
					tmbrAdmLgnInf = tmbrAdmLgnInfDao.selectTmbrAdmLgnInfInfo(parameterMap);
				}
			}


			if("3".equals(tmbrAdmLgnInf.getUsr_stat_cd())) {
				userInfo.setLogin_result(UserInfo.LOGIN_UNCERT_USER); // 미인증 회원(13)
				insertTmbrUsrLgnInf(parameterMap, tmbrAdmLgnInf, "94");
			}else if ("2".equals(tmbrAdmLgnInf.getUsr_stat_cd())) {
				userInfo.setLogin_result(UserInfo.LOGIN_LEAVE_USER); // 탈퇴 회원(12)
				insertTmbrUsrLgnInf(parameterMap, tmbrAdmLgnInf, "93");
			}else if (!Const.BOOLEAN_TRUE.equals(tmbrAdmLgnInf.getActv_yn())) {
				userInfo.setLogin_result(UserInfo.LOGIN_ID_INACTIVE); // 사용자 비활성화 됨
				insertTmbrUsrLgnInf(parameterMap, tmbrAdmLgnInf, "92");
				if(tmbrAdmLgnInf.getPwd_fail_dttm() != null && (!"".equals(tmbrAdmLgnInf.getPwd_fail_dttm()))) {
					Date[] dateArrey = chkLoginTerm(tmbrAdmLgnInf.getF_pwd_fail_dttm(), login_term);
					userInfo.setLast_access_dy(DateUtil.format(dateArrey[1], "yyyy-MM-dd HH:mm:ss"));
				}


			}else {
				//sha512

				boolean flag = false;
				String mobileYn = parameterMap.getValue("mobile_yn");
				String encPwd = "";
				if("Y".equals(mobileYn)){
					//encPwd = CryptUtil.sha512(parameterMap.getValue("lgn_pwd"));
					encPwd = parameterMap.getValue("lgn_pwd");
				}else{
					encPwd = CryptUtil.sha512(parameterMap.getValue("lgn_pwd"));
				}
				if(tmbrAdmLgnInf.getLgn_pwd() != null && tmbrAdmLgnInf.getLgn_pwd().equals(encPwd)) {
					flag = true;
				} else {
//					String empPw = tbBchrEmpIDao.selectEmpUserPw(tmbrAdmLgnInf);
//					if(empPw != null && empPw.equals(encPwd)) {
//						flag = true;
//					}
				}
				userInfo.setLgn_pwd(CryptUtil.sha512(parameterMap.getValue("lgn_pwd")));
				//if (tmbrAdmLgnInf.getLgn_pwd() != null && tmbrAdmLgnInf.getLgn_pwd().equals(CryptUtil.sha512(parameterMap.getValue("lgn_pwd")))) {
				if (flag) {
					if("1".equals(tmbrAdmLgnInf.getUsr_stat_cd())){ //회원 인증 여부 판단.
						// 정상 로그인 시 비밀번호 실패 수  초기화
						if(tmbrAdmLgnInf.getPwd_fail_cnt() > 0) {
							// 로그인 허용시간 취득
							Date[] dateArr = chkLoginTerm(tmbrAdmLgnInf.getF_pwd_fail_dttm(), login_term);
							if(tmbrAdmLgnInf.getPwd_fail_cnt() == userPwWrongCntStd && login_term > 0 && dateArr[0].before(dateArr[1])) {
								userInfo.setLogin_result(UserInfo.PASSWD_WRONG_TERM);
								userInfo.setLast_access_dy(DateUtil.format(dateArr[1], "yyyy-MM-dd HH:mm:ss"));
							} else {
								tmbrAdmLgnInfDao.updateTmbrAdmLgnInfInitAdminPwInfo(tmbrAdmLgnInf);
							}
						}

						// 사용자 비밀번호 변경 공지
						if (Integer.parseInt(tmbrAdmLgnInf.getPw_upd_tr()) >= Config.getInt("user.passwd.change.cycle.day")) {
							userInfo.setLogin_result(UserInfo.PASSWD_CHANGE_NOTICE);
							// 변경가능한날 카운트다운
							userInfo.setLogin_pw_remain((Config.getInt("user.passwd.change.cycle.day") + Config.getInt("user.passwd.change.can.day")) - Integer.parseInt(tmbrAdmLgnInf.getPw_upd_tr()) );

							// 사용자 비밀번호 변경 공지도 지나면
							if (Integer.parseInt(tmbrAdmLgnInf.getPw_upd_tr())  >= (Config.getInt("user.passwd.change.cycle.day") + Config.getInt("user.passwd.change.can.day"))) {
								userInfo.setLogin_result(UserInfo.PASSWD_EXCEED_MAXDAYS);

								// 사용자 inactive
								tmbrAdmLgnInf.setActv_yn(Const.BOOLEAN_FALSE);
								tmbrAdmLgnInfDao.update(tmbrAdmLgnInf);

							}
						}
					}else{
						userInfo.setLogin_result(UserInfo.LOGIN_UNCERT_USER);// 미인증시 결과값
					}
				}else {
					//비번 틀릴 경우
					insertTmbrUsrLgnInf(parameterMap, tmbrAdmLgnInf, "91");
					// 사용자 설정값이 설정 되었을 때 : 비밀번호 오류횟수 체크(설정값이 0 초과)
					if("Y".equals(pw_wrong_yn) && userPwWrongCntStd > 0) {
						// 사용자 비밀번호 오류 횟수 저장(프로퍼티 OR 공통코드)
						userInfo.setPw_wrong_cnt(userPwWrongCntStd);

						//제한 수 까지 틀리면 계정 잠금
						if (tmbrAdmLgnInf.getPwd_fail_cnt() == userPwWrongCntStd) {
							// 사용자 비밀번호 N회 오류
							userInfo.setLogin_result(UserInfo.PASSWD_WRONG_EXCEED);
							// 사용자 inactive
							tmbrAdmLgnInf.setActv_yn(Const.BOOLEAN_FALSE);
							tmbrAdmLgnInfDao.update(tmbrAdmLgnInf);

							//사용자 잠금
							insertTbLgjbAdmlgninfH(tmbrAdmLgnInf);

						}
						else {
							// 제한 수까지 틀리기 직전까지 카운팅
							userInfo.setLogin_result(UserInfo.LOGIN_INVALID);
							tmbrAdmLgnInf.setPwd_fail_cnt(tmbrAdmLgnInf.getPwd_fail_cnt() + 1);
							tmbrAdmLgnInf.setF_pwd_fail_dttm(DateUtil.today("yyyyMMddHHmmss"));

							tmbrAdmLgnInfDao.update(tmbrAdmLgnInf);
						}
					} else {
						// 사용자 비밀번호 오류 :: UserInfo에만 설정값 설정
						userInfo.setLogin_result(UserInfo.LOGIN_INVALID);
					}
				}
			}
		}else {
			// 사용자 정보 없음
			userInfo.setLogin_result(UserInfo.LOGIN_INVALID);
		}

		if ((userInfo.getLogin_result() == UserInfo.LOGIN_SUCCESS ||
				userInfo.getLogin_result() == UserInfo.PASSWD_CHANGE_NOTICE || userInfo.getLogin_result() == UserInfo.LOGIN_UNCERT_USER) && tmbrAdmLgnInf != null) {
				tmbrAdmLgnInf.setLgn_pwd(userInfo.getLgn_pwd());
				String lgn_unq_key = insertTmbrUsrLgnInf(parameterMap, tmbrAdmLgnInf, AppConst.LOGOUT_CASUS_CD_LOGIN);

				// useInfo 설정
				userInfo.setLogin(Const.BOOLEAN_TRUE);
				userInfo.setLogin_id(tmbrAdmLgnInf.getLgn_id());
				userInfo.setUser_id(tmbrAdmLgnInf.getUsr_id());
				userInfo.setUser_nm(tmbrAdmLgnInf.getUsr_nm());
				userInfo.setEmail(tmbrAdmLgnInf.getUsr_eml_addr());
				userInfo.setUsr_stat_cd(tmbrAdmLgnInf.getUsr_stat_cd());
				userInfo.setLast_access_ip_addr(parameterMap.getValue("ip_addr"));
				// 2019-03-11 중복 로그인 방지 처리를 위한 유니크 키값 추가
				userInfo.setLgn_unq_key(lgn_unq_key);
				// 조직 정보 추가
				userInfo.setMngr_tp_cd(tmbrAdmLgnInf.getMngr_tp_cd());
				//userInfo.setUser_auth_type(tmbrAdmLgnInf.getUser_auth_type());
				//회원 시스템(사이트) 번호

	        	userInfo.setPos_cd(tmbrAdmLgnInf.getPos_cd()); //직급코드
	        	userInfo.setJob_cd(tmbrAdmLgnInf.getJob_cd());       //직무코드
	        	userInfo.setOrg_cd(tmbrAdmLgnInf.getOrg_cd());       //조직코드
	        	userInfo.setOrg_nm(tmbrAdmLgnInf.getOrg_nm());       //조직명
	        	userInfo.setApvl_yn(tmbrAdmLgnInf.getApvl_yn());        //승인여부
	        	userInfo.setPos_nm(tmbrAdmLgnInf.getPos_nm());
	        	userInfo.setGrp_rol_nm(tmbrAdmLgnInf.getGrp_rol_nm());
	        	userInfo.setGrp_rol_id(tmbrAdmLgnInf.getGrp_rol_id());
	        	userInfo.setSys_cls_cd(tmbrAdmLgnInf.getSys_cls_cd());
	        	userInfo.setExcv_yn(tmbrAdmLgnInf.getExcv_yn());
	        	
			/*
			 * String lastLgnInTime = selectLastLgnInTime(tmbrAdmLgnInf.getUsr_id()); if
			 * (lastLgnInTime == null) {
			 * userInfo.setLgn_access_dy(tmbrAdmLgnInf.getLgn_access_dy()); } else {
			 * userInfo.setLgn_access_dy(lastLgnInTime); }
			 */
	        	userInfo.setLgn_access_dy(tmbrAdmLgnInf.getLgn_access_dy());

				parameterMap.put("user_id", tmbrAdmLgnInf.getUsr_id());

		}

		return userInfo;
	}


	/**
	 * FO/BO 메뉴관리에서 url로 메뉴아이디 얻기
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public String selectMenuId(ParameterMap parameterMap) throws Exception {
		return tsysAdmMnuDao.selectTsysAdmMnuId(parameterMap);
	}
	
	//사용자 마지막 로그인 정보 가져오기.
	public String selectLastLgnInTime(String userId) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("usr_id", userId);
		map.put("sys_cd", AppConst.SYS_CD);
		
		return tmbrAdmLastLgnInfDao.selectLastLgnInTime(map);
		
	}

	/**
	 * 진입로그 저장
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveCounterLog(ParameterMap parameterMap) throws Exception {
		// 진입자 IP 중복 체크
		String overLapYn = checkOverlapIpAddr(parameterMap);
		// 진입자 수(중복제거)
		int visr_cnt = 0;
		// 당일 접속IP가 중복이 아닌 경우
		if("N".equals(overLapYn)) {

			TmbrConnLog tmbrConnLog = new TmbrConnLog();
			tmbrConnLog.setIp_addr(parameterMap.getValue("ip_addr"));
			tmbrConnLog.setCrtr_id(parameterMap.getUserInfo().getUser_id());
			tmbrConnLog.setUsr_agt(parameterMap.getValue("userAgent"));

			// IP/USERAGENT 저장
			tmbrConnLogDao.insert(tmbrConnLog);
			visr_cnt = 1;
			parameterMap.put("unq_flag", "Y");
		}
		parameterMap.put("visr_cnt", visr_cnt);
		// 전체 접속자 수 통계 갱신(당일 첫회:insert / 당일 첫회 이후 : update)
		tmbrConnLogDao.insertTmbrConnStts(parameterMap);
		// 전체 누적 통계 업데이트
		tmbrConnLogDao.updateTmbrConnSttsTotInfo(parameterMap);
	}

	/**
	 * 진입자 IP 중복 체크("Y":중복 / "N" 허용)
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	private String checkOverlapIpAddr(ParameterMap parameterMap) throws Exception {
		return tmbrConnLogDao.selectTmbrConnLogIpOvlp(parameterMap);
	}


	/**
	 * 로그인 허용시간 & 기준시간 취득
	 * @param targetDate : 최종 접속시도 기준일
	 * @return 0 : 현재일시
	 *         1 : 기준일시 + 로그인 허용시간
	 * @throws Exception
	 */
	private Date[] chkLoginTerm(String targetDate, int login_term) throws Exception{
		// 기준일시 취득
		Calendar cal = Calendar.getInstance();
		Date tgtDate = DateUtil.parse(targetDate, "yyyyMMddHHmmss");
		// 현재일시 취득
		Date now = cal.getTime();
		// 기준일시 + 로그인 허용시간
		cal.setTime(tgtDate);
		cal.add(Calendar.SECOND, login_term);

		// 리턴값 생성
		Date[] dateArr = new Date[2];
		dateArr[0] = now;
		dateArr[1] = cal.getTime();
		return dateArr;
	}


	/**
	 * 회원가입 > 회원아이디 유효성 확인(중복/금지어)
	 * @param login_id
	 * @return
	 * @throws Exception
	 */
	public String getTmbrAdmLgnInfDupLgnId(String login_id) throws Exception {
		return tmbrAdmLgnInfDao.getTmbrAdmLgnInfDupLgnId(login_id);
	}

	/**
	 * 이메일 중복 확인
	 * @param email
	 * @return
	 * @throws Exception
	 */
	public String getTmbrAdmLgnInfDupUsrEmlAdr(String email) throws Exception {
		return tmbrAdmLgnInfDao.getTmbrAdmLgnInfDupUsrEmlAdr(email);
	}


	/**
	 * 사용자별 권한 메뉴 리스트 조회 : 미사용 2018-02-10
	 * @param parameterMap
	 * @return List<SysAdminMenu>
	 * @throws Exception
	 */
	public List<TsysAdmMnu> selectSysAdminMenuListByUserId(ParameterMap parameterMap) throws Exception {
		return tsysAdmMnuDao.selectTsysAdmMnuListByUserId(parameterMap);
	}

	/**
	 * Front 메뉴 목록 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectTsysAdmMnuFrntList(ParameterMap parameterMap) throws Exception {
		// TODO Auto-generated method stub
		return tsysAdmMnuDao.selectTsysAdmMnuFrntList(parameterMap);
	}

	/**
	 * BO URL 매핑 메뉴 정보 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public TsysAdmMnu selectTsysAdmMnuTgt(ParameterMap parameterMap) throws Exception {
		parameterMap.put("sys_cd", AppConst.SYS_CD);
		return tsysAdmMnuDao.selectTsysAdmMnuTgt(parameterMap);
	}

	/**
	 * 시간 조회
	 * @param parameterMap
	 * @return String
	 * @throws Exception
	 */
	public String selectSimpleSysdate(ParameterMap parameterMap) throws Exception {
		return commonDao.getSimpleSysdate(parameterMap);
	}

	/**
	 * 통계관리 > 진입통계목록(BO)
	 * @param parameterMap
	 * @throws Exception
	 */
	public JSONObject selectStaticsGridList(ParameterMap parameterMap) throws Exception {
		return tmbrConnLogDao.selectTmbrConnSttsGridList(parameterMap);
	}

	/**
	 * 통계관리 > 진입통계 초기값(BO:총 통계&당일 통계)
	 * @param parameterMap
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public JSONObject selectTmbrConnSttsInitCnt(ParameterMap parameterMap, JSONObject json) throws Exception {
		List<TmbrConnLog> list = tmbrConnLogDao.selectTmbrConnSttsInitCnt(parameterMap);
		for(int i=0; i<list.size(); i++)
		{
			if("TOT".equals(list.get(i).getCnt_tp()))
			{
				json.put("totVisitorCnt", list.get(i).getVisr_cnt());
				json.put("totPageViewCnt", list.get(i).getScrn_acs_Cnt());
			}
			else if("TGT".equals(list.get(i).getCnt_tp()))
			{
				json.put("tgtVisitorCnt", list.get(i).getVisr_cnt());
				json.put("tgtPageViewCnt", list.get(i).getScrn_acs_Cnt());
			}
		}
		return json;
	}

	/**
	 * 공통 팝업 grid 설정 값 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public JSONObject selectCommonPopupGrid(ParameterMap parameterMap) throws Exception {

		TcmnPopupInf tcmnPopupInf = tcmnPopupInfDao.selectTcmnPopupInfGrid(parameterMap);

		if (TextUtil.isEmpty(tcmnPopupInf)) {
			throw new UtilException("팝업 데이터가 정의되어 있지 않습니다.^^^^");
		}

		JSONObject json = new JSONObject();

		json.put("popup_id"  , tcmnPopupInf.getPopup_id());
		json.put("popup_nm"  , tcmnPopupInf.getPopup_nm());
		json.put("grd_conf"  , tcmnPopupInf.getGrd_conf());
		json.put("sch_box"   , tcmnPopupInf.getSch_box());
		json.put("popup_desc", tcmnPopupInf.getPopup_desc());
		json.put("wdt"       , tcmnPopupInf.getPopup_wdt());
		json.put("hgt"       , tcmnPopupInf.getPopup_hgt());

		return json;
	}

	/**
	 * 공통 팝업 grid 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public JSONObject selectCommonPopupList(ParameterMap parameterMap) throws Exception {

		// 공통 팝업 grid 조회를 위한 쿼리 절 조회
		TcmnPopupInf tcmnPopupInf = tcmnPopupInfDao.selectTcmnPopupInfInfo(parameterMap);

		if (TextUtil.isEmpty(tcmnPopupInf)) {
			throw new UtilException("팝업 데이터가 정의되어 있지 않습니다.");
		}

		String query = queryBuilder(parameterMap, tcmnPopupInf);

		parameterMap.put("popupQuery", query);
		List<Map<String, Object>> searchList = tcmnPopupInfDao.selectCommonPopupList(parameterMap);

		JSONObject json = new JSONObject();
		json.put("rows", searchList);

		return json;
	}

	/**
	 * @param parameterMap
	 * @param tcmnPopupInf
	 * @return
	 */
	private String queryBuilder(ParameterMap parameterMap, TcmnPopupInf tcmnPopupInf) {

		StringBuilder sb = new StringBuilder();
		//sb.append("/* [" + popCode + "][" + popName + "][공통팝업][TANINE] */ ");
		// select 절
		sb.append(" ").append(tcmnPopupInf.getSch_synx())
		// from 절
		.append(" ").append(tcmnPopupInf.getFrom_synx())
		// wehre 절
		.append(" ").append(tcmnPopupInf.getWhere_synx());
		// where 추가 절(검색)
		// 2019-03-06 oracle, mysql, mssql 적용을 위한 like절 수정
		String likeSchVal = "'%" + TextUtil.toEmptyDefaultString(parameterMap.getValue("searchValue"), "") + "%'";
		if(TextUtil.isEmpty(tcmnPopupInf.getWhere_add())) {
			//sb.append(" AND " + parameterMap.getValue("searchTarget") + " LIKE CONCAT('%', #{searchValue, jdbcType=VARCHAR}, '%')");
			sb.append(" AND ")
			.append(parameterMap.getValue("searchTarget"))
			.append(" LIKE")
			.append(likeSchVal);
		} else{
			//sb.append(" AND " + tcmnPopupInf.getWhere_add() + " LIKE CONCAT('%', #{searchValue, jdbcType=VARCHAR}, '%')");
			sb.append(" AND ")
			.append(tcmnPopupInf.getWhere_add())
			.append(" LIKE")
			.append(likeSchVal);
		}
		// orderby 절
		sb.append(" ")
		.append(TextUtil.toEmpty(tcmnPopupInf.getSrt_synx()));

		String query = sb.toString();

		return query;
	}

	/**
	 * 중복 로그인 방지를 위한 최신 유니크 키값 조회
	 * @param parameterMap
	 * @throws Exception
	 */
	public TmbrUsrLgnInf getTmbrUsrLgnInfUnqKey(ParameterMap parameterMap) throws Exception {
		return tmbrUsrLgnInfDao.selectTmbrUsrLgnInfUnqKey(parameterMap);
	}


	/**
	 * 정상 로그아웃 처리
	 * @param request, parameterMap
	 * @throws Exception
	 */
	public void registUserLogout(HttpServletRequest request, ParameterMap parameterMap) throws Exception {
		//TmbrUsrLgnInf tmbrUsrLgnInf = tmbrUsrLgnInfDao.selectTmbrUsrLgnInfAtLast(parameterMap);
		TmbrUsrLgnInf tmbrUsrLgnInf = (TmbrUsrLgnInf) parameterMap.populate(TmbrUsrLgnInf.class);

		String lgn_unq_key = (String) request.getSession().getAttribute("lgn_unq_key");

		if(lgn_unq_key != null && !"".equals(lgn_unq_key)) {

			tmbrUsrLgnInf.setLgn_unq_key(lgn_unq_key);
			tmbrUsrLgnInf.setLgo_caus_cd(AppConst.LOGOUT_CASUS_CD_LOGOUT);
			//tmbrUsrLgnInfDaoTrx.update(tmbrUsrLgnInf);
		}
	}


	/**
	 * 로그인 팝업 > 조직 통합 그룹별 권한 조회
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTsysAdmOrgGrpRolList(ParameterMap parameterMap) throws Exception {
		return tsysAdmRolDao.selectTsysAdmOrgGrpRolList(parameterMap);
	}



	/**
	 * 로그인 팝업 > 사용자 UsrApvl 허용 처리
	 * @param parameterMap
	 * @throws Exception
	 */
	public void updateUsrApvl(ParameterMap parameterMap) throws Exception {
		tmbrAdmLgnInfDao.updateUsrApvl(parameterMap);
	}



	/**
	 * 파라미터 시간 유효성 검사 ( 10분)
	 * @param checkTime
	 * @return int
	 * @throws Exception
	 */
	public int selectAvailabilityTime(String checkTime) throws Exception {
		return psysCommonDao.selectAvailabilityTime(checkTime);
	}



	/**
	 * 현재 시간 DB에서 조회
	 * @return
	 * @throws Exception
	 */
	public String selectNowTime() throws Exception {
		return psysCommonDao.selectNowTime();
	}



	/**
	 * 마지막 로그인 접속 시간 및 아이피 체크/ 있으면 insert 없으면 update
	 * @param userInfo
	 * @throws Exception
	 */
	public void lastLgnInfCheck(UserInfo userInfo) throws Exception {
		TmbrAdmLastLgnInf tmbrAdmLastLgnInf = new TmbrAdmLastLgnInf();

		tmbrAdmLastLgnInf.setUsr_id(userInfo.getUser_id());
		tmbrAdmLastLgnInf.setSys_cd(userInfo.getSys_cd());
		tmbrAdmLastLgnInf.setIp_addr(userInfo.getLast_access_ip_addr());

		int admLastLgnInfCount = tmbrAdmLastLgnInfDao.selectTmbrAdmLastLgnInfCount(tmbrAdmLastLgnInf);

		//데이터가 있을 경우 update, 없을 경우 insert
		if(admLastLgnInfCount > 0) {
			//update
			tmbrAdmLastLgnInfDao.updateTmbrAdmLastLgnInf(tmbrAdmLastLgnInf);
		} else {
			//insert
			tmbrAdmLastLgnInfDao.insertTmbrAdmLastLgnInf(tmbrAdmLastLgnInf);
		}
	}



	/**
	 * 로그인 > 권한 신청 bpopup > 신청하기
	 * @param parameterMap
	 * @throws Exception
	 */
	public void insertAthrAppList(ParameterMap parameterMap) throws Exception {
		/*
		 * List<TbBcpcAthrApp> insertTbBcpcAthrAppList = new ArrayList<TbBcpcAthrApp>();
		 * List<TsysAdmRolRtnn> insertTsysAdmRolRtnnList = new
		 * ArrayList<TsysAdmRolRtnn>();
		 * parameterMap.populatesForForceUpdate(TbBcpcAthrApp.class,
		 * insertTbBcpcAthrAppList);
		 * parameterMap.populatesForForceUpdate(TsysAdmRolRtnn.class,
		 * insertTsysAdmRolRtnnList); UserInfo userInfo = parameterMap.getUserInfo();
		 * if(userInfo != null){ //신청 및 history 기록
		 * 
		 * 
		 * // 방문자 수 는 본사면 본점, 본점 -> 본점 , 직
		 * 
		 * //cstr_cd 가 비워있거나 본사이면 본점을 본다. if(TextUtil.isEmpty(cstr_cd) ||
		 * "0000".equals(cstr_cd)) { mstr_cd = "0001"; cstr_cd = "0001"; mstr_nm = "본점";
		 * cstr_nm = "본점"; } else if("Y".equals(rgn_ldr_yn)) { //지역 여부가 Y일 경우 소속점을 본다.
		 * mstr_cd = blstr_cd; cstr_cd = blstr_cd; mstr_nm =
		 * parameterMap.getUserInfo().getBlstr_nm(); cstr_nm =
		 * parameterMap.getUserInfo().getBlstr_nm(); } else { //본사, 본점, 지역장 제외 모점코드
		 * 
		 * if(TextUtil.isNotEmpty(shop_grde_cd) && shop_grde_cd.indexOf('L') > -1) {
		 * mstr_cd = blstr_cd; cstr_cd = blstr_cd; mstr_nm =
		 * parameterMap.getUserInfo().getBlstr_nm(); cstr_nm =
		 * parameterMap.getUserInfo().getBlstr_nm();
		 * 
		 * } else { mstr_cd = cstr_cd; }
		 * 
		 * }
		 * 
		 * 
		 * 
		 * for(TbBcpcAthrApp tbBcpcAthrApp : insertTbBcpcAthrAppList) { //시스템 코드 아이디 필요.
		 * tbBcpcAthrApp.setApvl_usr_id("SYSTEM");
		 * tbBcpcAthrApp.setApvl_usr_nm("SYSTEM"); tbBcpcAthrApp.setAppl_stat_nm("승인");
		 * tbBcpcAthrApp.setAppl_stat_cd("10");
		 * tbBcpcAthrApp.setHr_org_cd(userInfo.getHr_org_cd());
		 * tbBcpcAthrApp.setApvl_yn("Y"); tbBcpcAthrApp.setAppl_rsn_cont("시스템 자동 신청");
		 * tbBcpcAthrApp.setMstr_cd(mstr_cd); tbBcpcAthrApp.setCstr_cd(cstr_cd);
		 * tbBcpcAthrApp.setMstr_nm(mstr_nm); tbBcpcAthrApp.setCstr_nm(cstr_nm);
		 * 
		 * tbBcpcAthrAppDao.insertTbBcpcAthrApp(tbBcpcAthrApp);
		 * tbLgapAthrappHDao.insertTbLgapAthrappH(tbBcpcAthrApp);
		 * 
		 * }
		 * 
		 * parameterMap.put("usr_id", userInfo.getUser_id());
		 * 
		 * userInfo.setApvl_yn("Y"); //사용자 사용 허용
		 * tmbrAdmLgnInfDao.updateUsrApvl(parameterMap); }
		 */

	}

	//로그인 시도 등 기록 남기기 위한 처리
	public String insertTmbrUsrLgnInf(ParameterMap parameterMap, TmbrAdmLgnInf tmbrAdmLgnInf, String lgo_caus_cd) throws Exception {

		String lgn_unq_key = UUID.randomUUID().toString().replace("-", "");

		//로그인 시도 관련 공통 코드 조회를 위한 값 셋팅
		parameterMap.put("mst_cd", "S100");
		parameterMap.put("cd", lgo_caus_cd);


		if("Y".equals(parameterMap.getValue("mobile_yn"))){
			parameterMap.put("sys_cd", "11");
		}else{
			parameterMap.put("sys_cd", AppConst.SYS_CD);
		}

		//공통 코드 조회
		TcmnCdDtl tcmnCdDtl = tcmnCdDtlDao.selectDTO("TcmnCdDtl.select", parameterMap);
		TdspSysInf tdspSysInf = tdspSysInfDao.selectDTO(TdspSysInf.class, parameterMap);


		TmbrUsrLgnInf tmbrUsrLgnInf = new TmbrUsrLgnInf();
		tmbrUsrLgnInf.setUsr_id(tmbrAdmLgnInf.getUsr_id());
		tmbrUsrLgnInf.setIp_addr(parameterMap.getValue("ip_addr"));
		tmbrUsrLgnInf.setLgo_caus_cd(tcmnCdDtl.getCd());
		tmbrUsrLgnInf.setLgo_caus_nm(tcmnCdDtl.getCd_nm());
		tmbrUsrLgnInf.setSys_cd(tdspSysInf.getSys_cd());
		tmbrUsrLgnInf.setSys_nm(tdspSysInf.getSys_nm());
		tmbrUsrLgnInf.setCrtr_id(tmbrAdmLgnInf.getUsr_id());
		tmbrUsrLgnInf.setUpdr_id(tmbrAdmLgnInf.getUsr_id());
		tmbrUsrLgnInf.setMngr_tp_cd(tmbrAdmLgnInf.getMngr_tp_cd());
		tmbrUsrLgnInf.setMngr_tp_nm(tmbrAdmLgnInf.getMngr_tp_nm());
		// 2019-03-11 중복 로그인 방지 처리를 위한 유니크 키값 추가
		tmbrUsrLgnInf.setLgn_unq_key(lgn_unq_key);
		
		Configuration configuration = Configuration.getInstance();
		String excludeLoginPw = configuration.get("app.exclude.login.pw");
		if(TextUtil.isEmpty(tmbrAdmLgnInf.getLgn_pwd()) || !CryptUtil.sha512(excludeLoginPw).equals(tmbrAdmLgnInf.getLgn_pwd())) {
			//tmbrUsrLgnInfDaoTrx.insert(tmbrUsrLgnInf);
		}

		return lgn_unq_key;
	}

	/**
	 * 회원 변경 이력
	 * @param tmbrAdmLgnInf
	 * @throws Exception
	 */
	public void insertTbLgjbAdmlgninfH(TmbrAdmLgnInf tmbrAdmLgnInf) throws Exception {
		//신규 생생 로그 추가.
		tmbrAdmLgnInf.setUpdr_id(tmbrAdmLgnInf.getUsr_id());
		Map<String, Object> tmbrAdmLgnInfMap = CommonUtil.convertObjectToMap(tmbrAdmLgnInf);
		ParameterMap paramMap = new ParameterMap();

		paramMap.put("mst_cd", "MSTS");
		paramMap.put("cd", tmbrAdmLgnInfMap.get("usr_stat_cd"));

		TcmnCdDtl tcmnCdDtl = tcmnCdDtlDao.selectDTO("TcmnCdDtl.select", paramMap);


		tmbrAdmLgnInfMap.put("hist_stat_cd", "20");
		tmbrAdmLgnInfMap.put("hist_stat_nm", "수정");
		if(tcmnCdDtl != null) {
			tmbrAdmLgnInfMap.put("usr_ss_nm", tcmnCdDtl.getCd_nm());
		}

		// 이력 insert
		tbLgjbAdmlgninfHDao.insertTbLgjbAdmlgninfH(tmbrAdmLgnInfMap);
	}




	/**
	 * D.bot SLO 매장등급 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public String selectShopGrdeCdOne(ParameterMap parameterMap) throws Exception {
		return psysCommonDao.selectShopGrdeCdOne(parameterMap);
	}
	
	/*
	 * select *
from tb_bcpc_usprathr_m 
where usr_id ='121200073'
	 */

}