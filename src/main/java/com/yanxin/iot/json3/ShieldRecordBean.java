package com.yanxin.iot.json3;

import java.util.List;

import com.yanxin.iot.json2.StationBean;

/**
 * Created by ${GuozhenCheng} on 2018/3/29.
 */
//华为推送的变电站
public class ShieldRecordBean {
	//运维班id
    private int ywbId;
  //运维班名称
    private String ywbName;
	//用户名
	private String username;
	//变电站id
    private long stationId;
  //变电站名称
    private String stationName;
    //是否接收告警，true接收告警，false屏蔽告警
    private boolean accept;
    //配置时间
    private String createTime;

    public int getYwbId() {
        return ywbId;
    }

    public void setYwbId(int ywbId) {
        this.ywbId = ywbId;
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

	/**
	 * @return the createTime
	 */
	public String getCreateTime() {
		return createTime;
	}

	/**
	 * @param createTime the createTime to set
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	/**
	 * @return the accept
	 */
	public boolean isAccept() {
		return accept;
	}

	/**
	 * @param accept the accept to set
	 */
	public void setAccept(boolean accept) {
		this.accept = accept;
	}

	/**
	 * @return the stationName
	 */
	public String getStationName() {
		return stationName;
	}

	/**
	 * @param stationName the stationName to set
	 */
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}

	/**
	 * @return the stationId
	 */
	public long getStationId() {
		return stationId;
	}

	/**
	 * @param stationId the stationId to set
	 */
	public void setStationId(long stationId) {
		this.stationId = stationId;
	}

	/**
	 * @return the ywbName
	 */
	public String getYwbName() {
		return ywbName;
	}

	/**
	 * @param ywbName the ywbName to set
	 */
	public void setYwbName(String ywbName) {
		this.ywbName = ywbName;
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
