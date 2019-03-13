package com.yanxin.iot.json2;

import java.util.ArrayList;
import java.util.List;

import javassist.expr.NewArray;

/**
 * Created by zhushiyuan on 2018/2/26.
 * 变电站实体类
 */

public class SubstationBean {
    private long stationId;//变电站ID
    private String stationName;//变电站名称
   /* private long regionId;//区域ID
    private String regionName;//区域名称
*/    private int alarmNumber = 0;//告警数量
    private int doorOpen = 0;//打开门的数量
    private int doorNumber = 0;//门总数量
    private int barrierOpen = 0;//防鼠栅栏打开数量
    private int barrierNumber = 0;//防鼠栅栏总数
    private int windowOpen = 0;//窗户打开数量
    private int windowNumber = 0;//窗户总数
    private int holeCoverOpen = 0;//井盖打开数量
    private int holeCoverNumber = 0;//井盖总数
    private int otherOpen = 0;//其他通道设备打开数量
    private int otherNumber = 0;//其他通道设备总数
    private int activeTicketNumber = 0;//当前时间正在进行的工作票数量
    private List<BaseEquip> equipList = new ArrayList<BaseEquip>();
    
    private List<RegionNameBean> regions = new ArrayList<RegionNameBean>(); // 区域列表

    public List<BaseEquip> getEquipList() {
        return equipList;
    }

    public void setEquipList(List<BaseEquip> equipList) {
        this.equipList = equipList;
    }

    public long getStationId() {
        return stationId;
    }

    public void setStationId(long stationId) {
        this.stationId = stationId;
    }

    public String getStationName() {
        return stationName;
    }

    public void setStationName(String stationName) {
        this.stationName = stationName;
    }

	public int getAlarmNumber() {
        return alarmNumber;
    }

    public void setAlarmNumber(int alarmNumber) {
        this.alarmNumber = alarmNumber;
    }

    public int getDoorOpen() {
        return doorOpen;
    }

    public void setDoorOpen(int doorOpen) {
        this.doorOpen = doorOpen;
    }

    public int getDoorNumber() {
        return doorNumber;
    }

    public void setDoorNumber(int doorNumber) {
        this.doorNumber = doorNumber;
    }

    public int getBarrierOpen() {
        return barrierOpen;
    }

    public void setBarrierOpen(int barrierOpen) {
        this.barrierOpen = barrierOpen;
    }

    public int getBarrierNumber() {
        return barrierNumber;
    }

    public void setBarrierNumber(int barrierNumber) {
        this.barrierNumber = barrierNumber;
    }

    public int getWindowOpen() {
        return windowOpen;
    }

    public void setWindowOpen(int windowOpen) {
        this.windowOpen = windowOpen;
    }

    public int getWindowNumber() {
        return windowNumber;
    }

    public void setWindowNumber(int windowNumber) {
        this.windowNumber = windowNumber;
    }

    public int getHoleCoverOpen() {
        return holeCoverOpen;
    }

    public void setHoleCoverOpen(int holeCoverOpen) {
        this.holeCoverOpen = holeCoverOpen;
    }

    public int getHoleCoverNumber() {
        return holeCoverNumber;
    }

    public void setHoleCoverNumber(int holeCoverNumber) {
        this.holeCoverNumber = holeCoverNumber;
    }

    public int getOtherOpen() {
        return otherOpen;
    }

    public void setOtherOpen(int otherOpen) {
        this.otherOpen = otherOpen;
    }

    public int getOtherNumber() {
        return otherNumber;
    }

    public void setOtherNumber(int otherNumber) {
        this.otherNumber = otherNumber;
    }

    public int getActiveTicketNumber() {
        return activeTicketNumber;
    }

    public void setActiveTicketNumber(int activeTicketNumber) {
        this.activeTicketNumber = activeTicketNumber;
    }

	/**
	 * @return the regions
	 */
	public List<RegionNameBean> getRegions() {
		return regions;
	}

	/**
	 * @param regions the regions to set
	 */
	public void setRegions(List<RegionNameBean> regions) {
		this.regions = regions;
	}


//    private List<PassageEquipBean> equipBeanList;//变电站下通道设备列表

//    /**
//     * 获取报警设备数量
//     * @return 报警设备数量
//     */
//    private int getAlarmEquipNumber(){
//        List<PassageEquipBean> troubleEquipList = getAlarmEquipList();
//
//        return troubleEquipList.size();
//    }
//    /**
//     * 获取报警设备
//     * @return 报警设备
//     */
//    private List<PassageEquipBean> getAlarmEquipList(){
//        List<PassageEquipBean> troubleEquipList = new ArrayList<>();
//        if (equipBeanList!=null){
//            for (PassageEquipBean equipBean:equipBeanList){
//                if (equipBean.getAlarmType()!=0||equipBean.getTroubleType()!=0){
//                    troubleEquipList.add(equipBean);
//                }
//            }
//        }
//
//        return troubleEquipList;
//    }
//
//    /**
//     * 获取正在进行的工作票数量
//     * @return
//     */
//    private int getActiveWorkTicketNumber(){
//        return 0;
//    }
//    /**
//     * 获取正在进行的工作票
//     * @return
//     */
//    private List<WorkTicketBean> getActiveWorkTicketList(){
//        List<WorkTicketBean> activeTicketList = new ArrayList<>();
//        if (equipBeanList!=null){
//            for (PassageEquipBean equipBean:equipBeanList){      // TODO: 2018/2/27 获取所有工作票
//                if (equipBean.getTicketList()!=null){
//                    for (WorkTicketBean ticketBean:equipBean.getTicketList()){
////                        if (ticketBean.isActived()){
////                            activeTicketList.add(ticketBean);
////                        }
//
//                    }
//                }
//            }
//        }
//        return activeTicketList;
//    }
}
