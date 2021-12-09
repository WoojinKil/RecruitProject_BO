package kr.co.ta9.pandora3.pwzn.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspMst;

/**
 * BaseTbbsWbznDspMstDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TBBS_WBZN_DSP_MST].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class BaseTbbsWbznDspMstDaoTrx extends BaseDao {

	/**
	 * @param tbbsWbznDspMst TbbsWbznDspMst
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TbbsWbznDspMst tbbsWbznDspMst) {
		boolean result = true;
		if (tbbsWbznDspMst == null) {
			result = false;
		}

		if (
			tbbsWbznDspMst.getObj_wbzn_seq()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tbbsWbznDspMst TbbsWbznDspMst
	 * @throws Exception
	 */
	public  int insert(TbbsWbznDspMst tbbsWbznDspMst) throws Exception {
		return getSqlSession().insert("TbbsWbznDspMstTrx.insert", tbbsWbznDspMst);
	}

	/**
	 * @param tbbsWbznDspMsts TbbsWbznDspMst[]
	 * @throws Exception
	 */
	public int insertMany(TbbsWbznDspMst[] tbbsWbznDspMsts) throws Exception {
		int count = 0;
		if (tbbsWbznDspMsts != null) {
			for (TbbsWbznDspMst tbbsWbznDspMst : tbbsWbznDspMsts) {
				count += insert(tbbsWbznDspMst);
			}
		}
		return count;		
	}

	/**
	 * @param tbbsWbznDspMst TbbsWbznDspMst
	 * @throws Exception
	 */
	public  int update(TbbsWbznDspMst tbbsWbznDspMst) throws Exception {
		if(!isPrimaryKeyValid(tbbsWbznDspMst)) {
			throw new PrimaryKeyNotSettedException("instance of TbbsWbznDspMst can't be null or Primary key is not set");
		}
		return getSqlSession().update("TbbsWbznDspMstTrx.update", tbbsWbznDspMst);
	}

	/**
	 * @param tbbsWbznDspMsts TbbsWbznDspMst[]
	 * @throws Exception
	 */
	public  int updateMany(TbbsWbznDspMst[] tbbsWbznDspMsts) throws Exception {
		 int count = 0;
		if (tbbsWbznDspMsts != null) {
			for (TbbsWbznDspMst tbbsWbznDspMst : tbbsWbznDspMsts) {
				count += update(tbbsWbznDspMst);
			}
		}
		return count;		
	}

	/**
	 * @param tbbsWbznDspMst TbbsWbznDspMst
	 * @throws Exception
	 */
	public  int delete(TbbsWbznDspMst tbbsWbznDspMst)throws Exception {
		if(!isPrimaryKeyValid(tbbsWbznDspMst)) {
			throw new PrimaryKeyNotSettedException("instance of TbbsWbznDspMst can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TbbsWbznDspMstTrx.delete", tbbsWbznDspMst);
	}

	/**
	 * @param tbbsWbznDspMsts TbbsWbznDspMst[]
	 * @throws Exception
	 */
	public int deleteMany( TbbsWbznDspMst[] tbbsWbznDspMsts) throws Exception {
		int count = 0;
		if (tbbsWbznDspMsts != null) {
			for (TbbsWbznDspMst tbbsWbznDspMst : tbbsWbznDspMsts) {
				count += delete(tbbsWbznDspMst);
			}
		}
		return count;		
	}

}