/**
 * 
 */
package com.yanxin.common.controller;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.jcbase.core.auth.anno.RequiresPermissions;
import com.jcbase.core.controller.JCBaseController;
import com.jcbase.core.model.Condition;
import com.jcbase.core.model.Operators;
import com.jcbase.core.util.CommonUtils;
import com.jcbase.core.util.JqGridModelUtils;
import com.jcbase.core.view.InvokeResult;
import com.jcbase.model.DictData;
import com.jcbase.model.SysRole;
import com.jcbase.model.SysUser;
import com.jcbase.model.SysUserRole;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.common.model.OperationClass;

/**
 * @author Cheng Guozhen
 * 
 */
public class OperationClassController extends JCBaseController {
	
	public void index(){
		render("opclasslist_index.jsp");
	}
	public void getListData() {
		String keyword=this.getPara("name");
		Page<OperationClass> pageInfo=OperationClass.me.getOperationClassPage(getPage(), this.getRows(),keyword,this.getOrderbyStr());
		System.out.println("第几页：："+getPage()+"*************************");
		this.renderJson(JqGridModelUtils.toJqGridView(pageInfo)); 
	}
	public void getListDataNew() {
		
		String userName=this.getPara("username");
		int workArea = this.getParaToInt("workarea");
		
		Page<OperationClass> pageInfo=OperationClass.me.getOperationClassPageNew(getPage(), this.getRows(),
				userName,workArea,this.getOrderbyStr());
		System.out.println("第几页：："+getPage()+"*************************");
		this.renderJson(JqGridModelUtils.toJqGridView(pageInfo)); 
	}
	
	
//	public void getListData() {
//		String name=this.getPara("name");
//		Set<Condition> conditions=new HashSet<Condition>();
//		if(CommonUtils.isNotEmpty(name)){
//			conditions.add(new Condition("op_name",Operators.LIKE,name));
//		}
//		Page<OperationClass> pageInfo=OperationClass.me.getPage(this.getPage(), this.getRows(),conditions,this.getOrderby());
//		this.renderJson(OperationClass.me.toJqGridView(pageInfo)); 
//	}

	public void add() {
		Integer id=this.getParaToInt("id");
		if(id!=null){
			this.setAttr("item", OperationClass.me.findById(id));
		}
		this.setAttr("id", id);
		render("opclasslist_add.jsp");
	}
	public void save(){
		String op_name=this.getPara("name");
		String op_desc=this.getPara("op_desc");
		String op_addr=this.getPara("op_addr");
		Integer id=this.getParaToInt("id");
		//Integer op_manager=this.getParaToInt("op_manager");
		InvokeResult result=OperationClass.me.save(id, op_name,op_desc,op_addr);
		this.renderJson(result); 
	}
	public void saveNew(){
		String op_name=this.getPara("name");
		String op_desc=this.getPara("op_desc");
		String op_addr=this.getPara("op_addr");
		Integer id=this.getParaToInt("id");
		Integer workAreaId = this.getParaToInt("work_area_id");
		//Integer op_manager=this.getParaToInt("op_manager");
		InvokeResult result=OperationClass.me.saveNew(id, op_name,workAreaId,op_desc,op_addr);
		this.renderJson(result); 
	}
	
	public void deleteData(){
		Integer id=this.getParaToInt("id");
		InvokeResult invokeResult=OperationClass.me.deleteData(id);
		this.renderJson(invokeResult);
	}

}
