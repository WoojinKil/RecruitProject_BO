package kr.co.ta9.pandora3.meta.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TbMetaBasicSettingM;

/**
 * BaseTbMetaBasicSettingMDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TB_META_BASIC_SETTING_M].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 05. 20
 */
@Repository
public class BaseTbMetaBasicSettingMDaoTrx extends BaseDao {

	/**
	 * @param tbMetaBasicSettingM TbMetaBasicSettingM
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TbMetaBasicSettingM tbMetaBasicSettingM) {
		boolean result = true;
		if (tbMetaBasicSettingM == null) {
			result = false;
		}

		if (
			tbMetaBasicSettingM.getCmpny_cd()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tbMetaBasicSettingM TbMetaBasicSettingM
	 * @throws Exception
	 */
	public  int insert(TbMetaBasicSettingM tbMetaBasicSettingM) throws Exception {
		if(!isPrimaryKeyValid(tbMetaBasicSettingM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaBasicSettingM can't be null or Primary key is not set");
		}

		return getSqlSession().insert("TbMetaBasicSettingMTrx.insert", tbMetaBasicSettingM);
	}

	/**
	 * @param tbMetaBasicSettingMs TbMetaBasicSettingM[]
	 * @throws Exception
	 */
	public int insertMany(TbMetaBasicSettingM[] tbMetaBasicSettingMs) throws Exception {
		int count = 0;
		if (tbMetaBasicSettingMs != null) {
			for (TbMetaBasicSettingM tbMetaBasicSettingM : tbMetaBasicSettingMs) {
				count += insert(tbMetaBasicSettingM);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaBasicSettingM TbMetaBasicSettingM
	 * @throws Exception
	 */
	public  int update(TbMetaBasicSettingM tbMetaBasicSettingM) throws Exception {
		if(!isPrimaryKeyValid(tbMetaBasicSettingM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaBasicSettingM can't be null or Primary key is not set");
		}
		return getSqlSession().update("TbMetaBasicSettingMTrx.update", tbMetaBasicSettingM);
	}

	/**
	 * @param tbMetaBasicSettingMs TbMetaBasicSettingM[]
	 * @throws Exception
	 */
	public  int updateMany(TbMetaBasicSettingM[] tbMetaBasicSettingMs) throws Exception {
		 int count = 0;
		if (tbMetaBasicSettingMs != null) {
			for (TbMetaBasicSettingM tbMetaBasicSettingM : tbMetaBasicSettingMs) {
				count += update(tbMetaBasicSettingM);
			}
		}
		return count;		
	}

	/**
	 * @param tbMetaBasicSettingM TbMetaBasicSettingM
	 * @throws Exception
	 */
	public  int delete(TbMetaBasicSettingM tbMetaBasicSettingM)throws Exception {
		if(!isPrimaryKeyValid(tbMetaBasicSettingM)) {
			throw new PrimaryKeyNotSettedException("instance of TbMetaBasicSettingM can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TbMetaBasicSettingMTrx.delete", tbMetaBasicSettingM);
	}

	/**
	 * @param tbMetaBasicSettingMs TbMetaBasicSettingM[]
	 * @throws Exception
	 */
	public Object deleteMany( TbMetaBasicSettingM[] tbMetaBasicSettingMs) throws Exception {
		int count = 0;
		if (tbMetaBasicSettingMs != null) {
			for (TbMetaBasicSettingM tbMetaBasicSettingM : tbMetaBasicSettingMs) {
				count += delete(tbMetaBasicSettingM);
			}
		}
		return count;		
	}

}