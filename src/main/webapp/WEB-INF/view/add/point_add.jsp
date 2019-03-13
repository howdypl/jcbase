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
							<form class="form-horizontal" id="form" enctype="multipart/form-data" method="post">
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
													            <input type="text" name="warn_temp" value="${item.warn_temp}" class="col-xs-12 col-sm-6">
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
												    <div hidden id="typealert" class="form-group alert alert-danger">
												    	<strong>警告:</strong>请选择一个运维组！
													</div>
							      					<div hidden id="nooperationalert" class="form-group alert alert-danger">
												   		 <strong>警告:</strong>没有可用的运维组，请先创建运维组！
													</div>
													<div class="form-group">
													    <label class="control-label col-xs-12 col-sm-3 no-padding-right" for="email">所属班组</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
																<select name="op_id"  id="station_op_class" onchange="getOpClassSelect(this)" class="col-xs-12 col-sm-6">
																	<option value='0'>---请选择班组---</option>
																</select>
										                    </div>
														</div>
													</div>
												    <div hidden id="nostationalert" class="form-group alert alert-danger">
												   		 <strong>警告:</strong>该运维组无变电站！
													</div>
													<div hidden class="form-group" id="add_station_div">
													    <label class="control-label col-xs-12 col-sm-3 no-padding-right" for="station_manager">所属变电站</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
																<select name="station_id"  id="add_station" onclick="stationSelect(this)" class="col-xs-12 col-sm-6">
																	<option value='0'>---请选择变电站---</option>
																</select>
										                    </div>
														</div>
													</div>
												    
<!-- 													<div class="form-group"> -->
<!-- 														<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="des">变电站介绍</label> -->
<!-- 														<div class="col-xs-12 col-sm-9"> -->
<!-- 															<div class="clearfix"> -->
<%-- 													            <input type="text"  name="station_desc" value="${item.station_desc}" class="col-xs-12 col-sm-6"> --%>
<!-- 															</div> -->
<!-- 														</div> -->
<!-- 													</div> -->
                                                    <div hidden id="nobuildingalert" class="form-group alert alert-danger">
												   		 <strong>警告:</strong>没有设备间信息，请先创建设备间！
													</div>
													<div hidden class="form-group" id="add_building_div">
														<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="phone">所属设备间</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
													           <select name="building_id" id="add_building" onclick="bulidingSelect(this)" class="col-xs-12 col-sm-6">
									                        		<option  value='0'>---请选择设备间---</option>
									                       		</select>
															</div>
														</div>
													</div>
												    
												    <div hidden id="typealert" class="form-group alert alert-danger">
												    	<strong>警告:</strong>请选择一个监控器！
													</div>
							      					<div hidden id="nooperationalert" class="form-group alert alert-danger">
												   		 <strong>警告:</strong>没有可用的监控器，请先添加监控器！
													</div>
													<div hidden class="form-group" id="add_sensor_div">
													    <label class="control-label col-xs-12 col-sm-3 no-padding-right" for="email">所属监控器</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
																<select name="seneor_id"  id="seneor_id" onchange="sensorSelect(this)" class="col-xs-12 col-sm-6">
																	<option value='0'>---请选择监控器---</option>
																</select>
										                    </div>
														</div>
													</div>
												     <div hidden id="typeal" class="form-group alert alert-danger">
												    	<strong>警告:</strong>请选择一个预设点类型！
													</div>
							      					<div hidden id="nooperational" class="form-group alert alert-danger">
												   		 <strong>警告:</strong>没有可选的预设点类型，请先创建预设点类型！
													</div>
													<div hidden class="form-group" id="add_point_type_div">
													    <label class="control-label col-xs-12 col-sm-3 no-padding-right" for="station_manager">预设点类型</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
																<select name="point_type"  id="add_point_type" onchange="managerSelect(this)" class="col-xs-12 col-sm-6">
																	<option value='0'>---请选择预设点类型---</option>
																</select>
										                    </div>
														</div>
													</div>
												    
													<div class="form-group">
														<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="des">上传图片</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
															   <input type="file"  name="images" class="col-xs-12 col-sm-6" accept="image/*">											
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
<!-- 															<i class="ace-icon fa fa-check bigger-110"></i> -->
															&nbsp; &nbsp; &nbsp;
															<button class="btn" type="reset">
<!-- 												<i class="ace-icon fa fa-undo bigger-110"></i> -->
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
		<script src="${res_url}js/jquery.form.min.js"></script>
	<script type="text/javascript">
	var parameter;
	var workareaid;
	var operationID;
	var station;
	var building;
	var sensor;
	 $(window).load(function(){
	 	parameter = "${item}";
		workareaid="${item.work_area_id}";
		operationID="${item.op_id}";
		station = "${item.station_id}";
		building = "${item.building_id}";
		sensor = "${item.sensor_code}";
		getWorkArea();
		//getOperationClass();
		
	  });
	 $(document).ready(function () {
	    $("#submit-btn").click(function () {
	        var name = $('#name').val();
	        
	        if(name==''){
	            alert("请输入预设点名称");
	        }else{
	           $("#form").ajaxForm({  
			    url : "${context_path}/setpoint/save",  
			    dataType : 'json',  
			    success : function(data) {  
			      if(data.code==0){
			    	  parent.reloadGrid(); //重新载入
  					layer.msg('操作成功', {
  					    icon: 1,
  					    time: 3000 //2秒关闭（如果不配置，默认是3秒）
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
	 });
	 
	 
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
					    var wa = document.getElementById("work_area_class");//$('#station_op_class');
					    getWorkAreaSelect(wa);
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
		}else {
			hiddleComp('typealert2',which);
			getOperationClassNew(which.value);
		}

	}
	function getOperationClassNew(wa){
		var name="${sessionScope.sysUser.name}";
		var which = $('#station_op_class');
		$(which).empty();
		$(which).append("<option value='0'>---请选择班组---</option>"); 
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/getoperation/getOP",
			    data:{
				    'username':name,
				    'workarea':wa
			    },
			    success: function(data) {
			    	var result = data.result;
					var content = data.content;
					if(result){
						var selec = 0;
						 var index = 0;
					     $.each(content, function(i,value){
					    	$(which).append("<option value='"+value.id+"'>"+value.op_name+"</option>"); 
					    	if(parameter!=""){
								selec = operationID;
								if(value.id == selec){
									index = i+1;
								}
							}
					    });
					    
					    if(index>0){
					    	which.get(0).selectedIndex=index;//index为索引值
					    }
					    
					    var station = document.getElementById("station_op_class");
					    getOpClassSelect(station);
					    
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
				hiddleComp('typealert',which);
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
						var result = data.result;
						var content = data.content;
						if(result){
							var selec = 0;
						 	var index = 0;
						     $.each(content, function(i,value){
				
						    	$(which).append("<option value='"+value.id+"'>"+value.station_name+"</option>");
						    	if(parameter!=""){
									selec = station;
									if(value.id == selec){
										index = i+1;
									}
								}  
						    });
						    if(index>0){
						    	which.get(0).selectedIndex=index;//index为索引值
						    }
						    var stationDiv = document.getElementById("add_station");
					    	stationSelect(stationDiv);
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
						var result = data.result;
						var content = data.content;
						if(result){					
							var selec = 0;
						 	var index = 0;
						     $.each(content, function(i,value){
						    	$(which).append("<option value='"+value.id+"'>"+value.building_name+"</option>"); 
						    });
						    if(parameter!=""){
								selec = building;
								if(value.id == selec){
									index = i+1;
								}
							}  
							 if(index>0){
						    	which.get(0).selectedIndex=index;//index为索引值
						    }
						    var bDiv = document.getElementById("add_building");
					    	bulidingSelect(bDiv);
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
			//alert(s);
			var which = $('#seneor_id');
			$(which).empty();
			$(which).append("<option value='0'>---请选择监控器---</option>"); 
			$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/sensorlist/getSensorCodeById",
			    data:{"buliding":buliding},
			    success: function(data) {
			    	var result = data.result;
					var content = data.content;
					
					if(result){
						var selec = 0;
						var index = 0;
					     $.each(content, function(i,value){
					    	$('#seneor_id').append("<option value='"+value.sensor_code+"'>"+value.name+"</option>");
					    	
					    	if(parameter!=""){
								selec = sensor;
								if(value.sensor_code == selec){
									index = i+1;
								}
							}   
					    });
					     if(index>0){
					    	which.get(0).selectedIndex=index;//index为索引值
					    }
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
						
						var result = data.result;
						var content = data.content;
						if(result){
							$.each(content, function(i,value){
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
		}
		
		/* $(function(){  
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
			});   */
			
			function closeView(){
				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.layer.close(index); //再执行关闭 
			}
			
		</script>
</body>

</html>
