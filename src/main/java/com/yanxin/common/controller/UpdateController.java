/**
 * 
 */
package com.yanxin.common.controller;

import com.jcbase.core.controller.JCBaseController;
import com.jcbase.core.util.JqGridModelUtils;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.common.model.Point;
import com.yanxin.common.model.UpdateApp;
import com.yanxin.mobile.update.bean.UpBase;

/**
 * @author Guozhen Cheng
 *
 */
public class UpdateController extends JCBaseController {
	/**
	 * 
	 */
	public void index(){
		render("update_index.jsp");
	}
	
	/**
	 * 升级请求的响应
	 */
	public void update(){
		UpBase<Record> upInfo = new UpBase<Record>();
		Record data = Db.findFirst("select * from update_app order by send_time desc");

		if(data != null){
			upInfo.setState(1);
			upInfo.setData(data);
		}else {
			upInfo.setState(0);
		}
		renderJson(upInfo);
	}
	
	public void getListData() {
		String keyword=this.getPara("name");
		String username=this.getPara("username");
		Page<UpdateApp> pageInfo=UpdateApp.dao.getUpdateAppPage(getPage(), this.getRows(),keyword,username,this.getOrderbyStr());
		
		this.renderJson(JqGridModelUtils.toJqGridView(pageInfo)); 
	}
}
