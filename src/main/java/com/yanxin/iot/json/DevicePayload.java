package com.yanxin.iot.json;

import java.util.ArrayList;

/**
 * Created by Guozhen Cheng on 2017/6/18.
 */
public class DevicePayload {

    private String deviceId;
    private ArrayList<DeviceData> data;

    private String time;

    public DevicePayload(String deviceId, ArrayList<DeviceData> data, String time) {
        this.deviceId = deviceId;
        this.data = data;
        this.time = time;
    }

    public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }

    public ArrayList<DeviceData> getData() {
        return data;
    }

    public void setData(ArrayList<DeviceData> data) {
        this.data = data;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    @Override
    public String toString() {
        StringBuffer sb = new StringBuffer();
        sb.append("\ndeviceId="+getDeviceId()+"\n");
        sb.append("data="+getData().toString()+"\n");
        sb.append("time="+getTime()+"\n");
        return sb.toString();
    }
}
