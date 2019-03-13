package com.yanxin.common.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jcbase.core.controller.JCBaseController;
import com.jcbase.core.util.CommonUtils;
import com.jcbase.core.util.JqGridModelUtils;
import com.jcbase.core.view.InvokeResult;
import com.jcbase.model.SysUser;
import com.jcbase.model.SysUserRole;
import com.jcbase.model.WordJSON;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.common.model.Warn;
import com.yanxin.iot.Utils.ConstantsUtil;

import sun.misc.BASE64Encoder;

public class WarnController extends JCBaseController {

	// 新增的属性和方法

	private static String seperator = System.getProperty("file.separator");

	// 存放导出word所需要的ftl文件的路径
	public static String getFtlBasePath() {
		String os = System.getProperty("os.name");
		String basePath = "";
		if (os.toLowerCase().startsWith("win")) {
			basePath = "E:/demoword";
		} else {
			// linux下的模板路径
			basePath = "/xx/xx/xx";
		}
		basePath = basePath.replace("/", seperator);
		return basePath;
	}

	// 将图片转换成BASE64字符串
	public static String getImageStr(String str) {
		String imgFile = str;
		InputStream in = null;
		byte[] data = null;
		try {
			in = new FileInputStream(imgFile);
			data = new byte[in.available()];
			in.read(data);
			in.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		BASE64Encoder encoder = new BASE64Encoder();
		return encoder.encode(data);
	}

	public void lookWord() throws JsonParseException, JsonMappingException, IOException {
		Integer id = this.getParaToInt("id");
		System.out.println(id + "运行了这个程序");
		if (id != null) {
			String sqlString = "SELECT images.url,warn.sensor_code,sensor.create_time,station.station_name,platform_point.platform_code,sensor.name FROM images,temp,warn,sensor,station,platform_point,building WHERE warn.sensor_code=temp.temp_sensor_code  AND temp.temp_sensor_code=images.im_sensor_code AND warn.sensor_code = sensor.sensor_code AND platform_point.pp_sensor_code = sensor.sensor_code AND platform_point.point_type = warn.point_type AND sensor.building_id = building.id AND building.station_id = station.id AND temp.point_type=warn.point_type AND warn.point_type=images.point_type AND warn.create_time=temp.create_time AND warn.create_time=images.create_time AND warn.id=?";
			List<Record> imageList = Db.find(sqlString, id);
			
			this.setAttr("imageList", imageList.get(0));
			this.setAttr("imgStr", imageList.get(1));
			this.setAttr("id", id);
			System.out.println(imageList);
			// for(int i=0;i<imageList.size();i++){
			// System.out.println(imageList.get(i).toJson());
			// }

			// this.setAttr("content", imageList);
			// this.setAttr("result", true);

			// String path = "d:/rechengxiang/excel";
			// if(!new File(path).exists()) {
			// new File(path).mkdirs();
			// }
			/**
			WordJSON wordJson = new WordJSON();
			ObjectMapper object = new ObjectMapper();
			String json = imageList.get(0).toJson();
			wordJson = object.readValue(imageList.get(0).toJson(), WordJSON.class);
			Map<String, Object> cont = new HashMap<String, Object>();// 存储数据
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM");
			// String create_time =
			// dateFormat.format(wordJson.getCreate_time());
			// String op_time = dateFormat.format(wordJson.getOpTime());
			setAttr("nod", wordJson.getPlatform_code());
			setAttr("run", wordJson.getName());
			setAttr("station_name", wordJson.getStation_name());
			setAttr("create_time", wordJson.getCreate_time());
			setAttr("sensor_code", wordJson.getSensor_code());
			// setAttr("imgStr1",wordJson.getUrl());
			setAttr("id", id);

			cont.put("nod", wordJson.getPlatform_code());
			cont.put("run", wordJson.getName());
			cont.put("station_level", "");
			cont.put("station_name", wordJson.getStation_name());
			cont.put("create_time", wordJson.getCreate_time());
			cont.put("op_time", "");
			cont.put("sensor_code", wordJson.getSensor_code());
			// cont.put("imgStr1",getImageStr("E:/work1/backend/image/"+wordJson.getUrl()));
			// cont.put("imgStr2",getImageStr("E:/work1/backend/image/inf/"+wordJson.getUrl()));

			cont.put("weather", "");
			cont.put("temp", "");
			cont.put("wet", "");
			cont.put("wind", "");
			cont.put("check_time", "");

			cont.put("analysis", "");
			cont.put("opinion", "");
			cont.put("remark", "");
			cont.put("username", "");
			**/
		}
		renderJson();
		render("word_look.jsp");
	}
	
	public void lookWord2() throws JsonParseException, JsonMappingException, IOException {
		if(this.getPara("id")==null){
			//this.renderJson(InvokeResult.failure("参数错误"));
			return;
		}
		Integer id = this.getParaToInt("id");
		Record rr = null;
		if (id != null) {
			String sqlString = "SELECT warn.*,temp.min_temp, station.station_name,building.building_name,platform_point.platform_code,sensor.name,sensor.sensor_model,sensor.emittance,sensor.distance,sensor.create_time sensor_maintence_time,sensor.update_time sensor_create_time,sensor.sensor_id FROM temp,warn,sensor,station,platform_point,building WHERE warn.sensor_code=temp.temp_sensor_code AND warn.sensor_code = sensor.sensor_code AND platform_point.pp_sensor_code = sensor.sensor_code AND platform_point.point_type = warn.point_type AND sensor.building_id = building.id AND building.station_id = station.id AND temp.point_type=warn.point_type AND warn.create_time=temp.create_time AND warn.id=?";
			String sqlString2 = "SELECT images.url,images.color_bar from warn,images WHERE warn.point_type=images.point_type AND warn.sensor_code=images.im_sensor_code AND warn.create_time=images.create_time AND warn.id = ? order by images.color_bar ASC";
			
			rr = Db.findFirst(sqlString, id);
			
			List<Record> urls = Db.find(sqlString2,id);
			
			if(urls!=null&&urls.size()>0){
				rr.set("urls", urls.toArray(new Record[0]));
			}
		}
		if(rr!=null){
			this.renderJson(InvokeResult.success(rr));
		}else {
			this.renderJson(InvokeResult.failure("可能出错了！"));
		}
		
		this.setAttr("imageList",rr);
		// this.setAttr("imgStr", imageList.get(1));
		this.setAttr("id", id);

		renderJson();
		render("word_look.jsp");
	}

	// 新增代码到此结束

	public void index() {
		/*
		 * int op_id = 0; int station_id = 0; if(this.getPara("op_id")!= null){
		 * op_id = this.getParaToInt("op_id"); } if(this.getPara("station_id")!=
		 * null){ op_id = this.getParaToInt("station_id"); } setAttr("op_id",
		 * op_id); setAttr("station_id", station_id);
		 */

		render("warn_index.jsp");

	}

	/**
	 * 得到告警图片getWarnImages
	 */
	public void getWarnImages() {
		String sqlString = "SELECT building.building_name,warnimages.url AS url,temp.av_temp AS av,temp.max_temp AS max,temp.min_temp AS min ,warnimages.id as id, warnimages.create_time as create_time, warnimages.im_sensor_code as im_sensor_code,warnimages.point_type,platform_point.platform_code,sensor.name as sensor_name,station.station_name,building.id AS buildingID,station.id AS stationID,operation_class.id AS opID,work_area.id AS work_area_id, work_area.area ";
		String sqlException = " FROM warnimages,temp,building,sensor,station,operation_class,platform_point,work_area WHERE temp.create_time=warnimages.create_time AND warnimages.im_sensor_code=temp.temp_sensor_code AND sensor.sensor_code=temp.temp_sensor_code AND platform_point.pp_sensor_code=warnimages.im_sensor_code AND warnimages.point_type=platform_point.point_type AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id AND work_area.id=operation_class.work_area_id ";
		String username = this.getPara("username");
		int work_area = this.getParaToInt("work_area");
		int op_class = this.getParaToInt("op_class");
		
		SysUser user = SysUser.me.getUserOP(username);
		if(user.getUserType().intValue()==0){//管理员
			
			if(work_area>0){
				sqlException+=" AND work_area.id="+work_area;
			}
			sqlException += " ORDER BY warnimages.create_time DESC LIMIT 14";
		}else if(user.getUserType().intValue()==1){//工区
			if(work_area>0){
				sqlException+=" AND work_area.id="+work_area;
			}else {
				sqlException+=" AND work_area.id="+user.getWork_area_id();
			}
			
			if(op_class>0){
				sqlException+=" AND operation_class.id="+op_class;
			}
			
			sqlException += " ORDER BY warnimages.create_time DESC LIMIT 16";
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
			
			sqlException += " ORDER BY warnimages.create_time DESC LIMIT 16";
		}
		
		
		/*if (SysUserRole.dao.isOp(username)) {
			sqlString = "SELECT building.building_name,warnimages.url AS url,temp.av_temp AS av,temp.max_temp AS max,temp.min_temp AS min ,warnimages.id as id, warnimages.create_time as create_time, warnimages.im_sensor_code as im_sensor_code,warnimages.point_type,platform_point.platform_code,sensor.name as sensor_name,station.station_name,building.id AS buildingID,station.id AS stationID,operation_class.id AS opID FROM warnimages,temp,building,sensor,station,operation_class,platform_point WHERE temp.create_time=warnimages.create_time AND warnimages.im_sensor_code=temp.temp_sensor_code AND sensor.sensor_code=temp.temp_sensor_code AND platform_point.pp_sensor_code=warnimages.im_sensor_code AND warnimages.point_type=platform_point.point_type AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id AND warnimages.status=0 ORDER BY warnimages.create_time DESC LIMIT 16";
		} else {
			sqlString = "SELECT building.building_name,warnimages.url AS url,temp.av_temp AS av,temp.max_temp AS max,temp.min_temp AS min ,warnimages.id as id, warnimages.create_time as create_time, warnimages.im_sensor_code as im_sensor_code,warnimages.point_type,platform_point.platform_code,sensor.name as sensor_name,station.station_name,building.id AS buildingID,station.id AS stationID,operation_class.id AS opID FROM warnimages,temp,building,sensor,operation_class,station,platform_point WHERE temp.create_time=warnimages.create_time AND warnimages.im_sensor_code=temp.temp_sensor_code AND sensor.sensor_code=temp.temp_sensor_code AND platform_point.pp_sensor_code=warnimages.im_sensor_code AND warnimages.point_type=platform_point.point_type AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id AND warnimages.status=0 AND operation_class.id=(SELECT sys_user.operation_class_id FROM sys_user WHERE sys_user.`name`='"
					+ username + "') ORDER BY warnimages.create_time DESC LIMIT 16";
		}*/

		List<Record> imageList = Db.find(sqlString+sqlException);
		setAttr("content", imageList);
		if (imageList != null && imageList.size() > 0) {
			setAttr("result", true);
		} else {
			setAttr("result", false);
		}

		renderJson();

	}
	
	
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
		String sqlString2 = "select MAX(temp.max_temp) AS today_max_temp,Min(temp.min_temp) AS today_min_temp  ";
		String sqlString3 = "select MAX(temp.max_temp) AS yesterday_max_temp";
		String sqlString4 = "select MAX(temp.max_temp) AS month_max_temp ";
		String sqlString5 = "SELECT count(warn.id) warn_num,station.id";
		String sqlexcept1 = " from sensor,building,station,operation_class WHERE operation_class.id=station.op_id AND station.id=building.station_id AND sensor.building_id=building.id ";
		String sqlexcept2 = " from temp,sensor,building,station,operation_class where operation_class.id=station.op_id AND station.id=building.station_id AND sensor.building_id=building.id AND temp.temp_sensor_code=sensor.sensor_code AND temp.status=0 AND DATEDIFF(temp.create_time,NOW())=0 ";
		String sqlexcept3 = " from temp,sensor,building,station,operation_class where operation_class.id=station.op_id AND station.id=building.station_id AND sensor.building_id=building.id AND temp.temp_sensor_code=sensor.sensor_code AND temp.status=0 AND DATEDIFF(temp.create_time,NOW())=-1";
		String sqlexcept4 = " from temp,sensor,building,station,operation_class where operation_class.id=station.op_id AND station.id=building.station_id AND sensor.building_id=building.id AND temp.temp_sensor_code=sensor.sensor_code AND temp.status=0 AND PERIOD_DIFF(date_format(now(),'%Y%m'),date_format(temp.create_time,'%Y%m'))=0 ";
		String sqlexcept5 = " from warn,sensor,building,station,operation_class WHERE operation_class.id=station.op_id AND station.id=building.station_id AND sensor.building_id=building.id AND warn.sensor_code=sensor.sensor_code AND warn.`status`=0 ";
		if(user.getUserType().intValue()==0){//管理员
			if(work_area>0){
				sqlexcept1+="  AND operation_class.work_area_id="+work_area;
				sqlexcept2+="  AND operation_class.work_area_id="+work_area;
				sqlexcept3+="  AND operation_class.work_area_id="+work_area;
				sqlexcept4+="  AND operation_class.work_area_id="+work_area;
				sqlexcept5+="  AND operation_class.work_area_id="+work_area;
			}
		}else if(user.getUserType().intValue()==1){//工区
			
			if(work_area>0){
				sqlexcept1+="  AND operation_class.work_area_id="+work_area;
				sqlexcept2+="  AND operation_class.work_area_id="+work_area;
				sqlexcept3+="  AND operation_class.work_area_id="+work_area;
				sqlexcept4+="  AND operation_class.work_area_id="+work_area;
				sqlexcept5+="  AND operation_class.work_area_id="+work_area;
			}else {
				sqlexcept1+="  AND operation_class.work_area_id="+user.getWork_area_id();
				sqlexcept2+="  AND operation_class.work_area_id="+user.getWork_area_id();
				sqlexcept3+="  AND operation_class.work_area_id="+user.getWork_area_id();
				sqlexcept4+="  AND operation_class.work_area_id="+user.getWork_area_id();
				sqlexcept5+="  AND operation_class.work_area_id="+user.getWork_area_id();
			}
			
			if(op_class>0){
				sqlexcept1+=" AND operation_class.id="+op_class;
				sqlexcept2+=" AND operation_class.id="+op_class;
				sqlexcept3+=" AND operation_class.id="+op_class;
				sqlexcept4+=" AND operation_class.id="+op_class;
				sqlexcept5+="  AND operation_class.id="+op_class;
			}else {
				sqlexcept1+=" AND operation_class.id="+user.getOperation_class_id();
				sqlexcept2+=" AND operation_class.id="+user.getOperation_class_id();
				sqlexcept3+=" AND operation_class.id="+user.getOperation_class_id();
				sqlexcept4+=" AND operation_class.id="+user.getOperation_class_id();
				sqlexcept5+="  AND operation_class.id="+user.getOperation_class_id();
			}
			
		}else if(user.getUserType().intValue()==2){//运维班
			if(work_area>0){
				sqlexcept1+="  AND operation_class.work_area_id="+work_area;
				sqlexcept2+="  AND operation_class.work_area_id="+work_area;
				sqlexcept3+="  AND operation_class.work_area_id="+work_area;
				sqlexcept4+="  AND operation_class.work_area_id="+work_area;
				sqlexcept5+="  AND operation_class.work_area_id="+work_area;
			}else {
				sqlexcept1+="  AND operation_class.work_area_id="+user.getWork_area_id();
				sqlexcept2+="  AND operation_class.work_area_id="+user.getWork_area_id();
				sqlexcept3+="  AND operation_class.work_area_id="+user.getWork_area_id();
				sqlexcept4+="  AND operation_class.work_area_id="+user.getWork_area_id();
				sqlexcept5+="  AND operation_class.work_area_id="+user.getWork_area_id();
			}

			if(op_class>0){
				sqlexcept1+=" AND operation_class.id="+op_class;
				sqlexcept2+=" AND operation_class.id="+op_class;
				sqlexcept3+=" AND operation_class.id="+op_class;
				sqlexcept4+=" AND operation_class.id="+op_class;
				sqlexcept5+="  AND operation_class.id="+op_class;
			}else {
				sqlexcept1+=" AND operation_class.id="+user.getOperation_class_id();
				sqlexcept2+=" AND operation_class.id="+user.getOperation_class_id();
				sqlexcept3+=" AND operation_class.id="+user.getOperation_class_id();
				sqlexcept4+=" AND operation_class.id="+user.getOperation_class_id();
				sqlexcept5+="  AND operation_class.id="+user.getOperation_class_id();
			}
		}
		sqlexcept5+=" GROUP BY station.id ";
		String sql7 = "SELECT SUM(ws.warn_num) as warn_sum, count(1) As station_num FROM ("+sqlString5+sqlexcept5+") AS ws";
		Record r = new Record();
		String sql = "SELECT IFNULL(a.sum,0) as sum,IFNULL(a.line_sum,0) as line_sum,IFNULL(b.today_max_temp,0) as today_max_temp,IFNULL(b.today_min_temp,0) as today_min_temp,IFNULL(c.yesterday_max_temp,0) as yesterday_max_temp,IFNULL(d.month_max_temp,0) as month_max_temp,IFNULL(e.warn_sum,0) as warn_sum,IFNULL(e.station_num,0) as station_num from ("+sqlString1+sqlexcept1+") AS a, ("
						+ sqlString2+sqlexcept2+") AS b, ("
						+ sqlString3+sqlexcept3+") AS c, ("
						+ sqlString4+sqlexcept4+") AS d, ("
						+sql7+") AS e";
		
		List<Record> rList = Db.find(sql);
		if(rList!=null && rList.size()>0){
			r = rList.get(0);
			this.renderJson(InvokeResult.success(r));
		}else {
			this.renderJson(InvokeResult.failure("无数据"));
		}
	}

	/**
	 * 告警推送
	 */
	public void getWarnNews() {
		String sqlString = null;
//		String username = this.getPara("username");
		String status = this.getPara("status");
		String[] sensor=this.getPara("sensor").split("/");
		String sensor_code=sensor[0];
		String point_type=sensor[1];
		// System.out.println("*****************************************************8" + status);
//		if (SysUserRole.dao.isOp(username)) {
		if (status.equals("2")) {
			sqlString = "SELECT warn.*,station.station_name,building.building_name,sensor.`name` AS sensorName,platform_point.platform_code,operation_class.op_name FROM building,station,sensor,platform_point,warn,operation_class WHERE warn.point_type=platform_point.point_type AND warn.sensor_code=platform_point.pp_sensor_code AND platform_point.pp_sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id AND platform_point.pp_sensor_code='"+sensor_code+"' AND platform_point.point_type='"+point_type+"' ORDER BY warn.create_time DESC";
		} else {
			sqlString = "SELECT warn.*,station.station_name,building.building_name,sensor.`name` AS sensorName,platform_point.platform_code,operation_class.op_name FROM building,station,sensor,platform_point,warn,operation_class WHERE warn.point_type=platform_point.point_type AND warn.sensor_code=platform_point.pp_sensor_code AND platform_point.pp_sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id AND warn.status="
					+ status + " AND platform_point.pp_sensor_code='"+sensor_code+"' AND platform_point.point_type='"+point_type+"' ORDER BY warn.create_time DESC";
		}
//		} 
		/*else {
			if (status.equals("2")) {
				sqlString = "SELECT warn.*,station.station_name,building.building_name,sensor.`name` AS sensorName,platform_point.platform_code,operation_class.op_name FROM building,station,sensor,platform_point,warn,operation_class WHERE warn.point_type=platform_point.point_type AND warn.sensor_code=platform_point.pp_sensor_code AND platform_point.pp_sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id AND operation_class.id=(SELECT sys_user.operation_class_id FROM sys_user WHERE sys_user.`name`='"
						+ username + "') ORDER BY warn.create_time DESC";
			} else {
				sqlString = "SELECT warn.*,station.station_name,building.building_name,sensor.`name` AS sensorName,platform_point.platform_code,operation_class.op_name FROM building,station,sensor,platform_point,warn,operation_class WHERE warn.point_type=platform_point.point_type AND warn.sensor_code=platform_point.pp_sensor_code AND platform_point.pp_sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id AND operation_class.id=(SELECT sys_user.operation_class_id FROM sys_user WHERE sys_user.`name`='"
						+ username + "') AND warn.status=" + status + " ORDER BY warn.create_time DESC";
			}

		}*/
		List<Record> imageList = Db.find(sqlString);
		setAttr("content", imageList);
		if (imageList != null && imageList.size() > 0) {
			setAttr("result", true);
		} else {
			setAttr("result", false);
		}
		renderJson();
	}

	/**
	 * 得到变电站的历史最高温度和当前温度
	 */
	public void getStationTemp() {
		String op_class = this.getPara("op_class");
		String sqlString = "SELECT platform_point.current_temp,platform_point.history_max_temp ,platform_point.update_time,IFNULL(platform_point.history_time,'') AS history_time,station.station_name,building.building_name,sensor.`name`,platform_point.platform_code FROM station,operation_class,building,sensor,platform_point WHERE operation_class.id=station.op_id AND station.id=building.station_id AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code AND platform_point.islook=1 AND operation_class.id=?";
		List<Record> tempList = Db.find(sqlString, op_class);
		setAttr("content", tempList);
		if (tempList != null && tempList.size() > 0) {
			setAttr("result", true);
		} else {
			setAttr("result", false);
		}
		renderJson();
	}

	/**
	 * 得到当前变电站每个设备的折线图
	 */
	public void getSensorTemp() {
		String station=this.getPara("station");
		String op_class = this.getPara("op_class");
		// String sqlString = "select date_format(temp.create_time,'%m-%d') AS sj,max(temp.max_temp) AS maxTemp,temp.point_type,temp.temp_sensor_code,sensor.`name` AS sensor_name,platform_point.platform_code AS platform_point_name,station.station_name from platform_point,temp,sensor,building,station,operation_class where platform_point.pp_sensor_code=sensor.sensor_code AND platform_point.point_type=temp.point_type AND temp.temp_sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND operation_class.id=station.op_id AND temp.status = 0 AND operation_class.id=? AND platform_point.islook=1 AND date_format(temp.create_time,'%Y-%m-%d')>=DATE_FORMAT(DATE_ADD(sysdate(),INTERVAL -29 day),'%Y-%m-%d') group by date_format(temp.create_time,'%Y-%m-%d'),temp.point_type,temp.temp_sensor_code";
		String sqlString = "select temp.*,sensor.`name` AS sensor_name,platform_point.platform_code AS platform_point_name,station.station_name from platform_point,sensor,building,station,operation_class,(select date_format(temp.create_time,'%m-%d') AS sj,temp.point_type,temp.temp_sensor_code,max(temp.max_temp) AS maxTemp from temp where temp.status = 0 AND temp.create_time>=DATE_ADD(sysdate(),INTERVAL -29 day) group by date_format(temp.create_time,'%Y-%m-%d'),temp.point_type,temp.temp_sensor_code) temp where platform_point.point_type=temp.point_type AND temp.temp_sensor_code=platform_point.pp_sensor_code AND platform_point.islook=1 AND platform_point.pp_sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND operation_class.id=station.op_id AND operation_class.id=?";
		List<Record> tempList = new ArrayList<Record>();
		if(!station.equals("0")){
			//sqlString = "select date_format(temp.create_time,'%m-%d') AS sj,max(temp.max_temp) AS maxTemp,temp.point_type,temp.temp_sensor_code,sensor.`name` AS sensor_name,platform_point.platform_code AS platform_point_name,station.station_name from platform_point,temp,sensor,building,station,operation_class where platform_point.pp_sensor_code=sensor.sensor_code AND platform_point.point_type=temp.point_type AND temp.temp_sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND station.id=? AND operation_class.id=station.op_id AND temp.status = 0 AND operation_class.id=? AND platform_point.islook=1 AND date_format(temp.create_time,'%Y-%m-%d')>=DATE_FORMAT(DATE_ADD(sysdate(),INTERVAL -29 day),'%Y-%m-%d') group by date_format(temp.create_time,'%Y-%m-%d'),temp.point_type,temp.temp_sensor_code";
			sqlString = "select temp.*,sensor.`name` AS sensor_name,platform_point.platform_code AS platform_point_name,station.station_name from platform_point,sensor,building,station,operation_class,(select date_format(temp.create_time,'%m-%d') AS sj,temp.point_type,temp.temp_sensor_code,max(temp.max_temp) AS maxTemp from temp where temp.status = 0 AND temp.create_time>=DATE_ADD(sysdate(),INTERVAL -29 day) group by date_format(temp.create_time,'%Y-%m-%d'),temp.point_type,temp.temp_sensor_code) temp where platform_point.point_type=temp.point_type AND temp.temp_sensor_code=platform_point.pp_sensor_code AND platform_point.islook=1 AND platform_point.pp_sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND operation_class.id=station.op_id AND station.id=?";
			tempList = Db.find(sqlString,station);
		}else {
			tempList = Db.find(sqlString, op_class);
		}
		
		setAttr("content", tempList);
		if (tempList != null && tempList.size() > 0) {
			setAttr("result", true);
		} else {
			setAttr("result", false);
		}
		renderJson();
	}

	/**
	 * 测温动态光字牌
	 */
	public void getWarnNumber() {
		String username = this.getPara("username");
		int work_area = this.getParaToInt("work_area");
		int op_class = this.getParaToInt("op_class");
		SysUser user = SysUser.me.getUserOP(username);
		
		String sqlString = "";
		
		if(user.getUserType().intValue()==0){//管理员
			
			if(work_area>0){
				sqlString = "SELECT IFNULL(b.summ,0) AS number, a.op_name as address,IFNULL(c.maxTemp,0) AS temper,a.id AS op_id,a.work_area_id from (select operation_class.op_name,operation_class.id,operation_class.work_area_id from operation_class,work_area where work_area.id=operation_class.work_area_id AND work_area.id="+
						work_area+") a LEFT JOIN (SELECT COUNT(operation_class.op_name) summ,operation_class.op_name,work_area.id AS work_area_id,work_area.area from warn,sensor,building,station,operation_class ,work_area where work_area.id=operation_class.work_area_id AND work_area.id="+
						work_area+" AND warn.sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id AND warn.status=0 GROUP BY operation_class.id) b ON a.op_name =b.op_name LEFT JOIN (SELECT MAX(platform_point.current_temp) maxTemp,operation_class.op_name FROM platform_point,sensor,building,station,operation_class ,work_area where work_area.id=operation_class.work_area_id AND work_area.id="+
						work_area+" AND platform_point.pp_sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id GROUP BY operation_class.id) c ON c.op_name=a.op_name";
			}else {
				setAttr("result", false);
				renderJson();
				return;
			}
		}else if(user.getUserType().intValue()==1){//工区
			work_area=user.getWork_area_id();
			
			if(op_class == 0){
				setAttr("result", false);
				renderJson();
				return;
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
		
		
		/*if (SysUserRole.dao.isOp(username)) {
			sqlString = "select IFNULL(b.summ,0) AS number, a.op_name as address,IFNULL(c.maxTemp,0) AS temper,a.id AS op_id from (select operation_class.op_name,operation_class.id from operation_class) a LEFT JOIN (SELECT COUNT(operation_class.op_name) summ,operation_class.op_name from warn,sensor,building,station,operation_class WHERE warn.sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id AND warn.status=0 GROUP BY operation_class.id) b ON a.op_name =b.op_name LEFT JOIN (SELECT MAX(temp.max_temp) maxTemp,operation_class.op_name from temp,sensor,building,station,operation_class WHERE temp.temp_sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id GROUP BY operation_class.id) c ON c.op_name=a.op_name";
		} else {
			sqlString = "select IFNULL(b.summ,0) AS number, a.station_name as address, IFNULL(c.maxTemp,0) AS temper,a.op_id,a.id as station_id from (select station.station_name,station.id,station.op_id from station WHERE station.op_id = (SELECT operation_class_id FROM sys_user WHERE name='"
					+ username
					+ "')) a LEFT JOIN (SELECT COUNT(station.station_name) summ,station.station_name from warn,sensor,building,station,operation_class WHERE warn.sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id AND warn.status=0 GROUP BY station.id) b ON a.station_name =b.station_name LEFT JOIN (SELECT MAX(temp.max_temp) maxTemp,station.station_name from temp,sensor,building,station,operation_class WHERE temp.temp_sensor_code=sensor.sensor_code AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id GROUP BY station.id) c ON c.station_name=a.station_name";
		}*/
		
		sqlString +=" ORDER BY number DESC ";
		
		List<Record> imageList = Db.find(sqlString);
		setAttr("content", imageList);
		if (imageList != null && imageList.size() > 0) {
			setAttr("result", true);
		} else {
			setAttr("result", false);
		}

		renderJson();
	}

	public void getListData() {
		String op_class = this.getPara("op_class");
		String station = this.getPara("station");
		String building = this.getPara("building");
		String sensor = this.getPara("sensor");
		String status = this.getPara("status");
		//System.out.println("*************"+status);
		if (op_class==null || op_class=="" || op_class.equals("0")) {
			op_class = null;
		}
		if (station==null || station=="" || station.equals("0")) {
			station = null;
		}
		if (building==null || building=="" || building.equals("0")) {
			building = null;
		}
		if (sensor==null || sensor=="" || sensor.equals("0")) {
			sensor = null;
		}
		
		Page<Warn> pageInfo = Warn.me.getWarnPage(this.getPage(), this.getRows(), op_class, station, building, sensor,Integer.parseInt(status),
				this.getOrderbyStr());
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
		if(CommonUtils.isNotEmpty(sidx)){
			return " order by warn."+ sidx+" "+sord;
		}
		return "";
	}

	/*
	 * public void add() { Integer id=this.getParaToInt("id"); if(id!=null){
	 * this.setAttr("item", Sensor.me.findById(id)); } this.setAttr("id", id);
	 * render("sensor_add.jsp"); } public void save(){ String
	 * name=this.getPara("name"); String
	 * sensor_code=this.getPara("sensor_code"); Integer
	 * id=this.getParaToInt("id"); Integer
	 * building_id=this.getParaToInt("building_id"); InvokeResult
	 * result=Sensor.me.save(id, name,sensor_code,building_id);
	 * this.renderJson(result); }
	 */

	/*
	 * public void deleteData(){ Integer id=this.getParaToInt("id");
	 * InvokeResult invokeResult=Warn.me.deleteData(id);
	 * this.renderJson(invokeResult); }
	 */
	public void look() {
		Integer id = this.getParaToInt("id");
		System.out.println(id + "asdgasgggg");
		if (id != null) {
			String sqlString = "SELECT images.url,temp.* FROM images,temp,warn WHERE warn.sensor_code=temp.temp_sensor_code AND temp.temp_sensor_code=images.im_sensor_code AND temp.point_type=warn.point_type AND warn.point_type=images.point_type AND warn.create_time=temp.create_time AND warn.create_time=images.create_time AND warn.id=?";
			List<Record> imageList = Db.find(sqlString, id);
			this.setAttr("content", imageList);
			this.setAttr("result", true);
		} else {
			this.setAttr("result", false);
		}
		renderJson();
	}

	// 消除告警
	public void warnWindows() {
		int id=this.getParaToInt("id");
		String station_name=this.getPara("station_name");
		String sensor_name=this.getPara("sensor_name");
		String platform_code=this.getPara("platform_code");
		String create_time=this.getPara("create_time");
		String max_temp = this.getPara("temp");
		String sensor_code = this.getPara("sensor_code");
		String building_name=this.getPara("building_name");
		Record r = new Record();
		new Thread(()->setTempCancel(id,create_time,sensor_code)).start();
		r.set("id", id);
		r.set("station_name", station_name);
		r.set("building_name", building_name);
		r.set("sensor_name", sensor_name);
		r.set("platform_code", platform_code);
		r.set("create_time", create_time);
		r.set("temp", max_temp);
		this.setAttr("item", r);
		this.setAttr("id", id);
		this.renderJson();
		
		this.render("warn_dlg.jsp");
	}
	public void setTempCancel(int warnID,String create_time,String sensor_code) {
		
		String sqlString = "UPDATE warn SET warn.cancel=1 where warn.id=?";
		String tempSql =  "UPDATE temp SET temp.cancel=1 where temp_sensor_code=? AND create_time=?";
		/*if(SysUserRole.dao.isOp(userName)){
			sqlString = "UPDATE warn,platform_point SET warn.`status`=1 where warn.point_type=platform_point.point_type AND warn.sensor_code=platform_point.pp_sensor_code AND temp.max_temp>platform_point.warn_temp AND temp.status = 0";
		}else{
			sqlString = "UPDATE platform_point,warn,station,operation_class,building,sensor SET warn.`status`=1 WHERE operation_class.id=station.op_id AND station.id=building.station_id AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code AND warn.point_type=platform_point.point_type AND warn.sensor_code=platform_point.pp_sensor_code AND warn.status = 0 AND operation_class.id=(SELECT operation_class_id FROM sys_user WHERE sys_user.`name`='"+userName+"')";
		}*/
		int b=Db.update(sqlString,warnID);
		if((create_time!=null&&create_time!="") && (sensor_code!=null&&sensor_code!="")){
			Db.update(tempSql,sensor_code,create_time);
		}
		
	}
	
	
	
	// 消除告警
	public void setVisible() {
		Integer visible = this.getParaToInt("visible");
		String bids = this.getPara("ids");
		InvokeResult result = Warn.me.setVisible(bids, visible);
		this.renderJson(result);
	}

	public void deleteData() {
		/*
		 * Integer id=this.getParaToInt("id"); InvokeResult
		 * invokeResult=Warn.me.deleteData(id);
		 */
		String id = this.getPara("id");
		InvokeResult invokeResult = Warn.me.deleteData(id);
		this.renderJson(invokeResult);
	}

}
