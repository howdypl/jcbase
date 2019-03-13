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
<link rel="stylesheet" href="${res_url}js/om-fileupload.css" />
<script src="${res_url}ace-1.3.3/assets/js/jquery.js" ></script>
<script src="${res_url}ace-1.3.3/assets/js/ace-extra.js"></script>
<link rel="stylesheet" type="text/css" href="${res_url}uploadify/uploadifive.css">
<script src="${res_url}uploadify/jquery.uploadifive.min.js" type="text/javascript"></script>
  <style type="text/css">
  	.uploadify-button{
  		background-color: white;
  	}
  	.uploadify:hover .uploadify-button{
		background-color: white;
  	}
  </style>
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
							<div class="widget-box">
								
								<div class="widget-body">
									<div class="widget-main">
										<!-- #section:plugins/fuelux.wizard.container -->
										<div class="step-content pos-rel" id="step-container">
											<div class="step-pane active" id="step1">
											<form class="form-horizontal" id="validation-form" method="post">
												<input name="id" type="hidden" value="${id}"/>
													<div class="form-group">
														<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="name">预设点名称</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
													            <input type="text" id="name"  name="name" value="${item.platform_code}" class="col-xs-12 col-sm-6">
															</div>
														</div>
													</div>
													<div class="form-group">
														<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="warn_temp">设定温度</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
													            <input type="text" id="warn_temp" name="warn_temp" value="${item.warn_temp}" class="col-xs-12 col-sm-6">
															</div>
														</div>
													</div>
												    
													<div class="form-group">
														<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="file_upload">图片:</label>

														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
																<div class="cover-area" style="border: 1px solid #e0e0e0;width: 80%;border-radius:5px;padding: 5px 0 0 5px;">
																	<div class="cover-hd">
																		<input id="file_upload" name="file_upload" type="file" /> 
																		
																		<input id="url" class="cover-input" value="${item.url}" name="url" type="hidden" />
																	</div>
																	<p id="upload-tip" class="upload-tip"></p>
																	<p id="apkArea" class="cover-bd" style="display: ${action eq 'add'?'none':''}">
																		<a class="vb cover-del" href="#" style="width: 600px;">${item.url}</a>
																	</p>
																	
																</div>
															</div>
														</div>
													</div>
													
													
													
<!-- 													<div class="form-group"> -->
<!-- 														<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="phone">变电站地址</label> -->
<!-- 														<div class="col-xs-12 col-sm-9"> -->
<!-- 															<div class="clearfix"> -->
<%-- 													            <input type="text"  name="station_addr" value="${item.station_addr}" class="col-xs-12 col-sm-6"> --%>
<!-- 															</div> -->
<!-- 														</div> -->
<!-- 													</div> -->
						
													
													<div class="clearfix form-actions" align="center">
														<div class="col-md-offset-3 col-md-9">
															<input id="submit-btn" class="btn btn-info" type="submit" data-last="Finish" value="提交">
															&nbsp; &nbsp; &nbsp;
															<button class="btn" type="reset">
																重置
															</button>
														</div>
												</div>
											</form>
										</div>
									</div>
								</div><!-- /.widget-main -->
							</div><!-- /.widget-body -->
						</div>
		
						</div><!-- /.col -->
					</div><!-- /.row -->
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
			</div><!-- /.main-container-inner -->
		</div><!-- /.main-container -->
		<jsp:include page="/WEB-INF/view/common/basejs.jsp" flush="true" />
		<%-- <script src="${res_url}js/jquery.form.min.js"></script> --%>
	<script type="text/javascript">
		$(document).ready(function () {
			$('#file_upload').uploadifive({
				//校验数据
				'uploadScript' : '${context_path}/setpoint/uploadImage', //指定服务器端上传处理文件，默认‘upload.php’
				'auto' : true, //手动上传
				'buttonImage' : '${res_url}uploadify/uploadify-upload.png', //浏览按钮背景图片
				'width' : 110,
				'height' : 30,
				'cancelImg' : 'uploadify/uploadify-cancel.png',
				'buttonText' : '选 择图片',
				'multi' : false, //单文件上传
				'fileTypeExts' : '*.jpg', //允许上传的文件后缀
				'fileSizeLimit' : '10MB', //上传文件的大小限制，单位为B, KB, MB, 或 GB
				'successTimeout' : 60, //成功等待时间
				'onUploadComplete' : function(file, data, response) { //每成功完成一次文件上传时触发一次
					data = eval("[" + data + "]")[0];
					$("#apkArea").show().find(".cover-del").html(data.fileUrl);
					$("#url").val(data.fileUrl);
					$("#linkUrl").val(data.staticUrl);
				},
				'onUploadError' : function(file, data, response) { //当上传返回错误时触发
					$('#f_pics').append("<div class=\"pics_con\">" + data + "</div>");
				},
				'onCancel': function() {
				       $("#url").val("");
				      /* 注意：取消后应重新设置uploadLimit */
				      /* $data	= $(this).data('uploadifive'),
				      settings = $data.settings;
				      settings.uploadLimit++; */
				      alert(file.name + " 已取消上传~!");
			    },
			    'onFallback' : function() {
			      alert("该浏览器无法使用!");
			    },
			    'onUpload' : function(file) {
			      //document.getElementById("submit-btn").disabled = true;//当开始上传文件，要防止上传未完成而表单被提交
			    },
			});
	
			var $validation = true;
	
			$('#validation-form').validate({
				errorElement : 'div',
				errorClass : 'help-block',
				focusInvalid : false,
				//title versionNo url natureNo  contents
				rules : {
					name : {
						required : true
					}
				},
				messages : {
					name : {
						required : "预设点名不能为空"
					}
				},
				highlight : function(e) {
					$(e).closest('.form-group').removeClass('has-info').addClass('has-error');
				},
	
				success : function(e) {
					$(e).closest('.form-group').removeClass('has-error'); //.addClass('has-info');
					$(e).remove();
				},
	
				errorPlacement : function(error, element) {
					if (element.is(':checkbox') || element.is(':radio')) {
						var controls = element.closest('div[class*="col-"]');
						if (controls.find(':checkbox,:radio').length > 1) controls.append(error);
						else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
					} else if (element.is('.select2')) {
						error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
					} else if (element.is('.chosen-select')) {
						error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
					}
					else error.insertAfter(element.parent());
				},
	
				submitHandler : function(form) {
					var $form = $("#validation-form");
					var $btn = $("#submit-btn");
	
					if ($btn.hasClass("disabled")) return;
					//$('#file_upload').uploadify();
					var submitData = {
						id : "${item.id}",
						content : $("#content").val(),
						linkUrl : $("#linkUrl").val(),
						natureNo : $("#natureNo").val(),
						os : $("#os").val(),
						url : $("#url").val(),
						versionNo : $("#versionNo").val(),
						status : $("#status").val(),
						isForce : $("#isForce").val()
					};
					$btn.addClass("disabled");
					$.post('${context_path}/setpoint/saveInf', $form.serialize(), function(data) {
						$btn.removeClass("disabled");
						if (data.code == 0) {
							window.parent.reloadGrid(); //重新载入
							layer.msg("保存成功", {
								icon : 1,
								time : 2000 //2秒关闭（如果不配置，默认是3秒）
							}, function() {
								var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
								parent.layer.close(index); //再执行关闭 
							});
						} else {
							layer.msg(data.msg, {
								icon : 2,
								time : 2000 //2秒关闭（如果不配置，默认是3秒）
							}, function() {});
						}
					}, "json");
					return false;
				},
				invalidHandler : function(form) {}
			});
	
		});
	
	
	
 	 /* $(document).ready(function () {
	    $("#submit-btn").click(function () {
	        var name = $('#name').val();
	        // console.log("form="+$('#form').serialize());
	        // var form = $('#form');  
			var formdata = new FormData($('#form'));
			
	        if(name==''){
	            alert("请输入预设点名称");
	        }else{
	        	formdata.append("name",$('#name').val());
				formdata.append("warn_temp",$('#warn_temp').val());
				formdata.append("images",$('#images')[0]); 
	           $.ajax({
	           	type : "POST", 
			    url : "${context_path}/setpoint/save",
			    dataType:"JSON",
				cache:false, 
			    async: false,
			    contentType:false,
			    processData:false,
			    data : formdata,
			    success : function(data) {
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
			      
			    },  
			  });  
	        }
	        
	    });
	 });  */


 	 /* $(document).ready(function () {
	    $("#submit-btn").click(function () {
	        var name = $('#name').val();
	        // console.log("form="+$('#form').serialize());
	        var form = $('#form');  
			var formdata = new FormData(form);  
	        if(name==''){
	            alert("请输入预设点名称");
	        }else{
	           $("#form").ajaxForm({  
			    url : "${context_path}/setpoint/save",  
			    dataType : 'json',  
			    data : $('#form').serialize(),  
			    success : function(data) { 
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
			      
			    },  
			  });  
	        }
	        
	    });
	    
	 });  */
	<%--  $(window).load(function(){
		 
			getOperationClass();
			
	    });
	 
	 function getOperationClass(){
			
			var which = $('#station_op_class');
			$(which).empty();
			$(which).append("<option value='0'>---请选择班组---</option>"); 
			$.ajax({
				    type: 'POST',
				    dataType: 'json',
				    url: "<%=request.getContextPath()%>"+"/getoperation/getOpAll",
				    success: function(data) {
						var result = data.oplist;
						if(result){
							 
						     $.each(result, function(i,value){
						    
						    	$(which).append("<option value='"+value.id+"'>"+value.op_name+"</option>"); 
						    });
						}else{
							showAlert('nooperationalert');
						}
				    }
		        });

		}
		
	 function getOpClassSelect(which){
	        
		    var sindex = which.selectedIndex;
		    
		    hiddleComp('nostationalert',which);
			if(sindex == 0){
				isSelect('typealert',which);
				$('#add_station_div').hide();
				$('#add_building_div').hide();
				$('#add_sensor_div').hide();
				
			}else{
				// hiddleComp('typealert',which);
				$('#add_station_div').show();
				$('#add_building_div').hide();
				$('#add_sensor_div').hide();
				getStation(which.value);
			}
		}
		
		function getStation(op){
			var which = $('#add_station');
			var opclass = op;
			hiddleComp('nostationalert',which);
			$(which).empty();
			$(which).append("<option  value='0'>---请选择变电站---</option>");
			$.ajax({
				    type: 'POST',
				    dataType: 'json',
				    url: "<%=request.getContextPath()%>"+"/building/getStation",
				    data:{"opclass":opclass},
				    success: function(data) {
						var result = data.stationRecords;
						if(result){
								
						     $.each(result, function(i,value){
				
						    	$(which).append("<option value='"+value.id+"'>"+value.station_name+"</option>"); 
						    });
						}else{
							showAlert('nostationalert');
							$('#add_station_div').hide();
						}
				    }
		        });
		        
		        
		}
		
		function stationSelect(which){
			var sindex = which.selectedIndex;
			
			if(sindex == 0){
				$('#add_building_div').hide();
				$('#add_sensor_div').hide();
			}else{
				$('#add_building_div').show();
				$('#add_sensor_div').hide();
				getBuilding(which.value);
			}
		}
		

		function getBuilding(op){
		
			hiddleComp('nobuildingalert');
			
			var which = $('#add_building');
			
			var para = op;
			$(which).empty();
			$(which).append("<option  value='0'>---请选择设备间---</option>");
			
			$.ajax({
				    type: 'POST',
				    dataType: 'json',
				    url: "<%=request.getContextPath()%>"+"/building/getBuilding",
				    data:{"station":para},
				    success: function(data) {
						var result = data.buildingRecords;
						if(result){					
						     $.each(result, function(i,value){
						    	$(which).append("<option value='"+value.id+"'>"+value.building_name+"</option>"); 
						    });
						}else{
							showAlert('nobuildingalert');
							$('#add_building_div').hide();
						}
				    }
		        });
		}
	function bulidingSelect(which){
			var sindex = which.selectedIndex;
			
			if(sindex == 0){
				$('#add_sensor_div').hide();
			}else{
				$('#add_sensor_div').show();
				getSensorClass(which.value);
			}
		}
	 
	 function getSensorClass(s){
			var buliding=s;
			alert(s);
			var which = $('#seneor_id');
			$(which).empty();
			$(which).append("<option value='0'>---请选择监控器---</option>"); 
			$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/sensorlist/getSensorCodeById",
			    data:{"buliding":buliding},
			    success: function(data) {
			    	var notEmpty = data.result;
					var result = data.records;
					
					if(notEmpty){
					     $.each(result, function(i,value){
					    	$('#seneor_id').append("<option value='"+value.sensor_code+"'>"+value.name+"</option>"); 
					    });
					}else{
						showAlert('nosensoralert');
					}
			    }
	        });
		}	
		function sensorSelect(which){
	        
		    var sindex = which.selectedIndex;
			if(sindex == 0){
				isSelect('typealert',which);
				$('#add_point_type_div').hide();
			}else{
				hiddleComp('typealert',which);
				$('#add_point_type_div').show();
				getPointType(which.value);
			}
		}
		
		function getPointType(s){
			var sensor = s;
			var which = $('#add_point_type');
			hiddleComp('nostationalert',which);
			$(which).empty();
			$(which).append("<option  value='0'>---请选择预设点类型---</option>");
			$.ajax({
				    type: 'POST',
				    dataType: 'json',
				    url: "<%=request.getContextPath()%>"+"/setpoint/getPointType",
				    data:{"sensor":sensor},
				    success: function(data) {
						var result = data.stationRecords;
						var notEmpty = data.notempty;
						if(result){
							
						     $.each(result, function(i,value){
						     
						    	$(which).append("<option value='"+value.id+"'>"+value.point_type+"</option>"); 
						    });
						}else{
							//showAlert('nostationalert');
						}
				    }
		        });	        
		}
		function managerSelect(which){
	        
		    var sindex = which.selectedIndex;
			if(sindex == 0){
				isSelect('typealert',which);
			}else{
				hiddleComp('typealert',which);
			}
		}
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
		} --%>
		/* 
		$(function(){  
			  $("#form").ajaxForm({  
			    url : "${context_path}/setpoint/save",  
			    dataType : 'json',  
			    data : $('#form').serialize(),  
			    success : function(data) {  
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
			      
			    },  
			  });  
			});  
			 */
		function closeView() {
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.layer.close(index); //再执行关闭 
		}
		//上传开始
		$('#upload').on('click', function() {
			console.log("uploadify调用");
		        $('#file_upload').uploadify('upload', '*');
		    })
		    //取消上传
		    $('#cancel').on('click', function () {
		        $('#file_upload').uploadify('cancel', '*');
		    })
			
		</script>
</body>

</html>
