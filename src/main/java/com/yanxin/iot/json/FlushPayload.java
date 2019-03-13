/**
 * 
 */
package com.yanxin.iot.json;

import java.util.ArrayList;

/**
 * @author Guozhen Cheng
 *
 */
public class FlushPayload {

    private String deviceId;
    private ArrayList<PlatformLocData> data;
	/**
	 * 
	 */
	public FlushPayload() {
		// TODO Auto-generated constructor stub
	}
	
	
	public FlushPayload(String deviceId, ArrayList<PlatformLocData> data) {
		super();
		this.deviceId = deviceId;
		this.data = data;
	}


	/**
	 * @return the deviceId
	 */
	public String getDeviceId() {
		return deviceId;
	}
	/**
	 * @param deviceId the deviceId to set
	 */
	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}
	/**
	 * @return the data
	 */
	public ArrayList<PlatformLocData> getData() {
		return data;
	}
	/**
	 * @param data the data to set
	 */
	public void setData(ArrayList<PlatformLocData> data) {
		this.data = data;
	}


	@Override
	public String toString() {
		String output = "deviceId="+deviceId+" status="+data.get(0).getStatus()+" type="+data.get(0).getType()+" value="+data.get(0).getValue();
	
		return output;
	}
}
