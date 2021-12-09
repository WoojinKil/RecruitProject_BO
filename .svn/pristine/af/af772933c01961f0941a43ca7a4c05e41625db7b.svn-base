package kr.co.ta9.pandora3.psys.manager;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.pcommon.dto.TbLgapPgminfH;
import kr.co.ta9.pandora3.pcommon.dto.TsysPgmBtnInf;
import kr.co.ta9.pandora3.pcommon.dto.TsysPgmInf;
import kr.co.ta9.pandora3.psys.dao.TbLgapMnurtnnHDao;
import kr.co.ta9.pandora3.psys.dao.TbLgapPgminfHDao;
import kr.co.ta9.pandora3.psys.dao.TsysPgmBtnInfDao;
import kr.co.ta9.pandora3.psys.dao.TsysPgmInfDao;

/**
* <pre>
* 1. 클래스명 : Psys1001Mgr
* 2. 설명 :  프로그램관리  매니저
* 3. 작성일 : 2018-03-27
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class Psys1001Mgr {

	@Autowired
	private TsysPgmInfDao tsysPgmInfDao;

	@Autowired
	private TsysPgmBtnInfDao tsysPgmBtnInfDao;

	//로그 기록을 위한 방법.
	@Autowired
	private TbLgapMnurtnnHDao tbLgapMnurtnnHDao;

	@Autowired
	private TbLgapPgminfHDao tbLgapPgminfHDao;

	/**
	 * 프로그램 목록
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject getTsysPgmInfList(ParameterMap parameterMap) throws Exception {
		return tsysPgmInfDao.getTsysPgmInfList(parameterMap);
	}

	/**
	 * 프로그램 버튼목록
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject getTsysPgmInfBtnList(ParameterMap parameterMap) throws Exception {
		 JSONObject  jsonObject = tsysPgmInfDao.getTsysPgmInfBtnUsrList(parameterMap); //사용자별 버튼 조회
		if("0".equals(jsonObject.get("total").toString())){
			jsonObject = tsysPgmInfDao.getTsysPgmInfBtnOrgList(parameterMap); //조직별 버튼 조회
		}
		if("0".equals(jsonObject.get("total").toString())){
			jsonObject = tsysPgmInfDao.getTsysPgmInfBtnList(parameterMap); //화면 버튼 조회
		}
		return jsonObject;
	}

	/**
	 * 코드 입력/수정/삭제
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTsysPgmInfList(ParameterMap parameterMap) throws Exception {
//		int cnt = 0;
		List<TsysPgmInf> insertList = new ArrayList<TsysPgmInf>();
		List<TsysPgmInf> updateList = new ArrayList<TsysPgmInf>();
		List<TsysPgmInf> deleteList = new ArrayList<TsysPgmInf>();
		parameterMap.populates(TsysPgmInf.class, insertList, updateList, deleteList);
		//Foo[] fooArray = foos.toArray(new Foo[0]);

		TsysPgmInf[] insert = insertList.toArray(new TsysPgmInf[0]);
		TsysPgmInf[] update = updateList.toArray(new TsysPgmInf[0]);
		TsysPgmInf[] delete = deleteList.toArray(new TsysPgmInf[0]);
		/*
		if (!insertList.isEmpty()) {
			for (TsysPgmInf sysPgmInfo : insertList) {
				/
				parameterMap.put("mst_cd", sysCdMst.getMst_cd());
				cnt = tsysPgmInfDao.selectSysCdMstCnt(parameterMap);
				/
			}
		}

		if(cnt != 0) {
			parameterMap.put("MSG", "이미 같은 ID가 존재합니다.");
			throw new Exception();
		}
		*/

		tsysPgmInfDao.insertMany(insert);
		tsysPgmInfDao.updateMany(update);
		tsysPgmInfDao.deleteMany(delete);
	}


	/**
	 * 프로그램  입력/수정/삭제
	 * @param parameterMap
	 * @throws Exception
	 */
	public String saveTsysPgmInf(ParameterMap parameterMap) throws Exception {

		TsysPgmInf tsysPgmInf = (TsysPgmInf)parameterMap.populate(TsysPgmInf.class);
		TbLgapPgminfH tbLgapPgminfH = (TbLgapPgminfH)parameterMap.populate(TbLgapPgminfH.class);

		 int nResult =0 ;
		 // Key 파라미터(p_user_id)가 넘어오지 않은 경우 신규 회원으로 등록 / 그 외에는 수정
		if (TextUtil.isEmpty(parameterMap.getValue("reg_type")))  {

			// 프로그램ID 중복 체크
			int cnt = tsysPgmInfDao.selectTsysPgmInfCnt(tsysPgmInf);
			if(cnt > 0){
				parameterMap.put("MSG", "이미 같은 프로그램ID가 존재합니다.");
				return "이미 같은 프로그램ID가 존재합니다.";
			}else{
				nResult = tsysPgmInfDao.insert(tsysPgmInf);
				tbLgapPgminfH.setHist_stat_cd("10");
				tbLgapPgminfH.setHist_stat_nm("추가");
				//tbLgapPgminfHDaoTrx.insert(tbLgapPgminfH);
			}

		} else {
			nResult = tsysPgmInfDao.update(tsysPgmInf);
			tbLgapPgminfH.setHist_stat_cd("30");
			tbLgapPgminfH.setHist_stat_nm("수정");
			//tbLgapPgminfHDaoTrx.insert(tbLgapPgminfH);
		}

		tsysPgmBtnInfDao.deleteTsysPgmBtnInf(tsysPgmInf);

		if(nResult >0){
			String[] arPgmBtnInfo =parameterMap.getArray("btnInfo");

			if(arPgmBtnInfo !=null && arPgmBtnInfo.length>0){


				for(int i=0; i< arPgmBtnInfo.length; i++){
					TsysPgmBtnInf tsysPgmBtnInf = new TsysPgmBtnInf();
					tsysPgmBtnInf.setPgm_btn_cd(arPgmBtnInfo[i]);
					tsysPgmBtnInf.setPgm_id(tsysPgmInf.getPgm_id());
					tsysPgmBtnInf.setUs_yn(tsysPgmInf.getUs_yn());
					tsysPgmBtnInf.setCrtr_id(tsysPgmInf.getCrtr_id());
					tsysPgmBtnInf.setUpdr_id(tsysPgmInf.getUpdr_id());

					tsysPgmBtnInfDao.insert(tsysPgmBtnInf);
				}
			}

		}
		return "저장되었습니다.";
	}
}
