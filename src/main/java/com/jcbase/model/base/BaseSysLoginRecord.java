package com.jcbase.model.base;

import com.jcbase.core.model.BaseModel;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseSysLoginRecord<M extends BaseSysLoginRecord<M>> extends BaseModel<M> implements IBean {

	public void setId(java.lang.Integer id) {
		set("id", id);
	}

	public java.lang.Integer getId() {
		return get("id");
	}

	public void setSysUid(java.lang.Integer sysUid) {
		set("sys_uid", sysUid);
	}

	public java.lang.Integer getSysUid() {
		return get("sys_uid");
	}

	public void setLoginDate(java.util.Date loginDate) {
		set("login_date", loginDate);
	}

	public java.util.Date getLoginDate() {
		return get("login_date");
	}

	public void setLoginErrTimes(java.lang.Integer loginErrTimes) {
		set("login_err_times", loginErrTimes);
	}

	public java.lang.Integer getLoginErrTimes() {
		return get("login_err_times");
	}

	public void setLoginStatus(java.lang.Integer loginStatus) {
		set("login_status", loginStatus);
	}

	public java.lang.Integer getLoginStatus() {
		return get("login_status");
	}

}
