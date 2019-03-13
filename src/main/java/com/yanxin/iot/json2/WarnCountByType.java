/**
 * 
 */
package com.yanxin.iot.json2;

/**
 * @author Guozhen Cheng
 *
 */
public class WarnCountByType {
	
    //门禁无授权进入
    private int openDoorNoAuth = 0;
    //门禁开启超时
    private int openDoorTimeOut = 0;
    
    //窗户违规开启
    private int openWindowNoAuth = 0;
    //井盖违规开启
    private int openHoleCoverNoAuth = 0;
    //挡板违规开启
    private int openGuardNoAuth = 0;
    
    //其它告警数
    private int others = 0;
	/**
	 * @return the openDoorNoAuth
	 */
	public int getOpenDoorNoAuth() {
		return openDoorNoAuth;
	}
	/**
	 * @param openDoorNoAuth the openDoorNoAuth to set
	 */
	public void setOpenDoorNoAuth(int openDoorNoAuth) {
		this.openDoorNoAuth = openDoorNoAuth;
	}
	/**
	 * @return the openDoorTimeOut
	 */
	public int getOpenDoorTimeOut() {
		return openDoorTimeOut;
	}
	/**
	 * @param openDoorTimeOut the openDoorTimeOut to set
	 */
	public void setOpenDoorTimeOut(int openDoorTimeOut) {
		this.openDoorTimeOut = openDoorTimeOut;
	}
	/**
	 * @return the openWindowNoAuth
	 */
	public int getOpenWindowNoAuth() {
		return openWindowNoAuth;
	}
	/**
	 * @param openWindowNoAuth the openWindowNoAuth to set
	 */
	public void setOpenWindowNoAuth(int openWindowNoAuth) {
		this.openWindowNoAuth = openWindowNoAuth;
	}
	/**
	 * @return the openHoleCoverNoAuth
	 */
	public int getOpenHoleCoverNoAuth() {
		return openHoleCoverNoAuth;
	}
	/**
	 * @param openHoleCoverNoAuth the openHoleCoverNoAuth to set
	 */
	public void setOpenHoleCoverNoAuth(int openHoleCoverNoAuth) {
		this.openHoleCoverNoAuth = openHoleCoverNoAuth;
	}
	/**
	 * @return the openGuardNoAuth
	 */
	public int getOpenGuardNoAuth() {
		return openGuardNoAuth;
	}
	/**
	 * @param openGuardNoAuth the openGuardNoAuth to set
	 */
	public void setOpenGuardNoAuth(int openGuardNoAuth) {
		this.openGuardNoAuth = openGuardNoAuth;
	}
	/**
	 * @return the others
	 */
	public int getOthers() {
		return others;
	}
	/**
	 * @param others the others to set
	 */
	public void setOthers(int others) {
		this.others = others;
	}
}
