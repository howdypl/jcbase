package com.yanxin.iot.json2;

/**
 * @author Cheng Guozhen
 * 通道数和告警数指当前的数量，工作票数指未终结数
 */
public class DynamicState{
	//    运维班
    public String ywb;
    //    通道总数
    public int tDSum = 0;
    //    开启的通道
    public int openTdSum = 0;
    //    当前工作票未终结的数量
    public int wtCount = 0;
    //    告警总数
    public int warnCount = 0;
    //    门禁开着的数量
    public int doorOCount = 0;
    //    窗户开着的数量
    public int windowOCount = 0;
    //    挡板开着的数量
    public int guardOCount = 0;
    //    井盖开着的数量
    public int holeOCover = 0;
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
	 * @return the tDSum
	 */
	public int gettDSum() {
		return tDSum;
	}
	/**
	 * @param tDSum the tDSum to set
	 */
	public void settDSum(int tDSum) {
		this.tDSum = tDSum;
	}
	/**
	 * @return the openSum
	 */
	public int getOpenTdSum() {
		return openTdSum;
	}
	/**
	 * @param openSum the openSum to set
	 */
	public void setOpenTdSum(int openTdSum) {
		this.openTdSum = openTdSum;
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
	/**
	 * @return the doorOCount
	 */
	public int getDoorOCount() {
		return doorOCount;
	}
	/**
	 * @param doorOCount the doorOCount to set
	 */
	public void setDoorOCount(int doorOCount) {
		this.doorOCount = doorOCount;
	}
	/**
	 * @return the windowOCount
	 */
	public int getWindowOCount() {
		return windowOCount;
	}
	/**
	 * @param windowOCount the windowOCount to set
	 */
	public void setWindowOCount(int windowOCount) {
		this.windowOCount = windowOCount;
	}
	/**
	 * @return the guardOCount
	 */
	public int getGuardOCount() {
		return guardOCount;
	}
	/**
	 * @param guardOCount the guardOCount to set
	 */
	public void setGuardOCount(int guardOCount) {
		this.guardOCount = guardOCount;
	}
	/**
	 * @return the holeOCover
	 */
	public int getHoleOCover() {
		return holeOCover;
	}
	/**
	 * @param holeOCover the holeOCover to set
	 */
	public void setHoleOCover(int holeOCover) {
		this.holeOCover = holeOCover;
	}
}
