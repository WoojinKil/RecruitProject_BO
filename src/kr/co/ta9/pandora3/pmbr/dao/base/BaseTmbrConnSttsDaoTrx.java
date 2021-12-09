package kr.co.ta9.pandora3.pmbr.dao.base;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TmbrConnStts;

/**
 * BaseTmbrConnSttsDaoTrx - Transactional BASE DAO(Base Data Access Object) class for table [TMBR_CONN_STTS].
 *
 * <pre>
 * 1. 패키지명 : kr.co.ta9.pandora3.pmbr.dao
 * 2. 타입명 : class
 * 3. 작성일 : 2018-02-18
 * 4. 작성자 : TA9
 * 5. 설명 : 사용자 접속 상태 기본 DAOTrx(등록/수정/삭제 쿼리 호출)
 * </pre>
 */
@Repository
public class BaseTmbrConnSttsDaoTrx extends BaseDao {

	/**
	 * @param tmbrConnStts TmbrConnStts
	 * @return boolean
	 */
	public boolean isPrimaryKeyValid(TmbrConnStts tmbrConnStts) {
		boolean result = true;
		if (tmbrConnStts == null) {
			result = false;
		}

		if (
			tmbrConnStts.getObj_crt_dttm()== null
			) {
			result = false;
		}
		return result;
	}

	/**
	 * @param tmbrConnStts TmbrConnStts
	 * @return int
	 * @throws Exception
	 */
	public  int insert(TmbrConnStts tmbrConnStts) throws Exception {
		if(!isPrimaryKeyValid(tmbrConnStts)) {
			throw new PrimaryKeyNotSettedException("instance of TmbrConnStts can't be null or Primary key is not set");
		}

		return getSqlSession().insert("TmbrConnSttsTrx.insert", tmbrConnStts);
	}

	/**
	 * @param tmbrConnSttss TmbrConnStts...
	 * @return int
	 * @throws Exception
	 */
	public int insertMany(TmbrConnStts... tmbrConnSttss) throws Exception {
		int count = 0;
		if (tmbrConnSttss != null) {
			for (TmbrConnStts tmbrConnStts : tmbrConnSttss) {
				count += insert(tmbrConnStts);
			}
		}
		return count;		
	}

	/**
	 * @param tmbrConnStts TmbrConnStts
	 * @return int
	 * @throws Exception
	 */
	public int update(TmbrConnStts tmbrConnStts) throws Exception {

		return getSqlSession().update("TmbrConnSttsTrx.update", tmbrConnStts);
	}

	/**
	 * @param tmbrConnSttss TmbrConnStts...
	 * @return int
	 * @throws Exception
	 */
	public int updateMany(TmbrConnStts... tmbrConnSttss) throws Exception {
		 int count = 0;
		if (tmbrConnSttss != null) {
			for (TmbrConnStts tmbrConnStts : tmbrConnSttss) {
				count += update(tmbrConnStts);
			}
		}
		return count;		
	}

	/**
	 * @param tmbrConnStts TmbrConnStts
	 * @return int
	 * @throws Exception
	 */
	public int delete(TmbrConnStts tmbrConnStts)throws Exception {
		if(!isPrimaryKeyValid(tmbrConnStts)) {
			throw new PrimaryKeyNotSettedException("instance of TmbrConnStts can't be null or Primary key is not set");
		}
		return getSqlSession().delete("TmbrConnSttsTrx.delete", tmbrConnStts);
	}

	/**
	 * @param tmbrConnSttss TmbrConnStts...
	 * @return int
	 * @throws Exception
	 */
	public int deleteMany( TmbrConnStts... tmbrConnSttss) throws Exception {
		int count = 0;
		if (tmbrConnSttss != null) {
			for (TmbrConnStts tmbrConnStts : tmbrConnSttss) {
				count += delete(tmbrConnStts);
			}
		}
		return count;		
	}

}