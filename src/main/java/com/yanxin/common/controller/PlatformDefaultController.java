/**
 * 
 */
package com.yanxin.common.controller;

import java.io.IOException;
import java.util.ArrayList;
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
public class PlatformDefaultController extends Controller {
	
	public void index() {
		getPlatform();
		render("platformdefault.jsp");
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
		String setName = "预设点";
		for (int i = 0; i < 9; i++) {
			if((select >> i+1) == 0){
				int j = i+1;
				setName += j;
				break;
			}
		}
		System.out.println("setName="+setName);
		Db.update("UPDATE platform_point set status = 0 WHERE pp_sensor_code='"+sensorCodeString+"'");
		Db.update("UPDATE platform_point set status = 1 WHERE pp_sensor_code='"+sensorCodeString+"' and platform_code = '"+setName+"'");

		List<String> sensorList = new ArrayList<String>();
		if(sensorCodeString != null){
			sensorList.add(sensorCodeString);
		}
		
		// 设置预设点
		ConstantsUtil.MQTTPlatformCMDBatch(sensorList, ConstantsUtil.PLATFORM_CMD_PRESET_DEFAULT, select);
		// System.out.println(ConstantsUtil.SERVER_IP+":"+record.getInt("port"));
		setAttr("result", true);
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
