package kr.co.ta9.pandora3.pwzn.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspMnInf;

/**
 * BaseTbbsWbznDspMnInfDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TBBS_WBZN_DSP_MN_INF].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class BaseTbbsWbznDspMnInfDaoTrx extends BaseDao {

	/**
	 * @param tbbsWbznDspMnInf TbbsWbznDspMnInf
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TbbsWbznDspMnInf tbbsWbznDspMnInf) {
		boolean result = true;
		if (tbbsWbznDspMnInf == null) {
			result = false;
		}

		if (
			tbbsWbznDspMnInf.getObj_ctg_seq()== null
			||
			tbbsWbznDspMnInf.getObj_wbzn_seq()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tbbsWbznDspMnInf TbbsWbznDspMnInf
	 * @throws Exception
	 */
	public  int insert(TbbsWbznDspMnInf tbbsWbznDspMnInf) throws Exception {
		return getSqlSession().insert("TbbsWbznDspMnInfTrx.insert", tbbsWbznDspMnInf);
	}

	/**
	 * @param tbbsWbznDspMnInfs TbbsWbznDspMnInf[]
	 * @throws Exception
	 */
	public int insertMany(TbbsWbznDspMnInf[] tbbsWbznDspMnInfs) throws Exception {
		int count = 0;
		if (tbbsWbznDspMnInfs != null) {
			for (TbbsWbznDspMnInf tbbsWbznDspMnInf : tbbsWbznDspMnInfs) {
				count += insert(tbbsWbznDspMnInf);
			}
		}
		return count;		
	}

	/**
	 * @param tbbsWbznDspMnInf TbbsWbznDspMnInf
	 * @throws Exception
	 */
	public  int update(TbbsWbznDspMnInf tbbsWbznDspMnInf) throws Exception {
		if(!isPrimaryKeyValid(tbbsWbznDspMnInf)) {
			throw new PrimaryKeyNotSettedException("instance of TbbsWbznDspMnInf can't be null or Primary key is not set");
		}
		return getSqlSession().update("TbbsWbznDspMnInfTrx.update", tbbsWbznDspMnInf);
	}

	/**
	 * @param tbbsWbznDspMnInfs TbbsWbznDspMnInf[]
	 * @throws Exception
	 */
	public  int updateMany(TbbsWbznDspMnInf[] tbbsWbznDspMnInfs) throws Exception {
		 int count = 0;
		if (tbbsWbznDspMnInfs != null) {
			for (TbbsWbznDspMnInf tbbsWbznDspMnInf : tbbsWbznDspMnInfs) {
				count += update(tbbsWbznDspMnInf);
			}
		}
		return count;		
	}

	/**
	 * @param tbbsWbznDspMnInf TbbsWbznDspMnInf
	 * @throws Exception
	 */
	public  int delete(TbbsWbznDspMnInf tbbsWbznDspMnInf)throws Exception {
		/*if(!isPrimaryKeyValid(tbbsWbznDspMnInf)) {
			throw new PrimaryKeyNotSettedException("instance of TbbsWbznDspMnInf can't be null or Primary key is not set");
		}*/
		return getSqlSession().delete("TbbsWbznDspMnInfTrx.delete", tbbsWbznDspMnInf);
	}

	/**
	 * @param tbbsWbznDspMnInfs TbbsWbznDspMnInf[]
	 * @throws Exception
	 */
	public int deleteMany( TbbsWbznDspMnInf[] tbbsWbznDspMnInfs) throws Exception {
		int count = 0;
		if (tbbsWbznDspMnInfs != null) {
			for (TbbsWbznDspMnInf tbbsWbznDspMnInf : tbbsWbznDspMnInfs) {
				count += delete(tbbsWbznDspMnInf);
			}
		}
		return count;		
	}

}