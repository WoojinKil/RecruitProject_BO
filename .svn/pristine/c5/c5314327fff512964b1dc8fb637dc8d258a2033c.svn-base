/**
* <pre>
* 1. 프로젝트명 : 판도라 패키지
* 2. 패키지명 : kr.co.ta9.pandora3.app.entry
* 3. 파일명 : UserInfo
* 4. 작성일 : 2017-10-27
* </pre>
*/
package kr.co.ta9.pandora3.app.entry;

import java.io.Serializable;

import kr.co.ta9.pandora3.common.bean.BaseBean;
import kr.co.ta9.pandora3.common.conf.Const;

/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.app.entry
* 2. 타입명 : class
* 3. 작성일 : 2017-10-27
* 4. 설명 : 사용자 정보 dto
* </pre>
*/
public class UserInfo extends BaseBean implements Serializable {

	private static final long serialVersionUID = -2309819858852911920L; 
	
	//로그인 결과
    public static final int LOGIN_NO                = -1;   //로그인시도 안함
    public static final int LOGIN_SUCCESS           = 0;    //로그인 성공
    public static final int LOGIN_INVALID           = 1;    //사용자 정보 없음 또는 패스워드 불일치
    public static final int PASSWD_WRONG_EXCEED     = 2;    //패스워드 5회 오류
    public static final int LOGIN_FIRST             = 3;    //최초 로그인
    public static final int LOGIN_DUP_USER          = 4;    //서로 다른 IP에서 로그인
    public static final int PASSWD_CHANGE_NOTICE    = 5;    //변경 알림
    public static final int PASSWD_EXCEED_MAXDAYS   = 6;    //변경유효기간 초과
    public static final int LOGIN_IP_OUT            = 7;    //외부접속
    public static final int LOGIN_IP_OUT_INVALID    = 8;    //외부접속허용안함
    public static final int ID_SAME_PASSWD          = 9;    //사용자ID와 패스워드가 동일
    public static final int LOGIN_ID_INACTIVE       = 10;   //사용자ID 비활성화됨
    public static final int LAST_ACCESS_IP_DIFF     = 11;   //최근접속IP가 다름
    public static final int LOGIN_LEAVE_USER        = 12;   //탈퇴회원
    public static final int LOGIN_UNCERT_USER       = 13;   //미인증회원
    public static final int PASSWD_WRONG_TERM       = 14;   //로그인 횟수시도 제한시간
    public static final int SLO_LOGIN_INVALID       = 15;   //유효하지 않는 SLO 로그인
    public static final int RROL_NOT_FOUNT			= 30;   //권한을 찾을 수 없음.
    
    
	
	private String user_id;					// 사용자아이디
	private String user_nm;					// 사용자명
	private String login;					// 로그인 여부 (로그인 중 Y)
	private String login_id;				// 로그인아이디
	private String email;					// 이메일
	private int login_result;				// 로그인결과
	private int login_pw_remain;			// 로그인비밀번호유지
	private String usr_stat_cd;				// 유저상태코드
	private String usr_stat_nm;				// 유저상태명
	private String last_access_ip_addr;		// 최근접근ip주소
	private String last_access_dy;			// 최근접근일
	private String user_auth_type;			// 회원권한타입
	private int pw_wrong_cnt;               // 비밀번호 틀린 횟수
	private String org_nm;					// 부서명
	private String mngr_tp_cd;             	// 관리자유형
	private String org_cd;					// 조직코드
	private String grde_nm;					// 직급명
	private String pos_cd;					// 직책코드
	private String pos_nm;					// 직책명
	private String job_cd;					// 직무코드
	private String apvl_yn; 				// 승인여부
	private String lgn_unq_key;				// 로그인 유니크 키 (중복로그인 방지키)
	private String sys_cd; 					// 시스템코드
	private String grp_rol_id;				// 권한그룹 아이디
	private String grp_rol_nm;				// 권한그룹 명
	private String ctf_yn;					// 인증여부
	private String fnd_ctf_key_yn;			// 찾기인증여부
	private String sys_cls_cd;				// 시스템 구분 코드
	private String excv_yn;                 // 외부사용자 여부 
	private String lgn_access_dy;           //로그인 시점
	private String lgn_pwd;                 //로그인 패스워드
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public String getLogin_id() {
		return login_id;
	}
	public void setLogin_id(String login_id) {
		this.login_id = login_id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getLogin_result() {
		return login_result;
	}
	public void setLogin_result(int login_result) {
		this.login_result = login_result;
	}
	public int getLogin_pw_remain() {
		return login_pw_remain;
	}
	public void setLogin_pw_remain(int login_pw_remain) {
		this.login_pw_remain = login_pw_remain;
	}
	public String getLast_access_ip_addr() {
		return last_access_ip_addr;
	}
	public void setLast_access_ip_addr(String last_access_ip_addr) {
		this.last_access_ip_addr = last_access_ip_addr;
	}
	public String getLast_access_dy() {
		return last_access_dy;
	}
	public void setLast_access_dy(String last_access_dy) {
		this.last_access_dy = last_access_dy;
	}
	public String getUser_auth_type() {
		return user_auth_type;
	}
	public void setUser_auth_type(String user_auth_type) {
		this.user_auth_type = user_auth_type;
	}
	public int getPw_wrong_cnt() {
		return pw_wrong_cnt;
	}
	public void setPw_wrong_cnt(int pw_wrong_cnt) {
		this.pw_wrong_cnt = pw_wrong_cnt;
	}
	public String getOrg_nm() {
		return org_nm;
	}
	public void setOrg_nm(String org_nm) {
		this.org_nm = org_nm;
	}
	public String getMngr_tp_cd() {
		return mngr_tp_cd;
	}
	public void setMngr_tp_cd(String mngr_tp_cd) {
		this.mngr_tp_cd = mngr_tp_cd;
	}
	public String getOrg_cd() {
		return org_cd;
	}
	public void setOrg_cd(String org_cd) {
		this.org_cd = org_cd;
	}
	public String getGrde_nm() {
		return grde_nm;
	}
	public void setGrde_nm(String grde_nm) {
		this.grde_nm = grde_nm;
	}
	public String getPos_cd() {
		return pos_cd;
	}
	public void setPos_cd(String pos_cd) {
		this.pos_cd = pos_cd;
	}
	public String getPos_nm() {
		return pos_nm;
	}
	public void setPos_nm(String pos_nm) {
		this.pos_nm = pos_nm;
	}
	public String getJob_cd() {
		return job_cd;
	}
	public void setJob_cd(String job_cd) {
		this.job_cd = job_cd;
	}
	public String getApvl_yn() {
		return apvl_yn;
	}
	public void setApvl_yn(String apvl_yn) {
		this.apvl_yn = apvl_yn;
	}
	public String getLgn_unq_key() {
		return lgn_unq_key;
	}
	public void setLgn_unq_key(String lgn_unq_key) {
		this.lgn_unq_key = lgn_unq_key;
	}
	public String getGrp_rol_id() {
		return grp_rol_id;
	}
	public void setGrp_rol_id(String grp_rol_id) {
		this.grp_rol_id = grp_rol_id;
	}
	public String getGrp_rol_nm() {
		return grp_rol_nm;
	}
	public void setGrp_rol_nm(String grp_rol_nm) {
		this.grp_rol_nm = grp_rol_nm;
	}
	public String getCtf_yn() {
		return ctf_yn;
	}
	public void setCtf_yn(String ctf_yn) {
		this.ctf_yn = ctf_yn;
	}
	public String getFnd_ctf_key_yn() {
		return fnd_ctf_key_yn;
	}
	public void setFnd_ctf_key_yn(String fnd_ctf_key_yn) {
		this.fnd_ctf_key_yn = fnd_ctf_key_yn;
	}
	public String getExcv_yn() {
		return excv_yn;
	}
	public void setExcv_yn(String excv_yn) {
		this.excv_yn = excv_yn;
	}
	public String getLgn_access_dy() {
		return lgn_access_dy;
	}
	public void setLgn_access_dy(String lgn_access_dy) {
		this.lgn_access_dy = lgn_access_dy;
	}
	public String getLogin() {
		return login;
	}
	public void setLogin(String login) {
		this.login = login;
	}
	public boolean isLogin() {
		return Const.BOOLEAN_TRUE.equals(login);
	}
	public String getLgn_pwd() {
		return lgn_pwd;
	}
	public void setLgn_pwd(String lgn_pwd) {
		this.lgn_pwd = lgn_pwd;
	}
	public String getUsr_stat_cd() {
		return usr_stat_cd;
	}
	public void setUsr_stat_cd(String usr_stat_cd) {
		this.usr_stat_cd = usr_stat_cd;
	}
	public void setSys_cd(String sys_cd) {
		this.sys_cd = sys_cd;
	}
	public String getSys_cd() {
		return sys_cd;
	}
	public String getSys_cls_cd() {
		return sys_cls_cd;
	}
	public void setSys_cls_cd(String sys_cls_cd) {
		this.sys_cls_cd = sys_cls_cd;
	}
	public String getUsr_stat_nm() {
		return usr_stat_nm;
	}
	public void setUsr_stat_nm(String usr_stat_nm) {
		this.usr_stat_nm = usr_stat_nm;
	}
	
	
	
	
}
