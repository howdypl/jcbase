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
package com.jcbase.model;

import java.util.Date;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;
import com.jcbase.core.model.Condition;
import com.jcbase.core.model.Operators;
import com.jcbase.core.view.InvokeResult;
import com.jcbase.model.base.BaseAppVersion;
import com.jfinal.kit.StrKit;

/**
 * Generated by JFinal.
 */
@SuppressWarnings("serial")
public class AppVersion extends BaseAppVersion<AppVersion> {
	public static final AppVersion dao = new AppVersion();
	public static final class OS {
		public static final String android = "android";
		public static final String ios = "ios";
	}

	public void setVisible(List<Integer> idsList, int status) {
		// TODO Auto-generated method stub
		Set<Condition> conditions=new HashSet<Condition>();
		conditions.add(new Condition("id",Operators.IN,idsList));
		Map<String,Object> newValues=Maps.newHashMap();
		newValues.put("status", status);
		this.update(conditions, newValues);
	}

	public InvokeResult setVisible(String ids, int status) {
		List<Integer> idsList=Lists.newArrayList();
		for(String idstr : ids.split(",")){
			if(StrKit.isBlank(idstr))continue;
			idsList.add(Integer.valueOf(idstr));
		}
		AppVersion.dao.setVisible(idsList,status==0?0:1);
		return InvokeResult.success();
	}

	public InvokeResult saveAppVersion(AppVersion appVersion) {
		if(appVersion.getInt("id")!=null){
			appVersion.update();
		}else{
			appVersion.save();
		}
		return InvokeResult.success();
	}
	public InvokeResult saveAppVersion(Integer id,String content,String linkUrl,Integer natureNo,String os,
			String url,String versionNo,Integer status,Integer isForce){
		if(id!=null){
			AppVersion appVersion=AppVersion.dao.findById(id);
			appVersion.set("content", content).set("link_url", linkUrl).set("nature_no", natureNo)
			.set("os", os).set("url", url).set("version_no", versionNo).set("status", status).set("is_force", isForce).update();
		}else{
			new AppVersion().set("content", content).set("link_url", linkUrl).set("nature_no", natureNo)
			.set("os", os).set("url", url).set("version_no", versionNo).set("status", status)
			.set("is_force", isForce).set("create_time", new Date()).save();
		}
		return InvokeResult.success();
	} 
	public AppVersion getNewsAppVersion(String os, String versionNo) {
		// TODO Auto-generated method stub
		AppVersion appVersion=this.getLastAppVersion(os, "miyue");
		if(appVersion!=null&&!appVersion.getStr("version_no").equals(versionNo)){
			return appVersion;
		}
		return null;
	}

	public AppVersion getLastAppVersion(String os, String appname) {
		// TODO Auto-generated method stub 
		Set<Condition> conditions=Sets.newHashSet();
		conditions.add(new Condition("os",Operators.EQ,os));
		conditions.add(new Condition("title",Operators.EQ,appname));
		conditions.add(new Condition("visible",Operators.EQ,1));
		LinkedHashMap<String, String> orderby=Maps.newLinkedHashMap();
		orderby.put("nature_no", "desc");
		List<AppVersion> list=AppVersion.dao.getList(1, 1, conditions, orderby);
		if(list.size()>0)return list.get(0);
		return null;
	}
}
