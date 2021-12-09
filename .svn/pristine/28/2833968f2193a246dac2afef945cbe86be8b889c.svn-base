package kr.co.ta9.pandora3.pbbs.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TbbsCmtInf;

/**
 * BaseTbbsCmtInfDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TBBS_CMT_INF].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class BaseTbbsCmtInfDaoTrx extends BaseDao {

	/**
	 * @param tbbsCmtInf TbbsCmtInf
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TbbsCmtInf tbbsCmtInf) {
		boolean result = true;
		if (tbbsCmtInf == null) {
			result = false;
		}

		if (
			tbbsCmtInf.getObj_cmt_seq()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tbbsCmtInf TbbsCmtInf
	 * @throws Exception
	 */
	public  int insert(TbbsCmtInf tbbsCmtInf) throws Exception {
		return getSqlSession().insert("TbbsCmtInfTrx.insert", tbbsCmtInf);
	}

	/**
	 * @param tbbsCmtInfs TbbsCmtInf[]
	 * @throws Exception
	 */
	public int insertMany(TbbsCmtInf... tbbsCmtInfs) throws Exception {
		int count = 0;
		if (tbbsCmtInfs != null) {
			for (TbbsCmtInf tbbsCmtInf : tbbsCmtInfs) {
				count += insert(tbbsCmtInf);
			}
		}
		return count;
	}

	/**
	 * @param tbbsCmtInf TbbsCmtInf
	 * @throws Exception
	 */
	public  int update(TbbsCmtInf tbbsCmtInf) throws Exception {
		if(!isPrimaryKeyValid(tbbsCmtInf)) {
			throw new PrimaryKeyNotSettedException("instance of TbbsCmtInf can't be null or Primary key is not set");
		}
		return getSqlSession().update("TbbsCmtInfTrx.update", tbbsCmtInf);
	}

	/**
	 * @param tbbsCmtInfs TbbsCmtInf[]
	 * @throws Exception
	 */
	public  int updateMany(TbbsCmtInf... tbbsCmtInfs) throws Exception {
		 int count = 0;
		if (tbbsCmtInfs != null) {
			for (TbbsCmtInf tbbsCmtInf : tbbsCmtInfs) {
				count += update(tbbsCmtInf);
			}
		}
		return count;
	}

	/**
	 * @param tbbsCmtInf TbbsCmtInf
	 * @throws Exception
	 */
	public  int delete(TbbsCmtInf tbbsCmtInf)throws Exception {
		if(!isPrimaryKeyValid(tbbsCmtInf)) {
			throw new PrimaryKeyNotSettedException("instance of TbbsCmtInf can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TbbsCmtInfTrx.delete", tbbsCmtInf);
	}

	/**
	 * @param tbbsCmtInfs TbbsCmtInf[]
	 * @throws Exception
	 */
	public int deleteMany( TbbsCmtInf... tbbsCmtInfs) throws Exception {
		int count = 0;
		if (tbbsCmtInfs != null) {
			for (TbbsCmtInf tbbsCmtInf : tbbsCmtInfs) {
				count += delete(tbbsCmtInf);
			}
		}
		return count;
	}

}