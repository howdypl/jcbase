package com.yanxin.common.controller;

import java.util.ArrayList;
import java.util.List;

import com.jcbase.core.controller.JCBaseController;
import com.jcbase.core.util.JqGridModelUtils;
import com.jcbase.core.view.InvokeResult;
import com.jcbase.model.SysUser;
import com.jcbase.model.SysUserRole;
import com.jfinal.plugin.activerecord.Page;
import com.yanxin.common.model.WorkArea;

/**
 * @author Cheng Guozhen
 * 
 */
public class WorkAreaController extends JCBaseController {
	
	public void index(){
		render("workarealist_index.jsp");
	}
	public void getListData() {
		String keyword=this.getPara("name");
		Page<WorkArea> pageInfo=WorkArea.me.getWorkAreaPage(getPage(), this.getRows(),keyword,this.getOrderbyStr());
		//System.out.println("第几页：："+getPage()+"*************************");
		this.renderJson(JqGridModelUtils.toJqGridView(pageInfo)); 
	}
	
	public void getMyArea() {
		String keyword=this.getPara("username");
		if(keyword==null){
			setAttr("result", false);
			setAttr("content", "-");
			this.renderJson();
			return;
		}else {
			SysUser user = SysUser.me.getByName(keyword);
			if(user!=null){
				if(user.getUserType()==0){
					setAttr("result", true);
					setAttr("content", "超级管理员");
				}else{
					WorkArea wa = WorkArea.me.findById(user.getWork_area_id());
					setAttr("result", true);
					setAttr("content", wa.getArea());
				}
			}
		}
		this.renderJson();
	}
	
	public void add() {
		Integer id=this.getParaToInt("id");
		if(id!=null){
			this.setAttr("item", WorkArea.me.findById(id));
		}
		this.setAttr("id", id);
		render("workarealist_add.jsp");
	}
	public void save(){
		String area=this.getPara("name");
		String wa_desc=this.getPara("wa_desc");
		String wa_addr=this.getPara("wa_addr");
		Integer id=this.getParaToInt("id");
		//Integer op_manager=this.getParaToInt("op_manager");
		InvokeResult result=WorkArea.me.save(id, area,wa_desc,wa_addr);
		this.renderJson(result); 
	}
	
	public void deleteData(){
		Integer id=this.getParaToInt("id");
		InvokeResult invokeResult=WorkArea.me.deleteData(id);
		this.renderJson(invokeResult);
	}
	/**
	 * chengguozhen
	 */
	public void getAllListData() {
		List<WorkArea> resultList = new ArrayList<WorkArea>();
		
		String username=this.getPara("username");
		// System.out.println(SysUserRole.dao.userOP(username)+"********************");
		// int op = SysUserRole.dao.userOP(username); // 默认不是管理员
		SysUser user = SysUser.me.getByName(username);
		if(user.getUserType().intValue() == 0){
			resultList = WorkArea.me.getAllList();
		}else if(user.getUserType().intValue()>0){
			resultList = WorkArea.me.getWorkAreaByUser(username,user.getUserType().intValue());
		}
		
		if(!resultList.isEmpty()){
			setAttr("result", true);
			
			setAttr("content", resultList);
			setAttr("mysize", resultList.size());
		}else{
			setAttr("result", false);
			setAttr("mysize", 0);
		}
		setAttr("op", user.getUserType().intValue()+1);
		renderJson();
	}
	
}
