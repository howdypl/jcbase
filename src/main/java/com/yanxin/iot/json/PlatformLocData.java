/**
 * 
 */
package com.yanxin.iot.json;

/**
 * @author Cheng Guozhen
 * 
 */
public class PlatformLocData {

    private int type;
    private int value;
    private int status;

	public PlatformLocData(int type, int value) {
		super();
		this.type = type;
		this.value = value;
	}

	public PlatformLocData(int type, int value, int status) {
		super();
		this.type = type;
		this.value = value;
		this.status = status;
	}



	/**
	 * @return the type
	 */
	public int getType() {
		return type;
	}
	/**
	 * @param type the type to set
	 */
	public void setType(int type) {
		this.type = type;
	}
	/**
	 * @return the angle
	 */
	public int getValue() {
		return value;
	}
	/**
	 * @param angle the angle to set
	 */
	public void setValue(int value) {
		this.value = value;
	}
	/**
	 * @return the status
	 */
	public int getStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(int status) {
		this.status = status;
	}
	
	

}
