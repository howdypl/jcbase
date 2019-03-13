package com.yanxin.listener;


import java.util.TimerTask;
import java.util.concurrent.ScheduledExecutorService;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.log4j.Logger;

import com.yanxin.iot.Utils.ConstantsUtil;
import com.yanxin.iot.mqtt.CmdLineParser;

/**
 * @author Cheng Guozhen
 * 
 */
public class MqttTimerListener implements ServletContextListener {
	private final Logger logger = Logger.getLogger("");
	private java.util.Timer timer = null;
	private ScheduledExecutorService scheduler = null;
	private String[] args = null;
	private CmdLineParser parser = null;
	private boolean bstart = false;
	/**
	 * 
	 */
	public MqttTimerListener() {
		
	}

	/* (non-Javadoc)
	 * @see javax.servlet.ServletContextListener#contextDestroyed(javax.servlet.ServletContextEvent)
	 */
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		// TODO Auto-generated method stub
		bstart = false;
	}

	/* (non-Javadoc)
	 * @see javax.servlet.ServletContextListener#contextInitialized(javax.servlet.ServletContextEvent)
	 */
	@Override
	public void contextInitialized(ServletContextEvent event) {
		
		/*event.getServletContext().log("时间矫正定时器开启！");
		try {
			if(!ConstantsUtil.bstart){
				parser = new CmdLineParser(args);
				
			    System.out.println("[MqttTimerListener]时间校准定时器开始....");
			    parser.startTimePublishController();
			    ConstantsUtil.bstart = true;
			}else {
				event.getServletContext().log("[MqttTimerListener]时间校准已启动！无需再次启动！");
			}
		} catch (Exception e) {
			event.getServletContext().log("出错了");
		}*/
	}

}
