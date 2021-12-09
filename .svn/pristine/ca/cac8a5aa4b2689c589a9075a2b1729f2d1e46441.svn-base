package kr.co.ta9.pandora3.pbbs.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TbbsTmpDocInf;

/**
 * BaseTbbsTmpDocInfDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TBBS_TMP_DOC_INF].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class BaseTbbsTmpDocInfDaoTrx extends BaseDao {

	/**
	 * @param tbbsTmpDocInf TbbsTmpDocInf
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TbbsTmpDocInf tbbsTmpDocInf) {
		boolean result = true;
		if (tbbsTmpDocInf == null) {
			result = false;
		}

		if (
			tbbsTmpDocInf.getObj_doc_seq()== null
			||
			tbbsTmpDocInf.getObj_modl_seq()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tbbsTmpDocInf TbbsTmpDocInf
	 * @throws Exception
	 */
	public  int insert(TbbsTmpDocInf tbbsTmpDocInf) throws Exception {
		if(!isPrimaryKeyValid(tbbsTmpDocInf)) {
			throw new PrimaryKeyNotSettedException("instance of TbbsTmpDocInf can't be null or Primary key is not set");
		}

		return getSqlSession().insert("TbbsTmpDocInfTrx.insert", tbbsTmpDocInf);
	}

	/**
	 * @param tbbsTmpDocInfs TbbsTmpDocInf[]
	 * @throws Exception
	 */
	public int insertMany(TbbsTmpDocInf... tbbsTmpDocInfs) throws Exception {
		int count = 0;
		if (tbbsTmpDocInfs != null) {
			for (TbbsTmpDocInf tbbsTmpDocInf : tbbsTmpDocInfs) {
				count += insert(tbbsTmpDocInf);
			}
		}
		return count;		
	}

	/**
	 * @param tbbsTmpDocInf TbbsTmpDocInf
	 * @throws Exception
	 */
	public  int update(TbbsTmpDocInf tbbsTmpDocInf) throws Exception {
		if(!isPrimaryKeyValid(tbbsTmpDocInf)) {
			throw new PrimaryKeyNotSettedException("instance of TbbsTmpDocInf can't be null or Primary key is not set");
		}
		return getSqlSession().update("TbbsTmpDocInfTrx.update", tbbsTmpDocInf);
	}

	/**
	 * @param tbbsTmpDocInfs TbbsTmpDocInf[]
	 * @throws Exception
	 */
	public  int updateMany(TbbsTmpDocInf... tbbsTmpDocInfs) throws Exception {
		 int count = 0;
		if (tbbsTmpDocInfs != null) {
			for (TbbsTmpDocInf tbbsTmpDocInf : tbbsTmpDocInfs) {
				count += update(tbbsTmpDocInf);
			}
		}
		return count;		
	}

	/**
	 * @param tbbsTmpDocInf TbbsTmpDocInf
	 * @throws Exception
	 */
	public  int delete(TbbsTmpDocInf tbbsTmpDocInf)throws Exception {
		if(!isPrimaryKeyValid(tbbsTmpDocInf)) {
			throw new PrimaryKeyNotSettedException("instance of TbbsTmpDocInf can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TbbsTmpDocInfTrx.delete", tbbsTmpDocInf);
	}

	/**
	 * @param tbbsTmpDocInfs TbbsTmpDocInf[]
	 * @throws Exception
	 */
	public int deleteMany( TbbsTmpDocInf... tbbsTmpDocInfs) throws Exception {
		int count = 0;
		if (tbbsTmpDocInfs != null) {
			for (TbbsTmpDocInf tbbsTmpDocInf : tbbsTmpDocInfs) {
				count += delete(tbbsTmpDocInf);
			}
		}
		return count;		
	}

}