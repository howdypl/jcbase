<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
  <!-- Standard Meta -->
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
<jsp:include page="/WEB-INF/view/common/basecss.jsp" flush="true" />
</head>

<body class="no-skin">
		<div class="main-container" id="main-container">
			<script type="text/javascript">
				try{ace.settings.check('main-container' , 'fixed')}catch(e){}
			</script>

			<div class="main-container-inner">
				<div class="main-content" style="margin-left: 0px;">
					<div class="page-content">
						
						<div class="row">
						<div class="col-xs-12">
							<!-- PAGE CONTENT BEGINS -->
								<!-- PAGE CONTENT BEGINS -->
							<form class="form-horizontal" id="validation-form" method="post">
											
												<input name="id" type="hidden" value="${id}"/>
												    <div hidden id="namealert" class="form-group alert alert-danger">
												   	    <strong>警告:</strong>不能为空！
													</div>
													<div class="form-group">
														<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="name">班组名称</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
													            <%-- <input type="text"  name="name" ${id ne null?'readonly':'' } value="${item.op_name}" class="col-xs-12 col-sm-6"> --%>
													            <input type="text"  name="name" value="${item.op_name}" class="col-xs-12 col-sm-6">
															</div>
														</div>
													</div>
													
													<div hidden id="typealert2" class="form-group alert alert-danger">
												    	<strong>警告:</strong>请选择一个工区！
													</div>
							      					<div hidden id="nooperationalert2" class="form-group alert alert-danger">
												   		 <strong>警告:</strong>没有可用的工区组，请先创建工区！
													</div>
													<div id="work_area_group" class="form-group">
													    <label class="control-label col-xs-12 col-sm-3 no-padding-right" for="email">所属工区</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
																<select name="work_area_id"  id="work_area_class" onchange="getWorkAreaSelect(this)" class="col-xs-12 col-sm-6">
																	<option value='0'>---请选择工区---</option>
																</select>
										                    </div>
														</div>
													</div>
							
													<div class="form-group">
														<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="email">班组地址</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
													            <input type="text" name="op_addr" value="${item.op_addr}" class="col-xs-12 col-sm-6">
															</div>
														</div>
													</div>
												
												    
												    
												   <!-- <div hidden id="typealert" class="form-group alert alert-danger">
												    	<strong>警告:</strong>请选择一个负责人！
													</div>
							      					<div hidden id="nooperationalert" class="form-group alert alert-danger">
												   		 <strong>警告:</strong>没有可选的负责人，请先创建用户！
													</div>
													<div class="form-group">
													    <label class="control-label col-xs-12 col-sm-3 no-padding-right" for="op_manager">负责人</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
																<select name="op_manager"  id="station_op_class" onchange="getOpClassSelect(this)" class="col-xs-12 col-sm-6">
																	<option value='0'>---请选择负责人---</option>
																</select>
										                    </div>
														</div>
													</div> --> 
							
												    
													<div class="form-group">
														<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="desc">描述</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
													            <input type="text"  name="op_desc" value="${item.op_desc}" class="col-xs-12 col-sm-6">
															</div>
														</div>
													</div>
<!-- 													<div class="form-group"> -->
<!-- 														<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="phone">手机号</label> -->
<!-- 														<div class="col-xs-12 col-sm-9"> -->
<!-- 															<div class="clearfix"> -->
<%-- 													            <input type="text"  name="phone" value="${item.phone}" class="col-xs-12 col-sm-6"> --%>
<!-- 															</div> -->
<!-- 														</div> -->
<!-- 													</div> -->
													
													
													<div class="clearfix form-actions" align="center">
														<div class="col-md-offset-3 col-md-9">
															<button id="submit-btn" class="btn btn-info" type="submit" data-last="Finish">
																<i class="ace-icon fa fa-check bigger-110"></i>
																提交
															</button>
															&nbsp; &nbsp; &nbsp;
															<button class="btn" type="reset">
												<i class="ace-icon fa fa-undo bigger-110"></i>
												重置
											</button>
														</div>
													</div>
												</form>
						</div><!-- /.col -->
					</div><!-- /.row -->
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
			</div><!-- /.main-container-inner -->
		</div><!-- /.main-container -->
		<jsp:include page="/WEB-INF/view/common/basejs.jsp" flush="true" />
	<script type="text/javascript">
	
	var parameter;
	var workareaid;
	var operationID;
	$(window).load(function(){
		 	parameter = "${item}";
		 	workareaid="${item.work_area_id}";
		 	operationID="${item.id}";
		 	
			getWorkArea();
			
	 });
	<%--  	    
	 function getOperationClass(){
			
		 var which = $('#station_op_class');
			
			$(which).empty();
			$(which).append("<option value='0'>---请选择负责人---</option>"); 
			
			$.ajax({
				    type: 'POST',
				    dataType: 'json',
				    url: "<%=request.getContextPath()%>"+"/sys/user/getUser",
				    success: function(data) {
						var result = data.result;
						var userList = data.userList;
						if(result){
						     $.each(userList, function(i,value){
						    	$(which).append("<option value='"+value.id+"'>"+value.name+"</option>"); 
						    });
						}else{
							showAlert('nooperationalert');			
						}
				    }
		        });

		}
	 function getOpClassSelect(which){
		    
		    var sindex = which.selectedIndex;
			if(sindex == 0){
				isSelect('typealert',which);
			   }
		} --%>
		
		 /** */
	 function getWorkArea(){
			
		var which = $('#work_area_class');
		
		$(which).empty();
		$(which).append("<option value='0'>---请选择工区---</option>"); 
		var name="${sessionScope.sysUser.name}";
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/workarea/getAllListData",
			    data:{"username":name},
			    success: function(data) {
					var result = data.result;
					var content = data.content;
					if(result){
						 var selec = 0;
						 var index = 1;
					     $.each(content, function(i,value){
					     	
					    	$(which).append("<option value='"+value.id+"'>"+value.area+"</option>"); 
					    	if(name!='admin'){ //非工区用户添加用户时自动选择其所在的工区
					     		which.get(0).selectedIndex = i+1;
					     	}
					    	if(parameter!=""){
								selec = workareaid;
								if(value.id == selec){
									index = i+1;
								}
							}
					    });
					    
					    if(index>0){
					    	which.get(0).selectedIndex=index;//index为索引值
					    	//$('#work_area_class').attr("disabled","disabled");
					    	// getOperationClass(selec);
					    }
					}else{
						showAlert('nooperationalert2');
						
					}
			    }
	        });

	}
	 function getWorkAreaSelect(which){
	    var sindex = which.selectedIndex;
	    $('div.alert-danger').hide(); 
		if(sindex == 0){
			isSelect('typealert2',which);
		}else{
			hiddleComp('typealert2',which);
		}
	}
	 function showAlert(comp){
			var selected = "#"+comp;
			console.log("selected="+selected);
			$(selected).show();
	}
		
			//判断下拉框为空
		function isSelect(comp,obj){
			var selected = "#"+comp;
			if(obj.selectedIndex == 0){
				$(selected).show();
			}
		}
		
		//获取焦点后，隐藏告警信息
		function hiddleComp(comp,obj){
			var selected = "#"+comp;
			$(selected).hide();
		}
			jQuery(function($) {
				
				var $validation = true;
				$('#validation-form').validate({
					errorElement: 'div',
					errorClass: 'help-block',
					focusInvalid: false,
					rules: {
						name:{
							required: true
						}
					},
					messages: {
						name:{
							required: "请输入班组名称"
						}
					},
					highlight: function (e) {
						$(e).closest('.form-group').removeClass('has-info').addClass('has-error');
					},
			
					success: function (e) {
						$(e).closest('.form-group').removeClass('has-error');//.addClass('has-info');
						$(e).remove();
					},
			
					errorPlacement: function (error, element) {
						if(element.is(':checkbox') || element.is(':radio')) {
							var controls = element.closest('div[class*="col-"]');
							if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
							else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
						}
						else if(element.is('.select2')) {
							error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
						}
						else if(element.is('.chosen-select')) {
							error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
						}
						else error.insertAfter(element.parent());
					},
			
					submitHandler: function (form) {
						var $form = $("#validation-form");
						var $btn = $("#submit-btn");
						if($btn.hasClass("disabled")) return;
						var postData=$("#validation-form").serializeJson();
			        	 $.post("${context_path}/opclass/saveNew" ,postData, 
			        				function(data){
			        				if(data.code==0){
			        					parent.reloadGrid(); //重新载入
			        					layer.msg('操作成功', {
			        					    icon: 1,
			        					    time: 2000 //2秒关闭（如果不配置，默认是3秒）
			        					},function(){
			        						var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			        						parent.layer.close(index); //再执行关闭 
			        					});
			        				}else {
			        					layer.msg(data.msg, {
			        					    icon: 2,
			        					    time: 2000 //2秒关闭（如果不配置，默认是3秒）
			        					});
			        				}
			        		 		$("#btn-submit").removeClass("disabled");
			        		},"json");
						return false;
					},
					invalidHandler: function (form) {
					}
				});
			
			});
			
			function closeView(){
				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.layer.close(index); //再执行关闭 
			}
			
		</script>
</body>

</html>
