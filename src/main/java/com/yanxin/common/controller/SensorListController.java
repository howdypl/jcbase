/**
 * 
 */
package com.yanxin.common.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import com.jcbase.core.controller.JCBaseController;
import com.jcbase.core.util.CommonUtils;
import com.jcbase.core.util.JqGridModelUtils;
import com.jcbase.core.view.InvokeResult;
import com.jcbase.model.SysRole;
import com.jcbase.model.SysUser;
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
		String username=this.getPara("username");
		Page<Sensor> pageInfo=Sensor.me.getSensorPage(getPage(), this.getRows(),keyword,username,this.getOrderbyStr());
		this.renderJson(JqGridModelUtils.toJqGridView(pageInfo)); 
	}
	
	public void getListDataNew() {
		String username=this.getPara("username");
		int area = this.getParaToInt("workarea");
		int opID = this.getParaToInt("op_id");
		int station = this.getParaToInt("station");
		int building = this.getParaToInt("building");
		
		Page<Sensor> pageInfo=Sensor.me.getSensorPageNew(getPage(), this.getRows(),username,area,opID,station,building,this.getOrderbyStr());
		this.renderJson(JqGridModelUtils.toJqGridView(pageInfo)); 
	}
	
	public void add() {
		Integer id=this.getParaToInt("id");
		if(id!=null){
			//this.setAttr("item", Sensor.me.findById(id));
			Record r = Db.findFirst("select sensor.*,building.station_id,station.op_id,operation_class.work_area_id from sensor,building,station,operation_class where sensor.id=? and sensor.building_id=building.id and building.station_id=station.id and station.op_id=operation_class.id", id);
			this.setAttr("item", r);
		}
		this.setAttr("id", id);
		render("sensor_add.jsp");
	}
	
	public void setBatchIpDlg() {
		
		String bids=this.getPara("ids");
		
		this.setAttr("id", bids);
		render("set_server_ip.jsp");
	}
	public void setBatchIP() {
		String idStrs=this.getPara("id");
		String server_ip = this.getPara("server_ip");
		
		InvokeResult result=Sensor.me.setBatchIP(idStrs, server_ip);
		//添加批量配置后端IP地址的函数（批量）
		
		this.renderJson(result);

	}
	
	public void save(){
		String name=this.getPara("name");
		String sensor_code=this.getPara("sensor_code");
		Integer id=this.getParaToInt("id");
		Integer building_id=this.getParaToInt("building_id");
		Integer sensor_id=this.getParaToInt("sensor_id");
		String server_ip = this.getPara("server_ip");
		InvokeResult result=Sensor.me.save(id, name,sensor_code,building_id,sensor_id,server_ip);
		// 下发修改服务器IP地址的mqtt命令（单个）
		
		this.renderJson(result); 
	}
	
	public void deleteData(){
		Integer id=this.getParaToInt("id");
		InvokeResult invokeResult=Sensor.me.deleteData(id);
		this.renderJson(invokeResult);
	}
	
public void getSensorCode() {		
	long building_id = getParaToLong("building_id");
	List<Record> records = new ArrayList<Record>();
	if(building_id>0){
		records = Db.find("select sensor.* from sensor where building_id=?",building_id);
	}
	if (records != null && !records.isEmpty()) {
		setAttr("content", records);
		setAttr("result", true);
		renderJson();
	}else {
		setAttr("result", false);
		renderJson();
	}
		
}
public void getSensorCodeById() {	
	int id=this.getParaToInt("buliding");
	//System.out.println(id+"%%%%%%%%%%%%%%%%%5");
	List<Record> records = Db.find("select sensor_code,name from sensor where building_id=?",id);
	if (records != null && !records.isEmpty()) {
		setAttr("content", records);
		setAttr("result", true);
		renderJson();
	}else {
		setAttr("result", false);
		renderJson();
	}
}


	protected String getOrderbyStr(){
		String sord=this.getPara("sord");
		String sidx=this.getPara("sidx");
		String order = "";
		if(CommonUtils.isNotEmpty(sidx)){
			if(sidx.equals("status")){
				order= " order by sensor."+ sidx+" "+sord;
			}else if(sidx.equals("create_time")){
				order= " order by sensor."+ sidx+" "+sord;
			}else if(sidx.equals("update_time")){
				order= " order by sensor."+ sidx+" "+sord;
			}else if(sidx.equals("building_name")){
				order= " order by building."+ sidx+" "+sord;
			}else if(sidx.equals("station_name")){
				order= " order by station."+ sidx+" "+sord;
			}else if(sidx.equals("op_name")){
				order= " order by operation_class."+ sidx+" "+sord;
			}		
			
		}
		return order;
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
