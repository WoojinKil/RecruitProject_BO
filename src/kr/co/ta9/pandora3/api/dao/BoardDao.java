package kr.co.ta9.pandora3.api.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
/**
 * TbbsDocInfDao - DAO(Data Access Object) class for table [TBBS_DOC_INF].
 *
 * <pre>
 *   Generated by CodeProcessor. You can freely modify this generated file.
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class BoardDao extends BaseDao {

	/**
	 * 공통게시판 목록 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,Object>> selectNoticeList(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectList("BoardInf.selectNoticeList", parameterMap);
	}
	
	/**
	 * 공통게시판 목록 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,Object>> selectPopNotice(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectList("BoardInf.selectPopNotice", parameterMap);
	}

	/**
	 * 공통게시판 상세
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,Object>> selectNoticeView(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectList("BoardInf.selectNoticeView", parameterMap);
	}

	/**
	 * 공통게시판 첨부파일
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,Object>> selectTbbsFlInfList(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectList("BoardInf.selectTbbsFlInfList", parameterMap);
	}

}
