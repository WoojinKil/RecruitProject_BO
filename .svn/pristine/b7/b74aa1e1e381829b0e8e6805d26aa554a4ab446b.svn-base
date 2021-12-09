/**
* <pre>
* 1. 프로젝트명 : 판도라 패키지
* 2. 패키지명 : kr.co.ta9.pandora3.system.dto
* 3. 파일명 : SystemMgr
* 4. 작성일 : 2017-10-27
* </pre>
*/
package kr.co.ta9.pandora3.system.manager;

import java.util.Calendar;
import java.util.Date;
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
import kr.co.ta9.pandora3.common.conf.Config;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.exception.UtilException;
import kr.co.ta9.pandora3.common.util.DateUtil;
import kr.co.ta9.pandora3.common.util.MD5Util;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.pcmn.dao.TcmnPopupInfDao;
import kr.co.ta9.pandora3.pcommon.dto.TcmnCdDtl;
import kr.co.ta9.pandora3.pcommon.dto.TcmnPopupInf;
import kr.co.ta9.pandora3.pcommon.dto.TmbrAdmLgnInf;
import kr.co.ta9.pandora3.pcommon.dto.TmbrConnLog;
import kr.co.ta9.pandora3.pcommon.dto.TmbrUsrInf;
import kr.co.ta9.pandora3.pcommon.dto.TmbrUsrLgnInf;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmMnu;
import kr.co.ta9.pandora3.pmbr.dao.TmbrAdmLgnInfDao;
import kr.co.ta9.pandora3.pmbr.dao.TmbrConnLogDao;
import kr.co.ta9.pandora3.pmbr.dao.TmbrUsrInfDao;
import kr.co.ta9.pandora3.pmbr.dao.TmbrUsrLgnInfDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmMnuDao;


/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.system.dto
* 2. 타입명 : class
* 3. 작성일 : 2017-10-27
* 4. 설명 : 시스템 매니저
* </pre>
*/
@Service
public class SystemMgr {

	private final Log log = LogFactory.getLog(SystemMgr.class);

	@Autowired
	private TmbrAdmLgnInfDao tmbrAdmLgnInfDao;
	
	@Autowired
	private TmbrUsrLgnInfDao tmbrUsrLgnInfDao;
	
	@Autowired
	private TmbrUsrInfDao tmbrUsrInfDao;
	
	@Autowired
	private TsysAdmMnuDao tsysAdmMnuDao;
	
	@Autowired
	private TmbrConnLogDao tmbrConnLogDao;
	
	@Autowired
	private CommonDao commonDao;
	
	@Autowired
	private TcmnPopupInfDao tcmnPopupInfDao;

	/**
	 * 시스템 사용자 로그인 처리
	 * @param parameterMap
	 * @return UserInfo
	 * @throws Exception
	 */
	public UserInfo registAdminLogin(ParameterMap parameterMap) throws Exception {
		UserInfo userInfo = new UserInfo();
		TmbrAdmLgnInf tmbrAdmLgnInf = tmbrAdmLgnInfDao.selectTmbrAdmLgnInfInfo(parameterMap);
		userInfo.setLogin_result(UserInfo.LOGIN_SUCCESS);
		if(tmbrAdmLgnInf !=null) {
			if("3".equals(tmbrAdmLgnInf.getUsr_stat_cd())) {
				userInfo.setLogin_result(UserInfo.LOGIN_UNCERT_USER); // 미인증 회원(13)
			}else if ("2".equals(tmbrAdmLgnInf.getUsr_stat_cd())) {
				userInfo.setLogin_result(UserInfo.LOGIN_LEAVE_USER); // 탈퇴 회원(12)
			}else if (!Const.BOOLEAN_TRUE.equals(tmbrAdmLgnInf.getActv_yn())) {
				userInfo.setLogin_result(UserInfo.LOGIN_ID_INACTIVE); // 사용자 비활성화 됨
			}else {
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
				if (tmbrAdmLgnInf.getLgn_pwd() != null && tmbrAdmLgnInf.getLgn_pwd().equals(new MD5Util().hexDigest(parameterMap.getValue("lgn_pwd")))) {
					if(tmbrAdmLgnInf.getUsr_stat_cd().equals("1")){ //회원 인증 여부 판단.
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
							//tmbrAdmLgnInf.setPwd_fail_dttm(DateUtil.today("yyyyMMddHHmmss"));

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

		if (userInfo.getLogin_result() == UserInfo.LOGIN_SUCCESS ||
				userInfo.getLogin_result() == UserInfo.PASSWD_CHANGE_NOTICE || userInfo.getLogin_result() == UserInfo.LOGIN_UNCERT_USER) {
				String lgn_unq_key = UUID.randomUUID().toString().replace("-", "");
				
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
				//userInfo.setUser_auth_type(tmbrAdmLgnInf.getUser_auth_type());

				parameterMap.put("user_id", tmbrAdmLgnInf.getUsr_id());

				TmbrUsrLgnInf sysUserLogin = new TmbrUsrLgnInf();
				sysUserLogin.setUsr_id(tmbrAdmLgnInf.getUsr_id());
				sysUserLogin.setIp_addr(parameterMap.getValue("ip_addr"));
				sysUserLogin.setLgo_caus_cd(AppConst.LOGOUT_CASUS_CD_LOGIN);
				sysUserLogin.setCrtr_id(tmbrAdmLgnInf.getUsr_id());
				sysUserLogin.setUpdr_id(tmbrAdmLgnInf.getUsr_id());
				// 2019-03-11 중복 로그인 방지 처리를 위한 유니크 키값 추가
				sysUserLogin.setLgn_unq_key(lgn_unq_key);
				tmbrUsrLgnInfDao.insert(sysUserLogin);
				//회원 테이블에 로그인 ip 정보 및 최종 로그인 시간 업데이트
//				sysUserDaoTrx.updateLastLoginInfo(sysUserLogin);
			}

		return userInfo;
	}

	/**
	 * 로그인 처리
	 * @param parameterMap
	 * @return UserInfo
	 * @throws Exception
	 */
	public UserInfo registUserLogin(ParameterMap parameterMap) throws Exception {
		UserInfo userInfo = new UserInfo();
		TmbrUsrInf tmbrUsrInf = tmbrUsrInfDao.selectTmbrUsrInf(parameterMap);

		userInfo.setLogin_result(UserInfo.LOGIN_SUCCESS);

		/* 비밀번호 암호화 방식
		System.out.println("ORG passwd => " + parameterMap.getValue("passwd"));
		System.out.println("ERIK passwd + md5 => " + new MD5Util().hexDigest(parameterMap.getValue("passwd")) );
		System.out.println("ECFC passwd + b64 => " + CryptUtil.encode(parameterMap.getValue("passwd")) );	*/
		if (tmbrUsrInf != null) {
			if("3".equals(tmbrUsrInf.getUsr_ss_cd())) {

				userInfo.setLogin_result(UserInfo.LOGIN_UNCERT_USER);			// 미인증 회원(13)
			} else if ("2".equals(tmbrUsrInf.getUsr_ss_cd())) {
				userInfo.setLogin_result(UserInfo.LOGIN_LEAVE_USER);			// 탈퇴 회원(12)
			} else if (!Const.BOOLEAN_TRUE.equals(tmbrUsrInf.getActv_yn())) {	// 사용자 비활성화 됨
				userInfo.setLogin_result(UserInfo.LOGIN_ID_INACTIVE);
			}
			else {
				// DB 데이터 취득 : 로그인 설정값
				TcmnCdDtl[] loginProp = CodeUtil.getTcmnCdDtlList("LOGIN_PROP", null, null, null, Const.BOOLEAN_TRUE);
				int userPwWrongCntStd = Config.getInt("user.passwd.wrong.cnt");
				int login_term = 0;
				String pw_wrong_yn = "";
				// 사용자 설정값 취득 : 패스워드 무한대입 방지
				for(int i=0; i<loginProp.length; i++) {
					if("PW_WRONG".equals(loginProp[i].getCd())) {
						userPwWrongCntStd = Integer.parseInt(loginProp[i].getRef_1());
					}
					if("PW_WRONG_YN".equals(loginProp[i].getCd())) {
						pw_wrong_yn = loginProp[i].getRef_1();
					}
					if("LOGIN_TERM".equals(loginProp[i].getCd())) {
						login_term = Integer.parseInt(loginProp[i].getRef_1());
					}
				}

				if (tmbrUsrInf.getLgn_pwd() != null &&
						tmbrUsrInf.getLgn_pwd().equals(new MD5Util().hexDigest(parameterMap.getValue("lgn_pwd")))) {

					// 정상 로그인 시 비밀번호 초기화
					if(tmbrUsrInf.getPwd_fail_cnt() > 0) {
						// 로그인 허용시간 취득
						Date[] dateArr = chkLoginTerm(tmbrUsrInf.getPwd_fail_dttm(), login_term);
						if(tmbrUsrInf.getPwd_fail_cnt() == userPwWrongCntStd && login_term > 0 && dateArr[0].before(dateArr[1])) {
							userInfo.setLogin_result(UserInfo.PASSWD_WRONG_TERM);
							userInfo.setLast_access_dy(DateUtil.format(dateArr[1], "yyyy-MM-dd HH:mm:ss"));
						} else {
							tmbrUsrInfDao.updateTmbrUsrInfInitUserPwInfo(tmbrUsrInf);
						}
					}

					// 사용자 비밀번호 변경 공지
					if (Integer.parseInt(tmbrUsrInf.getPw_upd_tr()) >= Config.getInt("user.passwd.change.cycle.day")) {
						userInfo.setLogin_result(UserInfo.PASSWD_CHANGE_NOTICE);
						// 변경가능한날 카운트다운
						userInfo.setLogin_pw_remain((Config.getInt("user.passwd.change.cycle.day") + Config.getInt("user.passwd.change.can.day")) - Integer.parseInt(tmbrUsrInf.getPw_upd_tr()) );

						// 사용자 비밀번호 변경 공지도 지나면
						if (Integer.parseInt(tmbrUsrInf.getPw_upd_tr())  >= (Config.getInt("user.passwd.change.cycle.day") + Config.getInt("user.passwd.change.can.day"))) {
							userInfo.setLogin_result(UserInfo.PASSWD_EXCEED_MAXDAYS);

							// 사용자 inactive
							tmbrUsrInf.setActv_yn(Const.BOOLEAN_FALSE);
							tmbrUsrInfDao.update(tmbrUsrInf);
						}
					}
				}
				else {
					// 사용자 설정값이 설정 되었을 때 : 비밀번호 오류횟수 체크(설정값이 0 초과)
					if("Y".equals(pw_wrong_yn) && userPwWrongCntStd > 0) {
						// 사용자 비밀번호 오류 횟수 저장(프로퍼티 OR 공통코드)
						userInfo.setPw_wrong_cnt(userPwWrongCntStd);
						// 로그인 시도 횟수 제한시간 확인
						if (tmbrUsrInf.getPwd_fail_cnt() == userPwWrongCntStd) {
							Date[] dateArr = chkLoginTerm(tmbrUsrInf.getPwd_fail_dttm(), login_term);
							if(login_term > 0 && dateArr[0].before(dateArr[1])) {
								// 사용자 비밀번호 입력 제한시간 적용
								userInfo.setLogin_result(UserInfo.PASSWD_WRONG_TERM);
								userInfo.setLast_access_dy(DateUtil.format(dateArr[1], "yyyy-MM-dd HH:mm:ss"));
							} else {
								// 사용자 비밀번호 N회 오류
								userInfo.setLogin_result(UserInfo.PASSWD_WRONG_EXCEED);

								// 사용자 inactive
								tmbrUsrInf.setActv_yn(Const.BOOLEAN_FALSE);
								tmbrUsrInfDao.update(tmbrUsrInf);
							}
						}
						else {
							// 사용자 비밀번호 오류
							userInfo.setLogin_result(UserInfo.LOGIN_INVALID);
							tmbrUsrInf.setPwd_fail_cnt(tmbrUsrInf.getPwd_fail_cnt() + 1);
							tmbrUsrInf.setPwd_fail_dttm(DateUtil.today("yyyyMMddHHmmss"));

							tmbrUsrInfDao.update(tmbrUsrInf);
						}
					} else {
						// 사용자 비밀번호 오류 :: UserInfo에만 설정값 설정
						userInfo.setLogin_result(UserInfo.LOGIN_INVALID);
					}
				}
			}
		}
		else {
			// 사용자 정보 없음
			userInfo.setLogin_result(UserInfo.LOGIN_INVALID);
		}

		if (userInfo.getLogin_result() == UserInfo.LOGIN_SUCCESS ||
			userInfo.getLogin_result() == UserInfo.PASSWD_CHANGE_NOTICE) {
			// 2019-03-12 중복 로그인 방지를 위한 유니크 키값(PRIMARY KEY)
			String lgn_unq_key = UUID.randomUUID().toString().replace("-", "");
			// useInfo 설정
			userInfo.setLogin(Const.BOOLEAN_TRUE);
			userInfo.setLogin_id(tmbrUsrInf.getLgn_id());
			userInfo.setUser_id(tmbrUsrInf.getUsr_id());
			userInfo.setUser_nm(tmbrUsrInf.getUsr_nm());
			userInfo.setEmail(tmbrUsrInf.getUsr_eml_adr());
			userInfo.setMngr_tp_cd(tmbrUsrInf.getMngr_tp_cd());
			userInfo.setLast_access_ip_addr(parameterMap.getValue("ip_addr"));
			userInfo.setUser_auth_type(tmbrUsrInf.getUsr_auth_tp_cd());

			parameterMap.put("user_id", tmbrUsrInf.getUsr_id());

			TmbrUsrLgnInf tmbrUsrLgnInf = new TmbrUsrLgnInf();
			tmbrUsrLgnInf.setUsr_id(tmbrUsrInf.getUsr_id());
			tmbrUsrLgnInf.setIp_addr(parameterMap.getValue("ip_addr"));
			tmbrUsrLgnInf.setLgo_caus_cd(AppConst.LOGOUT_CASUS_CD_LOGIN);
			tmbrUsrLgnInf.setCrtr_id(tmbrUsrInf.getUsr_id());
			tmbrUsrLgnInf.setUpdr_id(tmbrUsrInf.getUsr_id());
			tmbrUsrLgnInf.setLgn_unq_key(lgn_unq_key);
			tmbrUsrLgnInfDao.insert(tmbrUsrLgnInf);
			//회원 테이블에 로그인 ip 정보 및 최종 로그인 시간 업데이트
			tmbrUsrInfDao.updateTmbrUsrInfLastLogin(tmbrUsrInf);
		}

		return userInfo;
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
			tmbrUsrLgnInfDao.update(tmbrUsrLgnInf);
		}
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
		JSONObject json = new JSONObject();
		TcmnPopupInf tcmnPopupInf = new TcmnPopupInf();
		
		tcmnPopupInf = tcmnPopupInfDao.selectTcmnPopupInfGrid(parameterMap);
			
		if (TextUtil.isEmpty(tcmnPopupInf)) {
			throw new UtilException("팝업 데이터가 정의되어 있지 않습니다.^^^^");
		}
		
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
		sb.append(" " + tcmnPopupInf.getSch_synx());
		// from 절
		sb.append(" " + tcmnPopupInf.getFrom_synx());
		// wehre 절
		sb.append(" " + tcmnPopupInf.getWhere_synx());
		// where 추가 절(검색)
		// 2019-03-06 oracle, mysql, mssql 적용을 위한 like절 수정
		String likeSchVal = "'%" + TextUtil.toEmptyDefaultString(parameterMap.getValue("searchValue"), "") + "%'";
		if(TextUtil.isEmpty(tcmnPopupInf.getWhere_add())) {
			//sb.append(" AND " + parameterMap.getValue("searchTarget") + " LIKE CONCAT('%', #{searchValue, jdbcType=VARCHAR}, '%')");
			sb.append(" AND " + parameterMap.getValue("searchTarget") + " LIKE" + likeSchVal);
		} else{
			//sb.append(" AND " + tcmnPopupInf.getWhere_add() + " LIKE CONCAT('%', #{searchValue, jdbcType=VARCHAR}, '%')");
			sb.append(" AND " + tcmnPopupInf.getWhere_add() + " LIKE" + likeSchVal);
		}
		// orderby 절
		sb.append(" " + TextUtil.toEmpty(tcmnPopupInf.getSrt_synx()));

		String query = sb.toString();
		
		return query;
	}
	
}