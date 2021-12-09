package kr.co.ta9.pandora3.psys.manager;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.NetUtil;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.pcmn.dao.TcmnPopupInfDao;
import kr.co.ta9.pandora3.pcommon.dto.TcmnPopupInf;
/**
* <pre>
* 1. 클래스명 : Psys1025Mgr
* 2. 설명       : 프론트메뉴접속이력 서비스
* 3. 작성일    : 2018-07-27
* 4. 작성자      : TANINE
* </pre>
*/
@Service
public class Psys1025Mgr {

	@Autowired
	private TcmnPopupInfDao tcmnPopupInfDao;

	/**
	 * 시스템관리 > 공통팝업관리 > 공통팝업관리 조회
	 * @param parameterMap
	 * @throws Exception
	 */
	public JSONObject selectTcmnPopupInfList(ParameterMap parameterMap) throws Exception {
		return tcmnPopupInfDao.selectTcmnPopupInfList(parameterMap);
	}

	/**
	 * 시스템관리 > 공통팝업관리 > 공통팝업관리 등록/수정/삭제
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTcmnPopupInf(ParameterMap parameterMap) throws Exception {
		 String reg_type = parameterMap.getValue("reg_type");
		 TcmnPopupInf tcmnPopupInf = (TcmnPopupInf)parameterMap.populate(TcmnPopupInf.class);

		 // uri 디코딩 및 script 태그 무력화
		 tcmnPopupInf.setGrd_conf(TextUtil.removeScript(NetUtil.decode(tcmnPopupInf.getGrd_conf())));
		 tcmnPopupInf.setSch_box(TextUtil.removeScript(NetUtil.decode(tcmnPopupInf.getSch_box())));


		 // Key 파라미터(p_user_id)가 넘어오지 않은 경우 신규 회원으로 등록 / 그 외에는 수정
		if ("I".equals(reg_type))  {
			int result = tcmnPopupInfDao.selectTcmnPopupInfCnt(parameterMap);

			if(result > 0) {
				parameterMap.put("MSG", "중복된 데이터입니다.");
				//throw new Exception("중복된 데이터입니다.");
			} else {
				tcmnPopupInfDao.insert(tcmnPopupInf);
			}
		}else if("U".equals(reg_type)){
			tcmnPopupInfDao.update(tcmnPopupInf);
		} else if("D".equals(reg_type)){
			tcmnPopupInfDao.delete(tcmnPopupInf);
		}
	}
}
