package com.yanxin.iot.json2;

/**
 * Created by zhushiyuan on 2018/2/26.
 * 通道实体类
 */

public class PassageEquipBean{
    private String equipName;//设备名称
    private String equipNumber;//设备唯一编号
    private long state = 0;//True:打开，false关闭
    private int alarmType = 0;//0:正常，其他值对应各种报警状态（待完善）
    private int troubleType = 0;//0:正常，其他值对应应各种设备问题
    private int alertType = 0;  //告警类型
    private int activeTicketNumber = 0;//当前时间正在进行的工作票数量

    private long equipType = 0;//设备类型，如1：门，2窗等
    private String station;//所属变电站
    private String region;//所在区域
    private int voltage = 0; //电压值
    private String time; //最近唤醒时间
    public String getEquipName() {
        return equipName;
    }

    public void setEquipName(String equipName) {
        this.equipName = equipName;
    }

    public long isState() {
        return state;
    }

    public void setState(long state) {
        this.state = state;
    }

    public int getAlarmType() {
        return alarmType;
    }

    public void setAlarmType(int alarmType) {
        this.alarmType = alarmType;
    }

    public int getTroubleType() {
        return troubleType;
    }

    public void setTroubleType(int troubleType) {
        this.troubleType = troubleType;
    }

    public int getActiveTicketNumber() {
        return activeTicketNumber;
    }

    public void setActiveTicketNumber(int activeTicketNumber) {
        this.activeTicketNumber = activeTicketNumber;
    }

    public String getEquipNumber() {
        return equipNumber;
    }

    public void setEquipNumber(String equipNumber) {
        this.equipNumber = equipNumber;
    }

    public long getEquipType() {
        return equipType;
    }

    public void setEquipType(long equipType) {
        this.equipType = equipType;
    }

    public String getStation() {
        return station;
    }

    public void setStation(String station) {
        this.station = station;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

	public int getAlertType() {
		return alertType;
	}

	public void setAlertType(int alertType) {
		this.alertType = alertType;
	}

    //    private int alarmType;//报警类型
//    private int troubleType;//故障类型
//    private List<WorkTicketBean> ticketList;//关联工作票列表
//
//    public int getAlarmType() {
//        return alarmType;
//    }
//
//    public void setAlarmType(int alarmType) {
//        this.alarmType = alarmType;
//    }
//
//    public int getTroubleType() {
//        return troubleType;
//    }
//
//    public void setTroubleType(int troubleType) {
//        this.troubleType = troubleType;
//    }
//
//    public List<WorkTicketBean> getTicketList() {
//        return ticketList;
//    }
//
//    public void setTicketList(List<WorkTicketBean> ticketList) {
//        this.ticketList = ticketList;
//    }
}
