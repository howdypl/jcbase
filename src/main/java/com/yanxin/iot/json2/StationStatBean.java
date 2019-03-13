/**
 * 
 */
package com.yanxin.iot.json2;

/**
 * @author guozhen cheng
 *
 */
public class StationStatBean {
	
	private long stationId;//变电站ID
	private String stationName;//变电站名称
	private int alarmNumber = 0;//告警数量
	private int doorOpen = 0;//打开门的数量
	private int doorNumber = 0;//门总数量
	private int barrierOpen = 0;//防鼠栅栏打开数量
	private int barrierNumber = 0;//防鼠栅栏总数
	private int windowOpen = 0;//窗户打开数量
	private int windowNumber = 0;//窗户总数
	private int holeCoverOpen = 0;//井盖打开数量
	private int holeCoverNumber = 0;//井盖总数
	private int otherOpen = 0;//其他通道设备打开数量
	private int otherNumber = 0;//其他通道设备总数
	private int activeTicketNumber = 0;//当前时间正在进行的工作票数量
	
	public long getStationId() {
		return stationId;
	}
	public void setStationId(long stationId) {
		this.stationId = stationId;
	}
	public String getStationName() {
		return stationName;
	}
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	public int getAlarmNumber() {
		return alarmNumber;
	}
	public void setAlarmNumber(int alarmNumber) {
		this.alarmNumber = alarmNumber;
	}
	public int getDoorOpen() {
		return doorOpen;
	}
	public void setDoorOpen(int doorOpen) {
		this.doorOpen = doorOpen;
	}
	public int getDoorNumber() {
		return doorNumber;
	}
	public void setDoorNumber(int doorNumber) {
		this.doorNumber = doorNumber;
	}
	public int getBarrierOpen() {
		return barrierOpen;
	}
	public void setBarrierOpen(int barrierOpen) {
		this.barrierOpen = barrierOpen;
	}
	public int getBarrierNumber() {
		return barrierNumber;
	}
	public void setBarrierNumber(int barrierNumber) {
		this.barrierNumber = barrierNumber;
	}
	public int getWindowOpen() {
		return windowOpen;
	}
	public void setWindowOpen(int windowOpen) {
		this.windowOpen = windowOpen;
	}
	public int getWindowNumber() {
		return windowNumber;
	}
	public void setWindowNumber(int windowNumber) {
		this.windowNumber = windowNumber;
	}
	public int getHoleCoverOpen() {
		return holeCoverOpen;
	}
	public void setHoleCoverOpen(int holeCoverOpen) {
		this.holeCoverOpen = holeCoverOpen;
	}
	public int getHoleCoverNumber() {
		return holeCoverNumber;
	}
	public void setHoleCoverNumber(int holeCoverNumber) {
		this.holeCoverNumber = holeCoverNumber;
	}
	public int getOtherOpen() {
		return otherOpen;
	}
	public void setOtherOpen(int otherOpen) {
		this.otherOpen = otherOpen;
	}
	public int getOtherNumber() {
		return otherNumber;
	}
	public void setOtherNumber(int otherNumber) {
		this.otherNumber = otherNumber;
	}
	public int getActiveTicketNumber() {
		return activeTicketNumber;
	}
	public void setActiveTicketNumber(int activeTicketNumber) {
		this.activeTicketNumber = activeTicketNumber;
	}
	
	

}
