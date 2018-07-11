package com.yanxin.iot;

import com.google.gson.JsonParser;
import com.yanxin.iot.Utils.ConstantsUtil;
import com.yanxin.iot.json.DeviceData;
import com.yanxin.iot.json.DevicePayload;
import com.yanxin.iot.mqtt.CmdLineParser;
import com.yanxin.iot.mqtt.MqttClientController;
import com.yanxin.iot.property.PropertiesUtil;

import org.eclipse.paho.client.mqttv3.MqttException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by Guozhen Cheng on 2017/6/11.
 */
public class Main
{
    private static Logger  log = LoggerFactory.getLogger(Main.class);
    


    public static void main( String[] args )
    {

        final CmdLineParser parser = new CmdLineParser(args);

        parser.startController();

        
        // parser.startSwitchPublishController(deviceId, type, status);
        //update time to sensors per 2 hours
        
        ////parser.startTimePublishController();
        

        //final MqttClientController client = parser.getClient();

        //client.subscribe(topicName, qos);
        
        // ===================test publish======================

/*        client.getCachedThreadPool().execute(new Runnable() {
			
			@Override
			public void run() {
				// TODO Auto-generated method stub
				// JsonParser jsonParser = new JsonParser();
				String deviceId = "sasdfewaaasde2";
				
				DevicePayload payload = client.getJsonParser().getCommand(deviceId, 6, 1);
				byte[] p = client.getJsonParser().getGson().toJson(payload).getBytes();
				
				// test topic: switches/v1/cmd
				String topic = ConstantsUtil.getPubTopic(1, 1, 1, 6);
				
				try {
					client.publish(topic, parser.getQos(), p);
				} catch (MqttException e) {
					// TODO Auto-generated catch block
					log.error("Publish command errors!");
					e.printStackTrace();
				}
			}
		});*/

    }

}
