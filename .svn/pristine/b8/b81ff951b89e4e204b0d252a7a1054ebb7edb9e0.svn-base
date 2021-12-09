package kr.co.ta9.pandora3.meta.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaCmpnySvrM;

/**
 * BaseTbMetaCmpnySvrMDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TB_META_CMPNY_SVR_M].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaCmpnySvrMDaoTrx extends BaseDao {

	/**
	 * @param tbMetaCmpnySvrM TbMetaCmpnySvrM
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TbMetaCmpnySvrM tbMetaCmpnySvrM) {
		boolean result = true;
		if (tbMetaCmpnySvrM == null) {
			result = false;
		}

		if (
			tbMetaCmpnySvrM.getCmpny_cd()== null
			||
			tbMetaCmpnySvrM.getSvr_host_cd()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tbMetaCmpnySvrM TbMetaCmpnySvrM
	 * @throws Exception
	 */
	public  int insert(TbMetaCmpnySvrM tbMetaCmpnySvrM) throws Exception {
		if(!isPrimaryKeyValid(tbMetaCmpnySvrM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaCmpnySvrM can't be null or Primary key is not set");
		}

		return getSqlSession().insert("TbMetaCmpnySvrMTrx.insert", tbMetaCmpnySvrM);
	}

	/**
	 * @param tbMetaCmpnySvrMs TbMetaCmpnySvrM[]
	 * @throws Exception
	 */
	public int insertMany(TbMetaCmpnySvrM[] tbMetaCmpnySvrMs) throws Exception {
		int count = 0;
		if (tbMetaCmpnySvrMs != null) {
			for (TbMetaCmpnySvrM tbMetaCmpnySvrM : tbMetaCmpnySvrMs) {
				count += insert(tbMetaCmpnySvrM);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaCmpnySvrM TbMetaCmpnySvrM
	 * @throws Exception
	 */
	public  int update(TbMetaCmpnySvrM tbMetaCmpnySvrM) throws Exception {
		if(!isPrimaryKeyValid(tbMetaCmpnySvrM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaCmpnySvrM can't be null or Primary key is not set");
		}
		return getSqlSession().update("TbMetaCmpnySvrMTrx.update", tbMetaCmpnySvrM);
	}

	/**
	 * @param tbMetaCmpnySvrMs TbMetaCmpnySvrM[]
	 * @throws Exception
	 */
	public  int updateMany(TbMetaCmpnySvrM[] tbMetaCmpnySvrMs) throws Exception {
		 int count = 0;
		if (tbMetaCmpnySvrMs != null) {
			for (TbMetaCmpnySvrM tbMetaCmpnySvrM : tbMetaCmpnySvrMs) {
				count += update(tbMetaCmpnySvrM);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaCmpnySvrM TbMetaCmpnySvrM
	 * @throws Exception
	 */
	public  int delete(TbMetaCmpnySvrM tbMetaCmpnySvrM)throws Exception {
		if(!isPrimaryKeyValid(tbMetaCmpnySvrM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaCmpnySvrM can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TbMetaCmpnySvrMTrx.delete", tbMetaCmpnySvrM);
	}

	/**
	 * @param tbMetaCmpnySvrMs TbMetaCmpnySvrM[]
	 * @throws Exception
	 */
	public Object deleteMany( TbMetaCmpnySvrM[] tbMetaCmpnySvrMs) throws Exception {
		int count = 0;
		if (tbMetaCmpnySvrMs != null) {
			for (TbMetaCmpnySvrM tbMetaCmpnySvrM : tbMetaCmpnySvrMs) {
				count += delete(tbMetaCmpnySvrM);
			}
		}
		return count;		
	}

}