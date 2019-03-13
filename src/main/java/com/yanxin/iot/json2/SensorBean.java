/**
 * 
 */
package com.yanxin.iot.json2;

/**
 * @author YT
 *
 */
public class SensorBean {
	
    private String equipName;//设备名称
    private String equipNumber;//设备唯一编号
    
    private long state = 0;//设备状态：1:打开，0关闭

    private long equipType = 0;//设备类型，如1：门，2窗等
    private int stationId;
    private String stationName;//所属变电站
    
    private int regionId;
    private String regionName;//所在区域
    
    private int voltage = 0; //电压值
    
    private String time; //最近唤醒时间

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
	 * @return the equipNumber
	 */
	public String getEquipNumber() {
		return equipNumber;
	}

	/**
	 * @param equipNumber the equipNumber to set
	 */
	public void setEquipNumber(String equipNumber) {
		this.equipNumber = equipNumber;
	}

	/**
	 * @return the state
	 */
	public long getState() {
		return state;
	}

	/**
	 * @param state the state to set
	 */
	public void setState(long state) {
		this.state = state;
	}

	/**
	 * @return the equipType
	 */
	public long getEquipType() {
		return equipType;
	}

	/**
	 * @param equipType the equipType to set
	 */
	public void setEquipType(long equipType) {
		this.equipType = equipType;
	}

	/**
	 * @return the stationId
	 */
	public int getStationId() {
		return stationId;
	}

	/**
	 * @param stationId the stationId to set
	 */
	public void setStationId(int stationId) {
		this.stationId = stationId;
	}

	/**
	 * @return the station
	 */
	public String getStationName() {
		return stationName;
	}

	/**
	 * @param station the station to set
	 */
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}

	/**
	 * @return the regionId
	 */
	public int getRegionId() {
		return regionId;
	}

	/**
	 * @param regionId the regionId to set
	 */
	public void setRegionId(int regionId) {
		this.regionId = regionId;
	}

	/**
	 * @return the region
	 */
	public String getRegionName() {
		return regionName;
	}

	/**
	 * @param region the region to set
	 */
	public void setRegion(String regionName) {
		this.regionName = regionName;
	}

	/**
	 * @return the voltage
	 */
	public int getVoltage() {
		return voltage;
	}

	/**
	 * @param voltage the voltage to set
	 */
	public void setVoltage(int voltage) {
		this.voltage = voltage;
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
    
}
