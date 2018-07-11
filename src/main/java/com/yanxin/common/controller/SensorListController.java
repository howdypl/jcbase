/**
 * 
 */
package com.yanxin.common.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import com.jcbase.core.controller.JCBaseController;
import com.jcbase.core.util.JqGridModelUtils;
import com.jcbase.core.view.InvokeResult;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.common.model.OperationClass;
import com.yanxin.common.model.Sensor;
import com.yanxin.common.model.SensorType;
import com.yanxin.iot.Utils.ConstantsUtil;

/**
 * @author Cheng Guozhen
 * 
 */
public class SensorListController extends JCBaseController {
	
	public void index() {
//		String sqlString = "SELECT operation_class.op_name,station.station_name,building.building_name,sensor.sensor_code,sensor.name,sensor.status,sensor.create_time FROM sensor,operation_class,station,building WHERE sensor.building_id = building.id AND station.id = building.station_id AND station.op_id=operation_class.id";
//		List<Record> sensorList = new ArrayList<Record>();
//		
//		sensorList = Db.find(sqlString);
//		System.out.println("asdgasdfgasdfgadffhds");
//		setAttr("sensorList", sensorList);
		render("sensor_index.jsp");
	}
	
	public void getListData() {
		String keyword=this.getPara("name");
		Page<Sensor> pageInfo=Sensor.me.getSensorPage(getPage(), this.getRows(),keyword,this.getOrderbyStr());
		this.renderJson(JqGridModelUtils.toJqGridView(pageInfo)); 
	}
	
	public void add() {
		Integer id=this.getParaToInt("id");
		if(id!=null){
			this.setAttr("item", Sensor.me.findById(id));
		}
		this.setAttr("id", id);
		render("sensor_add.jsp");
	}
	public void save(){
		String name=this.getPara("name");
		String sensor_code=this.getPara("sensor_code");
		Integer id=this.getParaToInt("id");
		Integer building_id=this.getParaToInt("building_id");
		InvokeResult result=Sensor.me.save(id, name,sensor_code,building_id);
		this.renderJson(result); 
	}
	
	public void deleteData(){
		Integer id=this.getParaToInt("id");
		InvokeResult invokeResult=Sensor.me.deleteData(id);
		this.renderJson(invokeResult);
	}

	
	
	
public void getSensorCode() {		
		List<Record> records = Db.find("select sensor_code,name from sensor");
		if (records != null && !records.isEmpty()) {
			setAttr("records", records);
			setAttr("result", true);
			renderJson();
		}else {
			setAttr("result", false);
			renderJson();
		}
		
	}
	
//	public void deleteSensor() {
//		boolean result;
//		String sensorCodeString = getPara("sensorcode");
//		System.out.println("userid="+sensorCodeString);
//		result = Db.deleteById("sensor", "sensor_code", sensorCodeString);
//		
//		setAttr("result", result);
//		renderJson();
//	}
//	
//	public void isExisting() {
//		String name = getPara("name");
//		Record sRecord = Db.findById("sensor", "sensor_code", name);
//		if(sRecord != null){
//
//			setAttr("hasExisting", 0);
//		}else{
//			setAttr("hasExisting", 1);
//		}
//		renderJson();
//	}
//	
//	public void isExisting2() {
//		String name = getPara("name");
//		String sqlString = "select * from sensor where name = '"+name+ "'";
//		System.out.println(sqlString);
//		Record sRecord = Db.findFirst(sqlString);
//		if(sRecord != null){
//
//			setAttr("hasExisting", 0);
//		}else{
//			setAttr("hasExisting", 1);
//		}
//		renderJson();
//	}
//	
//	public void getSensorType() {
//		
//		String sqlString = "select * from sensor_type";
//		
//		List<Record> sensorTypeList = Db.find(sqlString);
//		setAttr("sensorTypeList", sensorTypeList);
//		renderJson();
//	}
//	
//	public void addItem() {
////		long type = getParaToInt("type");
//
//		String sensor_code = getPara("sensor_code");
////		long op_id = getParaToInt("station_op");
////		long station = getParaToInt("station");
//		Integer building_id = getParaToInt("building");
////		long layer = getParaToInt("layer");
////		long room = getParaToInt("room");
//		String nameString = getPara("name");
//		
//		Sensor sensor = new Sensor();
////		sensor.setTypeId(type);
//		sensor.setSensorCode(sensor_code);
////		sensor.setAffiliation(4L); // 属于门
////		sensor.setOwnerId(room);
////		sensor.setStatus(0L);
//		sensor.setCreateTime(new Date());
////		sensor.setPort(ConstantsUtil.getPort(10000, 65500));
//		sensor.setName(nameString);
//		sensor.setStatus(0);
//		sensor.setBuilding_id(building_id);
//		boolean result = Db.save("sensor", sensor.toRecord());
//		
//		renderJson("result",result);
//	}

}
