package kr.co.ta9.pandora3.meta.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaObjCdM;

/**
 * BaseTbMetaObjCdMDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TB_META_OBJ_CD_M].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaObjCdMDaoTrx extends BaseDao {

	/**
	 * @param tbMetaObjCdM TbMetaObjCdM
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TbMetaObjCdM tbMetaObjCdM) {
		boolean result = true;
		if (tbMetaObjCdM == null) {
			result = false;
		}

		if (
			tbMetaObjCdM.getCmpny_cd()== null
			||
			tbMetaObjCdM.getObj_gbcd()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tbMetaObjCdM TbMetaObjCdM
	 * @throws Exception
	 */
	public  int insert(TbMetaObjCdM tbMetaObjCdM) throws Exception {
		if(!isPrimaryKeyValid(tbMetaObjCdM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaObjCdM can't be null or Primary key is not set");
		}

		return getSqlSession().insert("TbMetaObjCdMTrx.insert", tbMetaObjCdM);
	}

	/**
	 * @param tbMetaObjCdMs TbMetaObjCdM[]
	 * @throws Exception
	 */
	public int insertMany(TbMetaObjCdM[] tbMetaObjCdMs) throws Exception {
		int count = 0;
		if (tbMetaObjCdMs != null) {
			for (TbMetaObjCdM tbMetaObjCdM : tbMetaObjCdMs) {
				count += insert(tbMetaObjCdM);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaObjCdM TbMetaObjCdM
	 * @throws Exception
	 */
	public  int update(TbMetaObjCdM tbMetaObjCdM) throws Exception {
		if(!isPrimaryKeyValid(tbMetaObjCdM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaObjCdM can't be null or Primary key is not set");
		}
		return getSqlSession().update("TbMetaObjCdMTrx.update", tbMetaObjCdM);
	}

	/**
	 * @param tbMetaObjCdMs TbMetaObjCdM[]
	 * @throws Exception
	 */
	public  int updateMany(TbMetaObjCdM[] tbMetaObjCdMs) throws Exception {
		 int count = 0;
		if (tbMetaObjCdMs != null) {
			for (TbMetaObjCdM tbMetaObjCdM : tbMetaObjCdMs) {
				count += update(tbMetaObjCdM);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaObjCdM TbMetaObjCdM
	 * @throws Exception
	 */
	public  int delete(TbMetaObjCdM tbMetaObjCdM)throws Exception {
		if(!isPrimaryKeyValid(tbMetaObjCdM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaObjCdM can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TbMetaObjCdMTrx.delete", tbMetaObjCdM);
	}

	/**
	 * @param tbMetaObjCdMs TbMetaObjCdM[]
	 * @throws Exception
	 */
	public Object deleteMany( TbMetaObjCdM[] tbMetaObjCdMs) throws Exception {
		int count = 0;
		if (tbMetaObjCdMs != null) {
			for (TbMetaObjCdM tbMetaObjCdM : tbMetaObjCdMs) {
				count += delete(tbMetaObjCdM);
			}
		}
		return count;		
	}

}