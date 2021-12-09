package kr.co.ta9.pandora3.meta.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaPjtUsrM;

/**
 * BaseTbMetaPjtUsrMDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TB_META_PJT_USR_M].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaPjtUsrMDaoTrx extends BaseDao {

	/**
	 * @param tbMetaPjtUsrM TbMetaPjtUsrM
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TbMetaPjtUsrM tbMetaPjtUsrM) {
		boolean result = true;
		if (tbMetaPjtUsrM == null) {
			result = false;
		}

		if (
			tbMetaPjtUsrM.getCmpny_cd()== null
			||
			tbMetaPjtUsrM.getPjt_cd()== null
			||
			tbMetaPjtUsrM.getStaf_empno()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tbMetaPjtUsrM TbMetaPjtUsrM
	 * @throws Exception
	 */
	public  int insert(TbMetaPjtUsrM tbMetaPjtUsrM) throws Exception {
		if(!isPrimaryKeyValid(tbMetaPjtUsrM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaPjtUsrM can't be null or Primary key is not set");
		}

		return getSqlSession().insert("TbMetaPjtUsrMTrx.insert", tbMetaPjtUsrM);
	}

	/**
	 * @param tbMetaPjtUsrMs TbMetaPjtUsrM[]
	 * @throws Exception
	 */
	public int insertMany(TbMetaPjtUsrM[] tbMetaPjtUsrMs) throws Exception {
		int count = 0;
		if (tbMetaPjtUsrMs != null) {
			for (TbMetaPjtUsrM tbMetaPjtUsrM : tbMetaPjtUsrMs) {
				count += insert(tbMetaPjtUsrM);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaPjtUsrM TbMetaPjtUsrM
	 * @throws Exception
	 */
	public  int update(TbMetaPjtUsrM tbMetaPjtUsrM) throws Exception {
		if(!isPrimaryKeyValid(tbMetaPjtUsrM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaPjtUsrM can't be null or Primary key is not set");
		}
		return getSqlSession().update("TbMetaPjtUsrMTrx.update", tbMetaPjtUsrM);
	}

	/**
	 * @param tbMetaPjtUsrMs TbMetaPjtUsrM[]
	 * @throws Exception
	 */
	public  int updateMany(TbMetaPjtUsrM[] tbMetaPjtUsrMs) throws Exception {
		 int count = 0;
		if (tbMetaPjtUsrMs != null) {
			for (TbMetaPjtUsrM tbMetaPjtUsrM : tbMetaPjtUsrMs) {
				count += update(tbMetaPjtUsrM);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaPjtUsrM TbMetaPjtUsrM
	 * @throws Exception
	 */
	public  int delete(TbMetaPjtUsrM tbMetaPjtUsrM)throws Exception {
		if(!isPrimaryKeyValid(tbMetaPjtUsrM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaPjtUsrM can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TbMetaPjtUsrMTrx.delete", tbMetaPjtUsrM);
	}

	/**
	 * @param tbMetaPjtUsrMs TbMetaPjtUsrM[]
	 * @throws Exception
	 */
	public Object deleteMany( TbMetaPjtUsrM[] tbMetaPjtUsrMs) throws Exception {
		int count = 0;
		if (tbMetaPjtUsrMs != null) {
			for (TbMetaPjtUsrM tbMetaPjtUsrM : tbMetaPjtUsrMs) {
				count += delete(tbMetaPjtUsrM);
			}
		}
		return count;		
	}

}