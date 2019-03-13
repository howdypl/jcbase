/**
 * 
 */
package com.yanxin.common.controller;

import java.util.ArrayList;
import java.util.List;

import com.jcbase.core.view.InvokeResult;
import com.jcbase.model.SysUser;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.common.controller.SensorDataController.Data;
import com.yanxin.common.model.Temp;
import com.yanxin.iot.Utils.ConstantsUtil;

/**
 * @author Cheng Guozhen
 * 
 */
public class TempLookController extends Controller {
	
	public void index() {
		
		render("temp_look.jsp");
	}

	public void getImages2() {
		String name = this.getPara("name");
		int area = this.getParaToInt("work_area");
		int op_class=this.getParaToInt("op_class");
		int station=this.getParaToInt("station");
		int building=this.getParaToInt("building");
		
		List<Record> imageList=null;
		//查询整个运维班的图片
		String sqlString="select su.*,sensor.`name`,station.station_name,building.id AS buildingID,building.building_name,station.id AS stationID,operation_class.id AS opID, work_area.area,work_area.id AS work_area_id";
		
		String sqlExceptSelect=" FROM platform_point su,sensor,building,station,operation_class,work_area WHERE work_area.id=operation_class.work_area_id AND operation_class.id=station.op_id AND station.id=building.station_id AND building.id=sensor.building_id AND sensor.sensor_code=su.pp_sensor_code";
		SysUser user = SysUser.me.getByName(name);
		if(user.getUserType().intValue() == new Integer(0).intValue()){//管理员
			
			if(area>0){
				sqlExceptSelect += " AND work_area.id="+area;
				if(op_class>0){
					sqlExceptSelect += " AND operation_class.id="+op_class;
					if(station > 0){
						sqlExceptSelect += " AND station.id="+station;
						if(building >0){
							sqlExceptSelect += " AND building.id="+building;
							
						}
					}
				}
				
			}
			sqlExceptSelect += " order by building.building_name,sensor.name";
			imageList = Db.find(sqlString+sqlExceptSelect);
		}else {//工区
			int tempid = 0;
			if(area>0){
				tempid = area;
			}else{
				tempid = user.getWork_area_id();
			}
			sqlExceptSelect += " AND work_area.id="+tempid;
			if(op_class > 0){
				sqlExceptSelect += " AND operation_class.id="+op_class;
				if(station > 0){
					sqlExceptSelect += " AND station.id="+station;
					if(building >0){
						sqlExceptSelect += " AND building.id="+building;
					}
				}
			}
			sqlExceptSelect += " order by building.building_name,sensor.name";
			imageList = Db.find(sqlString+sqlExceptSelect);
		}
		setAttr("content", imageList);
		if(imageList != null && imageList.size() > 0){
			setAttr("result", true);
		}else{
			setAttr("result", false);
		}
		renderJson();
	}
	
	/**
	 * 测温查看:嵌套列表
	 */
	public void getImages() {
		String name = this.getPara("name");
		
		if(name==null){
			this.renderJson(InvokeResult.failure("用户名参数错误"));
			return;
		}
		int area = 0;
		int op_class=0;
		int station=0;
		int building=0;
		int sensor=0;
		if(this.getPara("work_area") != null && this.getPara("work_area") != ""){
			area = this.getParaToInt("work_area");
		}
		if(this.getPara("op_class") != null && this.getPara("op_class") != ""){
			op_class = this.getParaToInt("op_class");
		}
		if(this.getPara("station") != null && this.getPara("station") != ""){
			station = this.getParaToInt("station");
		}
		if(this.getPara("building") != null && this.getPara("building") != ""){
			building = this.getParaToInt("building");
		}
		
		
		List<Record> imageList=null;
		//查询整个运维班的图片
		String sqlString="select DISTINCT sensor.sensor_code,sensor.`name` AS sensor_name,station.station_name,building.id AS buildingID,building.building_name,station.id AS stationID,operation_class.id AS opID, work_area.area,work_area.id AS work_area_id";
		
		String sqlExceptSelect=" FROM platform_point,sensor,building,station,operation_class,work_area WHERE work_area.id=operation_class.work_area_id AND operation_class.id=station.op_id AND station.id=building.station_id AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code";
		SysUser user = SysUser.me.getByName(name);
		
		if(user.getUserType().intValue()==0&&area==0){
			this.renderJson(InvokeResult.failure("工区ID是必选项"));
			return;
		}
		
		if(user.getUserType().intValue() == new Integer(0).intValue()){//管理员
			
			if(area>0){
				sqlExceptSelect += " AND work_area.id="+area;
				if(op_class>0){
					sqlExceptSelect += " AND operation_class.id="+op_class;
					if(station > 0){
						sqlExceptSelect += " AND station.id="+station;
						if(building >0){
							sqlExceptSelect += " AND building.id="+building;
							/*if(sensor>0){
								sqlExceptSelect += " AND sensor.id="+sensor;
							}*/
						}
					}
				}
			}
			//sqlExceptSelect += " order by building.station_id,building.id,platform_point.update_time DESC";
			sqlExceptSelect += " order by building.building_name,sensor.name,platform_point.platform_code ASC";
			imageList = Db.find(sqlString+sqlExceptSelect);
		}else {//工区
			int tempid = 0;
			if(area>0){
				tempid = area;
			}else{
				tempid = user.getWork_area_id();
			}
			sqlExceptSelect += " AND work_area.id="+tempid;
			if(op_class > 0){
				sqlExceptSelect += " AND operation_class.id="+op_class;
				if(station > 0){
					sqlExceptSelect += " AND station.id="+station;
					if(building >0){
						sqlExceptSelect += " AND building.id="+building;
						/*if(sensor>0){
							sqlExceptSelect += " AND sensor.id="+sensor;
						}*/
					}
				}
			}
			//sqlExceptSelect += " order by building.station_id,building.id,platform_point.update_time DESC";
			sqlExceptSelect += " order by building.building_name,sensor.name,platform_point.platform_code ASC";
			imageList = Db.find(sqlString+sqlExceptSelect);
		}
		
		if(imageList!=null&&imageList.size()>0){
			for(Record rr :imageList){
				String sensor_code = rr.get("sensor_code");
				String sqlString2 = "SELECT * FROM platform_point WHERE platform_point.pp_sensor_code=? order by platform_point.defaul DESC";
				List<Record> pp = Db.find(sqlString2, sensor_code);
				
				rr.set("points",pp.toArray(new Record[0]));
			}
		}
		
		setAttr("content", imageList);
		if(imageList != null && imageList.size() > 0){
			setAttr("result", true);
		}else{
			setAttr("result", false);
		}
		renderJson();
	}
	
	public void createImage(){
		int opClass = getParaToInt("station_op");
		int station = getParaToInt("station");
		int building = getParaToInt("building");
		String sqlString = "";
		if(building != 0){
			sqlString = "select sensor_code from sensor where building_id = "+building;
		}else{
			 if(station != 0){
				 sqlString = "select sensor_code from sensor,building where building.id=sensor.building_id and building.station_id = "+station;
			}else {
				if(opClass != 0){
					 sqlString = "select sensor_code from sensor,building,station where station.id=building.station_id and building.id=sensor.building_id and station.op_id = "+opClass;
				}else {
					setAttr("result", false);
					renderJson();
				}
			}
		}
		List<Record> records = Db.find(sqlString);
		List<String> sensorList = new ArrayList<String>();
		if(sensorList != null){
			for(Record r:records){
				sensorList.add(r.getStr("sensor_code"));
			}
		}
		
		// 下发指令
		try {
			ConstantsUtil.MQTTPlatformCMDBatch(sensorList, ConstantsUtil.PLATFORM_CMD_PRESET, 0);
			// System.out.println(ConstantsUtil.SERVER_IP+":"+record.getInt("port"));
			setAttr("result", true);
			renderJson();
		}catch(Exception e){
			setAttr("result", false);
			renderJson();
		}
	}
	
	public void flushCntl(){
		int opClass = getParaToInt("station_op");
		int station = getParaToInt("station");
		int building = getParaToInt("building");
		String sqlString = "";
		if(building != 0){
			sqlString = "select sensor_code from sensor where building_id = "+building;
		}else{
			 if(station != 0){
				 sqlString = "select sensor_code from sensor,building where building.id=sensor.building_id and building.station_id = "+station;
			}else {
				if(opClass != 0){
					 sqlString = "select sensor_code from sensor,building,station where station.id=building.station_id and building.id=sensor.building_id and station.op_id = "+opClass;
				}else {
					setAttr("result", false);
					renderJson();
				}
			}
		}
		List<Record> records = Db.find(sqlString);
		List<String> sensorList = new ArrayList<String>();
		if(sensorList != null){
			for(Record r:records){
				sensorList.add(r.getStr("sensor_code"));
			}
		}
		
		// 下发指令
		try {
			ConstantsUtil.MQTTFlushCMDBatch(sensorList, ConstantsUtil.FLUSH_CMD_OP, ConstantsUtil.FLUSH_CMD_OPEN);
			// System.out.println(ConstantsUtil.SERVER_IP+":"+record.getInt("port"));
			setAttr("result", true);
			renderJson();
		}catch(Exception e){
			setAttr("result", false);
			renderJson();
		}
	}

}
