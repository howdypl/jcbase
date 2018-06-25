package com.yanxin.common.controller;

import java.util.List;

import com.jcbase.core.controller.JCBaseController;
import com.jcbase.core.util.JqGridModelUtils;
import com.jcbase.core.view.InvokeResult;
import com.jcbase.model.SysUserRole;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.common.model.Sensor;

public class WarnController extends JCBaseController{

	public void index() {
		render("warn_index.jsp");
	}
	
	public void getWarnImages() {
		String sqlString = "SELECT building.building_name,warnimages.url AS url,temp.av_temp AS av,temp.max_temp AS max,temp.min_temp AS min ,warnimages.id as id, warnimages.create_time as create_time, warnimages.im_sensor_code as im_sensor_code,sensor.name as sensor_name FROM warn,warnimages,temp,building,sensor WHERE warn.create_time=temp.create_time AND temp.create_time=warnimages.create_time AND warn.sensor_code=warnimages.im_sensor_code AND warnimages.im_sensor_code=temp.temp_sensor_code AND sensor.sensor_code=warn.sensor_code AND sensor.building_id=building.id ORDER BY warnimages.create_time DESC LIMIT 8";
		List<Record> imageList = Db.find(sqlString);
		setAttr("imageList", imageList);
		if(imageList != null && imageList.size() > 0){
			setAttr("result", true);
		}else{
			setAttr("result", false);
		}
		
		renderJson();

	}
	public void getWarnNews() {
		String sqlString = "SELECT warn.*,station.station_name,building.building_name,sensor.`name`,platform_point.platform_code,operation_class.op_name FROM building,station,sensor,platform_point,warn,operation_class WHERE warn.point_type=platform_point.point_type AND warn.sensor_code=platform_point.pp_sensor_code AND platform_point.pp_sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id ORDER BY warn.create_time DESC";
		List<Record> imageList = Db.find(sqlString);
		setAttr("imageList", imageList);
		if(imageList != null && imageList.size() > 0){
			setAttr("result", true);
		}else{
			setAttr("result", false);
		}
		
		renderJson();
	}
	
	public void getWarnNumber() {
		String sqlString;
		String username=this.getPara("username");
		if(SysUserRole.dao.isOp(username)) {
			sqlString = "select IFNULL(b.summ,0) AS number, a.op_name as address from (select operation_class.op_name from operation_class) a LEFT JOIN (SELECT COUNT(operation_class.op_name) summ,operation_class.op_name from warn,sensor,building,station,operation_class WHERE warn.sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id GROUP BY operation_class.id) b ON a.op_name =b.op_name";
		}
		else {
			sqlString = "select IFNULL(b.summ,0) AS number, a.station_name as address from (select station.station_name from station WHERE station.op_id = (SELECT operation_class_id FROM sys_user WHERE name='"+username+"')) a LEFT JOIN (SELECT COUNT(station.station_name) summ,station.station_name from warn,sensor,building,station,operation_class WHERE warn.sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id GROUP BY station.id) b ON a.station_name =b.station_name";
		}
		List<Record> imageList = Db.find(sqlString);
		setAttr("imageList", imageList);
		if(imageList != null && imageList.size() > 0){
			setAttr("result", true);
		}else{
			setAttr("result", false);
		}
		
		renderJson();
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
	
}
