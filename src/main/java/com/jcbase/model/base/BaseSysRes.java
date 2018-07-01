package com.jcbase.model.base;

import com.jcbase.core.model.BaseModel;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseSysRes<M extends BaseSysRes<M>> extends BaseModel<M> implements IBean {

	public void setId(java.lang.Integer id) {
		set("id", id);
	}

	public java.lang.Integer getId() {
		return get("id");
	}

	public void setPid(java.lang.Integer pid) {
		set("pid", pid);
	}

	public java.lang.Integer getPid() {
		return get("pid");
	}

	public void setName(java.lang.String name) {
		set("name", name);
	}

	public java.lang.String getName() {
		return get("name");
	}

	public void setDes(java.lang.String des) {
		set("des", des);
	}

	public java.lang.String getDes() {
		return get("des");
	}

	public void setUrl(java.lang.String url) {
		set("url", url);
	}

	public java.lang.String getUrl() {
		return get("url");
	}

	public void setIconCls(java.lang.String iconCls) {
		set("iconCls", iconCls);
	}

	public java.lang.String getIconCls() {
		return get("iconCls");
	}

	public void setSeq(java.lang.Integer seq) {
		set("seq", seq);
	}

	public java.lang.Integer getSeq() {
		return get("seq");
	}

	public void setType(java.lang.Integer type) {
		set("type", type);
	}

	public java.lang.Integer getType() {
		return get("type");
	}

	public void setModifydate(java.util.Date modifydate) {
		set("modifydate", modifydate);
	}

	public java.util.Date getModifydate() {
		return get("modifydate");
	}

	public void setEnabled(java.lang.Integer enabled) {
		set("enabled", enabled);
	}

	public java.lang.Integer getEnabled() {
		return get("enabled");
	}

	public void setLevel(java.lang.Integer level) {
		set("level", level);
	}

	public java.lang.Integer getLevel() {
		return get("level");
	}

}
