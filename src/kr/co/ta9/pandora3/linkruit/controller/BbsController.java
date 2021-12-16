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
import kr.co.ta9.pandora3.linkruit.manager.BbsMgr;

@Controller
public class BbsController extends CommonActionController {

	@Autowired
	private BbsMgr bbsMgr;
	
	@RequestMapping(value="/linkruit/getBbsList", method = RequestMethod.POST)
	public void getBbsList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ParameterMap parameterMap = getParameterGridMap(request, response);
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		
		try {
			json = bbsMgr.selectBbsGridList(parameterMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
			
		}
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
		
	}
	
	@RequestMapping(value="/linkruit/saveBbs", method=RequestMethod.POST)
	public void saveBbs(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ParameterMap parameterMap = getParameterGridMap(request, response);
		String result = Const.BOOLEAN_SUCCESS;
		
		JSONObject json = new JSONObject();
		System.out.println("/linkruit/saveBbs 진입");
		
		try {
			bbsMgr.saveBbs(parameterMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			json.put("MSG", parameterMap.getValue("MSG"));
		}
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
		
	}
}
