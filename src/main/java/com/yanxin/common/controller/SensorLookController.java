/**
 * 
 */
package com.yanxin.common.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.jcbase.core.controller.JCBaseController;
import com.jcbase.core.util.CommonUtils;
import com.jcbase.core.util.JqGridModelUtils;
import com.jcbase.core.view.InvokeResult;
import com.jcbase.model.SysUser;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.common.model.Sensor;
import com.yanxin.common.model.Temp;
import com.yanxin.common.model.Warn;

/**
 * @author Guozhen Cheng
 *
 */
public class SensorLookController extends JCBaseController {
	
	public void index() {
		render("sensor_indexs.jsp");
	}
	
	public void getSensorStatus() {
		String username=this.getPara("username");
		
		if(username==null){
			this.renderJson(InvokeResult.failure("参数有误"));
			return;
		}
		
		SysUser user = SysUser.me.getUserOP(username);
		if(user==null){
			this.renderJson(InvokeResult.failure("用户不存在"));
			return;
		}
		
		int area = 0;
		int opID = 0;
		int station = 0;
		int building = 0;
		int status = 2;
		
		if(this.getPara("workarea")!=null){
			area = this.getParaToInt("workarea");
		}
		if(this.getPara("op_id")!=null){
			opID = this.getParaToInt("op_id");
		}
		if(this.getPara("station")!=null){
			station = this.getParaToInt("station");
		}
		if(this.getPara("building")!=null){
			building = this.getParaToInt("building");
		}
		if(this.getPara("status")!=null){
			status = this.getParaToInt("status");
		}
		
		Page<Sensor> pageInfo=Sensor.me.getSensorPageNew(getPage(), this.getRows(),username,area,opID,station,building,status,this.getOrderbyStr());
		this.renderJson(JqGridModelUtils.toJqGridView(pageInfo)); 
	}
	
	/**
	 * （旧）只确认一条告警
	 */
	public void confirmWarn2() {
		Integer id=this.getParaToInt("id");
		if(id!=null){
			
			Record r = Db.findFirst("select warn.*,sensor.name,building.building_name,building.station_id,station.station_name,operation_class.op_name,station.op_id,operation_class.work_area_id from warn,sensor,building,station,operation_class where warn.id=? and warn.sensor_code=sensor.sensor_code and sensor.building_id=building.id and building.station_id=station.id and station.op_id=operation_class.id", id);
			this.setAttr("item", r);
			
		}
		this.setAttr("id", id);
		render("warn_confirm.jsp");
		
	}
	/**
	 * (旧)只确认一条告警
	 */
	public void saveConfirm2(){
		String confirm = this.getPara("confirm_user");
		String allow = this.getPara("allow_user");
		InvokeResult result;
		if(this.getPara("id")!=null && confirm!=null && allow!=null){
			int id = this.getParaToInt("id");
			Warn warn = Warn.me.findById(id);
			//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd  HH:mm:ss");
			warn.set("confirm_user", confirm).set("allow", allow).set("status", 1).set("confirm_time", new Date()).update();
			Temp temp = Temp.me.findFirst("SELECT * from temp WHERE temp.create_time=? AND temp.point_type=? AND temp.temp_sensor_code=?",
								warn.getCreateTime(),warn.getPointType(),warn.getSensorCode());
			if(temp!=null){
				temp.set("status",1).update();
			}
			result =  InvokeResult.success();
		}else {
			result =  InvokeResult.failure("失败");
			
		}
		this.renderJson(result);
	}
	
	/**
	 * 可以确认多条告警,调用saveConfirmAll
	 */
	public void confirmWarnALL() {
		
		String name=this.getPara("username");
		
		this.setAttr("useranme", name);
		render("warn_confirm_all.jsp");
	}
	/**
	 *  可以确认多条告警
	 */
	public void saveConfirmAll(){
		String username=this.getPara("username");
		System.out.println("confirm"+username);
		String confirm = this.getPara("confirm_user");
		String allow = this.getPara("allow_user");
		Date dd =new Date();
		InvokeResult result = Warn.me.setConfirmWarnWithName(username,confirm,allow,dd);
		
		this.renderJson(result);
	}
	/**
	 * 可以确认多条告警,调用saveConfirm
	 */
	public void confirmWarn() {
		
		String id=this.getPara("id");
		
		this.setAttr("id", id);
		render("warn_confirm.jsp");
	}
	/**
	 *  可以确认多条告警
	 */
	public void saveConfirm(){
		String id=this.getPara("id");
		String confirm = this.getPara("confirm_user");
		String allow = this.getPara("allow_user");
		Date dd =new Date();
		InvokeResult result = Warn.me.setConfirmWarnWithName(id,1,confirm,allow,dd);
		
		this.renderJson(result);
	}
	
	public void saveWarnInfo(){
		String idStr = this.getPara("id");
		int id = 0;
		if(idStr!=null){
			id = this.getParaToInt("id");
		}
		String create_time = this.getPara("create_time");
		if(create_time == null || create_time == ""){
			create_time="";
		}
		String op_time = this.getPara("op_time");
		if(create_time == null || create_time == ""){
			create_time="";
		}
		String analysis = this.getPara("analysis");
		if(analysis == null || analysis == ""){
			analysis="";
		}
		String opinion = this.getPara("opinion");
		if(opinion == null || opinion == ""){
			opinion="";
		}
		String remark = this.getPara("remark");
		if(remark == null || remark == ""){
			remark="";
		}
		String confirm_user = this.getPara("confirm_user");
		if(confirm_user == null || confirm_user == ""){
			confirm_user="";
		}
		String payload = this.getPara("payload");
		if(payload == null || payload == ""){
			payload="";
		}
		
		String sql = "update warn SET current=?,maintence_time=?, op_time=?,reason=?,suggestion=?,remark=?,confirm_user=? WHERE id=?";
		Db.update(sql, payload,create_time,op_time,analysis,opinion,remark,confirm_user,id);
		
		InvokeResult result = InvokeResult.success("成功");
		this.renderJson(result);
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
}
