package kr.co.ta9.pandora3.meta.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaPjtM;

/**
 * BaseTbMetaPjtMDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TB_META_PJT_M].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaPjtMDaoTrx extends BaseDao {

	/**
	 * @param tbMetaPjtM TbMetaPjtM
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TbMetaPjtM tbMetaPjtM) {
		boolean result = true;
		if (tbMetaPjtM == null) {
			result = false;
		}

		if (
			tbMetaPjtM.getCmpny_cd()== null
			||
			tbMetaPjtM.getPjt_cd()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tbMetaPjtM TbMetaPjtM
	 * @throws Exception
	 */
	public  int insert(TbMetaPjtM tbMetaPjtM) throws Exception {
		if(!isPrimaryKeyValid(tbMetaPjtM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaPjtM can't be null or Primary key is not set");
		}

		return getSqlSession().insert("TbMetaPjtMTrx.insert", tbMetaPjtM);
	}

	/**
	 * @param tbMetaPjtMs TbMetaPjtM[]
	 * @throws Exception
	 */
	public int insertMany(TbMetaPjtM[] tbMetaPjtMs) throws Exception {
		int count = 0;
		if (tbMetaPjtMs != null) {
			for (TbMetaPjtM tbMetaPjtM : tbMetaPjtMs) {
				count += insert(tbMetaPjtM);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaPjtM TbMetaPjtM
	 * @throws Exception
	 */
	public  int update(TbMetaPjtM tbMetaPjtM) throws Exception {
		if(!isPrimaryKeyValid(tbMetaPjtM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaPjtM can't be null or Primary key is not set");
		}
		return getSqlSession().update("TbMetaPjtMTrx.update", tbMetaPjtM);
	}

	/**
	 * @param tbMetaPjtMs TbMetaPjtM[]
	 * @throws Exception
	 */
	public  int updateMany(TbMetaPjtM[] tbMetaPjtMs) throws Exception {
		 int count = 0;
		if (tbMetaPjtMs != null) {
			for (TbMetaPjtM tbMetaPjtM : tbMetaPjtMs) {
				count += update(tbMetaPjtM);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaPjtM TbMetaPjtM
	 * @throws Exception
	 */
	public  int delete(TbMetaPjtM tbMetaPjtM)throws Exception {
		if(!isPrimaryKeyValid(tbMetaPjtM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaPjtM can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TbMetaPjtMTrx.delete", tbMetaPjtM);
	}

	/**
	 * @param tbMetaPjtMs TbMetaPjtM[]
	 * @throws Exception
	 */
	public Object deleteMany( TbMetaPjtM[] tbMetaPjtMs) throws Exception {
		int count = 0;
		if (tbMetaPjtMs != null) {
			for (TbMetaPjtM tbMetaPjtM : tbMetaPjtMs) {
				count += delete(tbMetaPjtM);
			}
		}
		return count;		
	}

}