package kr.co.ta9.pandora3.psys.controller;

import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import kr.co.ta9.pandora3.app.entry.UserInfo;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.app.util.DrmFileUtil;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.servlet.download.FileDownLoad;
import kr.co.ta9.pandora3.common.util.MD5Util;
import kr.co.ta9.pandora3.common.util.PasswdUtil;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.pcommon.dto.TmbrAdmLgnInf;
import kr.co.ta9.pandora3.psys.manager.Psys1007Mgr;

/**
 * <pre>
 * 1. 클래스명 : Psys1007Controller
 * 2. 설명 : 시스템사용자관리 컨트롤러
 * 3. 작성일 : 2018-03-28
 * 4. 작성자 : TANINE
 * </pre>
 */
@Controller
public class Psys1007Controller extends CommonActionController{

	@Autowired
	private Psys1007Mgr psys1007Mgr;

	/**
	 * BO 사용자 관리 > BO 사용자 그리드 목록 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1007List", method = RequestMethod.POST)
	public void getPsys1007GrdLst(HttpServletRequest request, HttpServletResponse response) throws Exception{
		System.out.println("getPsys1007GrdLst 들어감");
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		// json 선언
		JSONObject json = new JSONObject();

		try {
			// 시스템 사용자 목록 그리드 조회
			json = psys1007Mgr.selectTmbrAdmLgnInfGridList(parameterMap);
		} catch (Exception e) {
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
		System.out.println("처리완료");
	}

	/**
	 * BO 사용자 관리 > BO 사용자 관리 저장
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/savePsys1007", method = RequestMethod.POST)
	public void savePsys1007(HttpServletRequest request, HttpServletResponse response) throws Exception{

		System.out.println("savePsys1007들어감");
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		// json 선언
		JSONObject json = new JSONObject();

		try {

			// 상위메뉴 저장
			psys1007Mgr.saveTmbrAdmLgnInfList(parameterMap);

		} catch (Exception e) {

			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;

			// json에 MSG 담기
			json.put("MSG", parameterMap.getValue("MSG"));
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 시스템사용자관리 > 시스템사용자 그리드 목록 엑셀다운로드
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1007XlsxDwld")
	public void getPsys1007XlsxDwld(HttpServletRequest request, HttpServletResponse response) throws Exception{
		System.out.println("getPsys1007XlsxDwld 들어감");
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);

		// result 선언
		//String result = Const.BOOLEAN_SUCCESS;

		// json 선언
		JSONObject json = new JSONObject();

		try {
			// 권한 그리드 목록 조회
			json = psys1007Mgr.selectTmbrAdmLgnInfGridList(parameterMap);

			Map<String,String> header = parameterMap.parseGridHeader();
			// 비밀번호 초기화 컬럼 제거
			header.remove("PWD_RESET");

			List<Map<String, String>> list = (List)json.get("rows");
			String fileName = parameterMap.getValue("fileName");

			for(int i=0; i<list.size();i++){
				if("Y".equals(list.get(i).get("ACTV_YN"))){
					list.get(i).replace("ACTV_YN", "활성화");
				} else if("N".equals(list.get(i).get("ACTV_YN"))){
					list.get(i).replace("ACTV_YN", "비활성화");
				}

				// 비밀번호 초기화 컬럼 제거
				list.get(i).remove("PWD_RESET");

				// 상태값 코드명 적용
				list.get(i).replace("USR_STAT_CD", list.get(i).get("USR_STAT_CD_NM"));
			}

			FileDownLoad.exportExcelXslx(request, response, header, list, fileName);
			//DrmFileUtil.exportExcelXslx(request,response,header, list,fileName);
		}
		catch (Exception e) {
			//result = Const.BOOLEAN_FAIL;
		}
	}

	/**
	 * 임시비밀번호 이메일 전송
	 * 작성일 : 2019-02-11
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked"})
	@RequestMapping(value="/psys/updatePsys1007", method = RequestMethod.POST)
	public void updatePsys1007(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);

		// result 선언
		String result = Const.BOOLEAN_FAIL;
		String message = "";

		// json 선언
		JSONObject json = new JSONObject();

		try {


			if(!checkLoginAjax(request, response) || parameterMap.getValue("usr_eml_addr") == null)
				result = Const.BOOLEAN_FAIL;
			else {

				// 임시비밀번호로 변경
				result = psys1007Mgr.updateTmbrAdmLgnInfPwChg(parameterMap);

			}
		} catch(Exception e) {
			message = "비밀번호 초기화 중 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.";
		}

		// json에 결과 담기
		json.put("RESULT", result);
		json.put("MSG", message);
		ResponseUtil.write(response, json.toJSONString());
	}

}
