<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglib.jsp"%>
<%
	String virtualImages = "/backendimageinf";
	String baseImagePath = request.getScheme()+"://"
			+request.getServerName()+":"
			+request.getServerPort()+virtualImages+"/"; %>	
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<title>全时跟踪热成像测温平台</title>
<meta name="description" content="overview &amp; stats" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<jsp:include page="/WEB-INF/view/common/basecss.jsp" flush="true" />
</head>
<body class="no-skin">
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<script type="text/javascript">
				try{ace.settings.check('main-container' , 'fixed')}catch(e){}
		</script>
		<div class="main-content" id="page-wrapper">
			<div class="page-content" id="page-content">
				<div class="row">
					<div class="col-xs-12">
						<!-- PAGE CONTENT BEGINS -->
						<div class="widget-box">
							<div class="widget-header widget-header-small">
								<h5 class="widget-title lighter">告警信息</h5>
							</div>

							
								<!-- <div class="row" style=" padding-top: 10px">
									<div class="col-md-3" style="width: 18%; margin: 0 20px;">
										<label class="form-label control-label">班组：</label>
									</div>
									<div class="col-md-3" style="width: 18%; margin: 0 20px;">
										<label class="form-label control-label">变电站：</label>
									</div>
									<div class="col-md-3" style="width: 18%; margin: 0 20px;">
										<label class="form-label control-label">设备间：</label>
									</div>
									<div class="col-md-3" style="width: 18%; margin: 0 20px;">
										<label class="form-label control-label">设备：</label>
									</div>
								</div> -->
								<div class="row" style="padding-bottom: 10px;margin-top: 20px;">
									<div id="work_area_div" class="col-md-2" style="width: 12%; margin: 0 5px;">
										<select name="work_area_id"  id="work_area_class" 
											onchange="getWorkAreaSelect(this)" 
											class="form-control selectpicker">
											<option value='0'>---请选择工区---</option>
											</select>
									</div>
									<div id="operation_class_div" class="col-md-2" style="width: 12%; margin: 0 5px;">
										<select id="station_op_class"
											onchange="getOpClassSelect(this)"
											class="form-control selectpicker">
											<option value='0'>---请选择班组---</option>
										</select>
									</div>
									<div class="col-md-3" style="width: 12%; margin: 0 5px;">
										<select id="add_station" onchange="managerSelect(this)"
											class="form-control selectpicker">
											<option value='0'>---请选择变电站---</option>
										</select>
									</div>
									<div class="col-md-2" style="width: 13%; margin: 0 5px;">
										<select id="add_building" onchange="typeSelect(this)"
											class="form-control selectpicker">
											<option value='0'>---请选择设备间---</option>
										</select>
									</div>
									<div class="col-md-2" style="width: 12%; margin: 0 5px;">
										<select id="add_sensor_code" onchange="timeSelect(this)"
											class="form-control selectpicker">
											<option value='0'>---请选择设备---</option>
										</select>
									</div>
									<div class="col-md-2" style="width: 10%; margin: 0 5px;">
										<select id="warn_status" onchange="timeSelect()" class="form-control selectpicker" >
											<option value='0'>未确认</option>
											<option value='1'>已确认</option>
											<option value='2' selected>全部</option>
										</select>
									</div>
								</div>
								<div class="row-fluid" style="margin-bottom: 10px;margin-left: 5px;">
									<div class="span12 control-group">
										<jc:button className="btn btn-primary" id="btn-confirm-all" textName="确认全部告警" />
										<jc:button className="btn btn-success" id="btn-visible" textName="确认所选告警"/>
										<jc:button className="btn btn-danger" id="btn-delect" textName="告警删除按钮" />
										
										<%-- <jc:button className="btn btn-info" id="btn-edit" textName="编辑" />
										<jc:button className="btn" id="bnt-grant" textName="资源授权" permission="/sys/role"/>  --%>
										
									</div>
								</div>
							<!-- PAGE CONTENT BEGINS -->
							<table id="grid-table"></table>
	
							<div id="grid-pager"></div>
							<!-- PAGE CONTENT ENDS -->
						</div>
						
					</div>
					
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="width: auto;height: auto;">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" 
											aria-hidden="true">×
									</button>
									<h4 class="modal-title" id="myModalLabel">
										查看图片
									</h4>
								</div>
								<div class="modal-body">
									<div id="myCarousel" class="carousel slide" style="width: auto;height: auto;">
										<!-- 轮播（Carousel）指标 -->
										<ol class="carousel-indicators">
											<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
											<li data-target="#myCarousel" data-slide-to="1"></li>
											<li data-target="#myCarousel" data-slide-to="2"></li>
										</ol>
										<!-- 轮播（Carousel）项目 -->
										<div class="carousel-inner" id="add_Carousel">
						<!-- 					<div class="item active"> -->
						<!-- 						<img src="http://localhost:8080/backendimage/2018-05-09 13&56&25~b827ebc7ede5~40.2~44.3~53.7~1~2.jpg" -->
						<!-- 							alt="First slide"> -->
						<!-- 					</div> -->
						<!-- 					<div class="item"> -->
						<!-- 						<img src="http://localhost:8080/backendimage/2018-05-09 13&56&25~b827ebc7ede5~40.2~44.3~53.7~1~2.jpg" -->
						<!-- 							alt="Second slide"> -->
						<!-- 					</div> -->
						<!-- 					<div class="item"> -->
						<!-- 						<img src="http://localhost:8080/backendimage/2018-05-09 13&56&25~b827ebc7ede5~40.2~44.3~53.7~1~2.jpg" -->
						<!-- 							alt="Third slide"> -->
						<!-- 					</div> -->
										</div>
										<!-- 轮播（Carousel）导航 -->
										<a class="left carousel-control" href="#myCarousel" role="button"
											data-slide="prev"> <span
											class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
											<span class="sr-only">前一个</span>
										</a> <a class="right carousel-control" href="#myCarousel" role="button"
											data-slide="next"> <span
											class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
											<span class="sr-only">下一个</span>
										</a>
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default" 
											data-dismiss="modal">关闭
									</button>
									<!-- <button type="button" class="btn btn-primary">
										提交更改
									</button> -->
								</div>
							</div><!-- /.modal-content -->
						</div><!-- /.modal-dialog -->
					</div><!-- /.modal -->
				</div>
				<!-- /.row -->
			</div>
		</div>
	</div>
	<!-- /.main-container -->
	<!-- basic scripts -->
	<jsp:include page="/WEB-INF/view/common/basejs.jsp" flush="true" />

<script type="text/javascript"> 
	var work_areadd = 0;
	var op_idd = 0;
	var station_id = 0;
	var building_id = 0;
	var sensor_codee = null;
	var point_type = 0;     
	var ifirst = 0;
	$(window).load(function(){
		work_areadd = getUrlParam("work_area");
		op_idd = getUrlParam("op_id");
		station_id = getUrlParam("station_id");
		building_id = getUrlParam("buildingID");
		sensor_codee = getUrlParam("sensor_code");
		point_type = getUrlParam("point_type");
		// console.log("op_id1="+op_idd);
	 	var user_type = "${sessionScope.sysUser.user_type}";
	 	
	 	getWorkArea();
	 	if(user_type==1){
	 		getWAWord();
	 	}else if(user_type==2){
	 		getWord();
	 	}
	 	
		onOpenOneWarnDetailFrame();
		onexportWarnDetailFrame();
		
		
		function delete_data(){
			var id=getSelectedRows();
			//alert(id);
			var submitData={id:id};
			$.post("${context_path}/warn/deleteData", submitData,function(data) {
				if (data.code ==0) {
					layer.msg("删除成功", {
        				icon: 1,
        			    time: 2000 //2秒关闭（如果不配置，默认是3秒）
        			},function(){
						 $("#grid-table").trigger("reloadGrid"); //重新载入
					});
				}else{
					layer.msg(data.msg);
				}
			},"json");
		}
		
		$("#btn-confirm-all").click(function(){//添加页面
		 		var username = "${sessionScope.sysUser.name}";
				parent.layer.open({
					title:'确认全部告警信息',
				    type: 2,
				    area: ['370px', '320px'],
				    fix: false, //不固定
				    maxmin: true,
				    content: '${context_path}/sensorlook/confirmWarnALL?username='+username
				});
		});
		 $("#btn-visible").click(function(){//添加页面
		 	var rid=getSelectedRows();
			//alert(id);
			var stat = getRowData();
			var submitData={id:rid};
		 	
			if(rid == -1){
				layer.msg("请选择至少一条告警", {
				    icon: 2,
				    time: 2000 //2秒关闭（如果不配置，默认是3秒）
				});
			}else {
				if(stat==-1){
					layer.msg("请选择未确认告警", {
					    icon: 2,
					    time: 2000 //2秒关闭（如果不配置，默认是3秒）
					});
				}else {
					parent.layer.open({
						title:'确认告警信息',
					    type: 2,
					    area: ['370px', '320px'],
					    fix: false, //不固定
					    maxmin: true,
					    content: '${context_path}/sensorlook/confirmWarn?id='+rid
					});
				}
			
			}
		});
	 });
		
		 /* $("#btn-visible").click(function(){//添加页面
			var rid = getOneSelectedRows();
			if(rid == -1){
				layer.msg("请选择一条告警", {
				    icon: 2,
				    time: 2000 //2秒关闭（如果不配置，默认是3秒）
				});
			}else if(rid == -2 ){
				layer.msg("只能选择一条告警", {
				    icon: 2,
				    time: 2000 //2秒关闭（如果不配置，默认是3秒）
				});
			}else {
				parent.layer.open({
					title:'确认告警信息',
				    type: 2,
				    area: ['370px', '600px'],
				    fix: false, //不固定
				    maxmin: true,
				    content: '${context_path}/sensorlook/confirmWarn?id='+rid
				});
			}
		});
	 });  */
	 

	//获取url中的参数
    function getUrlParam(name) {
      var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
      var r = window.location.search.substr(1).match(reg); //匹配目标参数
      if (r != null) 
      	return unescape(r[2]); 
      return null; //返回参数值
    }
	
	 function getWorkArea(){
		var which = $('#work_area_class');
		var name="${sessionScope.sysUser.name}";
		$('#station_op_class').get(0).selectedIndex=0;
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
					 var index = (work_areadd!=null?work_areadd:0);
				    $.each(content, function(i,value){
				    	if(index==0 || index=='undefined'){
				     		index = 1;
				     	}else{
				     		if(index==value.id){
				     			index = i+1;
				     		}
				     	}
				     	
				    	$(which).append("<option value='"+value.id+"'>"+value.area+"</option>"); 
				    	
				    });
				    
				    if(index>0){
				    	which.get(0).selectedIndex=index;//index为索引值
				    }
				}else{
					showAlert('nooperationalert2');
					
				}
				var workarea = document.getElementById("work_area_class");
				getWorkAreaSelect(workarea);
		    }
        });
	}
	function getWorkAreaSelect(which){
	    var sindex = which.selectedIndex;
	    if(sindex==0){
	    	isSelect('typealert',which);
	    }else {
	    	getOperationClass2();
	    }
	}
	function getOperationClass2(){
		var which = $('#station_op_class');
		var wa = $('#work_area_class').val();
		$('#add_station').get(0).selectedIndex=0;
		$(which).empty();
		$(which).append("<option value='0'>---请选择班组---</option>"); 
		var name="${sessionScope.sysUser.name}";
		$.ajax({
			    type: 'GET',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/getoperation/getOpc",
			    data:{"username":name,
			    	"workarea":wa},
			    success: function(data) {
					var result = data.content;
					var notEmpty = data.result;
					if(notEmpty){
						var index =(op_idd!=null?op_idd:0);
					    $.each(result, function(i,value){
					    	if(index==0 || index=='undefined'){
					     		index = 1;
					     	}else{
					     		if(index==value.id){
					     			index = i+1;
					     		}
					     	}				     						    
					    	which.append("<option value='"+value.id+"'>"+value.op_name+"</option>"); 
					    });
					    
					   which.get(0).selectedIndex=index;//index为索引值
					   	
					   var opClass = document.getElementById("station_op_class");//$('#station_op_class');
        				getOpClassSelect(opClass);
					}
					
			    }
	        });
		
	}
	
	function getOperationClass(){
		var which = $('#station_op_class');
		$(which).empty();
		$(which).append("<option value='0'>---请选择班组---</option>"); 
		var name="${sessionScope.sysUser.name}";
		var myop = op_idd;
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/getoperation",
			    data:{"username":name},
			    success: function(data) {
					var result = data.content;
					var notEmpty = data.result;
					if(notEmpty){
						var index = 0 ;
 						if(ifirst==0){
 							index =(op_idd!=null?op_idd:0); // 默认打开页面时，默认的班组
 						}
						console.log('op_idd'+op_idd);
						console.log('index='+index);
					    $.each(result, function(i,value){
					    	if(index==0 || index=='undefined'){
					    		index = 1;
					    		op_idd = value.id;
					    	}else{
					    		if(index==value.id){
					     			index = i+1;
					     			op_idd = value.id;
					     		}
					    	}
					    	which.append("<option value='"+value.id+"'>"+value.op_name+"</option>"); 
					    });
					   //console.log('selected op_id='+op_idd);
					   which.get(0).selectedIndex=index;//index为索引值
					   	
					   	var opClass = document.getElementById("station_op_class");//$('#station_op_class');
        				getOpClassSelect(opClass);
					}
					
			    }
	        });
	     //op_idd=null;
	}
	function getOpClassSelect(which){
	    var sindex = which.selectedIndex;
		if(sindex == 0){
			isSelect('typealert',which);
		}else{
			getStation(which.value);
		}
	}	
	function getStation(op){
		var which = $('#add_station');
		var opclass = op;
		$(which).empty();
		$(which).append("<option  value='0'>---请选择变电站---</option>");		
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/building/getStation",
			    data:{"opclass":opclass},
			    success: function(data) {
					var result = data.content;
					var notEmpty = data.result;
					if(result){						
						var index =(station_id=='undefined'||station_id==null)?0:station_id; // 设置默认选择的变电站
					     $.each(result, function(i,value){
					     	if(index==0 || index=='undefined'){
					     		index = 0;
					     	}else{
					     		if(index==value.id){
					     			index = i+1;
					     			station_id=value.id;
					     		}
					     	}
					    	$(which).append("<option value='"+value.id+"'>"+value.station_name+"</option>"); 
					    });
					    /* console.log('station_id='+index);
					    console.log('op='+op); */
					    $(which).get(0).selectedIndex=index;//index为索引值
						var station = document.getElementById("add_station");// $('#add_station');
				        managerSelect(station);
 					}else{
 						$(which).get(0).selectedIndex=0;//index为索引值
						var station = document.getElementById("add_station");// $('#add_station');
				        managerSelect(station);
 					}
			    }
	        });  
	}
	function managerSelect(which){
		getBuilding(which.value);
		//command();			
	}	
	function getBuilding(op){
		
		var which = $('#add_building');
		$(which).empty();
		$(which).append("<option  value='0'>---请选择设备间---</option>");
		var para = op;
		
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/building/getBuilding",
			    data:{"station":para},
			    success: function(data) {
					var result = data.content;
					if(result){
						var index = 0;
						index = (building_id=='undefined'||building_id==null)?0:building_id;
					     $.each(result, function(i,value){
					     	/* if(index==0 || index=='undefined'){
					     		index = 0;
					     	}else{
					     		if(index==value.id){
					     			index = i+1;
					     		}
					     	} */
					     		  
					    	$(which).append("<option value='"+value.id+"'>"+value.building_name+"</option>"); 
					    });
					    which.get(0).selectedIndex=index;//index为索引值
					  
						var building = document.getElementById("add_building");// $('#add_building');
				        typeSelect(building);
					}else{
						which.get(0).selectedIndex=0;//index为索引值 
						var building = document.getElementById("add_building");// $('#add_building');
				        typeSelect(building);
					}
			    }
	        });
	}
	function typeSelect(which){							
		//command();
		getCode(which.value);
	}
	function getCode(op){
		var which = $("#add_building");
		var building_id = op;
		$('#add_sensor_code').empty();
		$('#add_sensor_code').append("<option  value='0'>---请选择设备---</option>");
		var para = op;
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/galleryquery/getSensorCode",
			    data:{//"room":room.val(),
			    	"building_id":para},
			    success: function(data) {
			    	var notEmpty = data.result;
					var result = data.content;
					
					if(notEmpty){
						var index = 0;
						
					     $.each(result, function(i,value){
					     	/* if(index==0 || index=='undefined'){
					     		index = 0;
					     	}else{
					     		if(index==value.id){
					     			index = i+1;
					     		}
					     	} */
					     	if(sensor_codee!=null && point_type!=null){
 					     		if(sensor_codee==value.sensor_code && point_type==value.point_type){
 					     			index = i+1;
 					     			sensor_codee=value.sensor_code;
 					     			point_type=value.point_type;
 					     		}
 							}
					    	$('#add_sensor_code').append("<option value='"+value.sensor_code+"/"+value.point_type+"'>"+value.name+"("+value.platform_code+")</option>"); 
					    	
					    });
					    $('#add_sensor_code').get(0).selectedIndex=index;//index为索引值					   
						//var device = document.getElementById("add_sensor_code");// $('#add_sensor_code');				       
					}
					timeSelect();
					ifirst++;
			    },
 			    complete: function () {
 			    	ifirst++;
 			    }
	        });
	}
	function timeSelect(){	
		command();
		updata();
	}
	
	
	
   function getWord() {
	$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: '<%=request.getContextPath()%>/sys/user/getWord?name="${sessionScope.sysUser.name}"',
		    success: function(data) {
				var result = data.word;
				if(!result){
					 $('#btn-delect').remove();
					 //$('#bnt-grant').remove();
					 $('#work_area_div').hide();
					  $('#operation_class_div').hide();
				}
		    }
        });
  	} 
  	
	 function getWAWord() {
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: '<%=request.getContextPath()%>/sys/user/getWAWord?name="${sessionScope.sysUser.name}"',
			    success: function(data) {
					var result = data.word;
					if(!result){
						 //$('#btn-delect').remove();
						 //$('#bnt-grant').remove();
						 $('#work_area_div').hide();
					}
			    }
	        });
	  	} 
  	
  	
        function command(){
        	var op_class= $("#station_op_class").val();
    		var station= $("#add_station").val();
    		var building = $("#add_building").val();
    		var sensor= $("#add_sensor_code").val();
    		var status = $('#warn_status option:selected').val(); 
        	var grid_selector = "#grid-table";
			var pager_selector = "#grid-pager";
        	//resize to fit page size
			$(window).on('resize.jqGrid', function () {
				$(grid_selector).jqGrid( 'setGridWidth', $(".page-content").width() );
		    });
             //resize on sidebar collapse/expand
			var parent_column = $(grid_selector).closest('[class*="col-"]');
			$(document).on('settings.ace.jqGrid' , function(ev, event_name, collapsed) {
				if( event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed' ) {
					//setTimeout is for webkit only to give time for DOM changes and then redraw!!!
					setTimeout(function() {
						$(grid_selector).jqGrid( 'setGridWidth', parent_column.width() );
					}, 0);
				}
		    });
            
            $("#grid-table").jqGrid({
                url:'${context_path}/warn/getListData',
                mtype: "GET",
                datatype: "json",
                postData:{'status':status,'op_class':op_class,'station':station,'building':building,'sensor':sensor},
                colModel: [
                	{ label: '所属工区', name: 'area', width: 55 ,sortable:false},
                	{ label: '所属班组', name: 'op_name', width: 30 ,sortable:false},
                    { label: '所属变电站', name: 'station_name', width: 40 ,sortable:false},
                    { label: '所属设备间', name: 'building_name', width: 50,sortable:false},
                    { label: '设备名称', name: 'sensorName', width: 100 ,sortable:false},
                    { label: '创建时间', name: 'create_time', width: 70 },
                    { label: '告警温度', name: 'max_temp', width: 35 },
                    { label: '告警状态', name: 'status',formatter:fmatterStatus, width:35},
                    { label: '确认人', name: 'confirm_user', width: 30 },
                    /*  { label: '审批人', name: 'allow', width: 30 }, */
                    { label: '操作', name: 'id',formatter:fmatterOperation, width:45,sortable:false}
                ],
                sortable:true,
   				sortorder:'desc',
				viewrecords: true,
                height: 'auto',
                rowNum: 10,
                multiselect: true,//checkbox多选
                altRows: true,//隔行变色
                recordtext:"{0} - {1} 共 {2} 条",
                pgtext:"第 {0} 页 共 {1} 页",
                pager: pager_selector,
                loadComplete : function() {
					var table = this;
					setTimeout(function(){
						updatePagerIcons(table);
					}, 0);
				}
            });
			$(window).triggerHandler('resize.jqGrid');

            /* $("#btn-visible").click(function(){
				setVisible(1);
			}); */
		    $("#btn-delect").click(function(){
				delete_data();
			});
			/* $("#btn-unvisible").click(function(){
				var rid = getOneSelectedRows();
				var submitData={id:rid};
				$.post("${context_path}/opclass/deleteData", submitData,function(data) {
					if (data.code ==0) {
						layer.msg("删除成功", {
	        				icon: 1,
	        			    time: 2000 //2秒关闭（如果不配置，默认是3秒）
	        			},function(){
							 $("#grid-table").trigger("reloadGrid"); //重新载入
						});
					}else{
						layer.msg(data.msg);
					}
				},"json");
			}); */
			
		/* 	$("#btn-edit").click(function(){//添加页面
				var rid = getOneSelectedRows();
				if(rid == -1){
					layer.msg("请选择一个班组", {
					    icon: 2,
					    time: 2000 //2秒关闭（如果不配置，默认是3秒）
					});
				}else if(rid == -2 ){
					layer.msg("只能选择一个班组", {
					    icon: 2,
					    time: 2000 //2秒关闭（如果不配置，默认是3秒）
					});
				}else {
					parent.layer.open({
						title:'修改班组',
					    type: 2,
					    area: ['370px', '430px'],
					    fix: false, //不固定
					    maxmin: true,
					    content: '${context_path}/opclass/add?id='+rid
					});
				}
			}); */
        }
      //replace icons with FontAwesome icons like above
		function updatePagerIcons(table) {
			var replacement = 
			{
				'ui-icon-seek-first' : 'ace-icon fa fa-angle-double-left bigger-140',
				'ui-icon-seek-prev' : 'ace-icon fa fa-angle-left bigger-140',
				'ui-icon-seek-next' : 'ace-icon fa fa-angle-right bigger-140',
				'ui-icon-seek-end' : 'ace-icon fa fa-angle-double-right bigger-140'
			};
			$('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function(){
				var icon = $(this);
				var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
				if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
			})
		}
      	/**获取选中的列***/
		function getSelectedRows() {
            var grid = $("#grid-table");
            var rowKey = grid.getGridParam("selrow");
            if (!rowKey)
                return "-1";
            else {
                var selectedIDs = grid.getGridParam("selarrrow");
                var result = "";
                for (var i = 0; i < selectedIDs.length; i++) {
                    result += selectedIDs[i] + ",";
                }
                return result;
            }                
        }
        
        function getRowData(){
        	var grid = $("#grid-table");
        	
        	var rowKey = grid.getGridParam("selrow");
        	var result = "-1";
        	if (!rowKey)
                return "-1";
            else {
                var selectedIDs = grid.getGridParam("selarrrow"); 
                for (var i = 0; i < selectedIDs.length; i++) {
                	var rowData = grid.jqGrid('getRowData',selectedIDs[i]);
                	if(rowData.status.indexOf("未确认")<0){
                		return "-1";
                	}else {
                		result = "1";
                	}
                }
                return "1";
            } 
        }
		function fmatterOperation(cellvalue, options, rowObject){
			//return '<button class="btn btn-info" id="viewDetailBtn" data-warnvalue="'+cellvalue+'">查看</button><button class="btn btn-info" id="exportDetailBtn" data-warnvalue="'+cellvalue+'">导出</button>';
			// return '<form action="http://localhost:33334/inf/warn/lookWord" method="GET"><input type="hidden" name="id" value="'+cellvalue+'"><button type="submit" class="btn btn-info" data-toggle="modal" onclick="look_data('+cellvalue+')">查看</button></form>' + '<form action="http://localhost:33334/jcbase/word/downloadExcel" method="GET"><input type="hidden" name="exportData" value="'+cellvalue+'"><button type="submit" class="btn btn-warn" data-toggle="modal" onclick="export_data('+cellvalue+')">导出</button></form>';
			// return '<div style="display:inline-block;"><button class="btn btn-info" id="viewDetailBtn" data-warnvalue="'+cellvalue+'">查看</button>'+'<form action="${context_path}/word/downloadExcel" method="GET"><input type="hidden" name="exportData" value="'+cellvalue+'"><input type="hidden" name="id" value="'+cellvalue+'"><button type="submit" class="btn btn-warn" data-toggle="modal" onclick="export_data('+cellvalue+')">导出</button></form></div>'
			return '<form action="${context_path}/word/downloadExcel" method="GET"><input type="hidden" name="exportData" value="'+cellvalue+'"><input type="hidden" name="id" value="'+cellvalue+'"><button class="btn btn-success" id="viewDetailBtn" data-warnvalue="'+cellvalue+'" style="padding:0 10px;">查看</button> <button type="submit" class="btn btn-danger" data-toggle="modal" onclick="export_data('+cellvalue+')"style=" padding:0 10px;">导出</button></form>'
		
		}
		/* function delete_data(id){
			var submitData={id:id};
			$.post("${context_path}/warn/deleteData", submitData,function(data) {
				if (data.code ==0) {
					layer.msg("删除成功", {
        				icon: 1,
        			    time: 2000 //2秒关闭（如果不配置，默认是3秒）
        			},function(){
						 $("#grid-table").trigger("reloadGrid"); //重新载入
					});
				}else{
					layer.msg(data.msg);
				}
			},"json");
		} */
		/***/
		//function look_data(a){
		//	var id=a;
		//	$.ajax({
		//		    type: 'POST',
		//		    dataType: 'json',
		//		    url: "<%=request.getContextPath()%>"+"/warn/look",
		//		    data:{"id":id},
		//		    success: function(data) {
		//				var imageList = data.content;
		//				var notEmpty = data.result;
		//				if(notEmpty){
		//					 document.getElementById("add_Carousel").innerHTML = "";
		//					 $.each(imageList, function(i,value){	
		//	            		 if(i==0){
		//	            			 $('#add_Carousel').append('<div class="item active"> <img src="<%=baseImagePath%>'+value.url+'" alt="First slide"></div>');
		//	            		 }else{
		//	            			 $('#add_Carousel').append('<div class="item"> <img src="<%=baseImagePath%>'+value.url+'" alt="First slide"> </div>');
		//	            		 }
		//	            	  });
		//				}else{
		//					alert("asdf");
		//				}
		//				
		//		    }
		//        });
		//	
		//}
		
		function export_data(a){
			var id=a;
			
			
		}
		
		function look_data(a){
			var id=a;
		
			
		}
		
      	function getOneSelectedRows() {
      		var grid = $("#grid-table");
            var rowKey = grid.getGridParam("selrow");
            if (!rowKey){
                return "-1";
            }else {
                var selectedIDs = grid.getGridParam("selarrrow");
                var result = "";
                if(selectedIDs.length==1){
                	return selectedIDs[0];
                }else{
                	return "-2";
                }
            } 
      	}
// 		function setVisible(status){
// 			var submitData = {
// 					"ids" : getSelectedRows(),
// 					"visible":status
// 			};
// 			$.post("${context_path}/sys/role/setVisible", submitData,function(data) {

// 				if (data.code == 0) {
// 					layer.msg("操作成功", {
// 					    icon: 1,
// 					    time: 1000 //1秒关闭（如果不配置，默认是3秒）
// 					},function(){
// 						//$("#grid-table").trigger("reloadGrid"); //重新载入
// 						reloadGrid();
// 					});
					  
// 				}  else{
// 					layer.alert(data.msg);
// 				} 
// 			},"json");
// 		}

        function setVisible(status){
			//alert(getSelectedRows());
			var submitData = {
					"ids" : getSelectedRows(),
					"visible":status
			};
			$.post("${context_path}/warn/setVisible", submitData,function(data) {

				if (data.code == 0) {
					layer.msg("操作成功", {
					    icon: 1,
					    time: 1000 //1秒关闭（如果不配置，默认是3秒）
					},function(){
						//$("#grid-table").trigger("reloadGrid"); //重新载入
						reloadGrid();
					});
					  
				}  else{
					layer.alert(data.msg);
				} 
			},"json");
		}
		function delete_data(){
			var id=getSelectedRows();
			//alert(id);
			var submitData={id:id};
			$.post("${context_path}/warn/deleteData", submitData,function(data) {
				if (data.code ==0) {
					layer.msg("删除成功", {
        				icon: 1,
        			    time: 2000 //2秒关闭（如果不配置，默认是3秒）
        			},function(){
						 $("#grid-table").trigger("reloadGrid"); //重新载入
					});
				}else{
					layer.msg(data.msg);
				}
			},"json");
		}
 		//格式化状态显示
 		function fmatterStatus(cellvalue, options, rowObject){
 			if(cellvalue==0){
 				return '<span class="label label-sm label-warning">未确认</span>';
 			}else{
 				return '<span class="label label-sm label-success">已确认</span>';
 			}
 		}
		function reloadGrid(){
			$("#grid-table").trigger("reloadGrid"); //重新载入
		}
		function updata(){  
		    //此处可以添加对查询数据的合法验证  
		    var op_class= $("#station_op_class").val();
			var station= $("#add_station").val();
			var building = $("#add_building").val();
			var sensor= $("#add_sensor_code").val(); 
			var status = $('#warn_status option:selected').val(); 
		    $("#grid-table").jqGrid('setGridParam',{  
		        datatype:'json',  
		        postData:{'status':status,'op_class':op_class,'station':station,'building':building,'sensor':sensor},//发送数据  
		        page:1  
		    }).trigger("reloadGrid"); //重新载入  
		}
		
	/**
	* 查看按钮邦定的事件，点击打开某一条告警的详细信息页面
	*/
	function onOpenOneWarnDetailFrame(){
		$("#grid-table").on("click",'#viewDetailBtn',function(e){
			e.preventDefault();
			var warnid=$(this).attr("data-warnvalue");
			console.log("id="+warnid);
			var url = '${context_path}/warn/lookWord2?id='+warnid;
			if(url){
				var history;
				$('.J_iframe', window.parent.document).each(function(){
					if($(this).css("display")=="inline"){
						history = $(this).attr("data-id");
						return false;
					}
				});
				
				$('.main-content', window.parent.document).find("iframe").css("display","none");
				window.location.hash=url;
				if(url=="/index"||url=="/"){
					url="/home";
				};
				var str = url.split("?");
				var dataid;
				if(str!=null && str.length>0){
					dataid = str[0].substr(4,18);
				}
				
				//var iframe=$("#content-main").find("[data-id='"+url+"']");
				var iframe=$('#content-main', window.parent.document).find("[data-id='"+dataid+"']");
				$('.main-container', window.parent.document).find(".nav-list li").removeClass("active");
				$('.main-container', window.parent.document).find(".nav-list li").find("[data-index='"+$(this).attr("data-index")+"']").parent("li").addClass("active");
				
				if(iframe.length>0){
					iframe.css("display","inline");
					currentIframe=iframe;
				}else{
					var index=$(this).attr("data-index");
					var ihtml='<iframe class="J_iframe" data-history="'+history+'" data-tag="temp" name="iframe'+index+'" width="100%" height="100%" src="'+url+'" frameborder="0" data-id="'+dataid+'" seamless style="display:inline;"></iframe>';
					$('#content-main', window.parent.document).append(ihtml);
					currentIframe=$('#content-main', window.parent.document).find("[data-id='"+dataid+"']");
				}
				// currentIframe.css("display","inline");
				var $page_tabs_content = $('.main-content', window.parent.document).find("div .page-tabs-content");
				var tab = $('.main-content', window.parent.document).find("div .page-tabs-content").find("[data-id='"+dataid+"']");
				// var tab=$(".page-tabs-content").find("[data-id='"+url+"']");
				//$(".page-tabs-content a").removeClass("active");
				$page_tabs_content.find("a").removeClass("active");
				if(tab.length > 0){
					tab.addClass("active");
				}else{
					$page_tabs_content.append('<a href="javascript:;" class="J_menuTab active" data-index="'+$(this).attr("data-index")+'" data-id="'+dataid+'">告警详情<i class="fa fa-times-circle"></i></a>');
					
					//tabsEventClear();
					//tabsEventInit();
				}
			}
		});
	}
	<!--
	function onexportWarnDetailFrame(){
		$("#grid-table").on("click","#exportDetailBtn",function(e){
			e.preventDefault();
			var warnid=$(this).attr("data-warnvalue");
			console.log("id="+warnid);
			var url = '${context_path}/word/downloadExcel';
			$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: '${context_path}/word/downloadExcel',
			    data:{"id":warnid},
			    success: function(data) {
					var result = data.result;
				    
		            if (result == true) { //成功添加
		            	$.toaster({ priority : 'info', title : '提示信息', message : '导出告警成功'});
					}else{
		            	//alert("ghgfd");
		            	$.toaster({ priority : 'info', title : '提示信息', message : '导出告警失败！'});
		             }
				    }
		        });
		});
	}
	-->

</script>

</body>
</html>



