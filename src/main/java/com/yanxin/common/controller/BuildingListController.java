/**
 * 
 */
package com.yanxin.common.controller;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.jcbase.core.controller.JCBaseController;
import com.jcbase.core.model.Condition;
import com.jcbase.core.model.Operators;
import com.jcbase.core.util.CommonUtils;
import com.jcbase.core.util.JqGridModelUtils;
import com.jcbase.core.view.InvokeResult;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.common.model.Building;
import com.yanxin.common.model.OperationClass;
import com.yanxin.common.model.Station;

/**
 * @author Cheng Guozhen
 * 
 */
public class BuildingListController extends JCBaseController {
	
	public void index() {
//		String sqlString = "SELECT building.id,building.building_name,building.create_time,station.station_name,station.station_addr FROM building,station WHERE building.station_id=station.id";
//		
//		List<Record> buildingList = Db.find(sqlString);
//		setAttr("buildingList", buildingList);
		render("buildinglist_index.jsp");
	}
	public void getListData() {
		String keyword=this.getPara("name");
		Page<Building> pageInfo=Building.me.getBuildingPage(getPage(), this.getRows(),keyword,this.getOrderbyStr());
		this.renderJson(JqGridModelUtils.toJqGridView(pageInfo)); 
	}
	
	
	public void add() {
		Integer id=this.getParaToInt("id");
		if(id!=null){
			this.setAttr("item", Building.me.findById(id));
		}
		this.setAttr("id", id);
		render("buildinglist_add.jsp");
	}
	public void save(){
		String building_name=this.getPara("name");
		
		Integer id=this.getParaToInt("id");
		Integer station_id=this.getParaToInt("station_id");
		InvokeResult result=Building.me.save(id, building_name,station_id);
		this.renderJson(result); 
	}
	
	public void deleteData(){
		Integer id=this.getParaToInt("id");
		InvokeResult invokeResult=Building.me.deleteData(id);
		this.renderJson(invokeResult);
	}
//	public void deleteItem() {
//		int id = getParaToInt("Id");
//		
//		boolean result = Db.deleteById("building", "id", id);
//		
//		setAttr("result", result);
//		
//		renderJson();
//	}
	public void getStation() {
		int id = getParaToInt("opclass");
		String sqlString = "select id, station_name from station where op_id=?";
		List<Record> stationRecords = Db.find(sqlString,id);
		if(null!=stationRecords && !stationRecords.isEmpty()){
			setAttr("notempty", true);
			setAttr("stationRecords", stationRecords);
		}else{
			setAttr("notempty", false);
		}
		
		renderJson();
		
	}
//	public void addItem() {
//		Building building = new Building();
//		
//		building.setBuildingName(getPara("building_name"));
//		building.setStationId(getParaToLong("station"));
//		
//		building.setCreateTime(new Date());
//		
//		boolean result = Db.save("building", building.toRecord());
//		setAttr("result", result);
//		renderJson();
//	}
//
//	public void isExisting() {
//		String buildingName = getPara("buildingName");
//		
//		List<Record> sRecords = Db.find("select * from building where building_name=?", buildingName);
//		
//		if(sRecords.isEmpty()){
//			
//			setAttr("hasExisting", 0);
//		}else{
//			setAttr("hasExisting", 1);
//		}
//		renderJson();
//	}
	public void getBuilding() {
		int id = getParaToInt("station");
		
		List<Record> buildingRecords = Db.find("select id,building_name from building where station_id=?", id);
		if(buildingRecords != null && !buildingRecords.isEmpty()){
			setAttr("buildingRecords", buildingRecords);
			setAttr("notempty", true);
		}else {
			setAttr("notempty", false);
		}
		
		
		renderJson();
		
	}
}
