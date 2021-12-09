package kr.co.ta9.pandora3.pwzn.dao;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspDtl;
import kr.co.ta9.pandora3.pwzn.dao.base.BaseTbbsWbznDspDtlDaoTrx;

/**
 * TbbsWbznDspDtlDaoTrx - Transactional DAO(Data Access Object) class for table
 * [TBBS_WBZN_DSP_DTL].
 *
 * <pre>
 *  Generated by CodeProcessor. You can freely modify this generated file.
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class TbbsWbznDspDtlDaoTrx extends BaseTbbsWbznDspDtlDaoTrx {
	
	/**
	 * 웹진 마스터 삭제로인한 웹진 카테고리 상세 삭제
	 * @param tbbsWbznDspDtl
	 * @return
	 * @throws Exception
	 */
	public int deleteTbbsWbznDspDtlAll(TbbsWbznDspDtl tbbsWbznDspDtl) throws Exception {
		return getSqlSession().delete("TbbsWbznDspDtlTrx.deleteTbbsWbznDspDtlAll", tbbsWbznDspDtl);
	}
}