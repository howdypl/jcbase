/**
 * 
 */
package com.yanxin.common.controller;

import java.util.List;

import com.jcbase.core.controller.JCBaseController;
import com.jcbase.core.util.CommonUtils;
import com.jcbase.core.util.JqGridModelUtils;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.common.controller.SensorDataController.Data;
import com.yanxin.common.model.Temp;
import com.yanxin.common.model.Warn;

/**
 * @author Cheng Guozhen
 * 
 */
public class TemperatureController extends JCBaseController {

	public void index() {

		render("temp_image.jsp");
	}

	public void getSensorCode() {

		// long roomid = getParaToLong("room");
		long building_id = getParaToLong("building_id");

		List<Record> records = Db.find("select sensor_code,status,name from sensor where building_id = ?", building_id);

		if (records != null && !records.isEmpty()) {
			setAttr("content", records);
			setAttr("result", true);
			renderJson();
		} else {
			setAttr("result", false);
			renderJson();
		}

	}

	public void getSensorType() {

		// String sqlString = "select * from sensor_type where id<>11 and id
		// <>10";
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

	public void getData() {

		String createTimeString = getPara("create_time");
		String endTimeString = getPara("end_time");
		// String op_class=this.getPara("op_class");
		// String station=this.getPara("station");
		// String building=this.getPara("building");
		String[] s = this.getPara("sensor").split("/");
		String sensorCodeString = s[0];
		String point_type = s[1];

		String sqlString = "SELECT temp.*,CONCAT(sensor.`name`,platform_code) as sensorName,building.building_name,station.station_name,operation_class.op_name FROM temp,platform_point,sensor,building,station,operation_class WHERE temp.temp_sensor_code=sensor.sensor_code AND sensor.sensor_code=platform_point.pp_sensor_code AND temp.point_type=platform_point.point_type AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id AND temp_sensor_code = ? AND temp.point_type= ? AND temp.create_time>? AND temp.create_time<? ORDER BY temp.create_time ASC";

		List<Record> dataList = Db.find(sqlString, sensorCodeString, point_type, createTimeString, endTimeString);
		setAttr("dataList", dataList);

		// render("galleryquery.jsp");

		if (dataList != null && dataList.size() > 0) {
			setAttr("result", true);
		} else {
			setAttr("result", false);
		}

		renderJson();

	}

	public void getListData() {
		String createTimeString = getPara("create_time");
		String endTimeString = getPara("end_time");
		String[] s = this.getPara("sensor").split("/");
		String sensorCodeString = s[0];
		String point_type = s[1];
		// System.out.println(createTimeString + "111111111111111111111");
		
		Page<Temp> pageInfo = Temp.me.getTempPage(this.getPage(), this.getRows(), createTimeString, endTimeString,
				sensorCodeString, point_type, this.getOrderbyStr());
		this.renderJson(JqGridModelUtils.toJqGridView(pageInfo));
	}
	
	/**
	 * 获取排序字符串
	 * @author eason	
	 * @return
	 */
	protected String getOrderbyStr(){
		String sord=this.getPara("sord");
		String sidx=this.getPara("sidx");
		String orderStr="";
		if(CommonUtils.isNotEmpty(sidx)){
			
			if(sidx.equals("area")){
				
				orderStr=" order by temp."+ sidx+" "+sord;
			}else if(sidx.equals("op_name")){
				
				orderStr=" order by temp."+ sidx+" "+sord;
			}else if(sidx.equals("station_name")){
				
				orderStr=" order by temp."+ sidx+" "+sord;
			}else if(sidx.equals("building_name")){
				
				orderStr=" order by temp."+ sidx+" "+sord;
			}else if(sidx.equals("max_temp")){
				
				orderStr=" order by temp."+ sidx+" "+sord;
			}else if(sidx.equals("create_time")){
				
				orderStr=" order by temp."+ sidx+" "+sord;
			}else if(sidx.equals("sensorName")){
				
				orderStr=" order by sensor.name "+sord;
			}
		}else {
			orderStr=" order by temp.create_time "+sord;
		}
		return orderStr;
	}
	

	public void forward() {
		String createTimeString = getPara("create_time");
		String endTimeString = getPara("end_time");
		String[] s = this.getPara("sensor").split("/");
		String sensorCodeString = s[0];
		String point_type = s[1];
		System.out.println(createTimeString + "111111111111111111111");
		Page<Temp> pageInfo = Temp.me.getTempPage(this.getPage(), this.getRows(), createTimeString, endTimeString,
				sensorCodeString, point_type, this.getOrderbyStr());
		this.renderJson(JqGridModelUtils.toJqGridView(pageInfo));

	}

}
