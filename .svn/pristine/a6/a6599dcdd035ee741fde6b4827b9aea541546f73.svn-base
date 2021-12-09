package kr.co.ta9.pandora3.meta.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaCmpnyObjD;

/**
 * BaseTbMetaCmpnyObjDDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TB_META_CMPNY_OBJ_D].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaCmpnyObjDDaoTrx extends BaseDao {

	/**
	 * @param tbMetaCmpnyObjD TbMetaCmpnyObjD
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TbMetaCmpnyObjD tbMetaCmpnyObjD) {
		boolean result = true;
		if (tbMetaCmpnyObjD == null) {
			result = false;
		}

		if (
			tbMetaCmpnyObjD.getCmpny_cd()== null
			||
			tbMetaCmpnyObjD.getObj_gbcd()== null
			||
			tbMetaCmpnyObjD.getSys_cd()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tbMetaCmpnyObjD TbMetaCmpnyObjD
	 * @throws Exception
	 */
	public  int insert(TbMetaCmpnyObjD tbMetaCmpnyObjD) throws Exception {
		if(!isPrimaryKeyValid(tbMetaCmpnyObjD)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaCmpnyObjD can't be null or Primary key is not set");
		}

		return getSqlSession().insert("TbMetaCmpnyObjDTrx.insert", tbMetaCmpnyObjD);
	}

	/**
	 * @param tbMetaCmpnyObjDs TbMetaCmpnyObjD[]
	 * @throws Exception
	 */
	public int insertMany(TbMetaCmpnyObjD[] tbMetaCmpnyObjDs) throws Exception {
		int count = 0;
		if (tbMetaCmpnyObjDs != null) {
			for (TbMetaCmpnyObjD tbMetaCmpnyObjD : tbMetaCmpnyObjDs) {
				count += insert(tbMetaCmpnyObjD);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaCmpnyObjD TbMetaCmpnyObjD
	 * @throws Exception
	 */
	public  int update(TbMetaCmpnyObjD tbMetaCmpnyObjD) throws Exception {
		if(!isPrimaryKeyValid(tbMetaCmpnyObjD)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaCmpnyObjD can't be null or Primary key is not set");
		}
		return getSqlSession().update("TbMetaCmpnyObjDTrx.update", tbMetaCmpnyObjD);
	}

	/**
	 * @param tbMetaCmpnyObjDs TbMetaCmpnyObjD[]
	 * @throws Exception
	 */
	public  int updateMany(TbMetaCmpnyObjD[] tbMetaCmpnyObjDs) throws Exception {
		 int count = 0;
		if (tbMetaCmpnyObjDs != null) {
			for (TbMetaCmpnyObjD tbMetaCmpnyObjD : tbMetaCmpnyObjDs) {
				count += update(tbMetaCmpnyObjD);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaCmpnyObjD TbMetaCmpnyObjD
	 * @throws Exception
	 */
	public  int delete(TbMetaCmpnyObjD tbMetaCmpnyObjD)throws Exception {
		if(!isPrimaryKeyValid(tbMetaCmpnyObjD)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaCmpnyObjD can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TbMetaCmpnyObjDTrx.delete", tbMetaCmpnyObjD);
	}

	/**
	 * @param tbMetaCmpnyObjDs TbMetaCmpnyObjD[]
	 * @throws Exception
	 */
	public Object deleteMany( TbMetaCmpnyObjD[] tbMetaCmpnyObjDs) throws Exception {
		int count = 0;
		if (tbMetaCmpnyObjDs != null) {
			for (TbMetaCmpnyObjD tbMetaCmpnyObjD : tbMetaCmpnyObjDs) {
				count += delete(tbMetaCmpnyObjD);
			}
		}
		return count;		
	}

}