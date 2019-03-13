/**
 * 
 */
package com.yanxin.iot.mqtt;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.concurrent.ConcurrentHashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Observable;
import java.util.Observer;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jfinal.plugin.activerecord.Db;
import com.yanxin.common.model.Sensor;
import com.yanxin.iot.Utils.ConstantsUtil;
/*import com.yanxin.iot.mariadb.beans2.Alert;
import com.yanxin.iot.mariadb.dbop.DBop2;
import com.yanxin.scan.utils.Constants;
import com.yanxin.scan.utils.SensorStatus;
import com.yanxin.scan.utils.Utils;*/

/**
 * @author GuozhenCheng
 *
 */
public class ConnectionTimeoutDetection implements Runnable {
	
	private static final Logger log = LoggerFactory.getLogger(ConnectionTimeoutDetection.class);
	
	List<Sensor> sensors = new ArrayList<Sensor>();
	//ConcurrentHashMap<Sensor, ScheduledExecutorService> detector = new ConcurrentHashMap<Sensor,ScheduledExecutorService>();
	ConcurrentHashMap<Sensor, FutureTask> detector = new ConcurrentHashMap<Sensor,FutureTask>();
	ScheduledThreadPoolExecutor scheduled = new ScheduledThreadPoolExecutor(5);
	/* (non-Javadoc)
	 * @see java.lang.Runnable#run()
	 */
	@Override
	public void run() {
		while(true){
			Sensor sf = Sensor.me;
			// sensors = Db.find("select * from sensor")
			sensors = Sensor.me.find("select * from sensor");
			// log.info("查询库里总设备数：+"+sensors.size());
			if(sensors == null || sensors.isEmpty()){
				if(!detector.isEmpty()){
					Iterator it = detector.keySet().iterator();
		            while (it.hasNext()) {
		            	Sensor sensor = (Sensor)it.next();
		            
		            	detector.get(sensor).getFuture().cancel(true); // 取消定时任务
	            		detector.remove(sensor);
	            		// DBop2.setSensorPushTag(sensor.getSensorCode(),"",Constants.NONE_ALERT_TAG);
	            		//log.info("关闭该设备的失联检测定时器1："+sensor.getSensorCode());
		            }
				} 
			}else {
				for (Sensor ss : sensors) {
					if (!detector.containsKey(ss)) {
						log.debug("添加该设备的失联检测器："+ss.getSensorCode());
						//ScheduledExecutorService scheduler = Executors.newSingleThreadScheduledExecutor();
						ConnectionTimeoutTask task = new ConnectionTimeoutTask(ss);
						
						//Future f = scheduler.scheduleAtFixedRate(task,0,3,TimeUnit.MINUTES);
						Future f = scheduled.scheduleAtFixedRate(task, 0,3,TimeUnit.MINUTES);
						FutureTask ft = new FutureTask(f,task);
						detector.put(ss, ft);
					}// end of if(!detector.containsKey(ss))
					
				} // end of for(Sensor ss :sensors)
				
				if (!detector.isEmpty()) {
					Iterator it = detector.keySet().iterator();
					while (it.hasNext()) {
						Sensor sensor = (Sensor) it.next();
						if (!sensors.contains(sensor)) {
							log.debug("关闭该设备的失联检测定时器2：" + sensor.getSensorCode());
							detector.get(sensor).getFuture().cancel(true); // 取消定时任务
		            		
							detector.remove(sensor);
							// DBop2.setSensorPushTag(sensor.getSensorCode(),"",Constants.NONE_ALERT_TAG);
						}
					}
				} // end of if(!detector.isEmpty())
			}
			try {
				Thread.sleep(180000); // 5分钟判断是否有新设备上线
				//Thread.sleep(600000);
			} catch (InterruptedException e1) {
				e1.printStackTrace();
			}
		} // end of while(true)
	} // end of run()
	
	/**
	 * 
	 * @author Guozhen Cheng
	 *
	 */
	class ConnectionTimeoutTask implements Runnable,Observer{

		private Sensor ss;
		private Connection connection;
		public ConnectionTimeoutTask(Sensor ss) {
			this.ss = ss;
			this.connection = new Connection(ss.getCreateTime().getTime());
			
		}

		@Override
		public void run() {
			try {
				log.debug("设备失联定期巡检...");
				long now = System.currentTimeMillis();
				Sensor sensorWithTag = Sensor.me.findFirst("select * from sensor where sensor_code=?",ss.getSensorCode());
				if(sensorWithTag == null){
					return;
				}
				this.connection.setLastTime(ss.getCreateTime().getTime());
				if((now - connection.getLastTime()) > ConstantsUtil.CONNECTION_TIMEOUT){
					Sensor.me.update(ss.getSensorCode(), 0, null, 0,now);
					log.debug("更新设备状态为下线 ："+ss.getSensorCode());
					/*Alert alert = new Alert();
					alert.setAlertObjCode(ss.getSensorCode());
					alert.setCreateTime(Utils.dateToTime(new Date()));
					String alertTime = new SimpleDateFormat().format(new Date());
					// 用于推送通知
					PushMessage msgMessage = DBop2.getStationFromSensor(ss.getSensorCode());
					// 用于短信通知
					PushMessage msgMessage2 = DBop2.getShortWordInfo(ss.getSensorCode());
					alert.setTypeId(ConstantsUtil.ALERT_TYPE_DEVICE_ANORMAL);
					alert.setSubTypeId(ConstantsUtil.ALERT_SUBTYPE_DEIVCE_ANORMAL); // 设备异常操作
					alert.setStatus(1);
					alert.setEquipStatus(SensorStatus.Open.getCode());
					alert.setSms(1);
					alert.setCurrent(sensorWithTag.getCurrent()); // 设置告警电量
					//sensorWithTag.setRegister(1);
					sensorWithTag.setStatus(2);// 状态失联
					HuaweiSends.sendPushMessage(msgMessage.getYwb(), msgMessage.getStationId(),
							"设备异常", msgMessage.getStationName(), msgMessage.getSensorName(),
							alertTime);
					System.out.println(
							"++++++++++++++++++++++++++++++2设备异常推送成功。" + alert.getAlertObjCode());
					String alertMsg = "";
					if (msgMessage2 != null && msgMessage2.getPersons().size() > 0) {
						String phone = "";
						for (RespPersion p : msgMessage2.getPersons()) {
							phone += p.getRespsPersonPhone() + ",";
						}
						SMSPush.send(alertTime, msgMessage2.getStationName(),
								msgMessage2.getSensorName(), "设备失联", phone);
						alert.setSms(2);
						alertMsg = alertTime + msgMessage2.getStationName()
								+ msgMessage2.getSensorName() + "设备异常"
								+ "，请立即处理。";
						alert.setSmsContent(alertMsg);
						System.out.println(
								"++++++++++++++++++++++++++++++短信发出。" + alert.getAlertObjCode());
					}
					sensorWithTag.setSmsTag(Constants.OPEN_TIMEOUT_ALERTED_TAG);
					sensorWithTag.setSms(alertMsg);
					
					DBop2.updateSensor(sensorWithTag);
					DBop2.insertAlert(alert);*/
				}
				this.ss = sensorWithTag;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		@Override
		public void update(Observable o, Object arg) {
			/*Sensor s = ((MqttClientController)o).getSensor();
			if(s != null){
				if(s.getSensorCode().equals(this.ss.getSensorCode())){
					
					this.connection.setLastTime(s.getCreateTime().getTime());
				}
			}*/
		}
	}
	
	
	public class Connection {
	    private long lastTime;
	    
	    public Connection(long lastTime) {
			this.lastTime = lastTime;
		}

		public void refresh() {
	        lastTime = System.currentTimeMillis();
	    }

	    public long getLastTime() {
	        return lastTime;
	    }

		/**
		 * @param lastTime the lastTime to set
		 */
		public void setLastTime(long lastTime) {
			this.lastTime = lastTime;
		}
	    
	    
	}
	public class FutureTask{
		private Future future;
		private ConnectionTimeoutTask task;
		/**
		 * @param future
		 * @param task
		 */
		public FutureTask(Future future, ConnectionTimeoutTask task) {
			this.future = future;
			this.task = task;
		}
		/**
		 * @return the future
		 */
		public Future getFuture() {
			return future;
		}
		/**
		 * @param future the future to set
		 */
		public void setFuture(Future future) {
			this.future = future;
		}
		/**
		 * @return the task
		 */
		public ConnectionTimeoutTask getTask() {
			return task;
		}
		/**
		 * @param task the task to set
		 */
		public void setTask(ConnectionTimeoutTask task) {
			this.task = task;
		}

	}
	
}
