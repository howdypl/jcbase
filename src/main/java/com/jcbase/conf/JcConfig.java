/**
 * Copyright (c) 2011-2016, Eason Pan(pylxyhome@vip.qq.com).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.jcbase.conf;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.druid.filter.stat.StatFilter;
import com.alibaba.druid.wall.WallFilter;
import com.jcbase.core.auth.interceptor.AuthorityInterceptor;
import com.jcbase.core.auth.interceptor.SysLogInterceptor;
import com.jcbase.core.handler.ResourceHandler;
import com.jcbase.core.util.IWebUtils;
import com.jcbase.model.SysUser;
import com.jcbase.model._MappingKit;
import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.core.Const;
import com.jfinal.ext.handler.ContextPathHandler;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.c3p0.C3p0Plugin;
import com.jfinal.plugin.druid.DruidPlugin;
import com.jfinal.plugin.druid.DruidStatViewHandler;
import com.jfinal.plugin.druid.IDruidStatViewAuth;
import com.jfinal.plugin.ehcache.EhCachePlugin;
import com.jfinal.render.ViewType;
import com.jfinal.template.Engine;
import com.yanxin.handler.WebSocketHandler;
import com.yanxin.iot.Utils.ConstantsUtil;
import com.yanxin.iot.mqtt.ConnectionTimeoutDetection;
import com.yanxin.websocket.TimePush;

/**
 * API引导式配置
 */
public class JcConfig extends JFinalConfig {
	private static final Logger log = LoggerFactory.getLogger(JcConfig.class);
	private static ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
	/**
	 * 配置常量
	 */
	public void configConstant(Constants me) {
		// 加载少量必要配置，随后可用PropKit.get(...)获取值
		PropKit.use("a_little_config.txt");
		me.setDevMode(PropKit.getBoolean("devMode", true));
		me.setViewType(ViewType.JSP);
		me.setError404View("/page/404.jsp");
		me.setError500View("/page/500.jsp");
//		me.setBaseUploadPath("upload/");
		me.setBaseUploadPath(PropKit.get("image_upload_temp_dir"));
		
		me.setMaxPostSize(10*Const.DEFAULT_MAX_POST_SIZE);
	}

	/**
	 * 配置路由
	 */
	public void configRoute(Routes me) {
		me.add(new AdminRoutes());
		me.add(new FrontRoutes());
		me.add(new ApiRoutes());
	}

	public static C3p0Plugin createC3p0Plugin() {
		return new C3p0Plugin(PropKit.get("jdbcUrl"), PropKit.get("user"),
				PropKit.get("password"));
	}

	public static DruidPlugin createDruidPlugin() {
		DruidPlugin dp = new DruidPlugin(PropKit.get("jdbcUrl"),PropKit.get("user"), PropKit.get("password"));
		dp.addFilter(new StatFilter());
		WallFilter wall = new WallFilter();
		wall.setDbType("mysql");
		dp.addFilter(wall);
		return dp;
	}

	/**
	 * 配置插件
	 */
	public void configPlugin(Plugins me) {
		DruidPlugin druidPlugin = createDruidPlugin();
		me.add(druidPlugin);

		// 配置ActiveRecord插件
		ActiveRecordPlugin arp = new ActiveRecordPlugin(druidPlugin);
		arp.setShowSql(PropKit.getBoolean("devMode", false));
		arp.setDevMode(PropKit.getBoolean("devMode", false));
		me.add(arp);
		me.add(new EhCachePlugin());
		// 所有配置在 MappingKit 中搞定
		_MappingKit.mapping(arp);
	}

	/**
	 * 配置全局拦截器
	 */
	public void configInterceptor(Interceptors me) {
		me.addGlobalActionInterceptor(new SysLogInterceptor());
		me.addGlobalActionInterceptor(new AuthorityInterceptor());
	}
	@Override
	public void configEngine(Engine arg0) {
		// TODO Auto-generated method stub
		
	}

	/**
	 * 配置处理器
	 */
	public void configHandler(Handlers me) {
		DruidStatViewHandler dvh =  new DruidStatViewHandler("/druid",new IDruidStatViewAuth(){
		    public boolean isPermitted(HttpServletRequest request) {
		        SysUser sysUser=IWebUtils.getCurrentSysUser(request);
		        return (sysUser != null && sysUser.getStr("name").equals("admin"));
		      }
		  });
		me.add(dvh);
		me.add(new ResourceHandler());
		me.add(new WebSocketHandler("^/websocket"));
		//添加上下文路径
		// me.add(new ContextPathHandler("inf"));
	}

	/* (non-Javadoc)
	 * @see com.jfinal.config.JFinalConfig#afterJFinalStart()
	 */
	@Override
	public void afterJFinalStart() {
		super.afterJFinalStart();
		
		log.info("采用同步sync mqttclient的心跳监测初始化...");
		ConstantsUtil.MqttHeartBit();
//		log.info("采用异步Async mqttclient的心跳监测初始化...");
//		ConstantsUtil.MqttHeartBitAsync();
		
		
		/**设备失联异常检测*/
		
       new Thread(new ConnectionTimeoutDetection()).start();
		
		log.info("========开启websocket推送===========");
		new Thread(new TimePush()).start();
		
		/*if(scheduler == null){
		log.info("========开启websocket推送===========");
		scheduler.scheduleAtFixedRate(new TimePush(), 0,30,TimeUnit.SECONDS);
		}*/
	}
}
