/**
 * 
 */
package com.yanxin.iot.json2;

/**
 * @author Guozhen Cheng
 *
 */
public class ImageSet {
	
	/**图片的URL地址*/
	private String url= "";
	/**图片的生成时间*/
	private String time = "";
	/**生成图片的设备所在的运维班*/
	private String ywbName = "";
	/**生成的图片设备或区域名称*/
	private String equipName = "";
	/**生成图片的设备所在的变电站*/
	private String stationName = "";
	/**
	 * @return the url
	 */
	public String getUrl() {
		return url;
	}
	/**
	 * @param url the url to set
	 */
	public void setUrl(String url) {
		this.url = url;
	}
	/**
	 * @return the time
	 */
	public String getTime() {
		return time;
	}
	/**
	 * @param time the time to set
	 */
	public void setTime(String time) {
		this.time = time;
	}
	/**
	 * @return the ywbName
	 */
	public String getYwbName() {
		return ywbName;
	}
	/**
	 * @param ywbName the ywbName to set
	 */
	public void setYwbName(String ywbName) {
		this.ywbName = ywbName;
	}
	/**
	 * @return the equipName
	 */
	public String getEquipName() {
		return equipName;
	}
	/**
	 * @param equipName the equipName to set
	 */
	public void setEquipName(String equipName) {
		this.equipName = equipName;
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
}
