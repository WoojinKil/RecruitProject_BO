/**
* <pre>
* 1. 프로젝트명 : 판도라 패키징
* 2. 패키지명 : kr.co.ta9.pandora3.app.util
* 3. 파일명 : CodeUtil
* 4. 작성일 : 2016-08-22
* 5. 작성자 : tmlee
* </pre>
*/
package kr.co.ta9.pandora3.app.util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import kr.co.ta9.pandora3.app.repository.CodeRepository;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.exception.UtilException;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaCmpnyWrkSysM;
import kr.co.ta9.pandora3.pcommon.dto.TcmnCdDtl;
import kr.co.ta9.pandora3.pcommon.dto.TdspSysInf;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmRol;

/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.app.util
* 2. 타입명 : class
* 3. 작성일 : 2016-08-22
* 4. 작성자 : tmlee
* 5. 설명 : 코드관련 유틸파일
* </pre>
*/
public class CodeUtil {
    private static final Log log = LogFactory.getLog(CodeUtil.class);

    /**
     * 업무시스템 가져오기 -- 2020.05.21 추가
     * @param sys_cd
     * @return String
     */    
    public static String getWrkSysComboList() {
    	TbMetaCmpnyWrkSysM[] tbMetaCmpnyWrkSysM = getWrkSysList();

    	StringBuilder buf = new StringBuilder("");
    	for(int i = 0; tbMetaCmpnyWrkSysM != null && i < tbMetaCmpnyWrkSysM.length; i++) {
    		if(i > 0) {
    			buf.append(";");
    		}
    		buf.append(tbMetaCmpnyWrkSysM[i].getSys_cd()).append(":").append(tbMetaCmpnyWrkSysM[i].getSys_nm());
    	}
    	
    	return buf.toString();
    }
    
    /**
     * 코드명 가져오기
     * @param mst_cd
     * @param cd
     * @return String
     */
    public String getCdNm(String mst_cd, String cd) {
        String cd_nm = "";
        try {
        	cd_nm = CodeRepository.getInstance().getCdNm(mst_cd, cd_nm);
        } catch (UtilException e) {
            log.error(CodeUtil.class, e);
        }
        return cd_nm;
    }

    /**
     * 코드 가져오기
     * @param mst_cd
     * @param cd_nm
     * @return String
     */
    public static String getCd(String mst_cd, String cd_nm) {
        return CodeRepository.getInstance().getCd(mst_cd, cd_nm);
    }

    /**
     * 코드존재 유무 확인
     * @param selsts
     * @param mst_cd
     * @return String
     */
    public static String getExistCd(String selsts, String mst_cd) {
        return getExistCd(selsts, mst_cd, null);
    }

    /**
     * 코드 exit
     * @param selsts
     * @param mst_cd
     * @param ref_1_tval
     * @return String
     */
    public static String getExistCd(String selsts, String mst_cd, String ref_1_tval) {
        String cd_nm = "Exit";
        if(selsts == null || "".equals(selsts)) {
        	cd_nm = "";
            return cd_nm;
        }

        TcmnCdDtl [] sysCdDtl = getTcmnCdDtlList(mst_cd, ref_1_tval);
        int tempCnt = 0;
        for(int i = 0; i < sysCdDtl.length; i++) {
            if(selsts.equals(sysCdDtl[i].getCd())) {
                tempCnt++;
                break;
            }
        }

        if(tempCnt == 0) {
            cd_nm = "";
        }
        return cd_nm;
    }

    /**
     * 코드 가져오기
     * @param mst_cd
     * @param cd
     * @return SysCdDtl
     */
    public static TcmnCdDtl getTcmnCdDtl(String mst_cd, String cd) {
    	TcmnCdDtl tcmnCdDtl = null;
        try {
        	tcmnCdDtl = CodeRepository.getInstance().getTcmnCdDtl(mst_cd, cd);
        } catch (UtilException e) {
            log.error(CodeUtil.class, e);
        }
        return tcmnCdDtl;
    }

    /**
     * 코드배열 가져오기
     * @param mst_cd
     * @return SysCdDtl
     */
    public static TcmnCdDtl[] getTcmnCdDtlList(String mst_cd) {
        return getTcmnCdDtlList(mst_cd, null, null, null);
    }

    public static TcmnCdDtl[] getTcmnCdDtlList(String mst_cd, String ref_1_tval) {
        return getTcmnCdDtlList(mst_cd, ref_1_tval, null, null);
    }

    public static TcmnCdDtl[] getTcmnCdDtlList(String mst_cd, String ref_1_tval, String ref_2_tval) {
        return getTcmnCdDtlList(mst_cd, ref_1_tval, ref_2_tval, null);
    }

    public static TcmnCdDtl[] getTcmnCdDtlList(String mst_cd, String ref_1_tval, String ref_2_tval, String ref_3_tval) {
        return CodeRepository.getInstance().getTcmnCdDtlList(mst_cd, ref_1_tval, ref_2_tval, ref_3_tval, Const.BOOLEAN_TRUE);
    }

    public static TcmnCdDtl[] getTcmnCdDtlList(String mst_cd, String ref_1_tval, String ref_2_tval, String ref_3_tval, String us_yn) {
        return CodeRepository.getInstance().getTcmnCdDtlList(mst_cd, ref_1_tval, ref_2_tval, ref_3_tval, us_yn);
    }
    
    public static TsysAdmRol[] getRolList(String mst_cd) {
    	return CodeRepository.getInstance().getRolList(mst_cd);
    }
    
    public static TdspSysInf[] getSitList() {
    	return CodeRepository.getInstance().getSitList();
    }
    
    // 2020.05.21 추가
    public static TbMetaCmpnyWrkSysM[] getWrkSysList() {
    	return CodeRepository.getInstance().getWrkSysList();
    }

    /**
     * 콤보 - 마스터코드
     */
    public static String getSelectComboList(String mst_cd, String name) {
        return getSelectComboList(mst_cd, name, null);
    }
    public static String getSelectComboList(String mst_cd, String name, String first) {
        return getSelectComboList(mst_cd, name, first, null);
    }
    public static String getSelectComboList(String mst_cd, String name, String first, String cd) {
        return getSelectComboList(mst_cd, name, first, cd, null);
    }
    public static String getSelectComboList(String mst_cd, String name, String first, String cd, String val) {
        return getSelectComboList(mst_cd, name, first, cd, val, null);
    }
    public static String getSelectComboList(String mst_cd, String name, String first, String cd, String val, String script) {
    	TcmnCdDtl[] tcmnCdDtls = CodeUtil.getTcmnCdDtlList(mst_cd);
        return getSelectComboList(tcmnCdDtls, name, first, cd, val, script);
    }
    public static String getSelectComboList(String mst_cd, String name, String first, String cd, String val, String script, String us_yn) {
    	TcmnCdDtl[] tcmnCdDtls = CodeUtil.getTcmnCdDtlList(mst_cd, null, null, null, us_yn);
        return getSelectComboList(tcmnCdDtls, name, first, cd, val, script);
    }

    /**
     * 콤보 - 마스터코드, 참조값1
     */
    public static String getSelectComboListRef1(String mst_cd, String name, String ref1) {
    	return getSelectComboListRef1(mst_cd, name, ref1, null);
    }
    public static String getSelectComboListRef1(String mst_cd, String name, String ref1, String first) {
    	return getSelectComboListRef1(mst_cd, name, ref1, first, null);
    }
    public static String getSelectComboListRef1(String mst_cd, String name, String ref1, String first, String cd) {
    	return getSelectComboListRef1(mst_cd, name, ref1, first, cd, null);
    }
    public static String getSelectComboListRef1(String mst_cd, String name, String ref1, String first, String cd, String val) {
    	return getSelectComboListRef1(mst_cd, name, ref1, first, cd, val, null);
    }
    public static String getSelectComboListRef1(String mst_cd, String name, String ref1, String first, String cd, String val, String script) {
    	TcmnCdDtl[] tcmnCdDtls = CodeUtil.getTcmnCdDtlList(mst_cd, ref1);
        return getSelectComboList(tcmnCdDtls, name, first, cd, val, script);
    }
    public static String getSelectComboListRef1(String mst_cd, String name, String ref1, String first, String cd, String val, String script, String us_yn) {
    	TcmnCdDtl[] tcmnCdDtls = CodeUtil.getTcmnCdDtlList(mst_cd, ref1, null, null, us_yn);
        return getSelectComboList(tcmnCdDtls, name, first, cd, val, script);
    }

    /**
     * 콤보 - 마스터코드, 참조값1, 참조값2
     */
    public static String getSelectComboListRef2(String mst_cd, String name, String ref1, String ref2) {
    	return getSelectComboListRef2(mst_cd, name, ref1, ref2, null);
    }
    public static String getSelectComboListRef2(String mst_cd, String name, String ref1, String ref2, String first) {
    	return getSelectComboListRef2(mst_cd, name, ref1, ref2, first, null);
    }
    public static String getSelectComboListRef2(String mst_cd, String name, String ref1, String ref2, String first, String cd) {
    	return getSelectComboListRef2(mst_cd, name, ref1, ref2, first, cd, null);
    }
    public static String getSelectComboListRef2(String mst_cd, String name, String ref1, String ref2, String first, String cd, String val) {
    	return getSelectComboListRef2(mst_cd, name, ref1, ref2, first, cd, val, null);
    }
    public static String getSelectComboListRef2(String mst_cd, String name, String ref1, String ref2, String first, String cd, String val, String script) {
    	TcmnCdDtl[] tcmnCdDtls = CodeUtil.getTcmnCdDtlList(mst_cd, ref1, ref2);
        return getSelectComboList(tcmnCdDtls, name, first, cd, val, script);
    }
    public static String getSelectComboListRef2(String mst_cd, String name, String ref1, String ref2, String first, String cd, String val, String script, String us_yn) {
    	TcmnCdDtl[] tcmnCdDtls = CodeUtil.getTcmnCdDtlList(mst_cd, ref1, ref2, null, us_yn);
        return getSelectComboList(tcmnCdDtls, name, first, cd, val, script);
    }

    /**
     * 콤보 - 마스터코드, 참조값1, 참조값2, 참조값3
     */
    public static String getSelectComboListRef3(String mst_cd, String name, String ref1, String ref2, String ref3) {
    	return getSelectComboListRef3(mst_cd, name, ref1, ref2, ref3, null);
    }
    public static String getSelectComboListRef3(String mst_cd, String name, String ref1, String ref2, String ref3, String first) {
    	return getSelectComboListRef3(mst_cd, name, ref1, ref2, ref3, first, null);
    }
    public static String getSelectComboListRef3(String mst_cd, String name, String ref1, String ref2, String ref3, String first, String cd) {
    	return getSelectComboListRef3(mst_cd, name, ref1, ref2, ref3, first, cd, null);
    }
    public static String getSelectComboListRef3(String mst_cd, String name, String ref1, String ref2, String ref3, String first, String cd, String val) {
    	return getSelectComboListRef3(mst_cd, name, ref1, ref2, ref3, first, cd, val, null);
    }
    public static String getSelectComboListRef3(String mst_cd, String name, String ref1, String ref2, String ref3, String first, String cd, String val, String script) {
    	TcmnCdDtl[] tcmnCdDtls = CodeUtil.getTcmnCdDtlList(mst_cd, ref1, ref2, ref3);
        return getSelectComboList(tcmnCdDtls, name, first, cd, val, script);
    }
    public static String getSelectComboListRef3(String mst_cd, String name, String ref1, String ref2, String ref3, String first, String cd, String val, String script, String us_yn) {
    	TcmnCdDtl[] tcmnCdDtls = CodeUtil.getTcmnCdDtlList(mst_cd, ref1, ref2, ref3, us_yn);
        return getSelectComboList(tcmnCdDtls, name, first, cd, val, script);
    }

    /**
     * 콤보박스 생성
     * @param  tcmnCdDtls : SYS_CD_MST 테이블의 MST_CD 컬럼 배열
     * @param  name      : 콤보박스의 ID, NAME 값
     * @param  first     : 첫번째 노출될 OPTION 명(예:전체, 선택)
     * @param  cd        : 해당 CD 값에 selected 속성 부여
     * @param  val       : 첫번째 노출될 OPTION 값
     * @param  script    : 콤보박스에 추가할 SCRIPT
     * @return String
     */
    public static String getSelectComboList(TcmnCdDtl[] tcmnCdDtls, String name, String first, String cd, String val, String script) {
        if(name == null || "".equals(name)) {
            throw new UtilException("Name is null");
        }

        if(script == null) script = "";
        StringBuilder buf = new StringBuilder(100);
        buf.append("<select name=\"").append(name).append("\" id=\"").append(name).append("\" class=\"select\" ").append(script).append(" >");
        if(first != null && !"".equals(first)) {
            buf.append("    <option value=\""+(val == null?"":val)+"\">").append(first).append("</option>");
        }
        for(int i = 0; tcmnCdDtls != null && i < tcmnCdDtls.length; i++) {
        	TcmnCdDtl tcmnCdDtl = tcmnCdDtls[i];
            buf.append("    <option value=\"").append(tcmnCdDtl.getCd()).append("\" ").append(cd != null && tcmnCdDtl.getCd().equals(cd) ? "selected=\"selected\"" : "").append(">").append(tcmnCdDtl.getCd_nm()).append("</option>");
        }
        buf.append("</select>");

        return buf.toString();
    }

    public static String getGridComboList(String mst_cd) {
        return getGridComboList(mst_cd, null);
    }
    public static String getGridComboList(String mst_cd, String ref_1_tval) {
        return getGridComboList(mst_cd, ref_1_tval, null);
    }
    public static String getGridComboList(String mst_cd, String ref_1_tval, String ref_2_tval) {
        return getGridComboList(mst_cd, ref_1_tval, ref_2_tval, null);
    }
    public static String getGridComboList(String mst_cd, String ref_1_tval, String ref_2_tval, String ref_3_tval) {
        return getGridComboList(mst_cd, ref_1_tval, ref_2_tval, ref_3_tval, Const.BOOLEAN_TRUE);
    }

    /**
     * 그리드 콤보박스 생성
     * @param  mst_cd     : SYS_CD_MST 테이블의 MST_CD 컬럼
     * @param  ref_1_tval : 참조값1
     * @param  ref_2_tval : 참조값2
     * @param  ref_3_tval : 참조값3
     * @param  us_yn     : 사용여부
     * @return String
     */
    public static String getGridComboList(String mst_cd, String ref_1_tval, String ref_2_tval, String ref_3_tval, String us_yn) {
    	TcmnCdDtl[] tcmnCdDtl = getTcmnCdDtlList(mst_cd, ref_1_tval, ref_2_tval, ref_3_tval, us_yn);
    	StringBuilder buf = new StringBuilder("");
        for(int i = 0; tcmnCdDtl != null && i < tcmnCdDtl.length; i++) {
            if(i > 0) {
                buf.append(";");
            }
            buf.append(tcmnCdDtl[i].getCd()).append(":").append(tcmnCdDtl[i].getCd_nm());
        }

        return buf.toString();
    }
    
    /**
     * 그리드 사이트별  권한 리스트  콤보박스 생성
     * @param  mst_cd     : SYS_CD_MST 테이블의 MST_CD 컬럼
     * @param  ref_1_tval : 참조값1
     * @param  ref_2_tval : 참조값2
     * @param  ref_3_tval : 참조값3
     * @param  us_yn     : 사용여부
     * @return String
     */
    public static String getRolGridComboList(String sys_cd) {
    	TsysAdmRol[] TsysAdmRol = getRolList(sys_cd);
    	StringBuilder buf = new StringBuilder("");
    	for(int i = 0; TsysAdmRol != null && i < TsysAdmRol.length; i++) {
    		if(i > 0) {
    			buf.append(";");
    		}
    		buf.append(TsysAdmRol[i].getRol_id()).append(":").append(TsysAdmRol[i].getRol_nm());
    	}
    	
    	return buf.toString();
    }
    
    public static String getSitGridComboList() {
    	TdspSysInf[] tdspSysInf = getSitList();
    	StringBuilder buf = new StringBuilder("");
    	for(int i = 0; tdspSysInf != null && i < tdspSysInf.length; i++) {
    		if(i > 0) {
    			buf.append(";");
    		}
    		buf.append(tdspSysInf[i].getSys_cd()).append(":").append(tdspSysInf[i].getSys_nm());
    	}
    	
    	return buf.toString();
    }

    /**
     * 라디오박스 - 마스터코드
     */
    public static String getRadioBoxList(String mst_cd, String name) {
        return getRadioBoxList(mst_cd, name, null);
    }
    public static String getRadioBoxList(String mst_cd, String name, String cd) {
    	TcmnCdDtl[] tcmnCdDtls = CodeUtil.getTcmnCdDtlList(mst_cd);
        return getRadioBoxList(tcmnCdDtls, name, cd);
    }
    public static String getRadioBoxList(String mst_cd, String name, String cd, String us_yn) {
    	TcmnCdDtl[] tcmnCdDtls = CodeUtil.getTcmnCdDtlList(mst_cd, null, null, null, us_yn);
        return getRadioBoxList(tcmnCdDtls, name, cd);
    }

    /**
     * 라디오박스 - 마스터코드, 참조값1
     */
    public static String getRadioBoxListRef1(String mst_cd, String name, String ref1) {
        return getRadioBoxListRef1(mst_cd, name, ref1, null);
    }
    public static String getRadioBoxListRef1(String mst_cd, String name, String ref1, String cd) {
    	TcmnCdDtl[] tcmnCdDtls = CodeUtil.getTcmnCdDtlList(mst_cd, ref1);
    	return getRadioBoxList(tcmnCdDtls, name, cd);
    }
    public static String getRadioBoxListRef1(String mst_cd, String name, String ref1, String cd, String us_yn) {
    	TcmnCdDtl[] tcmnCdDtls = CodeUtil.getTcmnCdDtlList(mst_cd, ref1, null, null, us_yn);
        return getRadioBoxList(tcmnCdDtls, name, cd);
    }

    /**
     * 라디오박스 - 마스터코드, 참조값1, 참조값2
     */
    public static String getRadioBoxListRef2(String mst_cd, String name, String ref1, String ref2) {
        return getRadioBoxListRef2(mst_cd, name, ref1, ref2, null);
    }
    public static String getRadioBoxListRef2(String mst_cd, String name, String ref1, String ref2, String cd) {
    	TcmnCdDtl[] tcmnCdDtls = CodeUtil.getTcmnCdDtlList(mst_cd, ref1, ref2);
    	return getRadioBoxList(tcmnCdDtls, name, cd);
    }
    public static String getRadioBoxListRef2(String mst_cd, String name, String ref1, String ref2, String cd, String us_yn) {
    	TcmnCdDtl[] tcmnCdDtls = CodeUtil.getTcmnCdDtlList(mst_cd, ref1, ref2, null, us_yn);
        return getRadioBoxList(tcmnCdDtls, name, cd);
    }

    /**
     * 라디오박스 - 마스터코드, 참조값1, 참조값2, 참조값3
     */
    public static String getRadioBoxListRef3(String mst_cd, String name, String ref1, String ref2, String ref3) {
        return getRadioBoxListRef3(mst_cd, name, ref1, ref2, ref3, null);
    }
    public static String getRadioBoxListRef3(String mst_cd, String name, String ref1, String ref2, String ref3, String cd) {
    	TcmnCdDtl[] tcmnCdDtls = CodeUtil.getTcmnCdDtlList(mst_cd, ref1, ref2, ref3);
    	return getRadioBoxList(tcmnCdDtls, name, cd);
    }
    public static String getRadioBoxListRef3(String mst_cd, String name, String ref1, String ref2, String ref3, String cd, String us_yn) {
    	TcmnCdDtl[] tcmnCdDtls = CodeUtil.getTcmnCdDtlList(mst_cd, ref1, ref2, ref3, us_yn);
        return getRadioBoxList(tcmnCdDtls, name, cd);
    }

    /**
     * 라디오박스 생성
     * @param  tcmnCdDtls : SYS_CD_MST 테이블의 MST_CD 컬럼 배열
     * @param  name      : 콤보박스의 ID, NAME 값
     * @param  cd        : 해당 CD 값에 checked 속성 부여
     * @return String
     */
    public static String getRadioBoxList(TcmnCdDtl[] tcmnCdDtls, String name, String cd) {
        if(name == null || "".equals(name)) {
            throw new UtilException("Name is null");
        }

        StringBuilder buf = new StringBuilder(100);
        buf.append("<div class=\"radio\">");
        for(int i = 0; tcmnCdDtls != null && i < tcmnCdDtls.length; i++) {
        	TcmnCdDtl tcmnCdDtl = tcmnCdDtls[i];
        	String id = name + "_" + tcmnCdDtl.getCd();
            buf.append("    <span><input type=\"radio\" id=\"").append(id).append("\" ").append("name=\"").append(name).append("\" ").append("value=\"").append(tcmnCdDtl.getCd()).append("\"").append(cd != null && tcmnCdDtl.getCd().equals(cd) ? " checked=\"checked\"" : "").append("/><label for=\"").append(id).append("\">").append(tcmnCdDtl.getCd_nm()).append("</label></span>");
        }
        buf.append("</div>");

        return buf.toString();
    }

    /**
     * 체크박스 - 마스터코드
     */
    public static String getCheckBoxList(String mst_cd, String name) {
        return getCheckBoxList(mst_cd, name, null);
    }
    public static String getCheckBoxList(String mst_cd, String name, String allChecked) {
    	return getCheckBoxList(mst_cd, name, allChecked, null);
    }
    public static String getCheckBoxList(String mst_cd, String name, String allChecked, String cd) {
    	TcmnCdDtl[] tcmnCdDtls = CodeUtil.getTcmnCdDtlList(mst_cd);
    	return getCheckBoxList(tcmnCdDtls, name, allChecked, cd);
    }
    public static String getCheckBoxList(String mst_cd, String name, String allChecked, String cd, String us_yn) {
    	TcmnCdDtl[] tcmnCdDtls = CodeUtil.getTcmnCdDtlList(mst_cd, null, null, null, us_yn);
    	return getCheckBoxList(tcmnCdDtls, name, allChecked, cd);
    }

    /**
     * 라디오박스 - 마스터코드, 참조값1
     */
    public static String getCheckBoxListRef1(String mst_cd, String name, String ref1) {
        return getCheckBoxListRef1(mst_cd, name, ref1, null);
    }
    public static String getCheckBoxListRef1(String mst_cd, String name, String ref1, String allChecked) {
    	return getCheckBoxListRef1(mst_cd, name, ref1, allChecked, null);
    }
    public static String getCheckBoxListRef1(String mst_cd, String name, String ref1, String allChecked, String cd) {
    	TcmnCdDtl[] tcmnCdDtls = CodeUtil.getTcmnCdDtlList(mst_cd, ref1);
        return getCheckBoxList(tcmnCdDtls, name, allChecked, cd);
    }
    public static String getCheckBoxListRef1(String mst_cd, String name, String ref1, String allChecked, String cd, String us_yn) {
    	TcmnCdDtl[] tcmnCdDtls = CodeUtil.getTcmnCdDtlList(mst_cd, ref1, null, null, us_yn);
    	return getCheckBoxList(tcmnCdDtls, name, allChecked, cd);
    }

    /**
     * 라디오박스 - 마스터코드, 참조값1, 참조값2
     */
    public static String getCheckBoxListRef2(String mst_cd, String name, String ref1, String ref2) {
        return getCheckBoxListRef2(mst_cd, name, ref1, ref2, null);
    }
    public static String getCheckBoxListRef2(String mst_cd, String name, String ref1, String ref2, String allChecked) {
    	return getCheckBoxListRef2(mst_cd, name, ref1, ref2, allChecked, null);
    }
    public static String getCheckBoxListRef2(String mst_cd, String name, String ref1, String ref2, String allChecked, String cd) {
    	TcmnCdDtl[] tcmnCdDtls = CodeUtil.getTcmnCdDtlList(mst_cd, ref1, ref2);
        return getCheckBoxList(tcmnCdDtls, name, allChecked, cd);
    }
    public static String getCheckBoxListRef2(String mst_cd, String name, String ref1, String ref2, String allChecked, String cd, String us_yn) {
    	TcmnCdDtl[] tcmnCdDtls = CodeUtil.getTcmnCdDtlList(mst_cd, ref1, ref2, null, us_yn);
        return getCheckBoxList(tcmnCdDtls, name, allChecked, cd);
    }

    /**
     * 라디오박스 - 마스터코드, 참조값1, 참조값2, 참조값3
     */
    public static String getCheckBoxListRef3(String mst_cd, String name, String ref1, String ref2, String ref3) {
        return getCheckBoxListRef3(mst_cd, name, ref1, ref2, ref3, null);
    }
    public static String getCheckBoxListRef3(String mst_cd, String name, String ref1, String ref2, String ref3, String allChecked) {
    	return getCheckBoxListRef3(mst_cd, name, ref1, ref2, ref3, allChecked, null);
    }
    public static String getCheckBoxListRef3(String mst_cd, String name, String ref1, String ref2, String ref3, String allChecked, String cd) {
    	TcmnCdDtl[] tcmnCdDtls = CodeUtil.getTcmnCdDtlList(mst_cd, ref1, ref2, ref3);
        return getCheckBoxList(tcmnCdDtls, name, allChecked, cd);
    }
    public static String getCheckBoxListRef3(String mst_cd, String name, String ref1, String ref2, String ref3, String allChecked, String cd, String us_yn) {
    	TcmnCdDtl[] tcmnCdDtls = CodeUtil.getTcmnCdDtlList(mst_cd, ref1, ref2, ref3, us_yn);
        return getCheckBoxList(tcmnCdDtls, name, allChecked, cd);
    }

    /**
     * 체크박스 생성
     * @param  tcmnCdDtls  : SYS_CD_MST 테이블의 MST_CD 컬럼 배열
     * @param  allChecked : 전체 체크 노출명(예:전체, 전체선택)
     * @param  name       : 콤보박스의 ID, NAME 값
     * @param  cd         : 해당 CD 값에 checked 속성 부여
     * @return String
     */
    public static String getCheckBoxList(TcmnCdDtl[] tcmnCdDtls, String name, String allChecked, String cd) {
        if(name == null || "".equals(name)) {
            throw new UtilException("Name is null");
        }

        int tcmnCdDtlsLen = tcmnCdDtls.length;
        StringBuilder buf = new StringBuilder(100);
        buf.append("<div class=\"check\">");
        String allId = "";
        String allCheckFlag = Const.BOOLEAN_FALSE;
        if(allChecked != null && !"".equals(allChecked)) {
        	allId = name + "_" + "all";
        	if(tcmnCdDtls != null && tcmnCdDtlsLen > 0) {
        		String cdExistYn = Const.BOOLEAN_FALSE;
        		for(int i = 0; tcmnCdDtls != null && i < tcmnCdDtlsLen; i++) {
        			TcmnCdDtl sysCdDtl = tcmnCdDtls[i];
        			if(sysCdDtl != null && cd != null && sysCdDtl.getCd().equals(cd)) {
        				cdExistYn = Const.BOOLEAN_TRUE;
        				break;
        			}
        		}
        		buf.append("    <span><input type=\"checkbox\" id=\"").append(allId).append("\" name=\"").append(allId).append("\" onclick=\"javascript:checkedAll('").append(allId).append("','").append(name).append("',").append(tcmnCdDtlsLen).append(")\" ").append(Const.BOOLEAN_TRUE.equals(cdExistYn) && tcmnCdDtlsLen == 1 ? "checked=\"checked\"" : "").append("/><label for=\"").append(allId).append("\">").append(allChecked).append("</label></span>");
        		allCheckFlag = Const.BOOLEAN_TRUE;
        	}
        }
        String script = "";
        int checkedCnt = 0;
        for(int i = 0; tcmnCdDtls != null && i < tcmnCdDtlsLen; i++) {
        	TcmnCdDtl tcmnCdDtl = tcmnCdDtls[i];
        	String id = name + "_" + tcmnCdDtl.getCd();
        	script = "";
        	if(Const.BOOLEAN_TRUE.equals(allCheckFlag)) {
        		script = "onclick=\"javascript:checkedYn('" + id + "','" + name + "','" + allId + "'," + tcmnCdDtlsLen + ")\"";
        	}
            buf.append("    <span><input type=\"checkbox\" id=\"").append(id).append("\" ").append("name=\"").append(name).append("\" ").append("value=\"").append(tcmnCdDtl.getCd()).append("\" ").append(script).append(cd != null && tcmnCdDtl.getCd().equals(cd) ? "checked=\"checked\"" : "").append("/><label for=\"").append(id).append("\">").append(tcmnCdDtl.getCd_nm()).append("</label></span>");
            if(tcmnCdDtl != null && cd != null && tcmnCdDtl.getCd().equals(cd)) checkedCnt++;
        }
        if(Const.BOOLEAN_TRUE.equals(allCheckFlag)) {
        	buf.append("    <input type=\"hidden\" id=\"").append(name).append("_checked_cnt").append("\" value=\"").append(checkedCnt).append("\"").append("/>");
        }
        buf.append("</div>");

        return buf.toString();
    }

}
