package com.jcbase.model;

import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.yanxin.common.model.Building;
import com.yanxin.common.model.OperationClass;
import com.yanxin.common.model.Point;
import com.yanxin.common.model.Sensor;
import com.yanxin.common.model.Station;

/**
 * Generated by JFinal, do not modify this file.
 * <pre>
 * Example:
 * public void configPlugin(Plugins me) {
 *     ActiveRecordPlugin arp = new ActiveRecordPlugin(...);
 *     _MappingKit.mapping(arp);
 *     me.add(arp);
 * }
 * </pre>
 */
public class _MappingKit {

	public static void mapping(ActiveRecordPlugin arp) {
		arp.addMapping("access_token", "uid", AccessToken.class);
		arp.addMapping("app_version", "id", AppVersion.class);
		arp.addMapping("dict_data", "id", DictData.class);
		arp.addMapping("dict_type", "id", DictType.class);
		arp.addMapping("sys_log", "id", SysLog.class);
		arp.addMapping("sys_login_record", "id", SysLoginRecord.class);
		arp.addMapping("sys_res", "id", SysRes.class);
		arp.addMapping("sys_role", "id", SysRole.class);
		arp.addMapping("sys_role_res", "id", SysRoleRes.class);
		arp.addMapping("sys_user", "id", SysUser.class);
		arp.addMapping("sys_user_role", "id", SysUserRole.class);
		arp.addMapping("operation_class", "id", OperationClass.class);
		arp.addMapping("station", "id", Station.class);
		arp.addMapping("building", "id", Building.class);
		arp.addMapping("platform_point", "id", Point.class);
		arp.addMapping("sensor", "id", Sensor.class);
	}
}

