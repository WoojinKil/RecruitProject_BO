package kr.co.ta9.pandora3.pcommon.dto;

import kr.co.ta9.pandora3.app.bean.CommonBean;

/**
 * TbBcPcOrgAthr - ValueObject Extended class for table [TB_BCPC_ORGATHR].
 *
 * <pre>
 *     Generated by CodeProcessor. Yon can freely modify this generated file.
 *     Copyright &amp;copy 2004 by Pionnet, Inc. All rights reserved.
 * </pre>
 *
 * @since 2020. 02. 28
 */
public class TbBcPcHRrshopbuy extends CommonBean {

    private String mstr_cd;         /* 모점코드 */
    private String mstr_nm;         /* 모점명 */
    private String cstr_cd;         /* 자점코드 */
    private String cstr_nm;         /* 자점명 */
    private String org_cd;       /* 인사조직코드 */
    private String srno;            /* 시퀀스 */
    private String org_cl_cd;       /* 조직구분코드 */
    private String shop_str_cd;     /* 매장점코드 */
    private String shop_team_cd;    /* 매장팀코드 */
    private String shop_team_nm;    /* 매장팀명 */
    private String shop_pc_cd;      /* 매장pc코드 */
    private String shop_pc_nm;      /* 매장pc명 */
    private String buy_fld_cd;      /* 매입부문코드 */
    private String buy_fld_nm;      /* 부문명 */
    private String buy_team_cd;     /* 매입팀코드 */
    private String buy_team_nm;     /* 매입팀명 */
    private String buy_pc_cd;       /* 매입pc코드 */
    private String buy_pc_nm;       /* 매입pc명 */
    private String rgn_ldr_yn;     /* 지역장여부 */
    private String auto_hdwt_cl_cd; /* 자동수기구분코드 */
    private String str_chk_yn;      /* 자점체크여부 */
    private String fld_chk_yn;      /* 부문체크여부 */
    private String crtr_id;
    private String updr_id;
    private String up_org_incl_yn;
    private String up_org_cd;
    private String rgn_yn;
    private String rgst_dtm;
    private String mdf_dtm;
    

    public String getUp_org_incl_yn() {
		return up_org_incl_yn;
	}
	public void setUp_org_incl_yn(String up_org_incl_yn) {
		this.up_org_incl_yn = up_org_incl_yn;
	}
	public String getUp_org_cd() {
		return up_org_cd;
	}
	public void setUp_org_cd(String up_org_cd) {
		this.up_org_cd = up_org_cd;
	}
	public String getRgn_yn() {
		return rgn_yn;
	}
	public void setRgn_yn(String rgn_yn) {
		this.rgn_yn = rgn_yn;
	}
	public String getRgst_dtm() {
		return rgst_dtm;
	}
	public void setRgst_dtm(String rgst_dtm) {
		this.rgst_dtm = rgst_dtm;
	}
	public String getMdf_dtm() {
		return mdf_dtm;
	}
	public void setMdf_dtm(String mdf_dtm) {
		this.mdf_dtm = mdf_dtm;
	}
	public String getCrtr_id() {
		return crtr_id;
	}
	public void setCrtr_id(String crtr_id) {
		this.crtr_id = crtr_id;
	}
	public String getUpdr_id() {
		return updr_id;
	}
	public void setUpdr_id(String updr_id) {
		this.updr_id = updr_id;
	}
	public String getMstr_cd() {
        return mstr_cd;
    }
    public void setMstr_cd(String mstr_cd) {
        this.mstr_cd = mstr_cd;
    }
    public String getMstr_nm() {
        return mstr_nm;
    }
    public void setMstr_nm(String mstr_nm) {
        this.mstr_nm = mstr_nm;
    }
    public String getCstr_cd() {
        return cstr_cd;
    }
    public void setCstr_cd(String cstr_cd) {
        this.cstr_cd = cstr_cd;
    }
    public String getCstr_nm() {
        return cstr_nm;
    }
    public void setCstr_nm(String cstr_nm) {
        this.cstr_nm = cstr_nm;
    }
    public String getHr_org_cd() {
        return org_cd;
    }
    public void setHr_org_cd(String org_cd) {
        this.org_cd = org_cd;
    }
    public String getSrno() {
        return srno;
    }
    public void setSrno(String srno) {
        this.srno = srno;
    }
    public String getOrg_cl_cd() {
        return org_cl_cd;
    }
    public void setOrg_cl_cd(String org_cl_cd) {
        this.org_cl_cd = org_cl_cd;
    }
    public String getShop_str_cd() {
        return shop_str_cd;
    }
    public void setShop_str_cd(String shop_str_cd) {
        this.shop_str_cd = shop_str_cd;
    }
    public String getShop_team_cd() {
        return shop_team_cd;
    }
    public void setShop_team_cd(String shop_team_cd) {
        this.shop_team_cd = shop_team_cd;
    }
    public String getShop_team_nm() {
        return shop_team_nm;
    }
    public void setShop_team_nm(String shop_team_nm) {
        this.shop_team_nm = shop_team_nm;
    }
    public String getShop_pc_cd() {
        return shop_pc_cd;
    }
    public void setShop_pc_cd(String shop_pc_cd) {
        this.shop_pc_cd = shop_pc_cd;
    }
    public String getShop_pc_nm() {
        return shop_pc_nm;
    }
    public void setShop_pc_nm(String shop_pc_nm) {
        this.shop_pc_nm = shop_pc_nm;
    }
    public String getBuy_fld_cd() {
        return buy_fld_cd;
    }
    public void setBuy_fld_cd(String buy_fld_cd) {
        this.buy_fld_cd = buy_fld_cd;
    }
    public String getBuy_fld_nm() {
        return buy_fld_nm;
    }
    public void setBuy_fld_nm(String buy_fld_nm) {
        this.buy_fld_nm = buy_fld_nm;
    }
    public String getBuy_team_cd() {
        return buy_team_cd;
    }
    public void setBuy_team_cd(String buy_team_cd) {
        this.buy_team_cd = buy_team_cd;
    }
    public String getBuy_team_nm() {
        return buy_team_nm;
    }
    public void setBuy_team_nm(String buy_team_nm) {
        this.buy_team_nm = buy_team_nm;
    }
    public String getBuy_pc_cd() {
        return buy_pc_cd;
    }
    public void setBuy_pc_cd(String buy_pc_cd) {
        this.buy_pc_cd = buy_pc_cd;
    }
    public String getBuy_pc_nm() {
        return buy_pc_nm;
    }
    public void setBuy_pc_nm(String buy_pc_nm) {
        this.buy_pc_nm = buy_pc_nm;
    }
    public String getRgn_ldr_yn() {
        return rgn_ldr_yn;
    }
    public void setRgn_ldr_yn(String rgn_ldr_yn) {
        this.rgn_ldr_yn = rgn_ldr_yn;
    }
    public String getAuto_hdwt_cl_cd() {
        return auto_hdwt_cl_cd;
    }
    public void setAuto_hdwt_cl_cd(String auto_hdwt_cl_cd) {
        this.auto_hdwt_cl_cd = auto_hdwt_cl_cd;
    }
    public String getStr_chk_yn() {
        return str_chk_yn;
    }
    public void setStr_chk_yn(String str_chk_yn) {
        this.str_chk_yn = str_chk_yn;
    }
    public String getFld_chk_yn() {
        return fld_chk_yn;
    }
    public void setFld_chk_yn(String fld_chk_yn) {
        this.fld_chk_yn = fld_chk_yn;
    }

}