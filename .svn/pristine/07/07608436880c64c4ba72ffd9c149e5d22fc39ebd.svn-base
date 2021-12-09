package kr.co.ta9.pandora3.pbbs.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TbbsDocUsrRtnn;

/**
 * BaseTbbsDocUsrRtnnDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table
 * [TBBS_DOC_USR_RTNN].
 *
 * <pre>
 *  Do not modify this file
 *  Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class BaseTbbsDocUsrRtnnDaoTrx extends BaseDao {

	/**
	 * @param tbbsDocUsrRtnn TbbsDocUsrRtnn
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TbbsDocUsrRtnn tbbsDocUsrRtnn) {
		boolean result = true;
		if (tbbsDocUsrRtnn == null) {
			result = false;
		}

		if (
			tbbsDocUsrRtnn.getObj_doc_seq()== null
			||
			tbbsDocUsrRtnn.getObj_modl_seq()== null
			||
			tbbsDocUsrRtnn.getUsr_id()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tbbsDocUsrRtnn TbbsDocUsrRtnn
	 * @throws Exception
	 */
	public  int insert(TbbsDocUsrRtnn tbbsDocUsrRtnn) throws Exception {
		if(!isPrimaryKeyValid(tbbsDocUsrRtnn)) {
			throw new PrimaryKeyNotSettedException("instance of TbbsDocUsrRtnn can't be null or Primary key is not set");
		}

		return getSqlSession().insert("TbbsDocUsrRtnnTrx.insert", tbbsDocUsrRtnn);
	}

	/**
	 * @param tbbsDocUsrRtnns TbbsDocUsrRtnn[]
	 * @throws Exception
	 */
	public int insertMany(TbbsDocUsrRtnn... tbbsDocUsrRtnns) throws Exception {
		int count = 0;
		if (tbbsDocUsrRtnns != null) {
			for (TbbsDocUsrRtnn tbbsDocUsrRtnn : tbbsDocUsrRtnns) {
				count += insert(tbbsDocUsrRtnn);
			}
		}
		return count;		
	}

	/**
	 * @param tbbsDocUsrRtnn TbbsDocUsrRtnn
	 * @throws Exception
	 */
	public  int update(TbbsDocUsrRtnn tbbsDocUsrRtnn) throws Exception {
		if(!isPrimaryKeyValid(tbbsDocUsrRtnn)) {
			throw new PrimaryKeyNotSettedException("instance of TbbsDocUsrRtnn can't be null or Primary key is not set");
		}
		return getSqlSession().update("TbbsDocUsrRtnnTrx.update", tbbsDocUsrRtnn);
	}

	/**
	 * @param tbbsDocUsrRtnns TbbsDocUsrRtnn[]
	 * @throws Exception
	 */
	public  int updateMany(TbbsDocUsrRtnn... tbbsDocUsrRtnns) throws Exception {
		 int count = 0;
		if (tbbsDocUsrRtnns != null) {
			for (TbbsDocUsrRtnn tbbsDocUsrRtnn : tbbsDocUsrRtnns) {
				count += update(tbbsDocUsrRtnn);
			}
		}
		return count;		
	}

	/**
	 * @param tbbsDocUsrRtnn TbbsDocUsrRtnn
	 * @throws Exception
	 */
	public  int delete(TbbsDocUsrRtnn tbbsDocUsrRtnn)throws Exception {
		if(!isPrimaryKeyValid(tbbsDocUsrRtnn)) {
			throw new PrimaryKeyNotSettedException("instance of TbbsDocUsrRtnn can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TbbsDocUsrRtnnTrx.delete", tbbsDocUsrRtnn);
	}

	/**
	 * @param tbbsDocUsrRtnns TbbsDocUsrRtnn[]
	 * @throws Exception
	 */
	public int deleteMany( TbbsDocUsrRtnn... tbbsDocUsrRtnns) throws Exception {
		int count = 0;
		if (tbbsDocUsrRtnns != null) {
			for (TbbsDocUsrRtnn tbbsDocUsrRtnn : tbbsDocUsrRtnns) {
				count += delete(tbbsDocUsrRtnn);
			}
		}
		return count;		
	}

}