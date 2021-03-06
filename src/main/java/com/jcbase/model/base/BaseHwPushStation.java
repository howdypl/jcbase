package com.jcbase.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseHwPushStation<M extends BaseHwPushStation<M>> extends Model<M> implements IBean {

	public void setId(java.lang.Long id) {
		set("id", id);
	}

	public java.lang.Long getId() {
		return get("id");
	}

	public void setToken(java.lang.String token) {
		set("token", token);
	}

	public java.lang.String getToken() {
		return get("token");
	}

	public void setYwb(java.lang.Integer ywb) {
		set("ywb", ywb);
	}

	public java.lang.Integer getYwb() {
		return get("ywb");
	}

	public void setStationId(java.lang.Integer stationId) {
		set("station_id", stationId);
	}

	public java.lang.Integer getStationId() {
		return get("station_id");
	}

	public void setStationName(java.lang.String stationName) {
		set("station_name", stationName);
	}

	public java.lang.String getStationName() {
		return get("station_name");
	}

}
