package com.jcbase.model.base;

import com.jcbase.core.model.BaseModel;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseDictData<M extends BaseDictData<M>> extends BaseModel<M> implements IBean {

	public void setId(java.lang.Integer id) {
		set("id", id);
	}

	public java.lang.Integer getId() {
		return get("id");
	}

	public void setName(java.lang.String name) {
		set("name", name);
	}

	public java.lang.String getName() {
		return get("name");
	}

	public void setValue(java.lang.String value) {
		set("value", value);
	}

	public java.lang.String getValue() {
		return get("value");
	}

	public void setRemark(java.lang.String remark) {
		set("remark", remark);
	}

	public java.lang.String getRemark() {
		return get("remark");
	}

	public void setSeq(java.lang.Integer seq) {
		set("seq", seq);
	}

	public java.lang.Integer getSeq() {
		return get("seq");
	}

	public void setUpdateTime(java.lang.Integer updateTime) {
		set("update_time", updateTime);
	}

	public java.lang.Integer getUpdateTime() {
		return get("update_time");
	}

	public void setDictTypeId(java.lang.Integer dictTypeId) {
		set("dict_type_id", dictTypeId);
	}

	public java.lang.Integer getDictTypeId() {
		return get("dict_type_id");
	}

}
