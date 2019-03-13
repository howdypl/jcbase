package com.yanxin.iot.json2;

import java.util.List;

import com.yanxin.common.model.Images;

/**
 * Created by zhushiyuan on 2018/2/26.
 * 告警信息实体类
 */

public class AlarmMessageBean {
    private String equipName;//对应设备名称
    private String equipNumber;//对应设备唯一编号
    private int equipState;//设备开启状态
    private int alarmType;//报警类型，如0：正常，其他值对应其他报警状态
    private long equipAlarmType;//设备异常，如0：正常，其他值对应
    // 1:无授权开启通道;2:开启超时;3：设备异常；4：电量低；5：打开操作；6：关闭操作；
    private long alertType; 
    private String time;//操作时间或者产生记录时间
    private String ticketNumber;//工作票唯一编号，如果当时变电站有工作票正在进行
    private String person;//工作票负责人，是否为空同上
    private String phone;//负责人电话，是否为空同上
    private boolean alarmState;//报警状态，true未消除，false以消除或者设备正常开启关闭（根据alarmType判断）
    private long alarmNumber;//  操作信息唯一编号
    private String station; //变电站名称
    private String ywbName; // 运维班名称
	private long sms;  //1：未发送；2：已发送;
	private String smsContent = "";
	
	private String regionName = "";
	
	private String removePerson= "";
    //设备电压值
	private float voltage = 0;
	private String power = "";
	
    private List<SimpleWorkTicketBean> ticketList;
    
    private List<Images> imageList; // 曝光图片列表

    public String getEquipName() {
        return equipName;
    }

    public void setEquipName(String equipName) {
        this.equipName = equipName;
    }

    public String getEquipNumber() {
        return equipNumber;
    }

    public void setEquipNumber(String equipNumber) {
        this.equipNumber = equipNumber;
    }

    public int isEquipState() {
        return equipState;
    }

    public void setEquipState(int equipState) {
        this.equipState = equipState;
    }

    public int getAlarmType() {
        return alarmType;
    }

    public void setAlarmType(int alarmType) {
        this.alarmType = alarmType;
    }

    public long getEquipAlarmType() {
        return equipAlarmType;
    }

    public void setEquipAlarmType(long equipAlarmType) {
        this.equipAlarmType = equipAlarmType;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getTicketNumber() {
        return ticketNumber;
    }

    public void setTicketNumber(String ticketNumber) {
        this.ticketNumber = ticketNumber;
    }

    public String getPerson() {
        return person;
    }

    public void setPerson(String person) {
        this.person = person;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public boolean isAlarmState() {
        return alarmState;
    }

    public void setAlarmState(boolean alarmState) {
        this.alarmState = alarmState;
    }

    public long getAlarmNumber() {
        return alarmNumber;
    }

    public void setAlarmNumber(long alarmNumber) {
        this.alarmNumber = alarmNumber;
    }
    
    

	/**
	 * @return the removePerson
	 */
	public String getRemovePerson() {
		return removePerson;
	}

	/**
	 * @param removePerson the removePerson to set
	 */
	public void setRemovePerson(String removePerson) {
		this.removePerson = removePerson;
	}

	/**
	 * @return the equipState
	 */
	public int getEquipState() {
		return equipState;
	}

	/**
	 * @return the alertType
	 */
	public long getAlertType() {
		return alertType;
	}

	/**
	 * @param alertType the alertType to set
	 */
	public void setAlertType(long alertType) {
		this.alertType = alertType;
	}

	/**
	 * @return the ticketList
	 */
	public List<SimpleWorkTicketBean> getTicketList() {
		return ticketList;
	}

	/**
	 * @param ticketList the ticketList to set
	 */
	public void setTicketList(List<SimpleWorkTicketBean> ticketList) {
		this.ticketList = ticketList;
	}

	/**
	 * @return the sms
	 */
	public long getSms() {
		return sms;
	}

	/**
	 * @param sms the sms to set
	 */
	public void setSms(long sms) {
		this.sms = sms;
	}

	/**
	 * @return the smsContent
	 */
	public String getSmsContent() {
		return smsContent;
	}

	/**
	 * @param smsContent the smsContent to set
	 */
	public void setSmsContent(String smsContent) {
		this.smsContent = smsContent;
	}

	/**
	 * @return the imageList
	 */
	public List<Images> getImageList() {
		return imageList;
	}

	/**
	 * @param imageList the imageList to set
	 */
	public void setImageList(List<Images> imageList) {
		this.imageList = imageList;
	}

	/**
	 * @return the station
	 */
	public String getStation() {
		return station;
	}

	/**
	 * @param station the station to set
	 */
	public void setStation(String station) {
		this.station = station;
	}

	/**
	 * @return the voltage
	 */
	public float getVoltage() {
		return voltage;
	}

	/**
	 * @param voltage the voltage to set
	 */
	public void setVoltage(float voltage) {
		this.voltage = voltage;
	}

	/**
	 * @return the regionName
	 */
	public String getRegionName() {
		return regionName;
	}

	/**
	 * @param regionName the regionName to set
	 */
	public void setRegionName(String regionName) {
		this.regionName = regionName;
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

	public String getPower() {
		return power;
	}

	public void setPower(String power) {
		this.power = power;
	}
}
