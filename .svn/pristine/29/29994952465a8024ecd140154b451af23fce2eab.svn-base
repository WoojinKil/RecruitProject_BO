package kr.co.ta9.pandora3.pbbs.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TbbsScdInf;

/**
 * BaseTbbsScdInfDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TBBS_SCD_INF].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class BaseTbbsScdInfDaoTrx extends BaseDao {

	/**
	 * @param tbbsScdInf TbbsScdInf
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TbbsScdInf tbbsScdInf) {
		boolean result = true;
		if (tbbsScdInf == null) {
			result = false;
		}

		if (
			tbbsScdInf.getObj_scd_seq()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tbbsScdInf TbbsScdInf
	 * @throws Exception
	 */
	public  int insert(TbbsScdInf tbbsScdInf) throws Exception {
		return getSqlSession().insert("TbbsScdInfTrx.insert", tbbsScdInf);
	}

	/**
	 * @param tbbsScdInfs TbbsScdInf[]
	 * @throws Exception
	 */
	public int insertMany(TbbsScdInf... tbbsScdInfs) throws Exception {
		int count = 0;
		if (tbbsScdInfs != null) {
			for (TbbsScdInf tbbsScdInf : tbbsScdInfs) {
				count += insert(tbbsScdInf);
			}
		}
		return count;		
	}

	/**
	 * @param tbbsScdInf TbbsScdInf
	 * @throws Exception
	 */
	public  int update(TbbsScdInf tbbsScdInf) throws Exception {
		if(!isPrimaryKeyValid(tbbsScdInf)) {
			throw new PrimaryKeyNotSettedException("instance of TbbsScdInf can't be null or Primary key is not set");
		}
		return getSqlSession().update("TbbsScdInfTrx.update", tbbsScdInf);
	}

	/**
	 * @param tbbsScdInfs TbbsScdInf[]
	 * @throws Exception
	 */
	public  int updateMany(TbbsScdInf... tbbsScdInfs) throws Exception {
		 int count = 0;
		if (tbbsScdInfs != null) {
			for (TbbsScdInf tbbsScdInf : tbbsScdInfs) {
				count += update(tbbsScdInf);
			}
		}
		return count;		
	}

	/**
	 * @param tbbsScdInf TbbsScdInf
	 * @throws Exception
	 */
	public  int delete(TbbsScdInf tbbsScdInf)throws Exception {
		if(!isPrimaryKeyValid(tbbsScdInf)) {
			throw new PrimaryKeyNotSettedException("instance of TbbsScdInf can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TbbsScdInfTrx.delete", tbbsScdInf);
	}

	/**
	 * @param tbbsScdInfs TbbsScdInf[]
	 * @throws Exception
	 */
	public int deleteMany( TbbsScdInf... tbbsScdInfs) throws Exception {
		int count = 0;
		if (tbbsScdInfs != null) {
			for (TbbsScdInf tbbsScdInf : tbbsScdInfs) {
				count += delete(tbbsScdInf);
			}
		}
		return count;		
	}

}