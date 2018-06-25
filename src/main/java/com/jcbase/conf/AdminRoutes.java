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

import com.jcbase.controller.ImageController;
import com.jcbase.controller.IndexController;
import com.jcbase.controller.app.AppVersionController;
import com.jcbase.controller.sys.DictController;
import com.jcbase.controller.sys.LogController;
import com.jcbase.controller.sys.ResController;
import com.jcbase.controller.sys.RoleController;
import com.jcbase.controller.sys.UserController;
import com.jfinal.config.Routes;
import com.yanxin.common.controller.BuildingListController;
import com.yanxin.common.controller.GalleryController;
import com.yanxin.common.controller.GalleryQueryController;
import com.yanxin.common.controller.GetOperationController;
import com.yanxin.common.controller.ImageAllController;
import com.yanxin.common.controller.ImageDirectoryController;
import com.yanxin.common.controller.ImageSetController;
import com.yanxin.common.controller.LayerListController;
import com.yanxin.common.controller.LogoutController;
import com.yanxin.common.controller.OperationClassController;
import com.yanxin.common.controller.OpClassController;
import com.yanxin.common.controller.PlatformController;
import com.yanxin.common.controller.PlatformDefaultController;
import com.yanxin.common.controller.PointSetController;
import com.yanxin.common.controller.RealImageController;
import com.yanxin.common.controller.RoomListController;
import com.yanxin.common.controller.SensorListController;
import com.yanxin.common.controller.SensorTypeController;
import com.yanxin.common.controller.StationListController;
import com.yanxin.common.controller.TemperatureController;
import com.yanxin.common.controller.TimeSyncController;
import com.yanxin.common.controller.UserAddController;
import com.yanxin.common.controller.UserAdminController;
import com.yanxin.common.controller.VideoController;
import com.yanxin.common.controller.WarnController;
import com.yanxin.common.controller.WarnDetilController;
/**
 * 后台管理Routes配置
 * @author eason
 *
 */
public class AdminRoutes extends Routes{

	@Override
	public void config() {
		add("/", IndexController.class,"/WEB-INF/view");
		add("/sys/log", LogController.class,"/WEB-INF/view/sys");
		add("/sys/res", ResController.class,"/WEB-INF/view/sys");
		add("/sys/user", UserController.class,"/WEB-INF/view/sys");
		add("/sys/role", RoleController.class,"/WEB-INF/view/sys");
		add("/dict", DictController.class,"/WEB-INF/view/sys/dict");
		add("/app", AppVersionController.class,"/WEB-INF/view/app");
		add("/image", ImageController.class,"/WEB-INF/view/image");
		add("/gallery", GalleryController.class,"/WEB-INF/view/add");
		add("/galleryquery", GalleryQueryController.class, "/WEB-INF/view/add");	
		add("/temp", TemperatureController.class,"/WEB-INF/view/add");
		add("/video", VideoController.class,"/WEB-INF/view/add");		
		add("/platform", PlatformController.class,"/WEB-INF/view/add");
		add("/platformdefault", PlatformDefaultController.class,"/WEB-INF/view/add");		
		add("/realimage", RealImageController.class,"/WEB-INF/view/add");
		add("/imageset", ImageSetController.class,"/WEB-INF/view/add");
		add("/imagedirectory", ImageDirectoryController.class, "/WEB-INF/view/add");		
	    add("/logout", LogoutController.class,"/WEB-INF/view/add");		
		add("/userdata", UserAdminController.class,"/WEB-INF/view/add");		
		add("/useradd", UserAddController.class,"/WEB-INF/view/add");
		add("/getoperation", GetOperationController.class,"/WEB-INF/view/add");		
		add("/sensorlist", SensorListController.class,"/WEB-INF/view/add");
		add("/sensortype",SensorTypeController.class,"/WEB-INF/view/add");		
//		add("/opclass", OpClassController.class, "/WEB-INF/view/add");	
		add("/opclass", OperationClassController.class, "/WEB-INF/view/add");
		add("/station", StationListController.class,"/WEB-INF/view/add");
		add("/building",BuildingListController.class,"/WEB-INF/view/add");		
		add("/layer",LayerListController.class,"/WEB-INF/view/add");		
		add("/room",RoomListController.class,"/WEB-INF/view/add");		
		add("/time",TimeSyncController.class,"/WEB-INF/view/add");		
		add("/imageall",ImageAllController.class,"/WEB-INF/view/add");
		add("/setpoint",PointSetController.class,"/WEB-INF/view/add");
		add("/warn",WarnController.class,"/WEB-INF/view/add");
		add("/warndetil",WarnDetilController.class,"/WEB-INF/view/add");

	}

}
