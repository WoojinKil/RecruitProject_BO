package kr.co.ta9.pandora3.pbbs.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TmbrPtnrInf;

/**
 * BaseTmbrPtnrInfDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TMBR_PTNR_INF].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class BaseTmbrPtnrInfDaoTrx extends BaseDao {

	/**
	 * @param tmbrPtnrInf TmbrPtnrInf
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TmbrPtnrInf tmbrPtnrInf) {
		boolean result = true;
		if (tmbrPtnrInf == null) {
			result = false;
		}

		if (
			tmbrPtnrInf.getObj_ptnr_seq()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tmbrPtnrInf TmbrPtnrInf
	 * @throws Exception
	 */
	public  int insert(TmbrPtnrInf tmbrPtnrInf) throws Exception {
		return getSqlSession().insert("TmbrPtnrInfTrx.insert", tmbrPtnrInf);
	}

	/**
	 * @param tmbrPtnrInfs TmbrPtnrInf[]
	 * @throws Exception
	 */
	public int insertMany(TmbrPtnrInf... tmbrPtnrInfs) throws Exception {
		int count = 0;
		if (tmbrPtnrInfs != null) {
			for (TmbrPtnrInf tmbrPtnrInf : tmbrPtnrInfs) {
				count += insert(tmbrPtnrInf);
			}
		}
		return count;		
	}

	/**
	 * @param tmbrPtnrInf TmbrPtnrInf
	 * @throws Exception
	 */
	public  int update(TmbrPtnrInf tmbrPtnrInf) throws Exception {
		if(!isPrimaryKeyValid(tmbrPtnrInf)) {
			throw new PrimaryKeyNotSettedException("instance of TmbrPtnrInf can't be null or Primary key is not set");
		}
		return getSqlSession().update("TmbrPtnrInfTrx.update", tmbrPtnrInf);
	}

	/**
	 * @param tmbrPtnrInfs TmbrPtnrInf[]
	 * @throws Exception
	 */
	public  int updateMany(TmbrPtnrInf... tmbrPtnrInfs) throws Exception {
		 int count = 0;
		if (tmbrPtnrInfs != null) {
			for (TmbrPtnrInf tmbrPtnrInf : tmbrPtnrInfs) {
				count += update(tmbrPtnrInf);
			}
		}
		return count;		
	}

	/**
	 * @param tmbrPtnrInf TmbrPtnrInf
	 * @throws Exception
	 */
	public  int delete(TmbrPtnrInf tmbrPtnrInf)throws Exception {
		if(!isPrimaryKeyValid(tmbrPtnrInf)) {
			throw new PrimaryKeyNotSettedException("instance of TmbrPtnrInf can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TmbrPtnrInfTrx.delete", tmbrPtnrInf);
	}

	/**
	 * @param tmbrPtnrInfs TmbrPtnrInf[]
	 * @throws Exception
	 */
	public int deleteMany( TmbrPtnrInf... tmbrPtnrInfs) throws Exception {
		int count = 0;
		if (tmbrPtnrInfs != null) {
			for (TmbrPtnrInf tmbrPtnrInf : tmbrPtnrInfs) {
				count += delete(tmbrPtnrInf);
			}
		}
		return count;		
	}

}