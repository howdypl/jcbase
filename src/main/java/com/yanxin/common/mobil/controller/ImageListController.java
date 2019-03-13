package com.yanxin.common.mobil.controller;

import com.jcbase.core.controller.JCBaseController;
import com.jcbase.core.view.InvokeResult;
import com.jfinal.plugin.activerecord.Page;
import com.yanxin.common.model.Images;

public class ImageListController extends JCBaseController {
	
	public void getImages() {
		String createTimeString = getPara("create_time");
		String endTimeString = getPara("end_time");
		String op_class=this.getPara("op_class");
		String station=this.getPara("station");
		String building=this.getPara("building");
		String sensor=this.getPara("sensor");
		int page = 1;
		if(this.getPara("page")!=null && this.getPara("page")!=""){
			page=this.getParaToInt("page");
		}
		
		if(op_class.equals("0")||op_class==null||op_class=="") {
			op_class=null;
		}
		if(station.equals("0")||station==null||station=="") {
			station=null;
		}
		if(building.equals("0")||building==null||building=="") {
			building=null;
		}
		if(sensor.equals("0")||sensor==null||sensor=="") {
			sensor=null;
		}
		
		Page<Images> pageInfo=Images.me.getImagesPagev2(page,20,op_class,station,building,sensor,createTimeString,endTimeString,this.getOrderbyStr());
		
		this.renderJson(InvokeResult.success(pageInfo.getList()));
	}

}
