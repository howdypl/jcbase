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
							<form class="form-horizontal" id="validation-form" method="post">
												<input name="id" type="hidden" value="${id}"/>
													
													<div class="form-group">
														<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="name">设备后端IP地址</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
													            <input type="text"  name="server_ip" value="" placeholder="例如：116.255.207.148" class="col-xs-12 col-sm-6" >
															</div>
														</div>
													</div>
													<!-- <div class="form-group">
														<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="name">审批人</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
													            <input type="text"  name="allow_user" value="" class="col-xs-12 col-sm-6">
															</div>
														</div>
													</div> -->
													
<%-- 													<c:if test="${id eq null }"> --%>
<!-- 													<div class="form-group"> -->
<!-- 														<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="password">密码</label> -->
<!-- 														<div class="col-xs-12 col-sm-9"> -->
<!-- 															<div class="clearfix"> -->
<!-- 													            <input type="text" name="password" class="col-xs-12 col-sm-6"> -->
<!-- 															</div> -->
<!-- 														</div> -->
<!-- 													</div> -->
<%-- 													</c:if> --%>
												   
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
	/* var parameter;
	var workareaid;
	var operationID;
	var station;
	var building;
	 $(window).load(function(){
		parameter = "${item}";
		workareaid="${item.work_area_id}";
		operationID="${item.op_id}";
		station = "${item.station_id}";
		building = "${item.building_id}";
	 }); */
	 

	 function showAlert(comp){
			var selected = "#"+comp;
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
				//判断IP地址合法性
				 // IP地址验证   
			    jQuery.validator.addMethod("ip", function(value, element) {    
			      return this.optional(element) || /^(([1-9]|([1-9]\d)|(1\d\d)|(2([0-4]\d|5[0-5])))\.)(([1-9]|([1-9]\d)|(1\d\d)|(2([0-4]\d|5[0-5])))\.){2}([1-9]|([1-9]\d)|(1\d\d)|(2([0-4]\d|5[0-5])))$/.test(value);    
			    }, "请填写正确的IP地址。");
							
				
				var $validation = true;
				$('#validation-form').validate({
					errorElement: 'div',
					errorClass: 'help-block',
					focusInvalid: false,
					rules: {
						server_ip:{
							required: true,
							ip:true
						}
					},
					messages: {
						server_ip:{
							required: "请输入设备后端服务IP地址"
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
							alert(controls.find(':checkbox,:radio').length);
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
			        	 $.post("${context_path}/sensorlist/setBatchIP" ,postData, 
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
