package kr.co.ta9.pandora3.pcommon.dto.base;

import java.sql.Timestamp;

import  kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * BaseTbBchrEmpI - ValueObject class for table [TB_BCHR_EMP_I].
 *
 * <pre>
 *     Do not modify this file
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2019. 11. 08
 */
public class BaseTbBcpcZoneM extends CommonBean
{
	
		private String zone_cd;                                   /*zone코드*/
		private String zone_nm;                                   /*zone명*/
		private String us_yn;                                    /*사용여부*/
		private Timestamp rgst_dtm;                               /*등록일시*/
		private String crtr_id;                                   /*등록자아이디*/
		private Timestamp mdf_dtm;                                /*수정일시*/
		private String updr_id;                                  /*수정자아이디*/
		private String prgrp_clsf_cd;                             /*상품군분류코드*/
		private String bkgrnd_colr_cd;                            /*배경색상코드*/
		private int sort_sequ_val;                             	  /*정렬순서값*/
		private Integer obj_sort_sequ_val;
		private String fnl_load_dtm;                              /*최종적재일시*/
		public String getZone_cd() {
			return zone_cd;
		}
		public void setZone_cd(String zone_cd) {
			this.zone_cd = zone_cd;
		}
		public String getZone_nm() {
			return zone_nm;
		}
		public void setZone_nm(String zone_nm) {
			this.zone_nm = zone_nm;
		}
		public String getUs_yn() {
			return us_yn;
		}
		public void setUs_yn(String us_yn) {
			this.us_yn = us_yn;
		}
		public Timestamp getRgst_dtm() {
			return rgst_dtm;
		}
		public void setRgst_dtm(Timestamp rgst_dtm) {
			this.rgst_dtm = rgst_dtm;
		}
		public String getCrtr_id() {
			return crtr_id;
		}
		public void setCrtr_id(String crtr_id) {
			this.crtr_id = crtr_id;
		}
		public Timestamp getMdf_dtm() {
			return mdf_dtm;
		}
		public void setMdf_dtm(Timestamp mdf_dtm) {
			this.mdf_dtm = mdf_dtm;
		}
		public String getUpdr_id() {
			return updr_id;
		}
		public void setUpdr_id(String updr_id) {
			this.updr_id = updr_id;
		}
		public String getPrgrp_clsf_cd() {
			return prgrp_clsf_cd;
		}
		public void setPrgrp_clsf_cd(String prgrp_clsf_cd) {
			this.prgrp_clsf_cd = prgrp_clsf_cd;
		}
		public String getBkgrnd_colr_cd() {
			return bkgrnd_colr_cd;
		}
		public void setBkgrnd_colr_cd(String bkgrnd_colr_cd) {
			this.bkgrnd_colr_cd = bkgrnd_colr_cd;
		}
		public int getSort_sequ_val() {
			return sort_sequ_val;
		}
		public void setSort_sequ_val(int sort_sequ_val) {
			this.sort_sequ_val = sort_sequ_val;
			this.obj_sort_sequ_val = sort_sequ_val;
		}
		public Integer getObj_sort_sequ_val() {
			return obj_sort_sequ_val;
		}
//		public void setObj_sort_sequ_val(Integer obj_sort_sequ_val) {
//			this.obj_sort_sequ_val = obj_sort_sequ_val;
//		}
		public String getFnl_load_dtm() {
			return fnl_load_dtm;
		}
		public void setFnl_load_dtm(String fnl_load_dtm) {
			this.fnl_load_dtm = fnl_load_dtm;
		}
		
		
	}