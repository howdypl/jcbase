package com.yanxin.common.model;

import com.jfinal.plugin.activerecord.Page;
import com.yanxin.common.model.base.BaseUpdateApp;

/**
 * Generated by JFinal.
 */
@SuppressWarnings("serial")
public class UpdateApp extends BaseUpdateApp<UpdateApp> {
	public static final UpdateApp dao = new UpdateApp().dao();
	
	
	
	public Page<UpdateApp> getUpdateAppPage(int page, int rows, String keyword, String username, String orderbyStr) {
		
		Page<UpdateApp> updatePage = dao.paginate(1, 10, false, "select * ", "from update_app order by send_time desc", 18);
		return updatePage;
	}
}
