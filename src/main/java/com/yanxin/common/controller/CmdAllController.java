/**
 * 
 */
package com.yanxin.common.controller;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.iot.mqtt.CmdLineParser;

/**
 * @author Cheng Guozhen
 * 
 */
public class CmdAllController extends Controller {
	
	public void index() {
		render("cmdall.jsp");
	}

	
	public void isExisting() {
		String sensorCode = getPara("sensor_code");
		
		Record record = Db.findById("sensor", "sensor_code", sensorCode);
		if(null != record){
			setAttr("record", record);
			setAttr("hasExisting", 1);
		}else{
			setAttr("hasExisting", 0);
		}
		
		renderJson();
	}
	
	public void installCmd() {
		
		String sensorCodeString = getPara("sensor_code");
		long sensorType = getParaToLong("type");
		long status = getParaToLong("status");
		
		int result = Db.update("update sensor set status=? where sensor_code =?", status,sensorCodeString);
		
		// command(sensorCodeString, sensorType, 0, status);
		
		if(result > 0){
			
			setAttr("result", true);
			
		}else{
			setAttr("result", false);
		}
		
		renderJson();
	}
	
	/*private void command(String sensorCode, long type, long value, long status) {
		String[] args = null;
		final CmdLineParser parser = new CmdLineParser(args);

        parser.startController();
        
        parser.startSwitchPublishController(sensorCode,type,value,status);
    
	}*/
}
