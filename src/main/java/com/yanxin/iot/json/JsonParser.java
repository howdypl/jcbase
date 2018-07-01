package com.yanxin.iot.json;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.iot.Utils.ConstantsUtil;

import javassist.expr.NewArray;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Guozhen Cheng on 2017/6/18.
 */
public class JsonParser {

    private static Logger log = LoggerFactory.getLogger(JsonParser.class);
    private static Gson gson;
    
    public JsonParser() {
        gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
    }


    public Gson getGson() {
        return gson;
    }

    public void setGson(Gson gson) {
        this.gson = gson;
    }
    
    public byte[] getJsonData(DevicePayload payload){
    	String command = null;
    	byte[] result = null;
    	if(null != payload){
    		command = gson.toJson(payload);
    	}
    	
    	if(null != command){
    		result = command.getBytes();
    	}
    	
    	return result;
    }
    
    public byte[] getJsonTimeData(TimePayload payload){
    	String command = null;
    	byte[] result = null;
    	if(payload != null){
    		command = gson.toJson(payload);
    		result = command.getBytes();
    	}
    	return result;
    }
    
    public byte[] getJsonPlatformData(PlatformPayload payload){
    	String command = null;
    	byte[] result = null;
    	if(payload != null){
    		command = gson.toJson(payload);
    		result = command.getBytes();
    	}
    	return result;
    }
    
    public byte[] getJsonPlatformDataList(ArrayList<PlatformPayload> payloads){
    	String command = null;
    	byte[] result = null;
    	if(payloads != null){
    		command = gson.toJson(payloads);
    		result = command.getBytes();
    	}
    	return result;
    } 
    
    public DevicePayload getJsonObj(String jsonString){
    	
    	DevicePayload payload = gson.fromJson(jsonString, DevicePayload.class);
    	
    	return payload;
    }

    public DevicePayload getCommand(String deviceId, int type, String value){
    	
    	ArrayList<DeviceData> data = new ArrayList<DeviceData>();
    	DeviceData dd = new DeviceData(type, value);
    	data.add(dd);
    	
    	String time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
    	
    	DevicePayload payload = new DevicePayload(deviceId, data, time);
    	
    	return payload;
    }
    
    public DevicePayload getCommand(String deviceId, int type, String value, int status){
    	
    	ArrayList<DeviceData> data = new ArrayList<DeviceData>();
    	DeviceData dd = new DeviceData(type, value, status);
    	data.add(dd);
    	
    	String time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
    	
    	DevicePayload payload = new DevicePayload(deviceId, data, time);
    	
    	return payload;
    }
    
    public DevicePayload getCommand(String deviceId, int type, String value, int status, int colour){
    	
    	ArrayList<DeviceData> data = new ArrayList<DeviceData>();
    	DeviceData dd = new DeviceData(type, value, status, colour);
    	data.add(dd);
    	
    	String time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
    	
    	DevicePayload payload = new DevicePayload(deviceId, data, time);
    	
    	return payload;
    }
    
    public PlatformPayload getPlatform(String deviceId, int type, int selections){
    	
    	ArrayList<PlatformLocData> data = new ArrayList<PlatformLocData>();
    	
    	PlatformLocData dd = new PlatformLocData(type, selections);
		data.add(dd);
    	
    	PlatformPayload payload = new PlatformPayload(deviceId, data);
    	
    	return payload;
    }
    
    public ArrayList<PlatformPayload> getPlatformList(List<String> deviceIds, int type, int selections){
    	
    	ArrayList<PlatformLocData> data = new ArrayList<PlatformLocData>();
    	
    	PlatformLocData dd = new PlatformLocData(type, selections);
		data.add(dd);
		ArrayList<PlatformPayload> payloadLists = new ArrayList<PlatformPayload>();
		
		if(deviceIds != null){
			for (String dString :deviceIds) {
				PlatformPayload payload = new PlatformPayload(dString,data);
				
				payloadLists.add(payload);
			}
			
		}
    	return payloadLists;
    }
    
    public PlatformPayload getPlatform(String deviceId, int type, List<Record> records){
    	
    	ArrayList<PlatformLocData> data = new ArrayList<PlatformLocData>();
    	
    	for (Record record:records) {
			String time = record.get("time");
			String[] numStrings = time.split(":");
			if(null != numStrings && numStrings.length == 3){
				int hour = Integer.parseInt(numStrings[0]);
				int minutes = Integer.parseInt(numStrings[1]);
				int secords = Integer.parseInt(numStrings[2]);
				PlatformLocData dd = new PlatformLocData(type, hour, minutes);
	    		data.add(dd);
			}
			
		}
    	
    	PlatformPayload payload = new PlatformPayload(deviceId, data);
    	
    	return payload;
    }
    
    
    
    public PlatformPayload getPlatformObj(String jsonString){
    	
    	PlatformPayload payload = gson.fromJson(jsonString, PlatformPayload.class);
    	
    	return payload;
    }
    

    
    public static void main(String[] args) {

        JsonParser parser = new JsonParser();
        String jsonString = "{\"deviceId\":\"sdafasd\",\"data\":[{\"type\":\"1\",\"value\":\"20\"}, {\"type\":\"2\",\"value\":\"20\"}],\"time\":\"2017-06-18 16:37:34\"}";
        
        //log.info(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));

        DevicePayload payload = parser.getGson().fromJson(jsonString,DevicePayload.class);

        log.info(payload.toString());
        
        List<String> devicesList = new ArrayList<String>();
        devicesList.add("deaeadfaeaaf");
        devicesList.add("qezddvvqewe");
        devicesList.add("123aefads");
        ArrayList<PlatformPayload> payloads = parser.getPlatformList(devicesList,0,0);

        System.out.println(parser.getGson().toJson(payloads));
    }
}
