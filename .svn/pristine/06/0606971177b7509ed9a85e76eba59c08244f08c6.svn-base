/**
* <pre>
* 1. 프로젝트명 : 판도라 패키징
* 2. 패키지명 : kr.co.ta9.pandora3.app.repository
* 3. 파일명 : CodeRepository
* 4. 작성일 : 2016-08-22
* 5. 작성자 : tmlee
* </pre>
*/
package kr.co.ta9.pandora3.app.repository;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.exception.UtilException;
import kr.co.ta9.pandora3.meta.dao.TbMetaCmpnyWrkSysMDao;
import kr.co.ta9.pandora3.pcmn.dao.TcmnCdDtlDao;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaCmpnyWrkSysM;
import kr.co.ta9.pandora3.pcommon.dto.TcmnCdDtl;
import kr.co.ta9.pandora3.pcommon.dto.TdspSysInf;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmRol;
import kr.co.ta9.pandora3.pdsp.dao.TdspSysInfDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmRolDao;

/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.app.repository
* 2. 타입명 : class
* 3. 작성일 : 2016-08-22
* 4. 작성자 : tmlee
* 5. 설명 : 코드 리스트 출력
* </pre>
*/
@Service
public class CodeRepository {
	
	private static final CodeRepository codeRepository = new CodeRepository();
	protected static final Log log = LogFactory.getLog(CodeRepository.class);

	public static CodeRepository getInstance () {
		return codeRepository;
	}


	public TcmnCdDtl[] getTcmnCdDtlList(String mst_cd, String ref_1_tval, String ref_2_tval, String ref_3_tval, String us_yn) throws UtilException {

		ParameterMap parameterMap = new ParameterMap();
		parameterMap.put("mst_cd", mst_cd);
		// 변경
		//parameterMap.put("ref_1_tval", ref_1_tval);
		//parameterMap.put("ref_2_tval", ref_2_tval);
		//parameterMap.put("ref_3_tval", ref_3_tval);
		parameterMap.put("ref_1", ref_1_tval);
		parameterMap.put("ref_2", ref_2_tval);
		parameterMap.put("ref_3", ref_3_tval);
		parameterMap.put("us_yn", us_yn);

		List<TcmnCdDtl> list = new ArrayList<TcmnCdDtl>();
		try {
			TcmnCdDtlDao tcmnCdDtlDao =  (TcmnCdDtlDao) getBean("tcmnCdDtlDao");
			if (tcmnCdDtlDao != null) {
				list = tcmnCdDtlDao.selectTcmnCdDtlList(parameterMap);
			}
		}
		catch (UtilException e) {
			log.error(e.toString());
		}
		catch (Exception e) {
			log.error(e.toString());
			throw new UtilException("Can't get SysCdDtl");
		}
		return list.toArray(new TcmnCdDtl[0]);

	}
	
	
	public TsysAdmRol[] getRolList(String sys_cd) throws UtilException {
		
		ParameterMap parameterMap = new ParameterMap();
		parameterMap.put("sys_cd", sys_cd);
		
		List<TsysAdmRol> list = new ArrayList<TsysAdmRol>();
		try {
			TsysAdmRolDao tsysAdmRolDao =  (TsysAdmRolDao) getBean("tsysAdmRolDao");
			if (tsysAdmRolDao != null) {
				
				list = tsysAdmRolDao.selectRolList(parameterMap);
			}
		}
		catch (Exception e) {
			log.error(e.toString());
			throw new UtilException("Can't get SysCdDtl");
		}
		return list.toArray(new TsysAdmRol[0]);
		
	}
	
	public TdspSysInf[] getSitList() throws UtilException {
		
		ParameterMap parameterMap = new ParameterMap();
		
		List<TdspSysInf> list = new ArrayList<TdspSysInf>();
		try {
			TdspSysInfDao tdspSysInfDao =  (TdspSysInfDao) getBean("tdspSysInfDao");
			if (tdspSysInfDao != null) {
				list = tdspSysInfDao.selectSitList(parameterMap);
			}
		}
		catch (Exception e) {
			log.error(e.toString());
			throw new UtilException("Can't get TdspSysInfo");
		}
		return list.toArray(new TdspSysInf[0]);
		
	}
	
	// 2020.05.21 추가
	public TbMetaCmpnyWrkSysM[] getWrkSysList() throws UtilException {
		
		ParameterMap parameterMap = new ParameterMap();
		
		List<TbMetaCmpnyWrkSysM> list = new ArrayList<TbMetaCmpnyWrkSysM>();
	
		TbMetaCmpnyWrkSysM twrk = new TbMetaCmpnyWrkSysM();
		twrk.setSys_cd("000");
		twrk.setSys_nm("선택");
	
		try {
			TbMetaCmpnyWrkSysMDao tbMetaCmpnyWrkSysMDao =  (TbMetaCmpnyWrkSysMDao) getBean("tbMetaCmpnyWrkSysMDao");
			if (tbMetaCmpnyWrkSysMDao != null) {
				list.add(twrk);   // default값 세팅
				
				for(int i=0; i<tbMetaCmpnyWrkSysMDao.selectWrkSysList(parameterMap).size(); i++) {
					list.add(tbMetaCmpnyWrkSysMDao.selectWrkSysList(parameterMap).get(i));
				}
			}
		}
		catch (Exception e) {
			log.error(e.toString());
			throw new UtilException("Can't get TbMetaCmpnyWrkSysM");
		}
		return list.toArray(new TbMetaCmpnyWrkSysM[0]);
		
	}
	
	
	
	
	
	

	public TcmnCdDtl getTcmnCdDtl(String mst_cd, String cd) throws UtilException {
		ParameterMap parameterMap = new ParameterMap();
		parameterMap.put("mst_cd", mst_cd);
		parameterMap.put("cd", cd);

		TcmnCdDtl sysCdDtl = null;
		try {
			TcmnCdDtlDao tcmnCdDtlDao =  (TcmnCdDtlDao) getBean("tcmnCdDtlDao");
			if (tcmnCdDtlDao != null) {
				sysCdDtl = tcmnCdDtlDao.selectDTO("TcmnCdDtl.select", parameterMap);
				
				
			}
		}
		catch (Exception e) {
			log.error(e.toString());
			throw new UtilException("Can't get TdspSysInfo");
		}

		if ( sysCdDtl == null) {
			throw new UtilException("Key : Not Found Matched SysCdDtl with (" + mst_cd + ", " + cd + ")");
		}
		return sysCdDtl;
	}


	public String getCdNm(TcmnCdDtl sysCdDtl) {
		return sysCdDtl.getCd_nm();
	}

	public String getCdNm(String mst_cd, String cd) throws UtilException {
		if ("".equals(mst_cd) || mst_cd == null) {
			return "";
		} else {
			return getCdNm(getTcmnCdDtl(mst_cd, cd));
		}
	}

	public String getCd(String mst_cd, String cd_nm) throws UtilException {
		ParameterMap parameterMap = new ParameterMap();
		parameterMap.put("mst_cd", mst_cd);
		parameterMap.put("cd_nm", cd_nm);

		TcmnCdDtl[] sysCdDtls = null;
		try {
			TcmnCdDtlDao tcmnCdDtlDao =  (TcmnCdDtlDao) getBean("tcmnCdDtlDao");
			if (tcmnCdDtlDao != null) {
				
				List<TcmnCdDtl> list = tcmnCdDtlDao.selectTcmnCdDtlList(parameterMap);
				sysCdDtls = list.toArray(new TcmnCdDtl[0]);
			}
		}
		catch (Exception e) {
			log.error(e.toString());
			throw new UtilException("Can't get SysCdDtl");
		}
		String cd = null;
		if ( sysCdDtls != null && sysCdDtls.length > 0 ) {
			cd = sysCdDtls[0].getCd();
		}

		return cd;
	}
	
    private Object getBean(String beanName) {
        //현재 요청중인 thread local의 HttpServletRequest 객체 가져오기
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        //HttpSession 객체 가져오기
        HttpSession session = request.getSession();
        //ServletContext 객체 가져오기
        ServletContext conext = session.getServletContext();
        //Spring Context 가져오기
        WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(conext);
        return wContext.getBean(beanName);
    }


}
