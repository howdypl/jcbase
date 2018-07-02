/**
 * 
 */
package com.yanxin.common.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.collections.map.StaticBucketMap;
import org.eclipse.paho.client.mqttv3.MqttException;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.iot.Utils.ConstantsUtil;
import com.yanxin.iot.json.TimePayload;
import com.yanxin.iot.mqtt.CmdLineParser;

/**
 * @author Cheng Guozhen
 * 
 */
public class TimeSyncController extends Controller {
	
	public void index() {
		render("timesync.jsp");
	}
	
	public void setTime() {
		try {
			ConstantsUtil.MQTTTimeCommand();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			setAttr("result", true);
			renderJson();
		}

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
	

	public void getVideo(){
		
		final String sensorCodeString = getPara("sensor_code");
		
		
		String colourCodeString = getPara("colour");
		final int colour = Integer.parseInt(colourCodeString);
		
		final Record record = Db.findFirst("select port from sensor where affiliation=4 and sensor_code=?", sensorCodeString);
		setAttr("record", record);
		if(null != record){
			setAttr("result", true);
		}else{
			setAttr("result", false);
		}
		
		
		new Thread(){
	    	   public void run() {
	    		   ConstantsUtil.execCMD(sensorCodeString, ConstantsUtil.SENSOR_TYPE_VIDEO, ConstantsUtil.SERVER_IP+":"+record.getInt("port"), 0, colour);
				}
	       }.start();
	       
		ConstantsUtil.MQTTCommand(sensorCodeString, ConstantsUtil.SENSOR_TYPE_VIDEO, ConstantsUtil.SERVER_IP+":"+record.getInt("port"), 1,colour);
		System.out.println(ConstantsUtil.SERVER_IP+":"+record.getInt("port"));

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
