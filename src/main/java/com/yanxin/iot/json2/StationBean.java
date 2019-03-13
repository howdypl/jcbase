/**
 * 
 */
package com.yanxin.iot.json2;

/**
 * @author Cheng Guozhen
 * 
 */
public class StationBean {
	
    private long stationId;//变电站ID
    private String stationName;//变电站名称
    
	private int kv;
	private boolean accept;
	/**
	 * @return the stationId
	 */
	public long getStationId() {
		return stationId;
	}
	/**
	 * @param stationId the stationId to set
	 */
	public void setStationId(long stationId) {
		this.stationId = stationId;
	}
	/**
	 * @return the stationName
	 */
	public String getStationName() {
		return stationName;
	}
	/**
	 * @param stationName the stationName to set
	 */
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	/**
	 * @return the kv
	 */
	public int getKv() {
		return kv;
	}
	/**
	 * @param kv the kv to set
	 */
	public void setKv(int kv) {
		this.kv = kv;
	}
	/**
	 * @return the accept
	 */
	public boolean isAccept() {
		return accept;
	}
	/**
	 * @param accept the accept to set
	 */
	public void setAccept(boolean accept) {
		this.accept = accept;
	}
}
