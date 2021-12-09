package kr.co.ta9.pandora3.pbbs.dao;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pbbs.dao.base.BaseTbbsDocUsrRtnnDao;
import kr.co.ta9.pandora3.pcommon.dto.TbbsDocUsrRtnn;

/**
 * TbbsDocUsrRtnnDao - DAO(Data Access Object) class for table [TBBS_DOC_USR_RTNN].
 *
 * <pre>
 *   Generated by CodeProcessor. You can freely modify this generated file.
 *   Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class TbbsDocUsrRtnnDao extends BaseTbbsDocUsrRtnnDao {
	/**
	 * 게시글 스크랩 정보 조회(단건)
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public TbbsDocUsrRtnn selectTbbsDocUsrRtnnScrapDocInfo(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectOne("TbbsDocUsrRtnn.selectTbbsDocUsrRtnnScrapDocInfo", parameterMap);
	}
}