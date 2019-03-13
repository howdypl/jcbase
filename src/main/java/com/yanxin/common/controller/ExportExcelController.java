package com.yanxin.common.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import com.jcbase.core.util.XLSFileKit;
import com.yanxin.common.controller.ExportExcelService;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;


public class ExportExcelController extends Controller{

	ExportExcelService exportExcelService = new ExportExcelService();
	/**
	 * 导出表格
	 */
	public void exportOutExcel(){
		String sheetName = getPara("sheetName");		
		String createTimeString = getPara("create_time");
		String endTimeString = getPara("end_time");
		String[] s=this.getPara("sensor").split("/");
		String sensorCodeString=s[0];
		String point_type=s[1];
		String fileName = new Date().getTime()+ "_"+ "温度记录.xls";
		String filePath = getRequest().getRealPath("/") + "/file/export/";
		System.out.println(filePath+"1111");
		File file = new File(filePath);
		if(!file.exists()){
			file.mkdirs();
		}
		String relativePath = "/file/export/" + fileName;
		filePath += fileName;
		XLSFileKit xlsFileKit = new XLSFileKit(filePath);
		List<List<Object>> content = new ArrayList<List<Object>>();
		List<String> title = new ArrayList<String>();
		
		List<Record> datas = exportExcelService.getList(createTimeString,endTimeString,sensorCodeString,point_type);
		title.add("序号");
		title.add("所属运维班");
		title.add("所属变电站");
		title.add("所属设备间");
		title.add("设备名称");
		title.add("创建时间");
		title.add("最高温度");
		title.add("平均温度");
		title.add("最低温度");
		int i = 0;
		OK:
		while(true){
			if(datas.size() < (i + 1)){
				break OK;
			}
			int index = i + 1;
			List<Object> row = new ArrayList<Object>(); 
			row.add(index + "");
			row.add(null==datas.get(i).get("op_name")?"":datas.get(i).get("op_name"));
			row.add(null==datas.get(i).get("station_name")?"":datas.get(i).get("station_name"));
			row.add(null==datas.get(i).get("building_name")?"":datas.get(i).get("building_name"));
			row.add(null==datas.get(i).get("sensorName")?"":datas.get(i).get("sensorName"));
			row.add(null==datas.get(i).get("create_time")?"":datas.get(i).get("create_time"));
			row.add(null==datas.get(i).get("max_temp")?"":datas.get(i).get("max_temp"));
			row.add(null==datas.get(i).get("av_temp")?"":datas.get(i).get("av_temp"));
			row.add(null==datas.get(i).get("min_temp")?"":datas.get(i).get("min_temp"));
			content.add(row);
			i ++;
		}
		xlsFileKit.addSheet(content, sheetName, title);
		xlsFileKit.save();
		renderJson(new Record().set("relativePath", relativePath));
	}
	
}
