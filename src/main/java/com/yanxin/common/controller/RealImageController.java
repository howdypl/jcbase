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
public class RealImageController extends Controller {
	
	public void index() {
		getColour();
		render("realimage.jsp");
	}
	
	public void getColour(){
		List<Record> records = Db.find("select id, colour,status from colour");
		if (records != null && !records.isEmpty()) {
			setAttr("records", records);
			setAttr("result", true);
			renderJson();
		}else {
			setAttr("result", false);
			renderJson();
		}
	}
	
	public void createImage(){
		String sensorCodeString = getPara("sensor_code");
		List<String> sensorList = new ArrayList<String>();
		if(sensorCodeString != null){
			sensorList.add(sensorCodeString);
		}
		// 设置预设点
		ConstantsUtil.MQTTPlatformCMDBatch(sensorList, ConstantsUtil.PLATFORM_CMD_IMAGE_CREATE, 0);
		// System.out.println(ConstantsUtil.SERVER_IP+":"+record.getInt("port"));

		renderJson();
		
	}
	
	public void setColour(){
		
		String sensorCodeString = getPara("sensor_code");
		Integer[] selectsIntegers = getParaValuesToInt("colour");
		
		int select = ConstantsUtil.codeMask(selectsIntegers);
	    
		List<String> sensorList = new ArrayList<String>();
		if(sensorCodeString != null){
			sensorList.add(sensorCodeString);
		}
		// 设置预设点
		ConstantsUtil.MQTTPlatformCMDBatch(sensorList, ConstantsUtil.PLATFORM_CMD_IMAGE_COLOR, select);
		// System.out.println(ConstantsUtil.SERVER_IP+":"+record.getInt("port"));

		renderJson();
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
		Integer[] selectsIntegers = getParaValuesToInt("platform");
		
		int select = ConstantsUtil.codeMask(selectsIntegers);
	    
		List<String> sensorList = new ArrayList<String>();
		if(sensorCodeString != null){
			sensorList.add(sensorCodeString);
		}
		// 设置预设点
		ConstantsUtil.MQTTPlatformCMDBatch(sensorList, ConstantsUtil.PLATFORM_CMD_PRESET, select);
		// System.out.println(ConstantsUtil.SERVER_IP+":"+record.getInt("port"));

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
