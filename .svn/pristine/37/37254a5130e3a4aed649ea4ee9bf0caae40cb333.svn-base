package kr.co.ta9.pandora3.mbsv.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * MbsvStrSrvMgmDao - DAO(Data Access Object) class
 *
 * <pre>
 * 1. 패키지명 : kr.co.ta9.pandora3.mbsv.dao
 * 2. 타입명 : class
 * 3. 작성일 : 2019-10-10
 * 4. 작성자 : PCY
 * 5. 설명 : 점별 이용가능 서비스 관리 DAO
 * </pre>
 */
@Repository
public class MbsvStrSrvMgmDao extends BaseDao {

    /**
     * 서비스접점 정보 조회
     * @param parameterMap
     * @return List<Map>
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    public List<Map> selectPocCdInfoList(ParameterMap parameterMap) throws Exception {
        return getSqlSession().selectList("MbsvStrSrvMgm.selectPocCdInfoList", parameterMap);
    }

    /**
     * 서비스접점 정보 이름 조회
     * @param parameterMap
     * @return List<Map>
     * @throws Exception
     */
    public String selectPocCdInfoNms(ParameterMap parameterMap) throws Exception {
    	return getSqlSession().selectOne("MbsvStrSrvMgm.selectPocCdInfoNms", parameterMap);
    }

    /**
     * 소속회사정보 조회(단건_
     * @param parameterMap
     * @return List<Map>
     * @throws Exception
     */
    public String selectCoNm(ParameterMap parameterMap) throws Exception {
    	return getSqlSession().selectOne("MbsvStrSrvMgm.selectCoNm", parameterMap);
    }



    /**
     * 자점 정보 조회
     * @param parameterMap
     * @return List<Map>
     * @throws Exception
     */
	public Object selectStrCdInfoList(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectList("MbsvStrSrvMgm.selectStrCdInfoList", parameterMap);
	}


	public List<String> selectUtilComnCdDtlList(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectList("VipComn.selectUtilComnCdDtlList", parameterMap);
	}

	 /**
     * 소속회사정보 조회
     * @param parameterMap
     * @return List<Map>
     * @throws Exception
     */
    public List<Map> selectCoList(ParameterMap parameterMap) throws Exception {
    	return getSqlSession().selectList("MbsvStrSrvMgm.selectCoList", parameterMap);
    }
}