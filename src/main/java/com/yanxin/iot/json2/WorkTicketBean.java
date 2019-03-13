package com.yanxin.iot.json2;

import java.util.List;

/**
 * Created by zhushiyuan on 2018/2/26.
 * 工作票实体类
 */

public class WorkTicketBean {
	private long id;
	
    private String ticketNumber;//工作票编号
    private String station;//变电站
    private long stationId;
    private String jobUnit;//工作单位
    private String jobClass;//工作班组
    private String jobRespsPerson;//工作负责人
    private String respsPersonPhone;//负责人电话
    private String jobContent;//工作内容
    private String startJobTime;//开工时间
    private String startXuKePerson;//开工许可人
    private String endXuKePerson;//工作票结束许可人
    private String endTime;//结束时间
    private String timeMark;//
    private String jobTicketType;//工作票类型【如一种工作票、二种工作票、其他工作票】
    private long inputDateLong;//创建时间
    private int ywb;//运维班ID
    private List<PassageEquipBean> equipList; // 设备列表
    // 预留
    private String lendTime; // 钥匙借出时间
    private String lendPerson; // 钥匙借出人
    private String returnPerson; // 钥匙归还人
    private String returnTime; // 钥匙归还时间
    
    

    public List<PassageEquipBean> getEquipList() {
        return equipList;
    }

    public void setEquipList(List<PassageEquipBean> equipList) {
        this.equipList = equipList;
    }

    public String getTicketNumber() {
        return ticketNumber;
    }

    public void setTicketNumber(String ticketNumber) {
        this.ticketNumber = ticketNumber;
    }

    public String getStation() {
        return station;
    }

    public void setStation(String station) {
        this.station = station;
    }

    public String getJobUnit() {
        return jobUnit;
    }

    public void setJobUnit(String jobUnit) {
        this.jobUnit = jobUnit;
    }

    public String getJobClass() {
        return jobClass;
    }

    public void setJobClass(String jobClass) {
        this.jobClass = jobClass;
    }

    public String getJobRespsPerson() {
        return jobRespsPerson;
    }

    public void setJobRespsPerson(String jobRespsPerson) {
        this.jobRespsPerson = jobRespsPerson;
    }

    public String getRespsPersonPhone() {
        return respsPersonPhone;
    }

    public void setRespsPersonPhone(String respsPersonPhone) {
        this.respsPersonPhone = respsPersonPhone;
    }

    public String getJobContent() {
        return jobContent;
    }

    public void setJobContent(String jobContent) {
        this.jobContent = jobContent;
    }

    public String getStartJobTime() {
        return startJobTime;
    }

    public void setStartJobTime(String startJobTime) {
        this.startJobTime = startJobTime;
    }

    public String getStartXuKePerson() {
        return startXuKePerson;
    }

    public void setStartXuKePerson(String startXuKePerson) {
        this.startXuKePerson = startXuKePerson;
    }

    public String getEndXuKePerson() {
        return endXuKePerson;
    }

    public void setEndXuKePerson(String endXuKePerson) {
        this.endXuKePerson = endXuKePerson;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getTimeMark() {
        return timeMark;
    }

    public void setTimeMark(String timeMark) {
        this.timeMark = timeMark;
    }

    public String getJobTicketType() {
        return jobTicketType;
    }

    public void setJobTicketType(String jobTicketType) {
        this.jobTicketType = jobTicketType;
    }

    public long getInputDateLong() {
        return inputDateLong;
    }

    public void setInputDateLong(long inputDateLong) {
        this.inputDateLong = inputDateLong;
    }

    public int getYwb() {
        return ywb;
    }

    public void setYwb(int ywb) {
        this.ywb = ywb;
    }

	/**
	 * @return the lendTime
	 */
	public String getLendTime() {
		return lendTime;
	}

	/**
	 * @param lendTime the lendTime to set
	 */
	public void setLendTime(String lendTime) {
		this.lendTime = lendTime;
	}

	/**
	 * @return the lendPersonString
	 */
	public String getLendPerson() {
		return lendPerson;
	}

	/**
	 * @param lendPersonString the lendPersonString to set
	 */
	public void setLendPerson(String lendPerson) {
		this.lendPerson = lendPerson;
	}

	/**
	 * @return the returnPerson
	 */
	public String getReturnPerson() {
		return returnPerson;
	}

	/**
	 * @param returnPerson the returnPerson to set
	 */
	public void setReturnPerson(String returnPerson) {
		this.returnPerson = returnPerson;
	}

	/**
	 * @return the returnTime
	 */
	public String getReturnTime() {
		return returnTime;
	}

	/**
	 * @param returnTime the returnTime to set
	 */
	public void setReturnTime(String returnTime) {
		this.returnTime = returnTime;
	}

	public long getStationId() {
		return stationId;
	}

	public void setStationId(long stationId) {
		this.stationId = stationId;
	}

	/**
	 * @return the id
	 */
	public long getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(long id) {
		this.id = id;
	}
    
    

    //    /**
//     * 判断工作票的工作正在进行
//     * @return
//     */
//    public boolean isActive(){
//        return true;
//    }
}
