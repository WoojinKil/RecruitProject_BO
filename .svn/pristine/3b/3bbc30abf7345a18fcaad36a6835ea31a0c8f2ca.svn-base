package kr.co.ta9.pandora3.psys.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TbLgapGrprolrtnnH;

/**
 * BaseTbLgapGrprolrtnnHDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TB_LGAP_GRPROLRTNN_H].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 11. 28
 */
@Repository
public class BaseTbLgapGrprolrtnnHDaoTrx extends BaseDao {

	/**
	 * @param tbLgapGrprolrtnnH TbLgapGrprolrtnnH
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TbLgapGrprolrtnnH tbLgapGrprolrtnnH) {
		boolean result = true;
		if (tbLgapGrprolrtnnH == null) {
			result = false;
		}

		if (
			tbLgapGrprolrtnnH.getObj_hist_no()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tbLgapGrprolrtnnH TbLgapGrprolrtnnH
	 * @throws Exception
	 */
	public  int insert(TbLgapGrprolrtnnH tbLgapGrprolrtnnH) throws Exception {
		if(!isPrimaryKeyValid(tbLgapGrprolrtnnH)) {
			throw new PrimaryKeyNotSettedException("instance of TbLgapGrprolrtnnH can't be null or Primary key is not set");
		}

		return getSqlSession().insert("TbLgapGrprolrtnnHTrx.insert", tbLgapGrprolrtnnH);
	}

	/**
	 * @param tbLgapGrprolrtnnHs TbLgapGrprolrtnnH...
	 * @throws Exception
	 */
	public int insertMany(TbLgapGrprolrtnnH... tbLgapGrprolrtnnHs) throws Exception {
		int count = 0;
		if (tbLgapGrprolrtnnHs != null) {
			for (TbLgapGrprolrtnnH tbLgapGrprolrtnnH : tbLgapGrprolrtnnHs) {
				count += insert(tbLgapGrprolrtnnH);
			}
		}
		return count;		
	}

	/**
	 * @param tbLgapGrprolrtnnH TbLgapGrprolrtnnH
	 * @throws Exception
	 */
	public  int update(TbLgapGrprolrtnnH tbLgapGrprolrtnnH) throws Exception {
		if(!isPrimaryKeyValid(tbLgapGrprolrtnnH)) {
			throw new PrimaryKeyNotSettedException("instance of TbLgapGrprolrtnnH can't be null or Primary key is not set");
		}
		return getSqlSession().update("TbLgapGrprolrtnnHTrx.update", tbLgapGrprolrtnnH);
	}

	/**
	 * @param tbLgapGrprolrtnnHs TbLgapGrprolrtnnH...
	 * @throws Exception
	 */
	public  int updateMany(TbLgapGrprolrtnnH... tbLgapGrprolrtnnHs) throws Exception {
		 int count = 0;
		if (tbLgapGrprolrtnnHs != null) {
			for (TbLgapGrprolrtnnH tbLgapGrprolrtnnH : tbLgapGrprolrtnnHs) {
				count += update(tbLgapGrprolrtnnH);
			}
		}
		return count;		
	}

	/**
	 * @param tbLgapGrprolrtnnH TbLgapGrprolrtnnH
	 * @throws Exception
	 */
	public  int delete(TbLgapGrprolrtnnH tbLgapGrprolrtnnH)throws Exception {
		if(!isPrimaryKeyValid(tbLgapGrprolrtnnH)) {
			throw new PrimaryKeyNotSettedException("instance of TbLgapGrprolrtnnH can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TbLgapGrprolrtnnHTrx.delete", tbLgapGrprolrtnnH);
	}

	/**
	 * @param tbLgapGrprolrtnnHs TbLgapGrprolrtnnH...
	 * @throws Exception
	 */
	public Object deleteMany( TbLgapGrprolrtnnH... tbLgapGrprolrtnnHs) throws Exception {
		int count = 0;
		if (tbLgapGrprolrtnnHs != null) {
			for (TbLgapGrprolrtnnH tbLgapGrprolrtnnH : tbLgapGrprolrtnnHs) {
				count += delete(tbLgapGrprolrtnnH);
			}
		}
		return count;		
	}

}