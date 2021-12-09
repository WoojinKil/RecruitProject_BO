package kr.co.ta9.pandora3.psys.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TsysUsrRol;

/**
 * BaseTsysUsrRolDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TSYS_USR_ROL].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class BaseTsysUsrRolDaoTrx extends BaseDao {

	/**
	 * @param tsysUsrRol TsysUsrRol
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TsysUsrRol tsysUsrRol) {
		boolean result = true;
		if (tsysUsrRol == null) {
			result = false;
		}

		if (
			tsysUsrRol.getRol_id()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tsysUsrRol TsysUsrRol
	 * @throws Exception
	 */
	public  int insert(TsysUsrRol tsysUsrRol) throws Exception {
		if(!isPrimaryKeyValid(tsysUsrRol)) {
			throw new PrimaryKeyNotSettedException("instance of TsysUsrRol can't be null or Primary key is not set");
		}

		return getSqlSession().insert("TsysUsrRolTrx.insert", tsysUsrRol);
	}

	/**
	 * @param tsysUsrRols TsysUsrRol...
	 * @throws Exception
	 */
	public int insertMany(TsysUsrRol... tsysUsrRols) throws Exception {
		int count = 0;
		if (tsysUsrRols != null) {
			for (TsysUsrRol tsysUsrRol : tsysUsrRols) {
				count += insert(tsysUsrRol);
			}
		}
		return count;		
	}

	/**
	 * @param tsysUsrRol TsysUsrRol
	 * @throws Exception
	 */
	public  int update(TsysUsrRol tsysUsrRol) throws Exception {
		if(!isPrimaryKeyValid(tsysUsrRol)) {
			throw new PrimaryKeyNotSettedException("instance of TsysUsrRol can't be null or Primary key is not set");
		}
		return getSqlSession().update("TsysUsrRolTrx.update", tsysUsrRol);
	}

	/**
	 * @param tsysUsrRols TsysUsrRol...
	 * @throws Exception
	 */
	public  int updateMany(TsysUsrRol... tsysUsrRols) throws Exception {
		 int count = 0;
		if (tsysUsrRols != null) {
			for (TsysUsrRol tsysUsrRol : tsysUsrRols) {
				count += update(tsysUsrRol);
			}
		}
		return count;		
	}

	/**
	 * @param tsysUsrRol TsysUsrRol
	 * @throws Exception
	 */
	public  int delete(TsysUsrRol tsysUsrRol)throws Exception {
		if(!isPrimaryKeyValid(tsysUsrRol)) {
			throw new PrimaryKeyNotSettedException("instance of TsysUsrRol can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TsysUsrRolTrx.delete", tsysUsrRol);
	}

	/**
	 * @param tsysUsrRols TsysUsrRol...
	 * @throws Exception
	 */
	public int deleteMany( TsysUsrRol... tsysUsrRols) throws Exception {
		int count = 0;
		if (tsysUsrRols != null) {
			for (TsysUsrRol tsysUsrRol : tsysUsrRols) {
				count += delete(tsysUsrRol);
			}
		}
		return count;		
	}

}