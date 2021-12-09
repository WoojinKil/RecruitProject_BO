package kr.co.ta9.pandora3.psys.manager;

import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.psys.dao.DssMdObjInfoDao;
import kr.co.ta9.pandora3.psys.dao.TbBcPcOrgAthrDao;

/**
* <pre>
* 1. 클래스명 : Psys1031Mgr
* 2. 설명 : 조직별권한관리
* 3. 작성일 : 2019-03-12
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class Psys1050Mgr {

	@Autowired
	private TbBcPcOrgAthrDao tbBcPcOrgAthrDao;

	@Autowired
	private DssMdObjInfoDao dssMdObjInfoDao;



	/**
	 * 조직별직책권한관리 > 통합권한목록 조회
	 * @param parameterMap
	 * @return List<Map<String,Object>>
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectGrpRolList(ParameterMap parameterMap) throws Exception {
	    return tbBcPcOrgAthrDao.selectGrpRolList(parameterMap);
	}

	/**
	 * 조직별직책권한관리 > 자점목록 조회
	 * @param parameterMap
	 * @return List<Map<String,Object>>
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCstrList(ParameterMap parameterMap) throws Exception {
	    return tbBcPcOrgAthrDao.selectCstrList(parameterMap);
	}

    /**
     * 조직별직책권한관리 > 조직별 직책권한 목록 조회
     * @param parameterMap
     * @return
     * @throws Exception
     */
    public JSONObject selectOrgAthrList(ParameterMap parameterMap) throws Exception {
        return tbBcPcOrgAthrDao.selectOrgAthrList(parameterMap);
    }

    /**
     * 조직별직책권한관리 > 조직별 직책권한 저장
     * @param parameterMap
     * @throws Exception
     */
    public void saveOrgAthr(ParameterMap parameterMap) throws Exception {
        if("C".equals(parameterMap.get("status"))){
            // 중복 체크
            int cnt = tbBcPcOrgAthrDao.selectDupOrgAthr(parameterMap);
            if(cnt > 0){
                parameterMap.put("MSG", "중복된 데이터가 존재합니다.");
                //throw new Exception("이미 같은 프로그램ID가 존재합니다.");
            }else{
            	tbBcPcOrgAthrDao.insertOrgAthr(parameterMap);
            	tbBcPcOrgAthrDao.updateOrgCstrCd(parameterMap);
            }

        }  else {
             String jsonString = parameterMap.getValue("amdgriddata", false);
     		JSONParser jsonParser = new JSONParser();
     		Object jsonObject = jsonParser.parse(jsonString);
     		JSONArray jsonArray = (JSONArray)jsonObject;
     	  if(jsonArray != null && !jsonArray.isEmpty()){
     		 for(int i=0 ; i<jsonArray.size() ; i++){
                 JSONObject tempObj = (JSONObject) jsonArray.get(i);
                 if("D".equals((String)tempObj.get("JQGRIDCRUD"))){
                 	String grpRolId = (String)tempObj.get("GRP_ROL_ID");
                 	String sysClCd = (String)tempObj.get("SYS_CL_CD");
                 	String hrOrgCd = (String)tempObj.get("ORG_CD");
                 	ParameterMap delParam  = new ParameterMap();
                 	delParam.put("grp_rol_id", grpRolId);
                 	delParam.put("sys_cls_cd", sysClCd);
                 	delParam.put("org_cd", hrOrgCd);
                 	tbBcPcOrgAthrDao.deleteOrgAthr(delParam);
                 }else if ("U".equals((String)tempObj.get("JQGRIDCRUD"))){
                	 tbBcPcOrgAthrDao.updateOrgAthr(parameterMap);
                	 tbBcPcOrgAthrDao.updateOrgCstrCd(parameterMap);
                }
             }
     	  }else {
     		 if ("U".equals(parameterMap.get("status"))){
     			tbBcPcOrgAthrDao.updateOrgAthr(parameterMap);
     			tbBcPcOrgAthrDao.updateOrgCstrCd(parameterMap);
     		 }
     	  }
          //   parameterMap.put("MSG", "변경할 데이터가 존재하지 않습니다.");
        }
    }

    /**
     * 조직별직책권한관리 > 팝업 > BI라이센스 계정 목록 조회
     * @param parameterMap
     * @return
     * @throws Exception
     */
    public JSONObject selectBiList(ParameterMap parameterMap) throws Exception {
        return dssMdObjInfoDao.selectBiList(parameterMap);
    }

}
