/**
 * 
 */
package com.yanxin.iot.json2;

/**
 * @author Guozhen Cheng
 *
 */
public class OpenEquipStat {

    //    门禁开着的数量
    private int doorOCount = 0;
    //    窗户开着的数量
    private int windowOCount = 0;
    //    挡板开着的数量
    private int guardOCount = 0;
    //    井盖开着的数量
    private int holeOCover = 0;
    
    private int other = 0;

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
	/**
	 * @return the other
	 */
	public int getOther() {
		return other;
	}
	/**
	 * @param other the other to set
	 */
	public void setOther(int other) {
		this.other = other;
	}
 
}
