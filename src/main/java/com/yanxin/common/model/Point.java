package com.yanxin.common.model;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import com.jcbase.core.model.Condition;
import com.jcbase.core.model.Operators;
import com.jcbase.core.view.InvokeResult;
import com.jfinal.plugin.activerecord.Db;
import com.yanxin.common.model.base.BasePoint;

public class Point extends BasePoint<Point> {

	private static final long serialVersionUID = -4834111302759104592L; 
	public static final Point me = new Point();
	
	
	
	//用户名是否存在
		public boolean hasExist(String name,String pp_sensor_code){
			Set<Condition> conditions=new HashSet<Condition>();
			conditions.add(new Condition("platform_code",Operators.EQ,name));
			conditions.add(new Condition("pp_sensor_code",Operators.EQ,pp_sensor_code));
			long num=this.getCount(conditions);
			return num>0?true:false;
		}
		
		
		@SuppressWarnings("unused")
		public InvokeResult save(Integer id, String pp_sensor_code, String platform_code, String images, Integer warn_temp, Integer point_type) {
			// TODO Auto-generated method stub
			System.out.println(images+pp_sensor_code+point_type+"***************************");
			if(id!=null){
				Point point=this.findById(id);
				if(warn_temp==null && point_type==0 && images.equals("0") ) {
					System.out.println(images+"***************************10");
					point.set("pp_sensor_code",pp_sensor_code).set("create_time", new Date()).update();
				}
				else if(warn_temp==null && point_type==0 && pp_sensor_code.equals("0") ) {
					System.out.println(images+"***************************11");
					point.set("images",images).set("create_time", new Date()).update();
				}
				else if(images.equals("0") && point_type==0 && pp_sensor_code.equals("0") ) {
					System.out.println(images+"***************************12");
					point.set("warn_temp",warn_temp).set("create_time", new Date()).update();
				}
				else if(images.equals("0") && point_type==0 && pp_sensor_code.equals("0") && warn_temp==null) {
					System.out.println(images+"***************************13");
					point.set("platform_code", platform_code).update();
				}
				else if(pp_sensor_code.equals("0") && images.equals("0")) {
					System.out.println(images+"***************************5");
					point.set("create_time", new Date()).set("warn_temp",warn_temp).update();
				}
				else if(pp_sensor_code.equals("0") && warn_temp==null) {
					System.out.println(images+"***************************6");
					point.set("images",images).set("create_time", new Date()).update();
				}
				else if(images.equals("0") && warn_temp==null ) {
					System.out.println(images+"***************************7");
					point.set("pp_sensor_code",pp_sensor_code).set("create_time", new Date()).set("point_type",point_type).update();
				}
				else if(images.equals("0") && point_type==0 ) {
					System.out.println(images+"***************************8");
					point.set("pp_sensor_code",pp_sensor_code).set("create_time", new Date()).set("warn_temp",warn_temp).update();
				}
				else if(warn_temp==null && point_type==0 ) {
					System.out.println(images+"***************************9");
					point.set("pp_sensor_code",pp_sensor_code).set("create_time", new Date()).set("images",images).update();
				}
				else if(pp_sensor_code.equals("0")) {
					System.out.println(images+"***************************1");
					point.set("images",images).set("create_time", new Date()).set("warn_temp",warn_temp).update();
				}
				else if(images.equals("0")) {
					System.out.println(images+"***************************2");
					point.set("pp_sensor_code",pp_sensor_code).set("create_time", new Date()).set("warn_temp",warn_temp).set("point_type",point_type).update();
				}
				else if(warn_temp==null) {
					System.out.println(images+"***************************3");
					point.set("images",images).set("pp_sensor_code",pp_sensor_code).set("create_time", new Date()).set("point_type",point_type).update();
				}
				else if(point_type==0) {
					System.out.println(images+"***************************4");
					point.set("images",images).set("pp_sensor_code",pp_sensor_code).set("create_time", new Date()).set("warn_temp",warn_temp).update();
				}
				
				
			}else {
				if(this.hasExist(platform_code,pp_sensor_code)){
					return InvokeResult.failure("该监控器的预设点已存在");
				}else {
					new Point().set("platform_code", platform_code).set("images",images).set("pp_sensor_code",pp_sensor_code).set("status",0).set("defaul",0).set("create_time", new Date()).set("warn_temp",warn_temp).set("point_type",point_type).save();
				}
					
			}
			
			return InvokeResult.success();
		} 
		
		public InvokeResult deleteData(Integer id) {
			this.deleteById(id);
			return InvokeResult.success();
		}
	
	
}
