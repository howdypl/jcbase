/**
 * 
 */
package com.yanxin.common.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.collections.map.StaticBucketMap;
import org.eclipse.paho.client.mqttv3.MqttException;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.iot.Utils.ConstantsUtil;
import com.yanxin.iot.json.TimePayload;
import com.yanxin.iot.mqtt.CmdLineParser;

/**
 * @author Cheng Guozhen
 * 
 */
public class ImageAllController extends Controller {
	
	public void index() {
		render("imageall.jsp");
	}
	
	public void submitCmd() {
		try {
			ConstantsUtil.MQTTPlatformCMD("ffffffffffff", ConstantsUtil.PLATFORM_CMD_IMAGE_ALL, -1);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			setAttr("result", true);
			renderJson();
		}
	}
}
