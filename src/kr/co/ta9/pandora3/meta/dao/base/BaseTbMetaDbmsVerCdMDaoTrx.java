package kr.co.ta9.pandora3.meta.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaDbmsVerCdM;

/**
 * BaseTbMetaDbmsVerCdMDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TB_META_DBMS_VER_CD_M].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaDbmsVerCdMDaoTrx extends BaseDao {

	/**
	 * @param tbMetaDbmsVerCdM TbMetaDbmsVerCdM
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TbMetaDbmsVerCdM tbMetaDbmsVerCdM) {
		boolean result = true;
		if (tbMetaDbmsVerCdM == null) {
			result = false;
		}

		if (
			tbMetaDbmsVerCdM.getDbms_cd()== null
			||
			tbMetaDbmsVerCdM.getDbms_ver_val()== null
			||
			tbMetaDbmsVerCdM.getCmpny_cd()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tbMetaDbmsVerCdM TbMetaDbmsVerCdM
	 * @throws Exception
	 */
	public  int insert(TbMetaDbmsVerCdM tbMetaDbmsVerCdM) throws Exception {
		if(!isPrimaryKeyValid(tbMetaDbmsVerCdM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaDbmsVerCdM can't be null or Primary key is not set");
		}

		return getSqlSession().insert("TbMetaDbmsVerCdMTrx.insert", tbMetaDbmsVerCdM);
	}

	/**
	 * @param tbMetaDbmsVerCdMs TbMetaDbmsVerCdM[]
	 * @throws Exception
	 */
	public int insertMany(TbMetaDbmsVerCdM[] tbMetaDbmsVerCdMs) throws Exception {
		int count = 0;
		if (tbMetaDbmsVerCdMs != null) {
			for (TbMetaDbmsVerCdM tbMetaDbmsVerCdM : tbMetaDbmsVerCdMs) {
				count += insert(tbMetaDbmsVerCdM);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaDbmsVerCdM TbMetaDbmsVerCdM
	 * @throws Exception
	 */
	public  int update(TbMetaDbmsVerCdM tbMetaDbmsVerCdM) throws Exception {
		if(!isPrimaryKeyValid(tbMetaDbmsVerCdM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaDbmsVerCdM can't be null or Primary key is not set");
		}
		return getSqlSession().update("TbMetaDbmsVerCdMTrx.update", tbMetaDbmsVerCdM);
	}

	/**
	 * @param tbMetaDbmsVerCdMs TbMetaDbmsVerCdM[]
	 * @throws Exception
	 */
	public  int updateMany(TbMetaDbmsVerCdM[] tbMetaDbmsVerCdMs) throws Exception {
		 int count = 0;
		if (tbMetaDbmsVerCdMs != null) {
			for (TbMetaDbmsVerCdM tbMetaDbmsVerCdM : tbMetaDbmsVerCdMs) {
				count += update(tbMetaDbmsVerCdM);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaDbmsVerCdM TbMetaDbmsVerCdM
	 * @throws Exception
	 */
	public  int delete(TbMetaDbmsVerCdM tbMetaDbmsVerCdM)throws Exception {
		if(!isPrimaryKeyValid(tbMetaDbmsVerCdM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaDbmsVerCdM can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TbMetaDbmsVerCdMTrx.delete", tbMetaDbmsVerCdM);
	}

	/**
	 * @param tbMetaDbmsVerCdMs TbMetaDbmsVerCdM[]
	 * @throws Exception
	 */
	public Object deleteMany( TbMetaDbmsVerCdM[] tbMetaDbmsVerCdMs) throws Exception {
		int count = 0;
		if (tbMetaDbmsVerCdMs != null) {
			for (TbMetaDbmsVerCdM tbMetaDbmsVerCdM : tbMetaDbmsVerCdMs) {
				count += delete(tbMetaDbmsVerCdM);
			}
		}
		return count;		
	}

}