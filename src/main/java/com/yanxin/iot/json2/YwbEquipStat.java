/**
 * 
 */
package com.yanxin.iot.json2;

/**
 * @author YT
 *
 */
public class YwbEquipStat {
	
	public long ywbId;
	//    运维班
    public String ywb;
    //    门禁数量
    private int doorCount = 0;
    //    窗户数量
    private int windowCount = 0;
    //    挡板数量
    private int guardCount = 0;
    //    井盖数量
    private int holeCover = 0;
    //  有告警的门禁数量
    private int doorHasWarn = 0;
    //  有告警的窗户数量
    private int windowHasWarn = 0;
    //  有告警的挡板数量
    private int guardHasWarn = 0;
    //  有告警的井盖数量
    private int holeCoverHasWarn = 0;
    
	/**
	 * @return the ywbId
	 */
	public long getYwbId() {
		return ywbId;
	}
	/**
	 * @param ywbId the ywbId to set
	 */
	public void setYwbId(long ywbId) {
		this.ywbId = ywbId;
	}
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
	 * @return the doorCount
	 */
	public int getDoorCount() {
		return doorCount;
	}
	/**
	 * @param doorCount the doorCount to set
	 */
	public void setDoorCount(int doorCount) {
		this.doorCount = doorCount;
	}
	/**
	 * @return the windowCount
	 */
	public int getWindowCount() {
		return windowCount;
	}
	/**
	 * @param windowCount the windowCount to set
	 */
	public void setWindowCount(int windowCount) {
		this.windowCount = windowCount;
	}
	/**
	 * @return the guardCount
	 */
	public int getGuardCount() {
		return guardCount;
	}
	/**
	 * @param guardCount the guardCount to set
	 */
	public void setGuardCount(int guardCount) {
		this.guardCount = guardCount;
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
	 * @return the doorHasWarn
	 */
	public int getDoorHasWarn() {
		return doorHasWarn;
	}
	/**
	 * @param doorHasWarn the doorHasWarn to set
	 */
	public void setDoorHasWarn(int doorHasWarn) {
		this.doorHasWarn = doorHasWarn;
	}
	/**
	 * @return the windowHasWarn
	 */
	public int getWindowHasWarn() {
		return windowHasWarn;
	}
	/**
	 * @param windowHasWarn the windowHasWarn to set
	 */
	public void setWindowHasWarn(int windowHasWarn) {
		this.windowHasWarn = windowHasWarn;
	}
	/**
	 * @return the guardv
	 */
	public int getGuardHasWarn() {
		return guardHasWarn;
	}
	/**
	 * @param guardv the guardv to set
	 */
	public void setGuardHasWarn(int guardHasWarn) {
		this.guardHasWarn = guardHasWarn;
	}
	/**
	 * @return the holeCoverHasWarn
	 */
	public int getHoleCoverHasWarn() {
		return holeCoverHasWarn;
	}
	/**
	 * @param holeCoverHasWarn the holeCoverHasWarn to set
	 */
	public void setHoleCoverHasWarn(int holeCoverHasWarn) {
		this.holeCoverHasWarn = holeCoverHasWarn;
	}
       
}
