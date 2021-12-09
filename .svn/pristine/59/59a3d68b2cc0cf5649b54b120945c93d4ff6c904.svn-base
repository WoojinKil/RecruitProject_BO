package kr.co.ta9.pandora3.meta.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaTbTypCdM;

/**
 * BaseTbMetaTbTypCdMDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TB_META_TB_TYP_CD_M].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaTbTypCdMDaoTrx extends BaseDao {

	/**
	 * @param tbMetaTbTypCdM TbMetaTbTypCdM
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TbMetaTbTypCdM tbMetaTbTypCdM) {
		boolean result = true;
		if (tbMetaTbTypCdM == null) {
			result = false;
		}

		if (
			tbMetaTbTypCdM.getCmpny_cd()== null
			||
			tbMetaTbTypCdM.getTb_typ_gbcd()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tbMetaTbTypCdM TbMetaTbTypCdM
	 * @throws Exception
	 */
	public  int insert(TbMetaTbTypCdM tbMetaTbTypCdM) throws Exception {
		if(!isPrimaryKeyValid(tbMetaTbTypCdM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaTbTypCdM can't be null or Primary key is not set");
		}

		return getSqlSession().insert("TbMetaTbTypCdMTrx.insert", tbMetaTbTypCdM);
	}

	/**
	 * @param tbMetaTbTypCdMs TbMetaTbTypCdM[]
	 * @throws Exception
	 */
	public int insertMany(TbMetaTbTypCdM[] tbMetaTbTypCdMs) throws Exception {
		int count = 0;
		if (tbMetaTbTypCdMs != null) {
			for (TbMetaTbTypCdM tbMetaTbTypCdM : tbMetaTbTypCdMs) {
				count += insert(tbMetaTbTypCdM);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaTbTypCdM TbMetaTbTypCdM
	 * @throws Exception
	 */
	public  int update(TbMetaTbTypCdM tbMetaTbTypCdM) throws Exception {
		if(!isPrimaryKeyValid(tbMetaTbTypCdM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaTbTypCdM can't be null or Primary key is not set");
		}
		return getSqlSession().update("TbMetaTbTypCdMTrx.update", tbMetaTbTypCdM);
	}

	/**
	 * @param tbMetaTbTypCdMs TbMetaTbTypCdM[]
	 * @throws Exception
	 */
	public  int updateMany(TbMetaTbTypCdM[] tbMetaTbTypCdMs) throws Exception {
		 int count = 0;
		if (tbMetaTbTypCdMs != null) {
			for (TbMetaTbTypCdM tbMetaTbTypCdM : tbMetaTbTypCdMs) {
				count += update(tbMetaTbTypCdM);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaTbTypCdM TbMetaTbTypCdM
	 * @throws Exception
	 */
	public  int delete(TbMetaTbTypCdM tbMetaTbTypCdM)throws Exception {
		if(!isPrimaryKeyValid(tbMetaTbTypCdM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaTbTypCdM can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TbMetaTbTypCdMTrx.delete", tbMetaTbTypCdM);
	}

	/**
	 * @param tbMetaTbTypCdMs TbMetaTbTypCdM[]
	 * @throws Exception
	 */
	public Object deleteMany( TbMetaTbTypCdM[] tbMetaTbTypCdMs) throws Exception {
		int count = 0;
		if (tbMetaTbTypCdMs != null) {
			for (TbMetaTbTypCdM tbMetaTbTypCdM : tbMetaTbTypCdMs) {
				count += delete(tbMetaTbTypCdM);
			}
		}
		return count;		
	}

}