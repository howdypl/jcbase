package com.yanxin.common.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.jcbase.core.model.Condition;
import com.jcbase.core.model.Operators;
import com.jcbase.core.util.CommonUtils;
import com.jcbase.core.view.InvokeResult;
import com.jcbase.model.SysUser;
import com.jcbase.model.SysUserRole;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.yanxin.common.model.base.BasePoint;

public class Point extends BasePoint<Point> {

	private static final long serialVersionUID = -4834111302759104592L;
	public static final Point me = new Point();

	// 用户名是否存在
	public boolean hasExist(String name, String pp_sensor_code) {
		Set<Condition> conditions = new HashSet<Condition>();
		conditions.add(new Condition("platform_code", Operators.EQ, name));
		conditions.add(new Condition("pp_sensor_code", Operators.EQ, pp_sensor_code));
		long num = this.getCount(conditions);
		return num > 0 ? true : false;
	}

	@SuppressWarnings("unused")
	public InvokeResult save(Integer id, String pp_sensor_code, String platform_code, String images, Integer warn_temp,
			Integer point_type) {
		// TODO Auto-generated method stub
		System.out.println(images + id + pp_sensor_code + point_type + "***************************");
		if (id != null) {
			Point point = this.findById(id);
			if (images.equals("0")) {
				point.set("warn_temp", warn_temp).set("platform_code", platform_code).update();
			} else if (warn_temp == null) {
				point.set("images", images).set("platform_code", platform_code).update();
			} else if (warn_temp != null && !images.equals("0")) {
				point.set("warn_temp", warn_temp).set("images", images).set("platform_code", platform_code).update();
			}
			/*
			 * if(warn_temp==null && point_type==0 && images.equals("0") ) {
			 * System.out.println(images+"***************************10");
			 * point.set("pp_sensor_code",pp_sensor_code).set("create_time", new
			 * Date()).update(); } else if(warn_temp==null && point_type==0 &&
			 * pp_sensor_code.equals("0") ) {
			 * System.out.println(images+"***************************11");
			 * point.set("images",images).set("create_time", new
			 * Date()).update(); } else if(images.equals("0") && point_type==0
			 * && pp_sensor_code.equals("0") ) {
			 * System.out.println(images+"***************************12");
			 * point.set("warn_temp",warn_temp).set("create_time", new
			 * Date()).update(); } else if(images.equals("0") && point_type==0
			 * && pp_sensor_code.equals("0") && warn_temp==null) {
			 * System.out.println(images+"***************************13");
			 * point.set("platform_code", platform_code).update(); } else
			 * if(pp_sensor_code.equals("0") && images.equals("0")) {
			 * System.out.println(images+"***************************5");
			 * point.set("create_time", new
			 * Date()).set("warn_temp",warn_temp).update(); } else
			 * if(pp_sensor_code.equals("0") && warn_temp==null) {
			 * System.out.println(images+"***************************6");
			 * point.set("images",images).set("create_time", new
			 * Date()).update(); } else if(images.equals("0") && warn_temp==null
			 * ) { System.out.println(images+"***************************7");
			 * point.set("pp_sensor_code",pp_sensor_code).set("create_time", new
			 * Date()).set("point_type",point_type).update(); } else
			 * if(images.equals("0") && point_type==0 ) {
			 * System.out.println(images+"***************************8");
			 * point.set("pp_sensor_code",pp_sensor_code).set("create_time", new
			 * Date()).set("warn_temp",warn_temp).update(); } else
			 * if(warn_temp==null && point_type==0 ) {
			 * System.out.println(images+"***************************9");
			 * point.set("pp_sensor_code",pp_sensor_code).set("create_time", new
			 * Date()).set("images",images).update(); } else
			 * if(pp_sensor_code.equals("0")) {
			 * System.out.println(images+"***************************1");
			 * point.set("images",images).set("create_time", new
			 * Date()).set("warn_temp",warn_temp).update(); } else
			 * if(images.equals("0")) {
			 * System.out.println(images+"***************************2");
			 * point.set("pp_sensor_code",pp_sensor_code).set("create_time", new
			 * Date()).set("warn_temp",warn_temp).set("point_type",point_type).
			 * update(); } else if(warn_temp==null) {
			 * System.out.println(images+"***************************3");
			 * point.set("images",images).set("pp_sensor_code",pp_sensor_code).
			 * set("create_time", new
			 * Date()).set("point_type",point_type).update(); } else
			 * if(point_type==0) {
			 * System.out.println(images+"***************************4");
			 * point.set("images",images).set("pp_sensor_code",pp_sensor_code).
			 * set("create_time", new
			 * Date()).set("warn_temp",warn_temp).update(); }
			 */

		} else {
			if (this.hasExist(platform_code, pp_sensor_code)) {
				return InvokeResult.failure("该监控器的预设点已存在");
			} else {
				new Point().set("platform_code", platform_code).set("images", images)
						.set("pp_sensor_code", pp_sensor_code).set("status", 0).set("defaul", 0).set("islook", 0)
						.set("create_time", new Date()).set("warn_temp", warn_temp).set("point_type", point_type)
						.save();
			}

		}

		return InvokeResult.success();
	}

	public InvokeResult deleteData(Integer id) {
		this.deleteById(id);
		return InvokeResult.success();
	}

	// 设置高危点标志
	public InvokeResult setVisible(String idStrs, Integer visible) {
		List<Integer> ids = CommonUtils.getIntegerListByStrs(idStrs);
		Set<Condition> conditions = new HashSet<Condition>();
		conditions.add(new Condition("id", Operators.IN, ids));
		Map<String, Object> newValues = new HashMap<String, Object>();
		newValues.put("islook", visible);
		this.update(conditions, newValues);
		return InvokeResult.success();
	}

	public Page<Point> getPointPage(int page, int rows, String keyword, String username, String orderbyStr) {
		Set<Condition> conditions = new HashSet<Condition>();
		List<Object> outConditionValues = new ArrayList<Object>();
		StringBuffer sqlExceptSelect = new StringBuffer();
		if (SysUserRole.dao.isOp(username)) {
			if (CommonUtils.isNotEmpty(keyword)) {
				conditions.add(new Condition("station_name", Operators.LIKE, keyword));
			}
			sqlExceptSelect
					.append("FROM platform_point,building,sensor,station,operation_class WHERE platform_point.pp_sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id"
							+ super.getWhereSql(conditions, outConditionValues)
							+ " ORDER BY platform_point.create_time DESC");
		} else {
			String sqlString = "SELECT operation_class_id FROM sys_user WHERE `name`='" + username + "'";
			List<Long> userList = Db.query(sqlString);
			int r = Integer.parseInt(String.valueOf(userList.get(0)));
			if (CommonUtils.isNotEmpty(keyword)) {
				conditions.add(new Condition("station_name", Operators.LIKE, keyword));
			}
			sqlExceptSelect
					.append("FROM platform_point,building,sensor,station,operation_class WHERE platform_point.pp_sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id AND operation_class.id="
							+ r + super.getWhereSql(conditions, outConditionValues)
							+ " ORDER BY platform_point.create_time DESC");
		}
		String select = "SELECT platform_point.*, CONCAT(`name`,platform_code) as sensorName,building.building_name,station.station_name,operation_class.op_name";
		if (sqlExceptSelect.indexOf("where") != -1) {
			int s = sqlExceptSelect.indexOf("where");
			sqlExceptSelect.replace(s, s + 5, "AND");
		}
		return this.paginate(page, rows, select, sqlExceptSelect.toString());
	}
	
	public Page<Point> getPointPageNew(int page, int rows, String username, int area,int opID,int station,int building,int sensor,String orderbyStr) {
		SysUser user = SysUser.me.getByName(username);
		String select = "select platform_point.*, sensor.name as sensor_name,building.building_name as building_name,work_area.area as area,su.op_name as op_name,station.station_name,platform_point.platform_code ";
		String sqlExceptSelect = "from platform_point,sensor,building,station,operation_class su,work_area where  platform_point.pp_sensor_code=sensor.sensor_code AND sensor.building_id = building.id AND building.station_id=station.id AND station.op_id = su.id AND su.work_area_id=work_area.id";
		if(user.getUserType().intValue() == new Integer(0).intValue()){//管理员
			
			if(area>0){
				sqlExceptSelect += " AND work_area.id="+area;
				if(opID > 0){
					sqlExceptSelect += " AND su.id="+opID;
					if(station > 0){
						sqlExceptSelect += " AND station.id="+station;
						if(building >0){
							sqlExceptSelect += " AND building.id="+building;
							if(sensor > 0){
								sqlExceptSelect += " AND sensor.id="+sensor;
							}
						}
					}
				}
				sqlExceptSelect+=orderbyStr;
				return this.paginate(page, rows, select, sqlExceptSelect);
			}
			sqlExceptSelect+=orderbyStr;
			return this.paginate(page, rows, select, sqlExceptSelect);
		}else {//工区
			int tempid = 0;
			if(area>0){
				tempid = area;
			}else{
				tempid = user.getWork_area_id();
			}
			sqlExceptSelect += " AND work_area.id="+tempid;
			if(opID > 0){
				sqlExceptSelect += " AND su.id="+opID;
				if(station > 0){
					sqlExceptSelect += " AND station.id="+station;
					if(building >0){
						sqlExceptSelect += " AND building.id="+building;
						if(sensor > 0){
							sqlExceptSelect += " AND sensor.id="+sensor;
						}
					}
				}
			}
			sqlExceptSelect+=orderbyStr;
			return this.paginate(page, rows, select, sqlExceptSelect.toString());
		}
		
	}

}
