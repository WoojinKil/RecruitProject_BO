package kr.co.ta9.pandora3.meta.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaCmpnyWrkSysM;

/**
 * BaseTbMetaCmpnyWrkSysMDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TB_META_CMPNY_WRK_SYS_M].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaCmpnyWrkSysMDaoTrx extends BaseDao {

	/**
	 * @param tbMetaCmpnyWrkSysM TbMetaCmpnyWrkSysM
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TbMetaCmpnyWrkSysM tbMetaCmpnyWrkSysM) {
		boolean result = true;
		if (tbMetaCmpnyWrkSysM == null) {
			result = false;
		}

		if (
			tbMetaCmpnyWrkSysM.getCmpny_cd()== null
			||
			tbMetaCmpnyWrkSysM.getSys_cd()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tbMetaCmpnyWrkSysM TbMetaCmpnyWrkSysM
	 * @throws Exception
	 */
	public  int insert(TbMetaCmpnyWrkSysM tbMetaCmpnyWrkSysM) throws Exception {
		if(!isPrimaryKeyValid(tbMetaCmpnyWrkSysM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaCmpnyWrkSysM can't be null or Primary key is not set");
		}

		return getSqlSession().insert("TbMetaCmpnyWrkSysMTrx.insert", tbMetaCmpnyWrkSysM);
	}

	/**
	 * @param tbMetaCmpnyWrkSysMs TbMetaCmpnyWrkSysM[]
	 * @throws Exception
	 */
	public int insertMany(TbMetaCmpnyWrkSysM[] tbMetaCmpnyWrkSysMs) throws Exception {
		int count = 0;
		if (tbMetaCmpnyWrkSysMs != null) {
			for (TbMetaCmpnyWrkSysM tbMetaCmpnyWrkSysM : tbMetaCmpnyWrkSysMs) {
				count += insert(tbMetaCmpnyWrkSysM);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaCmpnyWrkSysM TbMetaCmpnyWrkSysM
	 * @throws Exception
	 */
	public  int update(TbMetaCmpnyWrkSysM tbMetaCmpnyWrkSysM) throws Exception {
		if(!isPrimaryKeyValid(tbMetaCmpnyWrkSysM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaCmpnyWrkSysM can't be null or Primary key is not set");
		}
		return getSqlSession().update("TbMetaCmpnyWrkSysMTrx.update", tbMetaCmpnyWrkSysM);
	}

	/**
	 * @param tbMetaCmpnyWrkSysMs TbMetaCmpnyWrkSysM[]
	 * @throws Exception
	 */
	public  int updateMany(TbMetaCmpnyWrkSysM[] tbMetaCmpnyWrkSysMs) throws Exception {
		 int count = 0;
		if (tbMetaCmpnyWrkSysMs != null) {
			for (TbMetaCmpnyWrkSysM tbMetaCmpnyWrkSysM : tbMetaCmpnyWrkSysMs) {
				count += update(tbMetaCmpnyWrkSysM);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaCmpnyWrkSysM TbMetaCmpnyWrkSysM
	 * @throws Exception
	 */
	public  int delete(TbMetaCmpnyWrkSysM tbMetaCmpnyWrkSysM)throws Exception {
		if(!isPrimaryKeyValid(tbMetaCmpnyWrkSysM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaCmpnyWrkSysM can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TbMetaCmpnyWrkSysMTrx.delete", tbMetaCmpnyWrkSysM);
	}

	/**
	 * @param tbMetaCmpnyWrkSysMs TbMetaCmpnyWrkSysM[]
	 * @throws Exception
	 */
	public Object deleteMany( TbMetaCmpnyWrkSysM[] tbMetaCmpnyWrkSysMs) throws Exception {
		int count = 0;
		if (tbMetaCmpnyWrkSysMs != null) {
			for (TbMetaCmpnyWrkSysM tbMetaCmpnyWrkSysM : tbMetaCmpnyWrkSysMs) {
				count += delete(tbMetaCmpnyWrkSysM);
			}
		}
		return count;		
	}

}