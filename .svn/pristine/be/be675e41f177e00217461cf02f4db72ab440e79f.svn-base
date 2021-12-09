package kr.co.ta9.pandora3.psys.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TbLgapVmsprinfschH;

/**
 * BaseTbLgapVmsprinfschHDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TB_LGAP_VMSPRINFSCH_H].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 12. 09
 */
@Repository
public class BaseTbLgapVmsprinfschHDaoTrx extends BaseDao {

	/**
	 * @param tbLgapVmsprinfschH TbLgapVmsprinfschH
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TbLgapVmsprinfschH tbLgapVmsprinfschH) {
		boolean result = true;
		if (tbLgapVmsprinfschH == null) {
			result = false;
		}

		if (
			tbLgapVmsprinfschH.getObj_log_seq()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tbLgapVmsprinfschH TbLgapVmsprinfschH
	 * @throws Exception
	 */
	public  int insert(TbLgapVmsprinfschH tbLgapVmsprinfschH) throws Exception {
		if(!isPrimaryKeyValid(tbLgapVmsprinfschH)) {
			throw new PrimaryKeyNotSettedException("instance of TbLgapVmsprinfschH can't be null or Primary key is not set");
		}

		return getSqlSession().insert("TbLgapVmsprinfschHTrx.insert", tbLgapVmsprinfschH);
	}

	/**
	 * @param tbLgapVmsprinfschHs TbLgapVmsprinfschH...
	 * @throws Exception
	 */
	public int insertMany(TbLgapVmsprinfschH... tbLgapVmsprinfschHs) throws Exception {
		int count = 0;
		if (tbLgapVmsprinfschHs != null) {
			for (TbLgapVmsprinfschH tbLgapVmsprinfschH : tbLgapVmsprinfschHs) {
				count += insert(tbLgapVmsprinfschH);
			}
		}
		return count;		
	}

	/**
	 * @param tbLgapVmsprinfschH TbLgapVmsprinfschH
	 * @throws Exception
	 */
	public  int update(TbLgapVmsprinfschH tbLgapVmsprinfschH) throws Exception {
		if(!isPrimaryKeyValid(tbLgapVmsprinfschH)) {
			throw new PrimaryKeyNotSettedException("instance of TbLgapVmsprinfschH can't be null or Primary key is not set");
		}
		return getSqlSession().update("TbLgapVmsprinfschHTrx.update", tbLgapVmsprinfschH);
	}

	/**
	 * @param tbLgapVmsprinfschHs TbLgapVmsprinfschH...
	 * @throws Exception
	 */
	public  int updateMany(TbLgapVmsprinfschH... tbLgapVmsprinfschHs) throws Exception {
		 int count = 0;
		if (tbLgapVmsprinfschHs != null) {
			for (TbLgapVmsprinfschH tbLgapVmsprinfschH : tbLgapVmsprinfschHs) {
				count += update(tbLgapVmsprinfschH);
			}
		}
		return count;		
	}

	/**
	 * @param tbLgapVmsprinfschH TbLgapVmsprinfschH
	 * @throws Exception
	 */
	public  int delete(TbLgapVmsprinfschH tbLgapVmsprinfschH)throws Exception {
		if(!isPrimaryKeyValid(tbLgapVmsprinfschH)) {
			throw new PrimaryKeyNotSettedException("instance of TbLgapVmsprinfschH can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TbLgapVmsprinfschHTrx.delete", tbLgapVmsprinfschH);
	}

	/**
	 * @param tbLgapVmsprinfschHs TbLgapVmsprinfschH...
	 * @throws Exception
	 */
	public Object deleteMany( TbLgapVmsprinfschH... tbLgapVmsprinfschHs) throws Exception {
		int count = 0;
		if (tbLgapVmsprinfschHs != null) {
			for (TbLgapVmsprinfschH tbLgapVmsprinfschH : tbLgapVmsprinfschHs) {
				count += delete(tbLgapVmsprinfschH);
			}
		}
		return count;		
	}

}