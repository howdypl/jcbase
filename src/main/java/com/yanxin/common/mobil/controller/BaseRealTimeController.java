/**
 * 
 */
package com.yanxin.common.mobil.controller;

import java.util.List;

import com.jcbase.core.view.InvokeResult;
import com.jcbase.model.SysUser;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.iot.Utils.ConstantsUtil;

/**
 * @author Guozhen Cheng
 *
 */
public class BaseRealTimeController extends Controller {
	
	/**
	 * 
	 */
	public void getBaseInfo(){
		
		String username = this.getPara("username");
		
		if(username==null){
			this.renderJson(InvokeResult.failure("参数有误"));
			return;
		}
		
		SysUser user = SysUser.me.getUserOP(username);
		if(user==null){
			this.renderJson(InvokeResult.failure("用户不存在"));
			return;
		}
		
		int work_area = 0;
		int op_class = 0;
		
		if(this.getPara("work_area")!=null){
			work_area = this.getParaToInt("work_area");
		}
		if(this.getPara("op_class")!=null){
			op_class = this.getParaToInt("op_class");
		}
				
		String sqlString1 = "select count(sensor.sensor_code) as sum,SUM(sensor.`status`) AS line_sum";
		String sqlString2 = "select MAX(temp.max_temp) AS today_max_temp ";
		String sqlString3 = "select MAX(temp.max_temp) AS yesterday_max_temp";
		String sqlString4 = "select MAX(temp.max_temp) AS month_max_temp ";
		String sqlexcept1 = " from sensor,building,station,operation_class WHERE operation_class.id=station.op_id AND station.id=building.station_id AND sensor.building_id=building.id ";
		String sqlexcept2 = " from temp,sensor,building,station,operation_class where operation_class.id=station.op_id AND station.id=building.station_id AND sensor.building_id=building.id AND temp.temp_sensor_code=sensor.sensor_code AND temp.status=0 AND DATEDIFF(temp.create_time,NOW())=0 ";
		String sqlexcept3 = " from temp,sensor,building,station,operation_class where operation_class.id=station.op_id AND station.id=building.station_id AND sensor.building_id=building.id AND temp.temp_sensor_code=sensor.sensor_code AND temp.status=0 AND DATEDIFF(temp.create_time,NOW())=-1";
		String sqlexcept4 = " from temp,sensor,building,station,operation_class where operation_class.id=station.op_id AND station.id=building.station_id AND sensor.building_id=building.id AND temp.temp_sensor_code=sensor.sensor_code AND temp.status=0 AND PERIOD_DIFF(date_format(now(),'%Y%m'),date_format(temp.create_time,'%Y%m'))=0 ";
		if(user.getUserType().intValue()==0){//管理员
			/*if(work_area>0){
				sqlexcept1+="  AND operation_class.work_area_id="+work_area;
				sqlexcept2+="  AND operation_class.work_area_id="+work_area;
				sqlexcept3+="  AND operation_class.work_area_id="+work_area;
				sqlexcept4+="  AND operation_class.work_area_id="+work_area;
			}*/
		}else if(user.getUserType().intValue()==1){//工区
			
			if(work_area>0){
				sqlexcept1+="  AND operation_class.work_area_id="+work_area;
				sqlexcept2+="  AND operation_class.work_area_id="+work_area;
				sqlexcept3+="  AND operation_class.work_area_id="+work_area;
				sqlexcept4+="  AND operation_class.work_area_id="+work_area;
			}else {
				sqlexcept1+="  AND operation_class.work_area_id="+user.getWork_area_id();
				sqlexcept2+="  AND operation_class.work_area_id="+user.getWork_area_id();
				sqlexcept3+="  AND operation_class.work_area_id="+user.getWork_area_id();
				sqlexcept4+="  AND operation_class.work_area_id="+user.getWork_area_id();
			}
			
		}else if(user.getUserType().intValue()==2){//运维班
			if(work_area>0){
				sqlexcept1+="  AND operation_class.work_area_id="+work_area;
				sqlexcept2+="  AND operation_class.work_area_id="+work_area;
				sqlexcept3+="  AND operation_class.work_area_id="+work_area;
				sqlexcept4+="  AND operation_class.work_area_id="+work_area;
			}else {
				sqlexcept1+="  AND operation_class.work_area_id="+user.getWork_area_id();
				sqlexcept2+="  AND operation_class.work_area_id="+user.getWork_area_id();
				sqlexcept3+="  AND operation_class.work_area_id="+user.getWork_area_id();
				sqlexcept4+="  AND operation_class.work_area_id="+user.getWork_area_id();
			}

			if(op_class>0){
				sqlexcept1+=" AND operation_class.id="+op_class;
				sqlexcept2+=" AND operation_class.id="+op_class;
				sqlexcept3+=" AND operation_class.id="+op_class;
				sqlexcept4+=" AND operation_class.id="+op_class;
			}else {
				sqlexcept1+=" AND operation_class.id="+user.getOperation_class_id();
				sqlexcept2+=" AND operation_class.id="+user.getOperation_class_id();
				sqlexcept3+=" AND operation_class.id="+user.getOperation_class_id();
				sqlexcept4+=" AND operation_class.id="+user.getOperation_class_id();
			}
		}
		
		Record r = new Record();
		Record rr1 = Db.findFirst(sqlString1+sqlexcept1);
		Record rr2 = Db.findFirst(sqlString2+sqlexcept2);
		Record rr3 = Db.findFirst(sqlString3+sqlexcept3);
		Record rr4 = Db.findFirst(sqlString4+sqlexcept4);
		
		
		r.set("sum", rr1.get("sum"));
		r.set("line_sum", rr1.get("line_sum"));
		
		if(rr2!=null){
			Object obb = rr2.get("today_max_temp");
			int today_max_temp= ConstantsUtil.getStatFromFloat(obb);
			r.set("today_max_temp", today_max_temp);
			
		}
		if(rr3!=null){
			Object ob3 = rr3.get("yesterday_max_temp");
			int yesterday_max_temp=ConstantsUtil.getStatFromFloat(ob3);
			r.set("yesterday_max_temp", yesterday_max_temp);
			
		}
		if(rr4!=null){
			Object ob4 = rr4.get("month_max_temp");
			int month_max_temp=ConstantsUtil.getStatFromFloat(ob4);
			r.set("month_max_temp", month_max_temp);
		}
		
		this.renderJson(InvokeResult.success(r));
	}
	
	/**
	 * 未启用
	 */
	public void getBaseInfoByWA(){
		int workAreaId = 0;
		if(this.getPara("work_area_id")!=null){
			workAreaId = this.getParaToInt("work_area_id");
		}else {
			this.renderJson(InvokeResult.failure("参数有误"));
			return;
		}
		
		String sqlString1 = "select count(sensor.sensor_code) as sum,SUM(sensor.`status`) AS line_sum from sensor,building,station,operation_class WHERE operation_class.id=station.op_id AND station.id=building.station_id AND sensor.building_id=building.id AND operation_class.work_area_id=?";
		
		Record rr1 = Db.findFirst(sqlString1,workAreaId);
		
		
		String sqlString2 = "select MAX(temp.max_temp) AS today_max_temp from temp,sensor,building,station,operation_class where operation_class.id=station.op_id AND station.id=building.station_id AND sensor.building_id=building.id AND temp.temp_sensor_code=sensor.sensor_code AND temp.status=0 AND DATEDIFF(temp.create_time,NOW())=0 AND operation_class.work_area_id=?";
		Record rr2 = Db.findFirst(sqlString2,workAreaId);
		
		Object obb = rr2.get("today_max_temp");
		int today_max_temp= ConstantsUtil.getStatFromFloat(obb);
		
		String sqlString3 = "select MAX(temp.max_temp) AS yesterday_max_temp from temp,sensor,building,station,operation_class where operation_class.id=station.op_id AND station.id=building.station_id AND sensor.building_id=building.id AND temp.temp_sensor_code=sensor.sensor_code AND temp.status=0 AND DATEDIFF(temp.create_time,NOW())=-1 AND operation_class.work_area_id=?";
		Record rr3 = Db.findFirst(sqlString3,workAreaId);
		
		Object ob3 = rr3.get("yesterday_max_temp");
		int yesterday_max_temp=ConstantsUtil.getStatFromFloat(ob3);
		
		String sqlString4 = "select MAX(temp.max_temp) AS month_max_temp from temp,sensor,building,station,operation_class where operation_class.id=station.op_id AND station.id=building.station_id AND sensor.building_id=building.id AND temp.temp_sensor_code=sensor.sensor_code AND temp.status=0 AND PERIOD_DIFF(date_format(now(),'%Y%m'),date_format(temp.create_time,'%Y%m'))=1 AND operation_class.work_area_id=?";
		Record rr4 = Db.findFirst(sqlString4,workAreaId);
		
		Object ob4 = rr4.get("month_max_temp");
		int month_max_temp=ConstantsUtil.getStatFromFloat(ob4);
		
		Record r = new Record();
		r.set("sum", rr1.get("sum"));
		r.set("line_sum", rr1.get("line_sum"));
		r.set("today_max_temp", today_max_temp);
		r.set("yesterday_max_temp", yesterday_max_temp);
		r.set("month_max_temp", month_max_temp);
		
		this.renderJson(InvokeResult.success(r));
	}
	/**
	 * 未启用
	 */
	public void getBaseInfoByOP(){
		int op_class = 0;
		if(this.getPara("op_class")!=null){
			op_class = this.getParaToInt("op_class");
		}else {
			this.renderJson(InvokeResult.failure("参数有误"));
			return;
		}
		GlobalInfo info = new GlobalInfo();
		String sqlString1 = "select count(sensor.sensor_code) as sum,SUM(sensor.`status`) AS line_sum from sensor,building,station,operation_class WHERE operation_class.id=station.op_id AND station.id=building.station_id AND sensor.building_id=building.id AND operation_class.id=?";
		
		Record rr1 = Db.findFirst(sqlString1,op_class);
		info.sum = rr1.getLong("sum");
		//info.line_sum = rr1.getLong("line_sum");
		
		Object ob = rr1.get("line_sum");
		info.line_sum= ConstantsUtil.getStatFromInt(ob);
		
		String sqlString2 = "select MAX(temp.max_temp) AS today_max_temp from temp,sensor,building,station,operation_class where operation_class.id=station.op_id AND station.id=building.station_id AND sensor.building_id=building.id AND temp.temp_sensor_code=sensor.sensor_code AND temp.status=0 AND DATEDIFF(temp.create_time,NOW())=0 AND operation_class.id=?";
		Record rr2 = Db.findFirst(sqlString2,op_class);
		
		Object ob2 = rr2.get("today_max_temp");
		int today_max_temp = ConstantsUtil.getStatFromFloat(ob2);
		
		String sqlString3 = "select MAX(temp.max_temp) AS yesterday_max_temp from temp,sensor,building,station,operation_class where operation_class.id=station.op_id AND station.id=building.station_id AND sensor.building_id=building.id AND temp.temp_sensor_code=sensor.sensor_code AND temp.status=0 AND DATEDIFF(temp.create_time,NOW())=-1 AND operation_class.id=?";
		Record rr3 = Db.findFirst(sqlString3,op_class);
		
		Object ob3 = rr3.get("yesterday_max_temp");
		int yesterday_max_temp = ConstantsUtil.getStatFromFloat(ob3);
		
		
		String sqlString4 = "select MAX(temp.max_temp) AS month_max_temp from temp,sensor,building,station,operation_class where operation_class.id=station.op_id AND station.id=building.station_id AND sensor.building_id=building.id AND temp.temp_sensor_code=sensor.sensor_code AND temp.status=0 AND PERIOD_DIFF(date_format(now(),'%Y%m'),date_format(temp.create_time,'%Y%m'))=1 AND operation_class.id=?";
		Record rr4 = Db.findFirst(sqlString4,op_class);
		Object ob4 = rr4.get("month_max_temp");
		int month_max_temp=ConstantsUtil.getStatFromFloat(ob4);
		
		Record r = new Record();
		r.set("sum", rr1.get("sum"));
		r.set("line_sum", rr1.get("line_sum"));
		r.set("today_max_temp", today_max_temp);
		r.set("yesterday_max_temp", yesterday_max_temp);
		r.set("month_max_temp", month_max_temp);
		
		this.renderJson(InvokeResult.success(r));
	}

	public void getRealTemp() {
		String username = this.getPara("username");
		
		if(username==null){
			this.renderJson(InvokeResult.failure("参数有误"));
			return;
		}
		int work_area = 0;
		int op_class = 0;
		if(this.getPara("work_area")!=null){
			work_area = this.getParaToInt("work_area");
		}
		if(this.getPara("op_class")!=null){
			op_class = this.getParaToInt("op_class");
		}
		
		
		SysUser user = SysUser.me.getUserOP(username);
		
		if(user==null){
			this.renderJson(InvokeResult.failure("用户不存在"));
			return;
		}
		
		String sqlString = "";
		
		if(user.getUserType().intValue()==0){//管理员
			
			if(work_area>0){
				sqlString = "SELECT IFNULL(b.summ,0) AS number, a.op_name as address,IFNULL(c.maxTemp,0) AS temper,a.id AS op_id,a.work_area_id from (select operation_class.op_name,operation_class.id,operation_class.work_area_id from operation_class,work_area where work_area.id=operation_class.work_area_id AND work_area.id="+
						work_area+") a LEFT JOIN (SELECT COUNT(operation_class.op_name) summ,operation_class.op_name,work_area.id AS work_area_id,work_area.area from warn,sensor,building,station,operation_class ,work_area where work_area.id=operation_class.work_area_id AND work_area.id="+
						work_area+" AND warn.sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id AND warn.status=0 GROUP BY operation_class.id) b ON a.op_name =b.op_name LEFT JOIN (SELECT MAX(platform_point.current_temp) maxTemp,operation_class.op_name FROM platform_point,sensor,building,station,operation_class ,work_area where work_area.id=operation_class.work_area_id AND work_area.id="+
						work_area+" AND platform_point.pp_sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id GROUP BY operation_class.id) c ON c.op_name=a.op_name";
			}else {
				
				this.renderJson(InvokeResult.failure("可能参数错误！"));
				return;
			}
		}else if(user.getUserType().intValue()==1){//工区
			work_area=user.getWork_area_id();
			
			if(op_class == 0){
				
				sqlString = "SELECT IFNULL(b.summ,0) AS number, a.op_name as address,IFNULL(c.maxTemp,0) AS temper,a.id AS op_id,a.work_area_id from (select operation_class.op_name,operation_class.id,operation_class.work_area_id from operation_class,work_area where work_area.id=operation_class.work_area_id AND work_area.id="+
						work_area+") a LEFT JOIN (SELECT COUNT(operation_class.op_name) summ,operation_class.op_name,work_area.id AS work_area_id,work_area.area from warn,sensor,building,station,operation_class ,work_area where work_area.id=operation_class.work_area_id AND work_area.id="+
						work_area+" AND warn.sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id AND warn.status=0 GROUP BY operation_class.id) b ON a.op_name =b.op_name LEFT JOIN (SELECT MAX(platform_point.current_temp) maxTemp,operation_class.op_name FROM platform_point,sensor,building,station,operation_class ,work_area where work_area.id=operation_class.work_area_id AND work_area.id="+
						work_area+" AND platform_point.pp_sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id GROUP BY operation_class.id) c ON c.op_name=a.op_name";
				
				
			}else {
				sqlString = "select IFNULL(b.summ,0) AS number, a.station_name as address, IFNULL(c.maxTemp,0) AS temper,a.op_id,a.id as station_id,a.op_id,a.work_area_id from (select station.station_name,station.id,station.op_id,operation_class.work_area_id from station,operation_class WHERE station.op_id="
						+ op_class
						+ " AND station.op_id=operation_class.id) a LEFT JOIN (SELECT COUNT(station.station_name) summ,station.station_name from warn,sensor,building,station WHERE warn.sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id="+op_class+" AND warn.status=0 GROUP BY station.id) b ON a.station_name =b.station_name LEFT JOIN (SELECT MAX(platform_point.current_temp) maxTemp,station.station_name FROM platform_point,sensor,building,station WHERE platform_point.pp_sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id="+op_class+" GROUP BY station.id) c ON c.station_name=a.station_name";
				
			}
			
		}else if(user.getUserType().intValue()==2){//运维班
			// op_class = user.getOperation_class_id();
			sqlString = "select IFNULL(b.summ,0) AS number, a.station_name as address, IFNULL(c.maxTemp,0) AS temper,a.op_id,a.id as station_id,a.work_area_id from (select station.station_name,station.id,station.op_id,operation_class.work_area_id from station,operation_class WHERE station.op_id = (SELECT operation_class_id FROM sys_user WHERE name='"
					+ username
					+ "') AND  station.op_id=operation_class.id) a LEFT JOIN (SELECT COUNT(station.station_name) summ,station.station_name from warn,sensor,building,station,operation_class WHERE warn.sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id AND warn.status=0 GROUP BY station.id) b ON a.station_name =b.station_name LEFT JOIN (SELECT MAX(platform_point.current_temp) maxTemp,station.station_name FROM platform_point,sensor,building,station,operation_class WHERE platform_point.pp_sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id GROUP BY station.id) c ON c.station_name=a.station_name";
			
		}
		
		sqlString +=" ORDER BY number DESC ";
		List<Record> imageList = Db.find(sqlString);
		
		this.renderJson(InvokeResult.success(imageList));
	}
	
	public void getAnormalImages() {
		String sqlString = "SELECT building.building_name,warnimages.url AS url,temp.av_temp AS av,temp.max_temp AS max,temp.min_temp AS min ,warnimages.id as id, warnimages.create_time as create_time, warnimages.im_sensor_code as im_sensor_code,warnimages.point_type,platform_point.platform_code,sensor.name as sensor_name,station.station_name,building.id AS buildingID,station.id AS stationID,operation_class.id AS opID,work_area.id AS work_area_id, work_area.area ";
		String sqlException = " FROM warnimages,temp,building,sensor,station,operation_class,platform_point,work_area WHERE temp.create_time=warnimages.create_time AND warnimages.im_sensor_code=temp.temp_sensor_code AND sensor.sensor_code=temp.temp_sensor_code AND platform_point.pp_sensor_code=warnimages.im_sensor_code AND warnimages.point_type=platform_point.point_type AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id AND work_area.id=operation_class.work_area_id ";
		String username = this.getPara("username");
		if(username==null){
			this.renderJson(InvokeResult.failure("用户参数有误"));
			return;
		}
		
		int work_area = 0;
		int op_class = 0;
		if(this.getPara("work_area")!=null){
			work_area = this.getParaToInt("work_area");
		}
		if(this.getPara("op_class")!=null){
			op_class = this.getParaToInt("op_class");
		}
		
		SysUser user = SysUser.me.getUserOP(username);
		if(user==null){
			this.renderJson(InvokeResult.failure("用户不存在"));
			return;
		}
		if(user.getUserType().intValue()==0){//管理员
			if(work_area>0){
				sqlException+=" AND work_area.id="+work_area;
			}
		}else if(user.getUserType().intValue()==1){//工区
			if(work_area>0){
				sqlException+=" AND work_area.id="+work_area;
			}else {
				sqlException+=" AND work_area.id="+user.getWork_area_id();
			}
			
			if(op_class>0){
				sqlException+=" AND operation_class.id="+op_class;
			}
		}else if(user.getUserType().intValue()==2){//运维班
			if(work_area>0){
				sqlException+=" AND work_area.id="+work_area;
			}else {
				sqlException+=" AND work_area.id="+user.getWork_area_id();
			}
			
			if(op_class>0){
				sqlException+=" AND operation_class.id="+op_class;
			}else {
				sqlException+=" AND operation_class.id="+user.getOperation_class_id();
			}
			
		}
		sqlException += " ORDER BY warnimages.create_time DESC LIMIT 16";
		List<Record> imageList = Db.find(sqlString+sqlException);
		this.renderJson(InvokeResult.success(imageList));
	}
	
	public class GlobalInfo extends Object{
		
		public long sum;
		public int line_sum;
		public int today_max_temp;
		public int yesterday_max_temp;
		public int month_max_temp;
		
		

	}
}
