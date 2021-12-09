package kr.co.ta9.pandora3.meta.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaCmpnyWrkSysDbM;

/**
 * BaseTbMetaCmpnyWrkSysDbMDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TB_META_CMPNY_WRK_SYS_DB_M].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaCmpnyWrkSysDbMDaoTrx extends BaseDao {

	/**
	 * @param tbMetaCmpnyWrkSysDbM TbMetaCmpnyWrkSysDbM
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TbMetaCmpnyWrkSysDbM tbMetaCmpnyWrkSysDbM) {
		boolean result = true;
		if (tbMetaCmpnyWrkSysDbM == null) {
			result = false;
		}

		if (
			tbMetaCmpnyWrkSysDbM.getCmpny_cd()== null
			||
			tbMetaCmpnyWrkSysDbM.getDb_id()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tbMetaCmpnyWrkSysDbM TbMetaCmpnyWrkSysDbM
	 * @throws Exception
	 */
	public  int insert(TbMetaCmpnyWrkSysDbM tbMetaCmpnyWrkSysDbM) throws Exception {
		if(!isPrimaryKeyValid(tbMetaCmpnyWrkSysDbM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaCmpnyWrkSysDbM can't be null or Primary key is not set");
		}

		return getSqlSession().insert("TbMetaCmpnyWrkSysDbMTrx.insert", tbMetaCmpnyWrkSysDbM);
	}

	/**
	 * @param tbMetaCmpnyWrkSysDbMs TbMetaCmpnyWrkSysDbM[]
	 * @throws Exception
	 */
	public int insertMany(TbMetaCmpnyWrkSysDbM[] tbMetaCmpnyWrkSysDbMs) throws Exception {
		int count = 0;
		if (tbMetaCmpnyWrkSysDbMs != null) {
			for (TbMetaCmpnyWrkSysDbM tbMetaCmpnyWrkSysDbM : tbMetaCmpnyWrkSysDbMs) {
				count += insert(tbMetaCmpnyWrkSysDbM);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaCmpnyWrkSysDbM TbMetaCmpnyWrkSysDbM
	 * @throws Exception
	 */
	public  int update(TbMetaCmpnyWrkSysDbM tbMetaCmpnyWrkSysDbM) throws Exception {
		if(!isPrimaryKeyValid(tbMetaCmpnyWrkSysDbM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaCmpnyWrkSysDbM can't be null or Primary key is not set");
		}
		return getSqlSession().update("TbMetaCmpnyWrkSysDbMTrx.update", tbMetaCmpnyWrkSysDbM);
	}

	/**
	 * @param tbMetaCmpnyWrkSysDbMs TbMetaCmpnyWrkSysDbM[]
	 * @throws Exception
	 */
	public  int updateMany(TbMetaCmpnyWrkSysDbM[] tbMetaCmpnyWrkSysDbMs) throws Exception {
		 int count = 0;
		if (tbMetaCmpnyWrkSysDbMs != null) {
			for (TbMetaCmpnyWrkSysDbM tbMetaCmpnyWrkSysDbM : tbMetaCmpnyWrkSysDbMs) {
				count += update(tbMetaCmpnyWrkSysDbM);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaCmpnyWrkSysDbM TbMetaCmpnyWrkSysDbM
	 * @throws Exception
	 */
	public  int delete(TbMetaCmpnyWrkSysDbM tbMetaCmpnyWrkSysDbM)throws Exception {
		if(!isPrimaryKeyValid(tbMetaCmpnyWrkSysDbM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaCmpnyWrkSysDbM can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TbMetaCmpnyWrkSysDbMTrx.delete", tbMetaCmpnyWrkSysDbM);
	}

	/**
	 * @param tbMetaCmpnyWrkSysDbMs TbMetaCmpnyWrkSysDbM[]
	 * @throws Exception
	 */
	public Object deleteMany( TbMetaCmpnyWrkSysDbM[] tbMetaCmpnyWrkSysDbMs) throws Exception {
		int count = 0;
		if (tbMetaCmpnyWrkSysDbMs != null) {
			for (TbMetaCmpnyWrkSysDbM tbMetaCmpnyWrkSysDbM : tbMetaCmpnyWrkSysDbMs) {
				count += delete(tbMetaCmpnyWrkSysDbM);
			}
		}
		return count;		
	}

}