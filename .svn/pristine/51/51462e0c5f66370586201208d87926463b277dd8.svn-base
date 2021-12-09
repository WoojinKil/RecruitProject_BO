package kr.co.ta9.pandora3.pbbs.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TbbsQaCmtInf;

/**
 * BaseTbbsQaCmtInfDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TBBS_QA_CMT_INF].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class BaseTbbsQaCmtInfDaoTrx extends BaseDao {

	/**
	 * @param tbbsQaCmtInf TbbsQaCmtInf
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TbbsQaCmtInf tbbsQaCmtInf) {
		boolean result = true;
		if (tbbsQaCmtInf == null) {
			result = false;
		}

		if (
			tbbsQaCmtInf.getObj_cmt_seq()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tbbsQaCmtInf TbbsQaCmtInf
	 * @throws Exception
	 */
	public  int insert(TbbsQaCmtInf tbbsQaCmtInf) throws Exception {
		return getSqlSession().insert("TbbsQaCmtInfTrx.insert", tbbsQaCmtInf);
	}

	/**
	 * @param tbbsQaCmtInfs TbbsQaCmtInf[]
	 * @throws Exception
	 */
	public int insertMany(TbbsQaCmtInf... tbbsQaCmtInfs) throws Exception {
		int count = 0;
		if (tbbsQaCmtInfs != null) {
			for (TbbsQaCmtInf tbbsQaCmtInf : tbbsQaCmtInfs) {
				count += insert(tbbsQaCmtInf);
			}
		}
		return count;		
	}

	/**
	 * @param tbbsQaCmtInf TbbsQaCmtInf
	 * @throws Exception
	 */
	public  int update(TbbsQaCmtInf tbbsQaCmtInf) throws Exception {
		if(!isPrimaryKeyValid(tbbsQaCmtInf)) {
			throw new PrimaryKeyNotSettedException("instance of TbbsQaCmtInf can't be null or Primary key is not set");
		}
		return getSqlSession().update("TbbsQaCmtInfTrx.update", tbbsQaCmtInf);
	}

	/**
	 * @param tbbsQaCmtInfs TbbsQaCmtInf[]
	 * @throws Exception
	 */
	public  int updateMany(TbbsQaCmtInf... tbbsQaCmtInfs) throws Exception {
		 int count = 0;
		if (tbbsQaCmtInfs != null) {
			for (TbbsQaCmtInf tbbsQaCmtInf : tbbsQaCmtInfs) {
				count += update(tbbsQaCmtInf);
			}
		}
		return count;		
	}

	/**
	 * @param tbbsQaCmtInf TbbsQaCmtInf
	 * @throws Exception
	 */
	public  int delete(TbbsQaCmtInf tbbsQaCmtInf)throws Exception {
		if(!isPrimaryKeyValid(tbbsQaCmtInf)) {
			throw new PrimaryKeyNotSettedException("instance of TbbsQaCmtInf can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TbbsQaCmtInfTrx.delete", tbbsQaCmtInf);
	}

	/**
	 * @param tbbsQaCmtInfs TbbsQaCmtInf[]
	 * @throws Exception
	 */
	public int deleteMany( TbbsQaCmtInf... tbbsQaCmtInfs) throws Exception {
		int count = 0;
		if (tbbsQaCmtInfs != null) {
			for (TbbsQaCmtInf tbbsQaCmtInf : tbbsQaCmtInfs) {
				count += delete(tbbsQaCmtInf);
			}
		}
		return count;		
	}

}