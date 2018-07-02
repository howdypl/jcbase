/**
 * 
 */
package com.yanxin.common.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.iot.Utils.ConstantsUtil;
import com.yanxin.iot.mqtt.CmdLineParser;

/**
 * @author Cheng Guozhen
 * 
 */
public class VideoController extends Controller {
	Process builder1 = null;

	public void index() {
		render("video.jsp");
	}

	public void closeVideo() {

		try {

			Video.close();
			setAttr("result", true);
			renderJson();
		} catch (Exception e) {
			setAttr("result", false);
			renderJson();
		}
	}

	public void convertProtocol() {
		String sensorCodeString = getPara("sensor_code");
		int select = getParaToInt("platform");
        System.out.println(select+"egtentj");
        System.out.println(sensorCodeString+"fsgsjjjjjjjjjjjjjj");
        List<String> sensorList = new ArrayList<String>();
		if(sensorCodeString != null){
			sensorList.add(sensorCodeString);
		}
		// 设置预设点
        try {
        	ConstantsUtil.MQTTPlatformCMDBatch(sensorList, ConstantsUtil.PLATFORM_CMD_PRESET, select);
        	setAttr("result", true);
    		renderJson();
        }catch(Exception e){
        	setAttr("result", false);
        }
		try {
			
			String cmd = "D:/ffmpeg/bin/ffmpeg -i rtsp://184.72.239.149/vod/mp4://BigBuckBunny_175k.mov -vcodec copy -acodec copy -f flv -y rtmp://localhost:1935/live/test2";
			String s = Video.execute(cmd);
			System.out.println(s);
		} catch (Exception e) {
		}
		renderJson();
	}

	public void getSensorCode() {

		long roomid = getParaToLong("room");
		long sensor_type = getParaToLong("sensor_type");

		List<Record> records = Db.find(
				"select sensor_code,status from sensor where affiliation=4 and owner_id=? and type_id = ?", roomid,
				sensor_type);

		if (records != null && !records.isEmpty()) {
			setAttr("records", records);
			setAttr("result", true);
			renderJson();
		} else {
			setAttr("result", false);
			renderJson();
		}

	}

	public void getColour() {
		List<Record> records = Db.find("select id, colour from colour");
		if (records != null && !records.isEmpty()) {
			setAttr("records", records);
			setAttr("result", true);
			renderJson();
		} else {
			setAttr("result", false);
			renderJson();
		}
	}

	public void getSensorType() {

		// String sqlString = "select * from sensor_type where id<>11 and id <>10";
		String sqlString = "select * from sensor_type";
		List<Record> sensorTypeList = Db.find(sqlString);
		setAttr("sensorTypeList", sensorTypeList);
		renderJson();
	}

	public void getSensorStatus() {

		String sensor_code = getPara("sensor_code");

		Record record = Db.findById("sensor", "sensor_code", sensor_code);

		setAttr("record", record);

		renderJson();

	}

	public void getVideo() {

		String sensorCodeString = getPara("sensor_code");

		String colourCodeString = getPara("colour");
		final int colour = Integer.parseInt(colourCodeString);

		Record record = Db.findFirst("select port from sensor where affiliation=4 and sensor_code=?", sensorCodeString);
		setAttr("record", record);
		if (null != record) {
			setAttr("result", true);
		} else {
			setAttr("result", false);
		}

		new Thread() {
			public void run() {
				ConstantsUtil.execCMD(sensorCodeString, ConstantsUtil.SENSOR_TYPE_VIDEO,
						ConstantsUtil.SERVER_IP + ":" + record.getInt("port"), 0, colour);
			}
		}.start();

		ConstantsUtil.MQTTCommand(sensorCodeString, ConstantsUtil.SENSOR_TYPE_VIDEO,
				ConstantsUtil.SERVER_IP + ":" + record.getInt("port"), 1, colour);
		System.out.println(ConstantsUtil.SERVER_IP + ":" + record.getInt("port"));

		renderJson();
	}

	@SuppressWarnings("unused")
	private void command(String sensorCode, long type, String value, long status) {
		String[] args = null;
		final CmdLineParser parser = new CmdLineParser(args);

		parser.startController();

		parser.startSwitchPublishController(sensorCode, type, value, status);

	}

	@SuppressWarnings("unused")
	private void ffmplayerExecutor(String cmd) {
		Runnable runnable = new Runnable() {
			public void run() {
				try {
					System.out.println("before run");
					Runtime.getRuntime().exec(cmd);
					System.out.println("after run");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}
		};

		new Thread(runnable).start();
	}

}

