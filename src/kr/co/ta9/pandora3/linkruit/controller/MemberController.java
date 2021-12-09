package kr.co.ta9.pandora3.linkruit.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.linkruit.manager.MemberMgr;

@Controller
public class MemberController extends CommonActionController {

	@Autowired
	private MemberMgr memberMgr;

	@RequestMapping(value = "/linkruit/getMemberList" , method = RequestMethod.POST)
	public void getMemberGrdList(HttpServletRequest  request, HttpServletResponse response) throws Exception{
		ParameterMap parameterMap = getParameterGridMap(request, response);

		
		
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		// json 선언
		JSONObject json = new JSONObject();

		try {
			System.out.println("여기까지 진입");
			// 시스템 사용자 목록 그리드 조회
			json = memberMgr.selectMemberList(parameterMap);
		} catch (Exception e) {
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
			e.printStackTrace();
		}
		System.out.println("처리완료");
		json.put("RESULT", result);
		System.out.println("처리완료2");
		
		ResponseUtil.write(response, json.toJSONString());
		System.out.println("처리완료3");
		System.out.println(json.toString());
		
	}
	

	
}
