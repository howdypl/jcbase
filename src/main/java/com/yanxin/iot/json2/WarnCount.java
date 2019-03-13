package com.yanxin.iot.json2;

/**
 * @author Cheng Guozhen
 * 告警数 + 工作票数 
 * 告警数和工作票数都是累计的
 */
public class WarnCount {
	//    运维班名称
    public String ywb;
    //    门禁告警数
    public int door = 0;
    //    窗体告警数
    public int window = 0;
    //    井盖告警数
    public int holeCover = 0;
    //    挡板告警数
    public int guard = 0;
    //    工作票数量
    public int wtCount = 0;
    //    告警总数
    public int warnCount = 0;
    
	/**
	 * @return the ywb
	 */
	public String getYwb() {
		return ywb;
	}
	
	/**
	 * @param ywb the ywb to set
	 */
	public void setYwb(String ywb) {
		this.ywb = ywb;
	}
	
	/**
	 * @return the door
	 */
	public int getDoor() {
		return door;
	}
	
	/**
	 * @param door the door to set
	 */
	public void setDoor(int door) {
		this.door = door;
	}
	
	/**
	 * @return the window
	 */
	public int getWindow() {
		return window;
	}
	
	/**
	 * @param window the window to set
	 */
	public void setWindow(int window) {
		this.window = window;
	}
	
	/**
	 * @return the holeCover
	 */
	public int getHoleCover() {
		return holeCover;
	}
	
	/**
	 * @param holeCover the holeCover to set
	 */
	public void setHoleCover(int holeCover) {
		this.holeCover = holeCover;
	}
	
	/**
	 * @return the guard
	 */
	public int getGuard() {
		return guard;
	}
	
	/**
	 * @param guard the guard to set
	 */
	public void setGuard(int guard) {
		this.guard = guard;
	}
	
	/**
	 * @return the wtCount
	 */
	public int getWtCount() {
		return wtCount;
	}
	
	/**
	 * @param wtCount the wtCount to set
	 */
	public void setWtCount(int wtCount) {
		this.wtCount = wtCount;
	}
	
	/**
	 * @return the warnCount
	 */
	public int getWarnCount() {
		return warnCount;
	}
	
	/**
	 * @param warnCount the warnCount to set
	 */
	public void setWarnCount(int warnCount) {
		this.warnCount = warnCount;
	}
    
}

