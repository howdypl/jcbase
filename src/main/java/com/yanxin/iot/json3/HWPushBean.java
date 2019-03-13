package com.yanxin.iot.json3;

import java.util.List;

import com.yanxin.iot.json2.StationBean;

/**
 * Created by ${MaXiaoYin} on 2018/3/29.
 */
//华为推送的变电站
public class HWPushBean {
	//运维班id
    private int ywbId;
    //接收的token
	private String token;
	//用户名
	private String username;
	//变电站id
	private List<StationBean> data;
	
    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public int getYwbId() {
        return ywbId;
    }

    public void setYwbId(int ywbId) {
        this.ywbId = ywbId;
    }

	/**
	 * @return the data
	 */
	public List<StationBean> getData() {
		return data;
	}

	/**
	 * @param data the data to set
	 */
	public void setData(List<StationBean> data) {
		this.data = data;
	}

	/**
	 * @return the username
	 */
	public String getUsername() {
		return username;
	}

	/**
	 * @param username the username to set
	 */
	public void setUsername(String username) {
		this.username = username;
	}



 /*   @Override
    public String toString() {
        return "HWPullStationBean{" +
                "ywbId=" + ywbId +
                ", stationId=" + stationId +
                ", token='" + token + '\'' +
                ", name='" + name + '\'' +
                '}';
    }*/
}
