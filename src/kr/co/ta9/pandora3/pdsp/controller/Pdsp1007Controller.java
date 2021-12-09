package kr.co.ta9.pandora3.pdsp.controller;

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
import kr.co.ta9.pandora3.pdsp.manager.Pdsp1007Mgr;
/**
* <pre>
* 1. 클래스명 : Pdsp1007Controller
* 2. 설명: 메인팝업추가
* 3. 작성일 : 2018-03-29
* 4.작성자   : TANINE
* </pre>
*/
@Controller
public class Pdsp1007Controller extends CommonActionController{
	@Autowired
	private Pdsp1007Mgr pdsp1007Mgr;

	/**
	 * 팝업관리 > 메인팝업등록(BO)
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psdp/insertPdsp1007", method = RequestMethod.POST)
	public void insertPdsp1007(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ParameterMap parameterMap = getParameterMap(request, response);
		log.debug(parameterMap);
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		try {
			pdsp1007Mgr.saveTdspMnPop(parameterMap);
		}catch(Exception e) {
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
			json.put("errorMsg", e.getMessage());
		}
		json.put("result", result);
		ResponseUtil.write(response, json.toJSONString());
	}

}
