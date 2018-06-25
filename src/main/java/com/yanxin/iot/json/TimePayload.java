/**
 * 
 */
package com.yanxin.iot.json;

/**
 * @author Cheng guozhen
 *
 */
public class TimePayload {
	
	private String deviceId = "ffffffffffff";
	
	private String time;

	public TimePayload(String time) {
		this.time = time;
	}
	
	
	public String getDeviceId() {
		return deviceId;
	}



	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}



	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}


	@Override
	public String toString() {
        StringBuilder sb = new StringBuilder();

        sb.append("deviceId="+this.getDeviceId()+" ");
        sb.append("time="+getTime()+"");

        return sb.toString();
	}
	
	

}
