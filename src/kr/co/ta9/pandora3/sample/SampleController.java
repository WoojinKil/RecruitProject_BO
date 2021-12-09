package kr.co.ta9.pandora3.sample;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspectj.lang.annotation.SuppressAjWarnings;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmRol;
import kr.co.ta9.pandora3.system.manager.SysCounterLogMgr;

/**
* <pre>
* 1. 클래스명 : Psys1005Controller
* 2. 설명 : 코드관리 컨트롤러
* 3. 작성일 : 2018-03-27
* 4. 작성자 : TANINE
* </pre>
*/
@Controller
public class SampleController extends CommonActionController{

	@Autowired
	private SampleMgr sampleMgr;

	@Autowired
	private SysCounterLogMgr sysCounterLogMgr;

	/**
	 * 코드관리 > 마스터코드 그리드 목록 조회
	 *
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/sample/selectAdminMnu", method = RequestMethod.POST)
	public void getPsys1005List1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
//		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 마스터코드 그리드 목록 조회
			//json = sampleMgr.selectAdminMnu(parameterMap);

		} catch (Exception e) {
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 회원정보관리 > 수정 : 1건씩
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/sample/saveSample1002", method = RequestMethod.POST)
	public void addPmbr1003(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
//		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {

			// 회원 등록
			//sampleMgr.saveSample1002(parameterMap);
		}
		catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}


	/**
	 * 샘플 > 고객별 정보 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/sample/getSample1010List", method = RequestMethod.POST)
	public void getSample1010GrdLst(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 시스템 사용자 목록 그리드 조회
			json = sampleMgr.selectTmbrAdmLgnInfGridList(parameterMap);
		} catch (Exception e) {
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 샘플 > 대시보드 > 팀별 실적 현황
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/sample/getTeamResultDataList", method = RequestMethod.POST)
	public void getTeamResultDataList(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 시스템 사용자 목록 그리드 조회
			json = sampleMgr.selectTeamResultDataGridList(parameterMap);

		} catch (Exception e) {
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}



	/**
	 * 샘플 > 수정 삭제 상태 관련 그리드
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/sample/getSample1003List", method = RequestMethod.POST)
	public void getPsys1006List(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 권한 그리드 목록 조회
			json = sampleMgr.selectTsysAdmRolGridList(parameterMap);
		}
		catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}


	/**
	 * 샘플 > 수정 삭제 상태 관련 그리드
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/sample/saveSample1003List", method = RequestMethod.POST)
	public void savePsys1006List(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 권한 저장
			sampleMgr.saveTsysAdmRolList(parameterMap);

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
	 * 샘플 > 타겟 템플릿 관리
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/sample/getSample1011List01", method = RequestMethod.POST)
	public void getPdsp1004List01(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ParameterMap parameterMap = getParameterGridMap(request, response);
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			// 템플릿 전시 트리 조회
			json = sampleMgr.selectTsysAdmMnuGridTreeList(parameterMap);

		} catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}



	/**
	 * 대시보드 방문자수/페이지뷰수 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/sample/selectVisitorPageviewCountList", method = RequestMethod.POST)
	public void selectVisitorPageviewCountList(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		json = sysCounterLogMgr.selectThisweekVisitorPageviewCount();
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			json = sysCounterLogMgr.selectVisitorPageviewCountList();
		} catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());

	}
	/**
	 * 샘플 > 그리드 그룹핑 샘플
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value ="/sample/selectGroupingList", method = RequestMethod.POST)
	public void selectGroupingList(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			json = sampleMgr.selectGroupingList(parameterMap);
		} catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());

	}


	/**
	 * BO 사용자 관리 > BO 사용자 그리드 목록 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/sample/getSample1013List", method = RequestMethod.POST)
	public void getSample1013List(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		// json 선언
		JSONObject json = new JSONObject();

		try {
			// 시스템 사용자 목록 그리드 조회
			json = sampleMgr.selectTmbrAdmLgnInfGridSampleList(parameterMap);
		} catch (Exception e) {
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}



	/**
	 * 일반 컨텐츠
	 * BOARD TYPE1/TYPE2 : 게시판 모듈 목록 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pdsp/getPdsp1009List1", method = RequestMethod.POST)
	public void getPdsp1009List01(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			// BOARD TYPE1/TYPE2 : 게시판 모듈 목록 조회
			json = sampleMgr.selectTbbsModlInfCommonList(parameterMap);
		} catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 일반 컨텐츠
	 * BOARD TYPE1/TYPE2 : 게시판 모듈 목록 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/selectRolList", method = RequestMethod.POST)
	public void selectRolList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			// BOARD TYPE1/TYPE2 : 게시판 모듈 목록 조회
			json = sampleMgr.getRolList(parameterMap);
		} catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 일반 컨텐츠
	 * BOARD TYPE1/TYPE2 : 게시판 모듈 목록 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/selectTsysAdmGrpRolList", method = RequestMethod.POST)
	public void selectTsysAdmGrpRolList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			// BOARD TYPE1/TYPE2 : 게시판 모듈 목록 조회
			json = sampleMgr.selectTsysAdmGrpRolList(parameterMap);
		} catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}




}
