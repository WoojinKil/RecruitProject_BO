package kr.co.ta9.pandora3.pwzn.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspDtl;

/**
 * BaseTbbsWbznDspDtlDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TBBS_WBZN_DSP_DTL].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class BaseTbbsWbznDspDtlDaoTrx extends BaseDao {

	/**
	 * @param tbbsWbznDspDtl TbbsWbznDspDtl
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TbbsWbznDspDtl tbbsWbznDspDtl) {
		boolean result = true;
		if (tbbsWbznDspDtl == null) {
			result = false;
		}

		if (
			tbbsWbznDspDtl.getObj_ctg_dtl_seq()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tbbsWbznDspDtl TbbsWbznDspDtl
	 * @throws Exception
	 */
	public  int insert(TbbsWbznDspDtl tbbsWbznDspDtl) throws Exception {
		return getSqlSession().insert("TbbsWbznDspDtlTrx.insert", tbbsWbznDspDtl);
	}

	/**
	 * @param tbbsWbznDspDtls TbbsWbznDspDtl[]
	 * @throws Exception
	 */
	public int insertMany(TbbsWbznDspDtl[] tbbsWbznDspDtls) throws Exception {
		int count = 0;
		if (tbbsWbznDspDtls != null) {
			for (TbbsWbznDspDtl tbbsWbznDspDtl : tbbsWbznDspDtls) {
				count += insert(tbbsWbznDspDtl);
			}
		}
		return count;		
	}

	/**
	 * @param tbbsWbznDspDtl TbbsWbznDspDtl
	 * @throws Exception
	 */
	public  int update(TbbsWbznDspDtl tbbsWbznDspDtl) throws Exception {
		if(!isPrimaryKeyValid(tbbsWbznDspDtl)) {
			throw new PrimaryKeyNotSettedException("instance of TbbsWbznDspDtl can't be null or Primary key is not set");
		}
		return getSqlSession().update("TbbsWbznDspDtlTrx.update", tbbsWbznDspDtl);
	}

	/**
	 * @param tbbsWbznDspDtls TbbsWbznDspDtl[]
	 * @throws Exception
	 */
	public  int updateMany(TbbsWbznDspDtl[] tbbsWbznDspDtls) throws Exception {
		 int count = 0;
		if (tbbsWbznDspDtls != null) {
			for (TbbsWbznDspDtl tbbsWbznDspDtl : tbbsWbznDspDtls) {
				count += update(tbbsWbznDspDtl);
			}
		}
		return count;		
	}

	/**
	 * @param tbbsWbznDspDtl TbbsWbznDspDtl
	 * @throws Exception
	 */
	public  int delete(TbbsWbznDspDtl tbbsWbznDspDtl)throws Exception {
		if(!isPrimaryKeyValid(tbbsWbznDspDtl)) {
			throw new PrimaryKeyNotSettedException("instance of TbbsWbznDspDtl can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TbbsWbznDspDtlTrx.delete", tbbsWbznDspDtl);
	}

	/**
	 * @param tbbsWbznDspDtls TbbsWbznDspDtl[]
	 * @throws Exception
	 */
	public int deleteMany( TbbsWbznDspDtl[] tbbsWbznDspDtls) throws Exception {
		int count = 0;
		if (tbbsWbznDspDtls != null) {
			for (TbbsWbznDspDtl tbbsWbznDspDtl : tbbsWbznDspDtls) {
				count += delete(tbbsWbznDspDtl);
			}
		}
		return count;		
	}

}