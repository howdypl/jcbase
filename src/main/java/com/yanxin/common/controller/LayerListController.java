/**
 * 
 */
package com.yanxin.common.controller;

import java.util.Date;
import java.util.List;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.common.model.Building;
import com.yanxin.common.model.Layer;

/**
 * @author Cheng Guozhen
 * 
 */
public class LayerListController extends Controller {
	
	public void index() {
		String sqlString = "SELECT layer.id, layer.layer_name,layer.create_time, building_name,station.station_name,station.station_addr FROM layer,building,station WHERE layer.building_id=building.id AND building.station_id = station.id";
		
		List<Record> layerRecords = Db.find(sqlString);
		
		setAttr("layerRecords", layerRecords);
		render("layerlist.jsp");
	}
	public void deleteItem() {
		int id = getParaToInt("Id");
		
		boolean result = Db.deleteById("layer", "id", id);
		
		setAttr("result", result);
		
		renderJson();
	}
	public void addItem() {
		Layer layer = new Layer();
		
		layer.setLayerName(getPara("layer_name"));
		layer.setBuildingId(getParaToLong("building"));

		
		layer.setCreateTime(new Date());
		
		boolean result = Db.save("layer", layer.toRecord());
		setAttr("result", result);
		renderJson();
	}
	public void isExisting() {
		String name = getPara("name");
		
		List<Record> sRecords = Db.find("select * from layer where layer_name=?", name);
		
		if(sRecords.isEmpty()){
			
			setAttr("hasExisting", 0);
		}else{
			setAttr("hasExisting", 1);
		}
		renderJson();
	}
	
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
