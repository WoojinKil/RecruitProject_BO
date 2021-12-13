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
import kr.co.ta9.pandora3.linkruit.manager.ApplyMgr;

@Controller
public class ApplyController extends CommonActionController{

	@Autowired
	ApplyMgr applyMgr;
	
	@RequestMapping(value="/linkruit/getApplyList", method = RequestMethod.POST)
	public void getApplyList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ParameterMap parameterMap = getParameterGridMap(request, response);
		String result = Const.BOOLEAN_SUCCESS;
		
		JSONObject json = new JSONObject();
		
		try {
			json = applyMgr.selectApplicatnGridList(parameterMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
			
		}
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
		
	}
	@RequestMapping(value="/linkruit/saveApply2", method = RequestMethod.POST)
	public void savsApply2(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ParameterMap parameterMap = getParameterMap(request, response);
		String result = Const.BOOLEAN_SUCCESS;
		
		JSONObject json = new JSONObject();
		
		try {
			applyMgr.saveApply2(parameterMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			json.put("MSG", parameterMap.getValue("MSG"));
		}
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
		
	}
	
}
