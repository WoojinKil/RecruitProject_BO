package kr.co.ta9.pandora3.meta.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaDbmsDataTypCdM;

/**
 * BaseTbMetaDbmsDataTypCdMDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TB_META_DBMS_DATA_TYP_CD_M].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaDbmsDataTypCdMDaoTrx extends BaseDao {

	/**
	 * @param tbMetaDbmsDataTypCdM TbMetaDbmsDataTypCdM
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TbMetaDbmsDataTypCdM tbMetaDbmsDataTypCdM) {
		boolean result = true;
		if (tbMetaDbmsDataTypCdM == null) {
			result = false;
		}

		if (
			tbMetaDbmsDataTypCdM.getData_typ_cd()== null
			||
			tbMetaDbmsDataTypCdM.getDbms_cd()== null
			||
			tbMetaDbmsDataTypCdM.getCmpny_cd()== null
			||
			tbMetaDbmsDataTypCdM.getDbms_ver_val()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tbMetaDbmsDataTypCdM TbMetaDbmsDataTypCdM
	 * @throws Exception
	 */
	public  int insert(TbMetaDbmsDataTypCdM tbMetaDbmsDataTypCdM) throws Exception {
		if(!isPrimaryKeyValid(tbMetaDbmsDataTypCdM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaDbmsDataTypCdM can't be null or Primary key is not set");
		}

		return getSqlSession().insert("TbMetaDbmsDataTypCdMTrx.insert", tbMetaDbmsDataTypCdM);
	}

	/**
	 * @param tbMetaDbmsDataTypCdMs TbMetaDbmsDataTypCdM[]
	 * @throws Exception
	 */
	public int insertMany(TbMetaDbmsDataTypCdM[] tbMetaDbmsDataTypCdMs) throws Exception {
		int count = 0;
		if (tbMetaDbmsDataTypCdMs != null) {
			for (TbMetaDbmsDataTypCdM tbMetaDbmsDataTypCdM : tbMetaDbmsDataTypCdMs) {
				count += insert(tbMetaDbmsDataTypCdM);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaDbmsDataTypCdM TbMetaDbmsDataTypCdM
	 * @throws Exception
	 */
	public  int update(TbMetaDbmsDataTypCdM tbMetaDbmsDataTypCdM) throws Exception {
		if(!isPrimaryKeyValid(tbMetaDbmsDataTypCdM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaDbmsDataTypCdM can't be null or Primary key is not set");
		}
		return getSqlSession().update("TbMetaDbmsDataTypCdMTrx.update", tbMetaDbmsDataTypCdM);
	}

	/**
	 * @param tbMetaDbmsDataTypCdMs TbMetaDbmsDataTypCdM[]
	 * @throws Exception
	 */
	public  int updateMany(TbMetaDbmsDataTypCdM[] tbMetaDbmsDataTypCdMs) throws Exception {
		 int count = 0;
		if (tbMetaDbmsDataTypCdMs != null) {
			for (TbMetaDbmsDataTypCdM tbMetaDbmsDataTypCdM : tbMetaDbmsDataTypCdMs) {
				count += update(tbMetaDbmsDataTypCdM);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaDbmsDataTypCdM TbMetaDbmsDataTypCdM
	 * @throws Exception
	 */
	public  int delete(TbMetaDbmsDataTypCdM tbMetaDbmsDataTypCdM)throws Exception {
		if(!isPrimaryKeyValid(tbMetaDbmsDataTypCdM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaDbmsDataTypCdM can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TbMetaDbmsDataTypCdMTrx.delete", tbMetaDbmsDataTypCdM);
	}

	/**
	 * @param tbMetaDbmsDataTypCdMs TbMetaDbmsDataTypCdM[]
	 * @throws Exception
	 */
	public Object deleteMany( TbMetaDbmsDataTypCdM[] tbMetaDbmsDataTypCdMs) throws Exception {
		int count = 0;
		if (tbMetaDbmsDataTypCdMs != null) {
			for (TbMetaDbmsDataTypCdM tbMetaDbmsDataTypCdM : tbMetaDbmsDataTypCdMs) {
				count += delete(tbMetaDbmsDataTypCdM);
			}
		}
		return count;		
	}

}