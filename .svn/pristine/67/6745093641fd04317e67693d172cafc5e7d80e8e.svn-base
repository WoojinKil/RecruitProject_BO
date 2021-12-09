/**
* <pre>
* 1. 프로젝트명 : 판도라 패키징
* 2. 패키지명 : kr.co.ta9.pandora3.front.main.dao
* 3. 파일명 : MainDao
* 4. 작성일 : 2019.04.04
* 5. 작성자 : TANINE
* </pre>
*/
package kr.co.ta9.pandora3.front.main.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pcommon.dto.usrdef.Main;

/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.front.main.dao
* 2. 타입명 : class
* 3. 작성일 : 2019.04.04
* 4. 작성자 : TANINE
* 5. 설명 : 메인화면 정보 DAO
* </pre>
*/
@Repository
public class MainDao extends BaseDao {
	
	/**
	 * 메인전시목록 조회
	 * @param  parameterMap
	 * @return List<Main>
	 * @throws Exception
	 */
	public List<Main> selectMnDispDocList(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectList("Main.selectMnDispDocList", parameterMap);
	}
	
	/**
	 * 공지사항 기타 정보 조회
	 * @return Main
	 * @throws Exception
	 */
	public Main selectNotiEtcInf() throws Exception {
		return getSqlSession().selectOne("Main.selectNotiEtcInf");
	}
	
}
