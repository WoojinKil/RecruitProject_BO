package kr.co.ta9.pandora3.psys.dao;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

@Repository
public class DssMdObjInfoDao extends BaseDao {

	   /**
     * 조직별직책권한관리 > 팝업 > BI라이센스 계정 목록 조회
     * @param parameterMap
     * @throws Exception
     */
    public JSONObject selectBiList(ParameterMap parameterMap) throws Exception {
        return queryForGrid("DssMdObjInfo.selectBiList", parameterMap);
    }

}
