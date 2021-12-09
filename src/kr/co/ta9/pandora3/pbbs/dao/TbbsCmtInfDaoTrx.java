package kr.co.ta9.pandora3.pbbs.dao;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.pbbs.dao.base.BaseTbbsCmtInfDaoTrx;
import kr.co.ta9.pandora3.pcommon.dto.TbbsCmtInf;

/**
 * TbbsCmtInfDaoTrx - Transactional DAO(Data Access Object) class for table
 * [TBBS_CMT_INF].
 *
 * <pre>
 *  1. 패키지명 : kr.co.ta9.pandora3.pbbs.dao
 *  2. 타입명    : class
 *  3. 작성일    : 2018-01-10
 *  4. 설명       : 댓글 DAO Trx (등록/수정/삭제)
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class TbbsCmtInfDaoTrx extends BaseTbbsCmtInfDaoTrx {
	
	/**
	 * 댓글 정보 갱신
	 * @param sysComments
	 * @return
	 * @throws Exception
	 */
	public int updateSysCommentsInfo(TbbsCmtInf tbbsCmtInf) throws Exception {
		return getSqlSession().update("TbbsCmtInfTrx.updateTbbsCmtInf", tbbsCmtInf);
	}
	
	/**
	 * 댓글 정보 삭제
	 * @param sysComments
	 * @return
	 * @throws Exception
	 */
	public int deleteSysCommentsInfo(TbbsCmtInf tbbsCmtInf) throws Exception {
		return getSqlSession().delete("TbbsCmtInfTrx.deleteTbbsCmtInf", tbbsCmtInf);
	}
	
	/**
	 * 하위 댓글 정보 삭제
	 * @param TbbsCmtInf
	 * @return int
	 * @throws Exception
	 */
	public int deleteTbbsCmtInfAllChd(TbbsCmtInf tbbsCmtInf) throws Exception {
		return getSqlSession().delete("TbbsCmtInfTrx.deleteTbbsCmtInfAllChd", tbbsCmtInf);
	}
}