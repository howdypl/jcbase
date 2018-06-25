/**
 * 
 */
package com.yanxin.common.controller;

import java.util.Date;
import java.util.List;

import com.alibaba.druid.sql.ast.statement.SQLIfStatement.Else;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.common.model.Layer;
import com.yanxin.common.model.Room;

/**
 * @author Cheng Guozhen
 * 
 */
public class RoomListController extends Controller {
	
	public void index() {
		String sqlString = "SELECT room.id, room_name,layer.layer_name,room.create_time, building_name,station.station_name,station.station_addr,operation_class.op_name FROM room,layer,building,station,operation_class WHERE room.layer_id = layer.id AND layer.building_id=building.id AND building.station_id = station.id AND station.op_id = operation_class.id";
		
		List<Record> roomRecords = Db.find(sqlString);
		
		setAttr("roomRecords", roomRecords);
		render("roomlist.jsp");
	}
	public void deleteItem() {
		int id = getParaToInt("Id");
		
		boolean result = Db.deleteById("room", "id", id);
		
		setAttr("result", result);
		
		renderJson();
	}
	public void addItem() {
		Room room = new Room();
		
		room.setRoomName(getPara("room_name"));
		room.setLayerId(getParaToLong("layer"));

		
		room.setCreateTime(new Date());
		
		boolean result = Db.save("room", room.toRecord());
		setAttr("result", result);
		renderJson();
	}

	
	public void getLayer() {
		int id = getParaToInt("layer");
		List<Record> layerRecords = Db.find("select id,layer_name from layer where building_id=?", id);
		
		if(layerRecords != null && !layerRecords.isEmpty()){
			setAttr("layerRecords", layerRecords);
			setAttr("notempty", true);
		}else {
			setAttr("notempty", false);
		}

		renderJson();
	}
	
	public void getRoom() {
		int id = getParaToInt("layer");
		List<Record> roomRecords = Db.find("select id,room_name from room where layer_id=?", id);
		if(roomRecords != null && !roomRecords.isEmpty()){
			setAttr("roomRecords", roomRecords);
			setAttr("notempty", true);
		}else {
			setAttr("notempty", false);
		}
		
		renderJson();
	}
	
	
	public void isExisting() {
		String name = getPara("name");
		int layer = getParaToInt("layer");
		List<Record> sRecords = Db.find("select * from room,layer where room.layer_id=layer.id and room_name=? and layer_id = ?", name,layer);
		
		if(sRecords.isEmpty()){
			
			setAttr("hasExisting", 0);
		}else{
			setAttr("hasExisting", 1);
		}
		renderJson();
	}

}
