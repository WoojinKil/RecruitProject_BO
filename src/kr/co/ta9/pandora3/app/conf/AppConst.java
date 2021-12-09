/**
* <pre>
* 1. 프로젝트명 : 판도라 패키징
* 2. 패키지명 : kr.co.ta9.pandora3.app.conf
* 3. 파일명 : AppConst
* 4. 작성일 : 2016-08-22
* 5. 작성자 : tmlee
* </pre>
*/
package kr.co.ta9.pandora3.app.conf;
/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.app.conf
* 2. 타입명 : class
* 3. 작성일 : 2016-08-22
* 4. 작성자 : tmlee
* 5. 설명 : Const 파일
* </pre>
*/
public final class AppConst {
	
	private AppConst() {
		
	}
	
	public static final String SYS_CD = "0";    // 사내 프로젝트
	
	public static final String ADMIN_EXT = ".adm";
	public final static String ADMIN_GB = "ADMIN";
	public static final String ADMIN_URL = "/pandora3";
	public static final String FRONT_URL = "/pandora3Front";
	public static final String GRID_SIZE = "JQGRIDSIZE";
	public static final String GRID_DATA = "JQGRIDDATA";
	public static final String GRID_CRUD = "JQGRIDCRUD";
	public static final String GRID_HEADER = "JQGRIDHEADER";
	public static final String GRID_EXCEL = "JQGRIDEXCEL";
	public static final String GRID_INSERT = "C";
	public static final String GRID_UPDATE = "U";
	public static final String GRID_DELETE = "D";
	
	public static final String ACTION_LOGIN = "10";
	public static final String ACTION_BACK = "20";
	public static final String ACTION_NONE = "30";
	public static final String ACTION_ERROR = "40";
	
	// 로그아웃 사유코드
	public static final String LOGOUT_CAUS_CD = "S100";
	public static final String LOGOUT_CASUS_CD_LOGIN = "10";	//정상로그인
	public static final String LOGOUT_CASUS_CD_LOGOUT = "20";   //정상로그아웃
	public static final String LOGOUT_CASUS_CD_EXCEED = "30";   //시간초과로그아웃
	
	// 메뉴유형코드
	public static final String MENU_TYPE_CD = "S101";
	public static final String MENU_TYPE_CD_TAB = "10";		    //일반(탭)
	public static final String MENU_TYPE_CD_POPUP = "20";       //팝업
	public static final String MENU_TYPE_CD_NEW_WINDOW = "30";  //새창
	
	// 배치실행유형코드
	public static final String BATCH_EXE_TYPE_CD = "S200";
	public static final String BATCH_EXE_TYPE_CD_ALONE = "10";		//독립실행
	public static final String BATCH_EXE_TYPE_CD_DEPEND = "20";		//종속실행
	
	// 배치업무유형코드 (TO DO : 각 사이트에따라 업무 유형 정의)
	public static final String JOB_TYPE_CD = "S201";
		
	// 배치결과코드
	public static final String BATCH_RSLT_CD = "S202";
	public static final String BATCH_RSLT_CD_SUCCESS = "S";		// 작업성공
	public static final String BATCH_RSLT_CD_FAIL = "F";		// 작업실패
	
	// 배치분기코드
	public static final String BATCH_MOV_CD = "S203";
	public static final String BATCH_MOV_CD_SUCCESS = "S";		//성공분기
	public static final String BATCH_MOV_CD_FAIL = "F";			//실패분기
}
