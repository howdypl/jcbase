/**
 * 
 */
package com.yanxin.common.mobil.controller;

import java.util.ArrayList;
import java.util.List;

import com.jcbase.core.util.JqGridModelUtils;
import com.jcbase.core.view.InvokeResult;
import com.jcbase.model.SysUser;
import com.jcbase.model.SysUserRole;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.common.model.WorkArea;

/**
 * @author Guozhen Cheng
 *
 */
public class StationFrameController extends Controller {

	/**
	 * chengguozhen
	 */
	public void getWorkArea() {
		List<WorkArea> resultList = new ArrayList<WorkArea>();
		
		String username=this.getPara("username");
		// System.out.println(SysUserRole.dao.userOP(username)+"********************");
		int op = SysUserRole.dao.userOP(username); // 默认不是管理员
		
		if(op == 1){
			resultList = WorkArea.me.getAllList();
		}else if(op == 2 || op == 3){
			resultList = WorkArea.me.getWorkAreaByUser(username,op);
		}
		
		this.renderJson(InvokeResult.success(resultList));
		
	}
	
	/**
	 * 根据用户和工区ID获取某工区运维班
	 */
	public void getOperationClass() {
		List<Record> resultList = new ArrayList<Record>();
		String sqlString;
		String username=this.getPara("username");
		String wa = this.getPara("workarea");

		int waID = 0;
		if(wa!=null){
			waID = this.getParaToInt("workarea");
		}else {
			if(!username.equals("admin")){
				SysUser user = SysUser.me.getByName(username);
				waID = user.getWork_area_id();
			}
		}
		//System.out.println(SysUserRole.dao.isOp(username)+"********************");
		int isOp = SysUserRole.dao.userOP(username); // 默认不是管理员
		if(waID>0){
			if(isOp == 1) {
				sqlString = "select id, op_name from operation_class where work_area_id=?";
				resultList = Db.find(sqlString,waID);
			}else if(isOp == 2){
				sqlString = "select id,op_name from operation_class where work_area_id=(SELECT work_area_id FROM sys_user WHERE name='"+username+"')";
				resultList = Db.find(sqlString);
			}else {
				sqlString = "select id,op_name from operation_class where id=(SELECT operation_class_id FROM sys_user WHERE name='"+username+"')";
				resultList = Db.find(sqlString);
			}
		}else{ // 工区ID传递0的话
		
			if(isOp == 1) {
				sqlString = "select id, op_name from operation_class";
			}else if(isOp == 2){
				sqlString = "select id,op_name from operation_class where work_area_id=(SELECT work_area_id FROM sys_user WHERE name='"+username+"')";
			}else {
				sqlString = "select id,op_name from operation_class where id=(SELECT operation_class_id FROM sys_user WHERE name='"+username+"')";
			}
			resultList = Db.find(sqlString);
		}
		
		this.renderJson(InvokeResult.success(resultList));
	}
	
	public void getStationList() {
		int id = 0;
		
		if(this.getPara("op_class")!=null){
			id = this.getParaToInt("op_class");
		}
		if(id>0){
			String sqlString = "select id, station_name from station where op_id=?";
			List<Record> stationRecords = Db.find(sqlString,id);
			
			this.renderJson(InvokeResult.success(stationRecords));
		}else {
			this.renderJson(InvokeResult.failure("参数有错"));
		}
		
	}
	public void getbuildingList() {
		/*String username = this.getPara("username");
		int area = this.getParaToInt("workarea");
		int opID = this.getParaToInt("op_id");*/
		
		int station = 0;
		if(this.getPara("station")!=null){
			station = this.getParaToInt("station");
		}
		if(station>0){
			String sqlString = "SELECT building.id AS building_id,building.building_name FROM building WHERE building.station_id=?";
			List<Record> buildingRecords = Db.find(sqlString, station);
			
			this.renderJson(InvokeResult.success(buildingRecords)); 
		}else {
			this.renderJson(InvokeResult.failure("参数有错"));
		}
		
	}
	
	
	public void getSensorList() {
		
		int building = 0;
		if(this.getPara("building")!=null){
			building = this.getParaToInt("building");
		}
		if(building > 0){
			String sql = "SELECT sensor.id AS sensor_id, sensor.`name` AS sensor_name,sensor.sensor_code FROM sensor where sensor.building_id=?";
			List<Record> sensorRecords = Db.find(sql, building);
			
			/*if(sensorRecords!=null&&sensorRecords.size()>0){
				for(Record rr :sensorRecords){
					String sql2 = "SELECT platform_point.point_type,platform_point.platform_code FROM platform_point WHERE platform_point.pp_sensor_code=?";
					String sc = rr.get("sensor_code");
					List<Record> pp = Db.find(sql2, sc);
					
					if(pp!=null&&pp.size()>0){
						rr.set("points",pp.toArray(new Record[0]));
					}
				}
			}*/
			
			this.renderJson(InvokeResult.success(sensorRecords)); 
		}else {
			this.renderJson(InvokeResult.failure("参数有错"));
		}
		
	}
	
	public void getPlatformList(){
		String sensorCodeString = getPara("sensor_code");
		if(sensorCodeString!=null){
			List<Record> platformRecords = Db.find("select * from platform_point where pp_sensor_code= '"+sensorCodeString+"'");
			this.renderJson(InvokeResult.success(platformRecords));
		}else {
			this.renderJson(InvokeResult.failure("参数有错"));
		}
		
	}
}
