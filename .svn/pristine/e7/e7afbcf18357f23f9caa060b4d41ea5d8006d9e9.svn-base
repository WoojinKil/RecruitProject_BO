package kr.co.ta9.pandora3.psys.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmOrgGrpRolRtnn;

/**
 * BaseTsysAdmOrgGrpRolRtnnDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TSYS_ADM_ORG_GRP_ROL_RTNN].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 10. 29
 */
@Repository
public class BaseTsysAdmOrgGrpRolRtnnDaoTrx extends BaseDao {

	/**
	 * @param tsysAdmOrgGrpRolRtnn TsysAdmOrgGrpRolRtnn
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TsysAdmOrgGrpRolRtnn tsysAdmOrgGrpRolRtnn) {
		boolean result = true;
		if (tsysAdmOrgGrpRolRtnn == null) {
			result = false;
		}

		if (
			tsysAdmOrgGrpRolRtnn.getGrp_rol_id()== null
			||
			tsysAdmOrgGrpRolRtnn.getHr_org_cd()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tsysAdmOrgGrpRolRtnn TsysAdmOrgGrpRolRtnn
	 * @throws Exception
	 */
	public  int insert(TsysAdmOrgGrpRolRtnn tsysAdmOrgGrpRolRtnn) throws Exception {
		if(!isPrimaryKeyValid(tsysAdmOrgGrpRolRtnn)) {
			throw new PrimaryKeyNotSettedException("instance of TsysAdmOrgGrpRolRtnn can't be null or Primary key is not set");
		}

		return getSqlSession().insert("TsysAdmOrgGrpRolRtnnTrx.insert", tsysAdmOrgGrpRolRtnn);
	}

	/**
	 * @param tsysAdmOrgGrpRolRtnns TsysAdmOrgGrpRolRtnn...
	 * @throws Exception
	 */
	public int insertMany(TsysAdmOrgGrpRolRtnn... tsysAdmOrgGrpRolRtnns) throws Exception {
		int count = 0;
		if (tsysAdmOrgGrpRolRtnns != null) {
			for (TsysAdmOrgGrpRolRtnn tsysAdmOrgGrpRolRtnn : tsysAdmOrgGrpRolRtnns) {
				count += insert(tsysAdmOrgGrpRolRtnn);
			}
		}
		return count;		
	}

	/**
	 * @param tsysAdmOrgGrpRolRtnn TsysAdmOrgGrpRolRtnn
	 * @throws Exception
	 */
	public  int update(TsysAdmOrgGrpRolRtnn tsysAdmOrgGrpRolRtnn) throws Exception {
		if(!isPrimaryKeyValid(tsysAdmOrgGrpRolRtnn)) {
			throw new PrimaryKeyNotSettedException("instance of TsysAdmOrgGrpRolRtnn can't be null or Primary key is not set");
		}
		return getSqlSession().update("TsysAdmOrgGrpRolRtnnTrx.update", tsysAdmOrgGrpRolRtnn);
	}

	/**
	 * @param tsysAdmOrgGrpRolRtnns TsysAdmOrgGrpRolRtnn...
	 * @throws Exception
	 */
	public  int updateMany(TsysAdmOrgGrpRolRtnn... tsysAdmOrgGrpRolRtnns) throws Exception {
		 int count = 0;
		if (tsysAdmOrgGrpRolRtnns != null) {
			for (TsysAdmOrgGrpRolRtnn tsysAdmOrgGrpRolRtnn : tsysAdmOrgGrpRolRtnns) {
				count += update(tsysAdmOrgGrpRolRtnn);
			}
		}
		return count;		
	}

	/**
	 * @param tsysAdmOrgGrpRolRtnn TsysAdmOrgGrpRolRtnn
	 * @throws Exception
	 */
	public  int delete(TsysAdmOrgGrpRolRtnn tsysAdmOrgGrpRolRtnn)throws Exception {
		if(!isPrimaryKeyValid(tsysAdmOrgGrpRolRtnn)) {
			throw new PrimaryKeyNotSettedException("instance of TsysAdmOrgGrpRolRtnn can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TsysAdmOrgGrpRolRtnnTrx.delete", tsysAdmOrgGrpRolRtnn);
	}

	/**
	 * @param tsysAdmOrgGrpRolRtnns TsysAdmOrgGrpRolRtnn...
	 * @throws Exception
	 */
	public Object deleteMany( TsysAdmOrgGrpRolRtnn... tsysAdmOrgGrpRolRtnns) throws Exception {
		int count = 0;
		if (tsysAdmOrgGrpRolRtnns != null) {
			for (TsysAdmOrgGrpRolRtnn tsysAdmOrgGrpRolRtnn : tsysAdmOrgGrpRolRtnns) {
				count += delete(tsysAdmOrgGrpRolRtnn);
			}
		}
		return count;		
	}

}