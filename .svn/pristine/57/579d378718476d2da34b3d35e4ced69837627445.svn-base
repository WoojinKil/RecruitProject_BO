package kr.co.ta9.pandora3.psys.dao;

import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.BeanUtil;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmMnuBtnRtnn;

/**
 * TsysAdmMnuBtnRtnnDao - DAO(Data Access Object) class for table [TSYS_ADM_MNU_BTN_RTNN].
 *
 * <pre>
 * 1. 클래스명 : TsysAdmMnuBtnRtnnDao
 * 2. 설명 : 권리자메뉴버튼할당 DAO(SELECT)
 * 3. 작성일 : 2019-03-12
 * 4. 작성자 : TANINE
 * </pre>
 *
 * @since 2019. 03. 12
 */
@Repository
public class TsysAdmMnuBtnRtnnDao extends BaseDao {
	
	/**
	 * 권리자메뉴버튼할당 정보 조회
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public JSONObject getTsysAdmMnuBtnRtnnInf(ParameterMap parameterMap) throws Exception {
		Object data = getSqlSession().selectOne("TsysAdmMnuBtnRtnn.selectTsysAdmMnuBtnRtnnInf", parameterMap);
		Map<String, Object> map = null;
		if(data != null) {
			map = BeanUtil.convertObjectToMap(data);
		}
		JSONObject json = new JSONObject();
		json.put("TsysAdmMnuBtnRtnnInf", map);
		return json;
	}

	/**사용자 버튼 정보 조회
	 * 
	 * @param tsysAdmMnuBtnRtnn
	 * @return
	 * @throws Exception
	 */
	public List<TsysAdmMnuBtnRtnn> selectTsysAdmMnuBtnRtnnList(TsysAdmMnuBtnRtnn tsysAdmMnuBtnRtnn) throws Exception {
		return getSqlSession().selectList("TsysAdmMnuBtnRtnn.selectTsysAdmMnuBtnRtnnList", tsysAdmMnuBtnRtnn);
	}
	
	/**
	 * 권리자메뉴버튼할당 정보 삭제
	 * @param  tsysAdmMnuBtnRtnn
	 * @return int
	 * @throws Exception
	 */
	public int deleteTsysAdmMnuBtnRtnnInf(TsysAdmMnuBtnRtnn tsysAdmMnuBtnRtnn) throws Exception {
		return getSqlSession().delete("TsysAdmMnuBtnRtnn.deleteTsysAdmMnuBtnRtnnInf", tsysAdmMnuBtnRtnn);
	}
	
}