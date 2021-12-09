package kr.co.ta9.pandora3.psys.dao.base;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TsysOrgRolRtnn;

/**
 * BaseTsysOrgRolRtnnDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TSYS_ORG_ROL_RTNN].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 03. 22
 */
@Repository
public abstract class BaseTsysOrgRolRtnnDaoTrx extends BaseDao {

	/**
	 * @param tsysOrgRolRtnn TsysOrgRolRtnn
	 * @return boolean
	 */
	public final boolean isPrimaryKeyValid(TsysOrgRolRtnn tsysOrgRolRtnn){
		boolean result = true;
		if (tsysOrgRolRtnn == null){
			result = false;
		}

		if (
			tsysOrgRolRtnn.getHr_org_cd()== null ||
			tsysOrgRolRtnn.getRol_id()== null
			){
			result = false;
		}
		return result;
	}

	/**
	 * @param tsysOrgRolRtnn TsysOrgRolRtnn
	 * @throws DataAccessException
	 */
	public  int insert(TsysOrgRolRtnn tsysOrgRolRtnn) throws DataAccessException {
		if(!isPrimaryKeyValid(tsysOrgRolRtnn)){
			throw new PrimaryKeyNotSettedException("instance of TsysOrgRolRtnn can't be null or Primary key is not set");
		}

		return getSqlSession().insert("TsysOrgRolRtnnTrx.insert", tsysOrgRolRtnn);
	}

	/**
	 * @param tsysOrgRolRtnns TsysOrgRolRtnn...
	 * @throws DataAccessException
	 */
	public int insertMany(final TsysOrgRolRtnn... tsysOrgRolRtnns) throws DataAccessException {
		int count = 0;
		if (tsysOrgRolRtnns != null) {
			for (TsysOrgRolRtnn tsysOrgRolRtnn : tsysOrgRolRtnns) {
				count += insert(tsysOrgRolRtnn);
			}
		}
		return count;		
	}

	/**
	 * @param tsysOrgRolRtnn TsysOrgRolRtnn
	 * @throws DataAccessException
	 */
	public  int update(TsysOrgRolRtnn tsysOrgRolRtnn) throws DataAccessException {
		if(!isPrimaryKeyValid(tsysOrgRolRtnn)){
			throw new PrimaryKeyNotSettedException("instance of TsysOrgRolRtnn can't be null or Primary key is not set");
		}
		return getSqlSession().update("TsysOrgRolRtnnTrx.update", tsysOrgRolRtnn);
	}

	/**
	 * @param tsysOrgRolRtnns TsysOrgRolRtnn...
	 * @throws DataAccessException
	 */
	public  int updateMany(TsysOrgRolRtnn... tsysOrgRolRtnns) throws DataAccessException {
		 int count = 0;
		if (tsysOrgRolRtnns != null) {
			for (TsysOrgRolRtnn tsysOrgRolRtnn : tsysOrgRolRtnns) {
				count += update(tsysOrgRolRtnn);
			}
		}
		return count;		
	}

	/**
	 * @param tsysOrgRolRtnn TsysOrgRolRtnn
	 * @throws DataAccessException
	 */
	public  int delete(TsysOrgRolRtnn tsysOrgRolRtnn)throws DataAccessException {
		if(!isPrimaryKeyValid(tsysOrgRolRtnn)){
			throw new PrimaryKeyNotSettedException("instance of TsysOrgRolRtnn can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TsysOrgRolRtnnTrx.delete", tsysOrgRolRtnn);
	}

	/**
	 * @param tsysOrgRolRtnns TsysOrgRolRtnn...
	 * @throws DataAccessException
	 */
	public final Object deleteMany( TsysOrgRolRtnn... tsysOrgRolRtnns) throws DataAccessException {
		int count = 0;
		if (tsysOrgRolRtnns != null) {
			for (TsysOrgRolRtnn tsysOrgRolRtnn : tsysOrgRolRtnns) {
				count += delete(tsysOrgRolRtnn);
			}
		}
		return count;		
	}

}