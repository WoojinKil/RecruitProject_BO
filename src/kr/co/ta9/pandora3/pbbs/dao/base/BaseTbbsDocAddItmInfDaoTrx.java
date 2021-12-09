package kr.co.ta9.pandora3.pbbs.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TbbsDocAddItmInf;

/**
 * BaseTbbsDocAddItmInfDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TBBS_DOC_ADD_ITM_INF].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class BaseTbbsDocAddItmInfDaoTrx extends BaseDao {

	/**
	 * @param tbbsDocAddItmInf TbbsDocAddItmInf
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TbbsDocAddItmInf tbbsDocAddItmInf) {
		boolean result = true;
		if (tbbsDocAddItmInf == null) {
			result = false;
		}

		if (
			tbbsDocAddItmInf.getObj_doc_seq()== null
			||
			tbbsDocAddItmInf.getLang_cd()== null
			||
			tbbsDocAddItmInf.getObj_modl_seq()== null
			||
			tbbsDocAddItmInf.getObj_var_seq()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tbbsDocAddItmInf TbbsDocAddItmInf
	 * @throws Exception
	 */
	public  int insert(TbbsDocAddItmInf tbbsDocAddItmInf) throws Exception {
		if(!isPrimaryKeyValid(tbbsDocAddItmInf)) {
			throw new PrimaryKeyNotSettedException("instance of TbbsDocAddItmInf can't be null or Primary key is not set");
		}

		return getSqlSession().insert("TbbsDocAddItmInfTrx.insert", tbbsDocAddItmInf);
	}

	/**
	 * @param tbbsDocAddItmInfs TbbsDocAddItmInf[]
	 * @throws Exception
	 */
	public int insertMany(TbbsDocAddItmInf... tbbsDocAddItmInfs) throws Exception {
		int count = 0;
		if (tbbsDocAddItmInfs != null) {
			for (TbbsDocAddItmInf tbbsDocAddItmInf : tbbsDocAddItmInfs) {
				count += insert(tbbsDocAddItmInf);
			}
		}
		return count;		
	}

	/**
	 * @param tbbsDocAddItmInf TbbsDocAddItmInf
	 * @throws Exception
	 */
	public  int update(TbbsDocAddItmInf tbbsDocAddItmInf) throws Exception {
		if(!isPrimaryKeyValid(tbbsDocAddItmInf)) {
			throw new PrimaryKeyNotSettedException("instance of TbbsDocAddItmInf can't be null or Primary key is not set");
		}
		return getSqlSession().update("TbbsDocAddItmInfTrx.update", tbbsDocAddItmInf);
	}

	/**
	 * @param tbbsDocAddItmInfs TbbsDocAddItmInf[]
	 * @throws Exception
	 */
	public  int updateMany(TbbsDocAddItmInf... tbbsDocAddItmInfs) throws Exception {
		 int count = 0;
		if (tbbsDocAddItmInfs != null) {
			for (TbbsDocAddItmInf tbbsDocAddItmInf : tbbsDocAddItmInfs) {
				count += update(tbbsDocAddItmInf);
			}
		}
		return count;		
	}

	/**
	 * @param tbbsDocAddItmInf TbbsDocAddItmInf
	 * @throws Exception
	 */
	public  int delete(TbbsDocAddItmInf tbbsDocAddItmInf)throws Exception {
		if(!isPrimaryKeyValid(tbbsDocAddItmInf)) {
			throw new PrimaryKeyNotSettedException("instance of TbbsDocAddItmInf can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TbbsDocAddItmInfTrx.delete", tbbsDocAddItmInf);
	}

	/**
	 * @param tbbsDocAddItmInfs TbbsDocAddItmInf[]
	 * @throws Exception
	 */
	public int deleteMany( TbbsDocAddItmInf... tbbsDocAddItmInfs) throws Exception {
		int count = 0;
		if (tbbsDocAddItmInfs != null) {
			for (TbbsDocAddItmInf tbbsDocAddItmInf : tbbsDocAddItmInfs) {
				count += delete(tbbsDocAddItmInf);
			}
		}
		return count;		
	}

}