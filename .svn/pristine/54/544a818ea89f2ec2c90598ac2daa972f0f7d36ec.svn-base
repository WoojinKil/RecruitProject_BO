package kr.co.ta9.pandora3.meta.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaCmpnyBasicSettingD;

/**
 * BaseTbMetaCmpnyBasicSettingDDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TB_META_CMPNY_BASIC_SETTING_D].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaCmpnyBasicSettingDDaoTrx extends BaseDao {

	/**
	 * @param tbMetaCmpnyBasicSettingD TbMetaCmpnyBasicSettingD
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TbMetaCmpnyBasicSettingD tbMetaCmpnyBasicSettingD) {
		boolean result = true;
		if (tbMetaCmpnyBasicSettingD == null) {
			result = false;
		}

		if (
			tbMetaCmpnyBasicSettingD.getCmpny_cd()== null
			||
			tbMetaCmpnyBasicSettingD.getSys_cd()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tbMetaCmpnyBasicSettingD TbMetaCmpnyBasicSettingD
	 * @throws Exception
	 */
	public  int insert(TbMetaCmpnyBasicSettingD tbMetaCmpnyBasicSettingD) throws Exception {
		if(!isPrimaryKeyValid(tbMetaCmpnyBasicSettingD)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaCmpnyBasicSettingD can't be null or Primary key is not set");
		}

		return getSqlSession().insert("TbMetaCmpnyBasicSettingDTrx.insert", tbMetaCmpnyBasicSettingD);
	}

	/**
	 * @param tbMetaCmpnyBasicSettingDs TbMetaCmpnyBasicSettingD[]
	 * @throws Exception
	 */
	public int insertMany(TbMetaCmpnyBasicSettingD[] tbMetaCmpnyBasicSettingDs) throws Exception {
		int count = 0;
		if (tbMetaCmpnyBasicSettingDs != null) {
			for (TbMetaCmpnyBasicSettingD tbMetaCmpnyBasicSettingD : tbMetaCmpnyBasicSettingDs) {
				count += insert(tbMetaCmpnyBasicSettingD);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaCmpnyBasicSettingD TbMetaCmpnyBasicSettingD
	 * @throws Exception
	 */
	public  int update(TbMetaCmpnyBasicSettingD tbMetaCmpnyBasicSettingD) throws Exception {
		if(!isPrimaryKeyValid(tbMetaCmpnyBasicSettingD)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaCmpnyBasicSettingD can't be null or Primary key is not set");
		}
		return getSqlSession().update("TbMetaCmpnyBasicSettingDTrx.update", tbMetaCmpnyBasicSettingD);
	}

	/**
	 * @param tbMetaCmpnyBasicSettingDs TbMetaCmpnyBasicSettingD[]
	 * @throws Exception
	 */
	public  int updateMany(TbMetaCmpnyBasicSettingD[] tbMetaCmpnyBasicSettingDs) throws Exception {
		 int count = 0;
		if (tbMetaCmpnyBasicSettingDs != null) {
			for (TbMetaCmpnyBasicSettingD tbMetaCmpnyBasicSettingD : tbMetaCmpnyBasicSettingDs) {
				count += update(tbMetaCmpnyBasicSettingD);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaCmpnyBasicSettingD TbMetaCmpnyBasicSettingD
	 * @throws Exception
	 */
	public  int delete(TbMetaCmpnyBasicSettingD tbMetaCmpnyBasicSettingD)throws Exception {
		if(!isPrimaryKeyValid(tbMetaCmpnyBasicSettingD)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaCmpnyBasicSettingD can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TbMetaCmpnyBasicSettingDTrx.delete", tbMetaCmpnyBasicSettingD);
	}

	/**
	 * @param tbMetaCmpnyBasicSettingDs TbMetaCmpnyBasicSettingD[]
	 * @throws Exception
	 */
	public Object deleteMany( TbMetaCmpnyBasicSettingD[] tbMetaCmpnyBasicSettingDs) throws Exception {
		int count = 0;
		if (tbMetaCmpnyBasicSettingDs != null) {
			for (TbMetaCmpnyBasicSettingD tbMetaCmpnyBasicSettingD : tbMetaCmpnyBasicSettingDs) {
				count += delete(tbMetaCmpnyBasicSettingD);
			}
		}
		return count;		
	}

}