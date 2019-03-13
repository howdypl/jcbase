/**
 * 
 */
package com.yanxin.listener;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.yanxin.iot.Utils.ConstantsUtil;
import com.yanxin.iot.mqtt.ConnectionTimeoutDetection;

/**
 * @author Guozhen Cheng
 *
 */
public class MqttHeartBitListener implements ServletContextListener{
	private static final Logger log = LoggerFactory.getLogger(MqttHeartBitListener.class);
	// private static final ScheduledExecutorService scheduler = Executors.newSingleThreadScheduledExecutor();
	
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		log.info("心跳监测初始化...");
		ConstantsUtil.MqttHeartBit();
		/**设备失联异常检测*/
		// scheduler.scheduleAtFixedRate(new ConnectionTimeoutDetection(), 0,5,TimeUnit.MINUTES);
        new Thread(new ConnectionTimeoutDetection()).start();
	}

}
