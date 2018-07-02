package com.yanxin.common.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseAlertType<M extends BaseAlertType<M>> extends Model<M> implements IBean {

	public void setId(java.lang.Long id) {
		set("id", id);
	}

	public java.lang.Long getId() {
		return get("id");
	}

	public void setAlertType(java.lang.String alertType) {
		set("alert_type", alertType);
	}

	public java.lang.String getAlertType() {
		return get("alert_type");
	}

	public void setAlertDesc(java.lang.String alertDesc) {
		set("alert_desc", alertDesc);
	}

	public java.lang.String getAlertDesc() {
		return get("alert_desc");
	}

	public void setCreateTime(java.util.Date createTime) {
		set("create_time", createTime);
	}

	public java.util.Date getCreateTime() {
		return get("create_time");
	}

}
