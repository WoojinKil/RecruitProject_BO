package kr.co.ta9.pandora3.meta.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaDbmsCdM;

/**
 * BaseTbMetaDbmsCdMDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TB_META_DBMS_CD_M].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaDbmsCdMDaoTrx extends BaseDao {

	/**
	 * @param tbMetaDbmsCdM TbMetaDbmsCdM
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TbMetaDbmsCdM tbMetaDbmsCdM) {
		boolean result = true;
		if (tbMetaDbmsCdM == null) {
			result = false;
		}

		if (
			tbMetaDbmsCdM.getDbms_cd()== null
			||
			tbMetaDbmsCdM.getCmpny_cd()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tbMetaDbmsCdM TbMetaDbmsCdM
	 * @throws Exception
	 */
	public  int insert(TbMetaDbmsCdM tbMetaDbmsCdM) throws Exception {
		if(!isPrimaryKeyValid(tbMetaDbmsCdM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaDbmsCdM can't be null or Primary key is not set");
		}

		return getSqlSession().insert("TbMetaDbmsCdMTrx.insert", tbMetaDbmsCdM);
	}

	/**
	 * @param tbMetaDbmsCdMs TbMetaDbmsCdM[]
	 * @throws Exception
	 */
	public int insertMany(TbMetaDbmsCdM[] tbMetaDbmsCdMs) throws Exception {
		int count = 0;
		if (tbMetaDbmsCdMs != null) {
			for (TbMetaDbmsCdM tbMetaDbmsCdM : tbMetaDbmsCdMs) {
				count += insert(tbMetaDbmsCdM);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaDbmsCdM TbMetaDbmsCdM
	 * @throws Exception
	 */
	public  int update(TbMetaDbmsCdM tbMetaDbmsCdM) throws Exception {
		if(!isPrimaryKeyValid(tbMetaDbmsCdM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaDbmsCdM can't be null or Primary key is not set");
		}
		return getSqlSession().update("TbMetaDbmsCdMTrx.update", tbMetaDbmsCdM);
	}

	/**
	 * @param tbMetaDbmsCdMs TbMetaDbmsCdM[]
	 * @throws Exception
	 */
	public  int updateMany(TbMetaDbmsCdM[] tbMetaDbmsCdMs) throws Exception {
		 int count = 0;
		if (tbMetaDbmsCdMs != null) {
			for (TbMetaDbmsCdM tbMetaDbmsCdM : tbMetaDbmsCdMs) {
				count += update(tbMetaDbmsCdM);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaDbmsCdM TbMetaDbmsCdM
	 * @throws Exception
	 */
	public  int delete(TbMetaDbmsCdM tbMetaDbmsCdM)throws Exception {
		if(!isPrimaryKeyValid(tbMetaDbmsCdM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaDbmsCdM can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TbMetaDbmsCdMTrx.delete", tbMetaDbmsCdM);
	}

	/**
	 * @param tbMetaDbmsCdMs TbMetaDbmsCdM[]
	 * @throws Exception
	 */
	public Object deleteMany( TbMetaDbmsCdM[] tbMetaDbmsCdMs) throws Exception {
		int count = 0;
		if (tbMetaDbmsCdMs != null) {
			for (TbMetaDbmsCdM tbMetaDbmsCdM : tbMetaDbmsCdMs) {
				count += delete(tbMetaDbmsCdM);
			}
		}
		return count;		
	}

}