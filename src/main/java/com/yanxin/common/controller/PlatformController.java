/**
 * 
 */
package com.yanxin.common.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.iot.Utils.ConstantsUtil;
import com.yanxin.iot.mqtt.CmdLineParser;


/**
 * @author Cheng Guozhen
 * 
 */
public class PlatformController extends Controller {
	
	public void index() {
		getPlatform();
		render("platform.jsp");
	}
	
	public void getSensorCode() {
		
		long roomid = getParaToLong("room");
		long sensor_type = getParaToLong("sensor_type");
		
		List<Record> records = Db.find("select sensor_code,status from sensor where affiliation=4 and owner_id=? and type_id = ?", roomid,sensor_type);
		
		if (records != null && !records.isEmpty()) {
			setAttr("records", records);
			setAttr("result", true);
			renderJson();
		}else {
			setAttr("result", false);
			renderJson();
		}
		
	}
	
	public void getPlatform(){
		String sensorCodeString = getPara("sensor_code");
		List<Record> records = Db.find("select * from platform_point where pp_sensor_code= '"+sensorCodeString+"'");
		if (records != null && !records.isEmpty()) {
			setAttr("records", records);
			setAttr("result", true);
			renderJson();
		}else {
			setAttr("result", false);
			renderJson();
		}
	}
	
	public void getSensorType() {
		
		// String sqlString = "select * from sensor_type where id<>11 and id <>10";
		String sqlString = "select * from sensor_type";
		List<Record> sensorTypeList = Db.find(sqlString);
		setAttr("sensorTypeList", sensorTypeList);
		renderJson();
	}
	
	public void getSensorStatus() {
		
		String sensor_code = getPara("sensor_code");
		
		Record record = Db.findById("sensor", "sensor_code", sensor_code);
		
		setAttr("record", record);
		
		renderJson();
		
	}
	

	public void setPlatform(){
		
		String sensorCodeString = getPara("sensor_code");
		int select = getParaToInt("platform");
		System.out.println(select+"shsjkdhgggggggggggggg");
		
		List<String> sensorList = new ArrayList<String>();
		if(sensorCodeString != null){
			sensorList.add(sensorCodeString);
		}
		
		// 设置预设点
        try {
        	ConstantsUtil.MQTTPlatformCMDBatch(sensorList, ConstantsUtil.PLATFORM_CMD_PRESET, select);
        	setAttr("result", true);
    		renderJson();
        }catch(Exception e){
        	setAttr("result", false);
    		renderJson();
        }
		
		// System.out.println(ConstantsUtil.SERVER_IP+":"+record.getInt("port"));
		
	}
	
	public void setTimePlatform(){
		
		String sensorCodeString = getPara("sensor_code");
		String sensorName = getPara("sensor_name");
		String addTime = getPara("add_time");
		String[] at = null;
		if(addTime != null){
			at = addTime.split(":");
		} else {
			setAttr("result", false);
			
			renderJson();
			return;
		}
		
		Record record = new Record();
		
		record.set("sensor_code", sensorCodeString);
		record.set("sensor_name", sensorName);
		record.set("time", addTime);
		record.set("create_time", new Date());
		record.set("status", 0);
		
		Db.save("time_point", record);
		
		List<Record> records = Db.find("select * from time_point where sensor_code = '"+sensorCodeString+"'");
		
		setAttr("result", true);
		setAttr("records", records);
		
		renderJson();
	}
	
	public void getTimePlatform(){
		
		String sensorCodeString = getPara("sensor_code");
		String sensorName = getPara("sensor_name");
		
		List<Record> records = Db.find("select * from time_point where sensor_code = '"+sensorCodeString+"'");
		
		if(records.isEmpty() ){
			setAttr("result", false);
		} else {
			setAttr("result", true);
			setAttr("records", records);
		}
		
		
		renderJson();
	}
	
	public void deleteTimePlatform(){
		
		String id = getPara("id");
		String sensorCodeString = getPara("sensor_code");
		int timeId = 0;
		if(null != id){
			
			try {
				timeId = Integer.parseInt(id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else {
			timeId = -1;
		}
		
		if(timeId > 0){
			Db.deleteById("time_point", timeId);	
			List<Record> records = Db.find("select * from time_point where sensor_code = '"+sensorCodeString+"'");
			setAttr("result", true);
			setAttr("records", records);
			renderJson();
		}else {
			setAttr("result", false);
			renderJson();
		}
	}
	
	/**
	 * 实时更新某个时间点的状态
	 */
	public void updateTimeStatus() {
		String sensorCodeString = getPara("sensor_code");
		int status = getParaToInt("status");
		int id = getParaToInt("id");
		Db.update("UPDATE time_point set status = "+status+" WHERE sensor_code='"+sensorCodeString+"' and id ="+id);
		
		setAttr("result", true);
		renderJson();
	}
	
	// 需要添加向摄像头发送时刻点命令
	public void submitTimePlatform() {
		String sensorCodeString = getPara("sensor_code");

		List<Record> records1 = Db.find("select * from time_point where sensor_code='"+sensorCodeString+"' and status =1");
		
		// 设置预设点
		ConstantsUtil.MQTTPlatformTimeCMD(sensorCodeString, ConstantsUtil.PLATFORM_CMD_TIMES, records1);
		
		List<Record> records = Db.find("select * from time_point where sensor_code='"+sensorCodeString+"'");
		setAttr("result", true);
		setAttr("records", records);
		renderJson();
	}

	@SuppressWarnings("unused")
	private void command(String sensorCode, long type, String value, long status) {
		String[] args = null;
		final CmdLineParser parser = new CmdLineParser(args);

        parser.startController();
        
        parser.startSwitchPublishController(sensorCode,type,value,status);

	}
	
	@SuppressWarnings("unused")
	private void ffmplayerExecutor(final String cmd){
		Runnable runnable = new Runnable(){
    		public void run(){
    			try {
    				System.out.println("before run");
    				Runtime.getRuntime().exec(cmd);
    				System.out.println("after run");
    			} catch (IOException e) {
    				// TODO Auto-generated catch block
    				e.printStackTrace();
    			}
    			
    		}
    	};
    	
    	new Thread(runnable).start();
	}
	
}
