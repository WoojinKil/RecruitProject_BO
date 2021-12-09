package kr.co.ta9.pandora3.psys.manager;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.entry.UserInfo;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.util.MD5Util;
import kr.co.ta9.pandora3.pbbs.dao.TbbsFlInfDao;
import kr.co.ta9.pandora3.pcmn.dao.TcmnCdDtlDao;
import kr.co.ta9.pandora3.pcommon.dao.PsysCommonDao;
import kr.co.ta9.pandora3.pcommon.dto.TbbsFlInf;
import kr.co.ta9.pandora3.pcommon.dto.TcmnCdDtl;
import kr.co.ta9.pandora3.pcommon.dto.TmbrAdmLgnInf;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmFvrt;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmMnu;
import kr.co.ta9.pandora3.pcommon.dto.TsysLogInf;
import kr.co.ta9.pandora3.pcommon.dto.usrdef.CommonInfo;
import kr.co.ta9.pandora3.pmbr.dao.TmbrAdmLgnInfDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmFvrtDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmMnuDao;
/**
* <pre>
* 1. 클래스명 : PsysCommonMgr
* 2. 설명 : Psys 공통 서비스
* 3. 작성일 : 2018-03-27
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class PsysCommonMgr {

	@Autowired
	private TcmnCdDtlDao tcmnCdDtlDao;
	
	@Autowired
	private TmbrAdmLgnInfDao tmbrAdmLgnInfDao;

	@Autowired
	private TsysAdmMnuDao tsysAdmMnuDao;

	@Autowired
	private TsysAdmFvrtDao tsysAdmFvrtDao;

	@Autowired
	private PsysCommonDao psysCommonDao;

	@Autowired
	private TbbsFlInfDao tbbsFlInfDao;

	/**
	 * 시스템 공통코드 상세정보 복수 조회
	 * @param parameterMap
	 * @return List<SysCdDtl>
	 * @throws Exception
	 */
	public List<TcmnCdDtl> selectTcmnCdDtlMultiList(ParameterMap parameterMap) throws Exception {

		String[] mst_cd_arr = parameterMap.getValue("mst_cd_arr").split(",");
		List<HashMap<String , Object>> mst_cd_list =  new ArrayList<HashMap<String , Object>>();
		for(int i=0; i<mst_cd_arr.length; i++) {
			HashMap<String , Object> map = new HashMap<String, Object>();
			map.put("MST_CD", mst_cd_arr[i]);
			mst_cd_list.add(map);
		}
		parameterMap.put("mst_cd_list", mst_cd_list);
		return tcmnCdDtlDao.selectTcmnCdDtlMultiList(parameterMap);
	}

	/**
	 * 시스템 공통코드 상세정보 복수 조회
	 * @param parameterMap
	 * @return List<SysCdDtl>
	 * @throws Exception
	 */
	public List<CommonInfo> getPsysCommonInfoList(ParameterMap parameterMap) throws Exception {

		parameterMap.put("sel_id", parameterMap.getValue("params[sel_id]"));
		parameterMap.put("p1"    , parameterMap.getValue("params[p1]"));
		parameterMap.put("p2"    , parameterMap.getValue("params[p2]"));
		parameterMap.put("p3"    , parameterMap.getValue("params[p3]"));
		parameterMap.put("p4"    , parameterMap.getValue("params[p4]"));
		parameterMap.put("p5"    , parameterMap.getValue("params[p5]"));
		parameterMap.put("p6"    , parameterMap.getValue("params[p6]"));
		parameterMap.put("p7"    , parameterMap.getValue("params[p7]"));
		parameterMap.put("p8"    , parameterMap.getValue("params[p8]"));
		parameterMap.put("p9"    , parameterMap.getValue("params[p9]"));

		return psysCommonDao.selectPsysCommonInfoList(parameterMap);
	}


	public String sndCertEml(ParameterMap parameterMap,HttpServletRequest request,HttpServletResponse response){
		String result = Const.BOOLEAN_SUCCESS;
		try{
			String user_id = String.valueOf(request.getParameter("usr_id"));
			parameterMap.put("usr_id", user_id);
			List<TmbrAdmLgnInf> tmbrAdmLgnInfList = selectTmbrAdmLgnInfList(parameterMap);

			if(tmbrAdmLgnInfList != null && !tmbrAdmLgnInfList.isEmpty()) {
				String millis = String.valueOf(System.currentTimeMillis());
				String certKey = new MD5Util().hexDigest(millis);

				TmbrAdmLgnInf user = new TmbrAdmLgnInf();
				user.setUsr_id(tmbrAdmLgnInfList.get(0).getUsr_id());

				//user.setCert_type_cd("10"); // 회원가입
				user.setJn_ctf_key(certKey);
				user.setJn_ctf_dttm(new Timestamp(System.currentTimeMillis()));
				user.setUpdr_id(tmbrAdmLgnInfList.get(0).getUsr_id());
				tmbrAdmLgnInfDao.update(user);

			}
		}catch (Exception e){
			result = Const.BOOLEAN_FAIL;
		}

		return result;
	}

	/**
	 * 인증메일 내용 작성
	 * @param domain
	 * @param url
	 * @return
	 */
	public String wrtCertMlCts(String domain, String url, String certType) {
		String contents = "";
		StringBuilder buffer = new StringBuilder();
		// 이메일 내용 작성
		buffer.append("<html>")
		.append("<head>")
		.append("<meta charset=\"utf-8\">")
		.append("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">")
		.append("<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\" />")
		.append("</head>")
		.append("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">")
		.append("<tr>")
		.append("<td align=\"center\">")
		.append("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"max-width: 750px border:1px solid #ddd\">")
		.append("<tr>")
		.append("<td align=\"center\">")
		.append("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"max-width: 650px\" >")
		.append("<tr>")
		.append("<td align=\"center\" valign=\"top\" style=\"padding: 25px 0 background:#FFF\" >")
		.append("</td>")
		.append("</tr>")
		.append("<tr>")
		.append("<td style=\"font-size:24pxline-height:28pxcolor:#666text-align:centerpadding: 25px 0 \">판도라 BO 인증안내</td>")
		.append("</tr>")
		.append("</table>")
		.append("</td>")
		.append("</tr>")
		.append("<tr>")
		.append("<td align=\"center\" style=\"background:#FFF\">")
		.append("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"max-width: 650px\" >")
		.append("<tr>")
		.append("<td>")
		.append("<!-- HERO IMAGE -->")
		.append("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"background: #f6f6f6\">")
		.append("<tr>")
		.append("<td>")
		.append("<!-- COPY -->")
		.append("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">")
		.append("<tr>")
		.append("<td align=\"center\" style=\"font-size: 25px font-family: Helvetica, Arial, sans-serif color:#666 padding:25px\">"+certType+"</td>")
		.append("</tr>")
		.append("<tr>")
		.append("<td align=\"center\" style=\"padding: 20px 0 0 0 font-size: 16px line-height: 25px font-family: Helvetica, Arial, sans-serif color: #666666\">")
		.append(certType)
		.append(" 완료를 위해 <br/><b>[인증페이지 이동]</b> 버튼을 클릭해주세요.")
		.append("</td>")
		.append("</tr>")
		.append("</table>")
		.append("</td>")
		.append("</tr>")
		.append("<tr>")
		.append("<td align=\"center\">")
		.append("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">")
		.append("<tr>")
		.append("<td align=\"center\" style=\"padding: 25px\">")
		.append("<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">")
		.append("<tr>")
		.append("<td align=\"center\" style=\"border-radius: 3px\" bgcolor=\"#256F9C\">")
		.append("<a href=\""+url+"\" target=\"_blank\" style=\"font-size: 16px font-family: Helvetica, Arial, sans-serif color: #ffffff text-decoration: none color: #ffffff text-decoration: none border-radius: 3px padding: 15px 25px border: 1px solid #256F9C display: inline-block\">인증페이지 이동</a>")
		.append("</td>")
		.append("</tr>")
		.append("</table>")
		.append("</td>")
		.append("</tr>")
		.append("</table>")
		.append("</td>")
		.append("</tr>")
		.append("</table>")
		.append("</td>")
		.append("</tr>")
		.append("</table>")
		.append("</td>")
		.append("</tr>")
		.append("<tr>")
		.append("<td bgcolor=\"#ffffff\" align=\"center\" style=\"padding: 25px 0px\">")
		.append("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" style=\"max-width: 650px\" >")
		.append("<tr>")
		.append("<td style=\"font-size:13pxline-height:20pxcolor:#666text-align:center\">본 메일은 메일 수신 동의에 의한 발신 전용 메일입니다.<br />자세한 문의 사항은 <span style=\"color:#337fd7\"></span>으로 문의 주시기 바랍니다.</td>")
		.append("</tr>")
		.append("</table>")
		.append("</td>")
		.append("</tr>")
		.append("</table>")
		.append("</td>")
		.append("</tr>")
		.append("</table>")
		.append("</html>");
		// 리턴값 설정
		contents = buffer.toString();
		return contents;
	}


	/**
	 * 사용자 로그 저장
	 * @param tsysLogInf
	 * @throws Exception
	 */
	public void insertTsysLogInf(TsysLogInf tsysLogInf) throws Exception {
		//tsysLogInfDaoTrx.insert(tsysLogInf);
	}

	/**
	 * bo 사용자별 권한 메뉴 리스트 조회
	 * @param parameterMap
	 * @return List<TsysAdmMnu>
	 * @throws Exception
	 */
	public List<TsysAdmMnu> selectTsysAdmMnuListByMnuList(ParameterMap parameterMap) throws Exception {
		
		int UsrMnuListCnt = tsysAdmMnuDao.selectUsrMnuListCnt(parameterMap);
		List<TsysAdmMnu> mnuList = null;
		
		if(UsrMnuListCnt > 0 ) {
			// 개인이 갖고 있는 권한을 검색한다.
			mnuList = tsysAdmMnuDao.selectTsysAdmMnuListUsrByMnuList(parameterMap);
		} else {
			//개인 권한이 없을 경우 tb_bcpc_usprathr_m 테이블에서 조직 권한에 매핑된 메뉴를 조회하여 확인한다.
			mnuList = tsysAdmMnuDao.selectTsysAdmMnuListOrgByMnuList(parameterMap);
		}
		
		return mnuList;
	}

	/**
	 * bo 사용자별 조직 권한 메뉴 리스트 조회
	 * @param parameterMap
	 * @return List<TsysAdmMnu>
	 * @throws Exception
	 */
	public List<TsysAdmMnu> selectTsysAdmMnuListByUserId(ParameterMap parameterMap) throws Exception {
		return tsysAdmMnuDao.selectTsysAdmMnuListByUserId(parameterMap);
	}

	/**
	 * bo 사용자별 권한 메뉴 리스트 조회
	 * @param parameterMap
	 * @return List<TsysAdmMnu>
	 * @throws Exception
	 */
	public List<TsysAdmMnu> selectTsysAdmMnuListByUsrAuth(ParameterMap parameterMap) throws Exception {
		return tsysAdmMnuDao.selectTsysAdmMnuListByUsrAuth(parameterMap);
	}

	/**
	 * 시스템 사용자 list 조회
	 * @param parameterMap
	 * @return List<TmbrAdmLgnInf>
	 * @throws Exception
	 */
	public List<TmbrAdmLgnInf> selectTmbrAdmLgnInfList(ParameterMap parameterMap) throws Exception {
		return tmbrAdmLgnInfDao.selectTmbrAdmLgnInfList(parameterMap);
	}

	/**
	 * 시스템 사용자 수정
	 * @param TmbrAdmLgnInf admin
	 * @return int
	 */
	public int updateTmbrAdmLgnInf(TmbrAdmLgnInf admin) throws Exception {
		return tmbrAdmLgnInfDao.update(admin);
	}


	/**
	 * 즐겨찾기 등록
	 * @param tsysAdmFvrt
	 * @return
	 * @throws Exception
	 */
	public void insertTsysAdmFvrt(ParameterMap parameterMap) throws Exception {

		TsysAdmFvrt tsysAdmFvrt = (TsysAdmFvrt)parameterMap.populate(TsysAdmFvrt.class);
		UserInfo userInfo = parameterMap.getUserInfo();
		if(userInfo != null){
			tsysAdmFvrt.setUsr_id(userInfo.getUser_id());
			tsysAdmFvrtDao.insertTsysAdmFvrt(tsysAdmFvrt);
		}

	}

	/**
	 * 즐겨찾기 유무 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public TsysAdmFvrt getTsysAdmFvrt(ParameterMap parameterMap) throws Exception {
		return tsysAdmFvrtDao.selectDTO(TsysAdmFvrt.class, parameterMap);
	}

	/**
	 * 즐겨찾기 유무 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public String selectExistTsysAdmFvrt(ParameterMap parameterMap) throws Exception {
		return tsysAdmFvrtDao.selectExistTsysAdmFvrt(parameterMap);
	}

	/**
	 *즐겨찾기 목록 조회
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject getTsysAdmFvrtList(ParameterMap parameterMap) throws Exception {
		return tsysAdmFvrtDao.getTsysAdmFvrtList(parameterMap);
	}

	/**
	 * 즐겨찾기 한항목 삭제
	 * @param parameterMap
	 * @throws Exception
	 */
	public void deleteTsysAdmFvrt(ParameterMap parameterMap) throws Exception {

		TsysAdmFvrt tsysAdmFvrt = (TsysAdmFvrt)parameterMap.populate(TsysAdmFvrt.class);
		UserInfo userInfo = parameterMap.getUserInfo();
		if(userInfo != null){
			tsysAdmFvrt.setUsr_id(userInfo.getUser_id());
			tsysAdmFvrtDao.delete(tsysAdmFvrt);

		}

	}

	/**
	 * 즐겨찾기 상위메뉴별삭제
	 * @param parameterMap
	 * @throws Exception
	 */
	public void deleteUpMnuTsysAdmFvrt(ParameterMap parameterMap) throws Exception {

		TsysAdmFvrt tsysAdmFvrt = (TsysAdmFvrt)parameterMap.populate(TsysAdmFvrt.class);
		UserInfo userInfo = parameterMap.getUserInfo();
		if(userInfo != null){
			tsysAdmFvrt.setUsr_id(userInfo.getUser_id());
			tsysAdmFvrtDao.deleteUpMnuTsysAdmFvrt(tsysAdmFvrt);
		}

	}



	/**
	 * 공통 > breadCrumb(홈 > 시스템관리 > 코드관리 > 코드관리) 메뉴 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	
	@SuppressWarnings("unchecked")
	public JSONObject selectTsysAdmMnuBreadCrumb(ParameterMap parameterMap) throws Exception {
		// string to int cast
		parameterMap.put("mnu_seq", Integer.parseInt(parameterMap.getValue("mnu_seq")));

		TsysAdmMnu tsysAdmMnu = tsysAdmMnuDao.selectTsysAdmMnuBreadCrumb(parameterMap);

		JSONObject json = new JSONObject();

		json.put("TOP_MNU_NM" , tsysAdmMnu.getTop_mnu_nm());
		json.put("MIDD_MNU_NM", tsysAdmMnu.getMidd_mnu_nm());
		json.put("BTM_MNU_NM" , tsysAdmMnu.getMnu_nm());

		return json;

	}

	/**
	 * 파일 정보 조회 : 단건
	 * @param  file_srl
	 * @return TbbsFlInf
	 * @throws Exception
	 */
	public TbbsFlInf selectTbbsFlInfInfo(String fl_seq) throws Exception {
		return tbbsFlInfDao.selectTbbsFlInfInfo(fl_seq);
	}


	/**
	 * 파일정보 수정 : 다운로드 수
	 * @param fl_seq
	 */
	public int updateTbbsFlInfDwldCnt(String fl_seq) throws Exception {
		return tbbsFlInfDao.updateTbbsFlInfDwldCnt(fl_seq);
	}

	/**
	 * 메뉴 정보 조회
	 * @param parameterMap
	 * @return TsysAdmMnu
	 */
	public TsysAdmMnu selectTsysAdmMnu(ParameterMap parameterMap) throws Exception {
		return tsysAdmMnuDao.selectDTO(TsysAdmMnu.class, parameterMap);
	}

	/**
	 * 개인 권한 신청
	 * @param parameterMap
	 * @return List<TsysAdmMnu>
	 * @throws Exception
	 */
	public List<TsysAdmMnu> getTsysAdmRolAppMnu(ParameterMap parameterMap) throws Exception {
		
		ArrayList<String> mnuArr = new ArrayList<String>();
		mnuArr.add("1295");
		mnuArr.add("1532");
		mnuArr.add("1580");
		mnuArr.add("1581");
		parameterMap.put("mnu_seq",mnuArr);
		
		return tsysAdmMnuDao.getTsysAdmRolAppMnu(parameterMap);
	}
}
