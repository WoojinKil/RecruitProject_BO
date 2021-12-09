package kr.co.ta9.pandora3.meta.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaCmpnyTbTypD;

/**
 * BaseTbMetaCmpnyTbTypDDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TB_META_CMPNY_TB_TYP_D].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaCmpnyTbTypDDaoTrx extends BaseDao {

	/**
	 * @param tbMetaCmpnyTbTypD TbMetaCmpnyTbTypD
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TbMetaCmpnyTbTypD tbMetaCmpnyTbTypD) {
		boolean result = true;
		if (tbMetaCmpnyTbTypD == null) {
			result = false;
		}

		if (
			tbMetaCmpnyTbTypD.getCmpny_cd()== null
			||
			tbMetaCmpnyTbTypD.getSys_cd()== null
			||
			tbMetaCmpnyTbTypD.getTb_typ_gbcd()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tbMetaCmpnyTbTypD TbMetaCmpnyTbTypD
	 * @throws Exception
	 */
	public  int insert(TbMetaCmpnyTbTypD tbMetaCmpnyTbTypD) throws Exception {
		if(!isPrimaryKeyValid(tbMetaCmpnyTbTypD)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaCmpnyTbTypD can't be null or Primary key is not set");
		}

		return getSqlSession().insert("TbMetaCmpnyTbTypDTrx.insert", tbMetaCmpnyTbTypD);
	}

	/**
	 * @param tbMetaCmpnyTbTypDs TbMetaCmpnyTbTypD[]
	 * @throws Exception
	 */
	public int insertMany(TbMetaCmpnyTbTypD[] tbMetaCmpnyTbTypDs) throws Exception {
		int count = 0;
		if (tbMetaCmpnyTbTypDs != null) {
			for (TbMetaCmpnyTbTypD tbMetaCmpnyTbTypD : tbMetaCmpnyTbTypDs) {
				count += insert(tbMetaCmpnyTbTypD);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaCmpnyTbTypD TbMetaCmpnyTbTypD
	 * @throws Exception
	 */
	public  int update(TbMetaCmpnyTbTypD tbMetaCmpnyTbTypD) throws Exception {
		if(!isPrimaryKeyValid(tbMetaCmpnyTbTypD)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaCmpnyTbTypD can't be null or Primary key is not set");
		}
		return getSqlSession().update("TbMetaCmpnyTbTypDTrx.update", tbMetaCmpnyTbTypD);
	}

	/**
	 * @param tbMetaCmpnyTbTypDs TbMetaCmpnyTbTypD[]
	 * @throws Exception
	 */
	public  int updateMany(TbMetaCmpnyTbTypD[] tbMetaCmpnyTbTypDs) throws Exception {
		 int count = 0;
		if (tbMetaCmpnyTbTypDs != null) {
			for (TbMetaCmpnyTbTypD tbMetaCmpnyTbTypD : tbMetaCmpnyTbTypDs) {
				count += update(tbMetaCmpnyTbTypD);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaCmpnyTbTypD TbMetaCmpnyTbTypD
	 * @throws Exception
	 */
	public  int delete(TbMetaCmpnyTbTypD tbMetaCmpnyTbTypD)throws Exception {
		if(!isPrimaryKeyValid(tbMetaCmpnyTbTypD)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaCmpnyTbTypD can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TbMetaCmpnyTbTypDTrx.delete", tbMetaCmpnyTbTypD);
	}

	/**
	 * @param tbMetaCmpnyTbTypDs TbMetaCmpnyTbTypD[]
	 * @throws Exception
	 */
	public Object deleteMany( TbMetaCmpnyTbTypD[] tbMetaCmpnyTbTypDs) throws Exception {
		int count = 0;
		if (tbMetaCmpnyTbTypDs != null) {
			for (TbMetaCmpnyTbTypD tbMetaCmpnyTbTypD : tbMetaCmpnyTbTypDs) {
				count += delete(tbMetaCmpnyTbTypD);
			}
		}
		return count;		
	}

}