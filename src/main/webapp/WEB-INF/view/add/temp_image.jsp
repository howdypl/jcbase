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
<meta name="description" content="overview &amp; stats" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<jsp:include page="/WEB-INF/view/common/basecss.jsp" flush="true" />
<link rel="stylesheet" type="text/css" media="all" href="${res_url}cssto/daterangepicker-1.3.7.css" />
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
								<h5 class="widget-title lighter">温度趋势</h5>
							<!-- </div>							
								<div class="row" style="margin-left: 15px;padding-top: 30px;">
									<div class="col-md-3" style="width: 16%">
										<label class="form-label control-label">运维班：</label>
									</div>
									<div class="col-md-3" style="width: 16%">
										<label class="form-label control-label">变电站：</label>
									</div>
									<div class="col-md-3" style="width: 16%">
										<label class="form-label control-label">设备间：</label>
									</div>
									<div class="col-md-3" style="width: 16%">
										<label class="form-label control-label">设备：</label>
									</div>
									<div class="col-md-3" style="width: 16%">
										<label class="form-label control-label">起止时间</label>
									</div>
								</div> -->
								<div class="row" style="margin-left: 15px">
									<div id="work_area_div" class="col-md-2" style="width: 12%; margin: 0 5px;">
										<select name="work_area_id"  id="work_area_class" 
											onchange="getWorkAreaSelect(this)" 
											class="form-control selectpicker">
											<option value='0'>---请选择工区---</option>
											</select>
									</div>
								
								
									<div class="col-md-3" style="width: 12%">
										<select id="station_op_class" onchange="getOpClassSelect(this)"
											class="form-control selectpicker">
											<option value='0'>---请选择运维班---</option>
										</select>
									</div>
									<div class="col-md-3" style="width: 12%">
										<select id="add_station" onchange="managerSelect(this)"
											class="form-control selectpicker">
											<option value='0'>---请选择变电站---</option>
										</select>
									</div>
									<div class="col-md-3" style="width: 15%">
										<select id="add_building" onchange="typeSelect(this)"
											class="form-control selectpicker">
											<option value='0'>---请选择设备间---</option>
										</select>
									</div>
									<div class="col-md-3" style="width: 15%">
										<select id="add_sensor_code" onchange="timeSelect(this)"
											class="form-control selectpicker">
											<option value='0'>---请选择设备---</option>
										</select>
									</div>
									<div class="col-md-3" style="width: 20%">
										<div id="reportrange" class="pull-left dateRange"
											style="width: 350px">
											<i class="glyphicon glyphicon-calendar fa fa-calendar"></i> <span
												id="searchDateRange"></span> <b class="caret"></b>
										</div>
									</div>
								</div>
								<!-- tab页开始 -->
								<ul hidden id="myTab" class="nav nav-tabs" style="padding-top: 40px;">
									<li class="active">
										<a href="#home" data-toggle="tab">
											 温度曲线
										</a>
									</li>
									<li><a href="#ios" data-toggle="tab">温度记录</a></li>
								</ul>
								<div id="myTabContent" class="tab-content" style="padding-top: 20px;">
									<div class="tab-pane fade in active" id="home">
										<div id="container" style="width: 100%; height: 400px; margin: 0 auto"></div>
									</div>
									<div class="tab-pane fade" id="ios">
										<div id ='tempdatarow' class="row">
										    <div class="box col-md-12">
										        <div class="box-inner">            
										          <div style="display:inline-block; *display:inline; *zoom:1">
										            <div style="width:200px; height:auto; display:inline"> <button type="button" id="export" value="0" class="btn btn-success btn-lg"><i class="glyphicon glyphicon-download glyphicon-white"> </i>导出全部记录  </button></div>
										          </div> 
										            
													<table id="grid-table"></table>
							
													<div id="grid-pager"></div>
										        </div>
										    </div>
										</div>
									</div>
								</div>
								<!-- tab页结束 -->
						</div>
					</div>
				</div>
				<!-- /.row -->
			</div>
		</div>
	</div>
	<!-- /.main-container -->
	<!-- basic scripts -->
	<jsp:include page="/WEB-INF/view/common/basejs.jsp" flush="true" />

	<script type="text/javascript" src="${res_url}jsto/jquery.table2excel.min.js"></script>
<%-- <script src="${res_url}bower_components/chosen/chosen.jquery.min.js"></script>
<script type="text/javascript" src="${res_url}jsto/moment.min.js"></script>
<script type="text/javascript" src="${res_url}jsto/daterangepicker-1.3.7.js"></script> --%>
<script type="text/javascript" src="${res_url}jsto/highchart/highcharts.js"></script>
<script type="text/javascript" src="${res_url}jsto/highchart/exporting.js"></script>
<script type="text/javascript">
//导出当前页面的方法**************************************************
var work_areadd = 0;
var op_idd = 0;
var station_id = 0;
var building_id = 0;
var sensor_codee = null;
var point_type = 0;        
var ifirst = 0;
$(document).ready(function(){
	//获取URL中默认的页面查询参数
	work_areadd = getUrlParam("work_area_id");
  	op_idd = getUrlParam("opID");
	station_id = getUrlParam("stationID");
	building_id = getUrlParam("buildingID");
	sensor_codee = getUrlParam("sensor_code");
	point_type = getUrlParam("point_type");
	//getOperationClass();
	
	getWorkArea();
	var user_type = "${sessionScope.sysUser.user_type}";

 	if(user_type==1){
 		getWAWord();
 	}else if(user_type==2){
 		getWord();
 	}
	
});

	//获取url中的参数
	function getUrlParam(name) {
	  var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
	  var r = window.location.search.substr(1).match(reg); //匹配目标参数
	  if (r != null) 
	  	return unescape(r[2]); 
	  return null; //返回参数值
	}
	
	function getWord() {
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: '<%=request.getContextPath()%>/sys/user/getWord?name="${sessionScope.sysUser.name}"',
			    success: function(data) {
					var result = data.word;
					if(!result){
						
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
	
	

	$("#export").click(function(){
	   	var op_class= $("#station_op_class").val();
		var station= $("#add_station").val();
		var building = $("#add_building").val();
		var sensor= $("#add_sensor_code").val();
		var timeArray = $('#reportrange span').html().split(" - ");
	   	$.post("excel/exportOutExcel",{'sheetName':"w",'create_time':timeArray[0],'end_time':timeArray[1],'sensor':sensor},function(data){
	   		
	   		var relativePath = data.relativePath;
			window.location.href = "..${context_path}" + relativePath;
	   		
	   	});
	}); 
//  };
        /* $("#btn").click(function(){
            $("#userTable2").table2excel({
                // 不被导出的表格行的CSS class类
                exclude: ".noExl",
                // 导出的Excel文档的名称，（没看到作用）
                name: "Excel Document Name",
                fileext: ".xls",
                // Excel文件的名称
                filename: "当前温度记录"
            });
        }); */
  
    
	 function command1(){
	 	var work_area = $('#work_area_class').val();
	 	var op_class= $("#station_op_class").val();
		var station= $("#add_station").val();
		var building = $("#add_building").val();
		var sensor= $("#add_sensor_code").val();
		var timeArray = $('#reportrange span').html().split(" - ");	
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
	         url:'${context_path}/temp/getListData',
	         mtype: "GET",
	         datatype: "json",
			 postData:{'create_time':timeArray[0],'end_time':timeArray[1],'sensor':sensor},
	         colModel: [
	         	{ label: '所属工区', name: 'area', width: 40 },
	         	 { label: '所属运维班', name: 'op_name', width: 60 },
	             { label: '所属变电站', name: 'station_name', width: 75 ,sortable:false},
	             { label: '所属设备间', name: 'building_name', width: 80 },
	             { label: '设备名称', name: 'sensorName', width: 80 ,sortable:false},
	             { label: '创建时间', name: 'create_time', width: 70 },
	             { label: '最高温度', name: 'max_temp', width: 40 },
	             { label: '平均温度', name: 'av_temp', width: 40 },
	             { label: '最低温度', name: 'min_temp', width: 40 },
	           //  { label: '操作', name: 'id',formatter:fmatterOperation, width:100,sortable:false}
	         ],
			viewrecords: true,
	         height: 325,
	         rowNum: 10,
	         //multiselect: true,//checkbox多选
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
			
	 }
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
	/* function fmatterOperation(cellvalue, options, rowObject){
		return '<button class="btn btn-info" data-toggle="modal" data-target="#myModal" onclick="look_data('+cellvalue+')">查看图片</button> <button class="btn btn-danger" onclick="delete_data('+cellvalue+')">删除</button>';
	} 
	function delete_data(id){
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
	}*/
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
	function reloadGrid(){
		$("#grid-table").trigger("reloadGrid"); //重新载入
	}
	function updata(){  
		 //此处可以添加对查询数据的合法验证  
		 var op_class= $("#station_op_class").val();
			var station= $("#add_station").val();
			var building = $("#add_building").val();
			var sensor= $("#add_sensor_code").val();
			var timeArray = $('#reportrange span').html().split(" - ");	
		 $("#grid-table").jqGrid('setGridParam',{  
		     datatype:'json',  
		      postData:{'create_time':timeArray[0],'end_time':timeArray[1],'sensor':sensor},//发送数据  
		     page:1  
		 }).trigger("reloadGrid"); //重新载入  
	}
	function command2(){
		var op_class= $("#station_op_class").val();
		var station= $("#add_station").val();
		var building = $("#add_building").val();
		var sensor= $("#add_sensor_code").val();
		var timeArray = $('#reportrange span').html().split(" - ");	
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    async: false,
			    url: "<%=request.getContextPath()%>"+"/temp/getData",
			    data: { "op_class":op_class,
		    	    "station":station,
		    		"sensor":sensor,
		    		"building":building,
		    		"create_time":timeArray[0],
		    		"end_time":timeArray[1],},
			    timeout:10000,
			    success: function(data) {
					var result = data.result;
				   
				    
		            if (result == true) { //成功添加
		            	var create_time = [];
		            	var avtemp = [];
		            	var maxtemp=[];
		            	var mintemp=[];
		            	var l =0;
		            	var curse = [];
		            	 var dataList = reduceIndex(data.dataList,60,1.5);
		            	
		                 $.each(dataList, function(i,value){
		                 		create_time.push(value.create_time);
		                 		avtemp.push(value.av_temp);
		                 		maxtemp.push(value.max_temp);
		                 		mintemp.push(value.min_temp);
		                 		l++;
		                 		
								/* $('#userTable2').DataTable().row.add([l,value.temp_sensor_code, value.min_temp, value.av_temp,value.max_temp,value.create_time]).draw( false );																	 */
		                 	});
		                 	curse.push({name:'最小值', data:mintemp});
		                 	curse.push({name:'平均值', data:avtemp});
		                 	curse.push({name:'最大值', data:maxtemp});
		                 	
							$('#container').highcharts({
						        chart: {
						            type: 'line'
						        },
						        title: {
						            text: '设备测温自定义趋势查询'
						        },
						        subtitle: {
						            text: ''
						        },
						        xAxis: {
						            categories: create_time
						        },
						        yAxis: {
						            title: {
						                text: '温度(°C)'
						            }
						        },
						        plotOptions: {
						            line: {
						                dataLabels: {
						                    enabled: true          // 开启数据标签
						                },
						                enableMouseTracking: false // 关闭鼠标跟踪，对应的提示框、点击事件会失效
						            }
						        },
						        series: curse
						    });
							$('#myTab').show();
		                return true;
		            }else{ //添加失败	
		                $.toaster({ priority : 'warning', title : '告警信息', message : '在此时间区间没有数据报告！'});
		                return false;
		            }
		            
			    },
			    error:function(){
			    	$.toaster({ priority : 'danger', title : '错误信息', message : '请求错误，请确认路径正确或网络正常！'});
			    	//$('#addModal').modal("hide");
			    }
	        });
	        
	    //window.location.reload("/station");
	    return false;
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
		$(which).append("<option value='0'>---请选择运维班---</option>"); 
		var name="${sessionScope.sysUser.name}";
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
						// var index =1;
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
	function getOpClassSelect(which){
	    var sindex = which.selectedIndex;
		if(sindex == 0){
			isSelect('typealert',which);
		}else{
			op_idd=which.value;
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
						var index = 0;
 						if(ifirst==0){
 							index = (station_id=='undefined'||station_id==null)?0:station_id; // 设置默认选择的变电站; // 设置默认选择的变电站
 					    } 
					     $.each(result, function(i,value){
					     	if(index==0 || index=='undefined'){
					     		index = 1;
					     	}else{
					     		if(index==value.id){
					     			index = i+1;
					     		}
					     	}				     	
					    	$(which).append("<option value='"+value.id+"'>"+value.station_name+"</option>"); 
					    });
					    
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
		station_id=which.value;
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
 						if(ifirst==0){
 							index = (building_id=='undefined'||building_id==null)?0:building_id; // 设置默认选择的变电站;			
 					    }
 					    $.each(result, function(i,value){
 					     	if(index==0 || index=='undefined'){
					     		index = 1;
					     	}else{
					     		if(index==value.id){
					     			index = i+1;
					     		}
					     	}					  
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
		building_id = which.value;							
		//command();
		getCode(which.value);
		
	}
	function getCode(op){
		var which = $("#add_building");
		var building_id = op;
		$('#add_sensor_code').empty();
		$('#add_sensor_code').append("<option  value='0'>---请选择设备---</option>");
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/galleryquery/getSensorCode",
			    data:{//"room":room.val(),
			    	"building_id":building_id},
			    success: function(data) {
			    	var notEmpty = data.result;
					var result = data.content;
					
					if(notEmpty){
						var index = 1;
					     $.each(result, function(i,value){
					     	if(sensor_codee!=null && point_type!=null){
 					     		if(ifirst==0&&sensor_codee==value.sensor_code && point_type==value.point_type){
 					     			index = i+1;
 					     		}
 							}
					    	$('#add_sensor_code').append("<option value='"+value.sensor_code+"/"+value.point_type+"'>"+value.name+"("+value.platform_code+")</option>"); 
					    	
					    });
					    $('#add_sensor_code').get(0).selectedIndex=index;//index为索引值
					   				   
						//var device = document.getElementById("add_sensor_code");// $('#add_sensor_code');				       
					}
					timeSelect( $('#add_sensor_code'));
					ifirst++;
			    },
 			    complete: function () {
 			    	ifirst++;
 			    }
	        });
	}
	function timeSelect(which){	
		//daterangetimeplugin();
		if(which.value&&which.value.split("/")){
	 		sensor_codee=which.value.split("/")[0];
	 		point_type=which.value.split("/")[1];
	 	}
         command2();
		 command1();
		 updata();
      	 //exportOutExcel();
	}
	function showAlert(comp){
		var selected = "#"+comp;
		console.log("selected="+selected);
		$(selected).show();
	}
	
		//判断密码不为空
	function isSelect(comp,obj){
		var selected = "#"+comp;
		if(obj.selectedIndex == 0){
			//$('#passalert').removeClass("hidden");
			$(selected).show();
		}
	}
	
	//获取焦点后，隐藏告警信息
	function hiddleComp(comp,obj){
		//$('#passalert').addClass("hidden");
		var selected = "#"+comp;
		$(selected).hide();
	}
	$(document).ready(function() {
		daterangetimeplugin();
	}); 
	
	/**
	* 当温度曲线的点过于密集时进行自适应抽样
	*/
	function reduceIndex(arr, reduceWidth,reduceIndex) {
         realWidth = arr.length;
         var newArr = []; // 需要保留第一条数据
         if (reduceWidth > 0 && realWidth > reduceWidth * reduceIndex) {
             // 需要消减，并且满足消减系数约束
             
             newArr.push(arr[0]);
             reduceStep = (realWidth - 2) / (reduceWidth - 2); // 消减步长，由于已经选择了首尾元素，计算时的分子分母都需要-2
             var cnt = 2; // 计数器
             var curP = 0; // 当前获取到的元素的下标
             while ( cnt * reduceStep < realWidth ) {
                 index = Math.floor( cnt*reduceStep );//计算本次选中的元素的下标，下标元素需要下取整
                 var temp = arr[index];
                 newArr.push(temp);
                 curP = index;
                 cnt ++;
             }
             if (curP != realWidth-1) {
                 //最后一个元素没有取到，现在保存最后一个元素
                 newArr.push(arr[realWidth-1]);
             }
             arr = newArr
         }
         return arr;
     }
	function daterangetimeplugin(){
		//时间插件
		$('#reportrange span').html(moment().subtract('days', 1).format('YYYY-MM-DD HH:mm:ss') + ' - ' + moment().format('YYYY-MM-DD HH:mm:ss'));

		$('#reportrange').daterangepicker(
				{
					// startDate: moment().startOf('day'),
					//endDate: moment(),
					//minDate: '01/01/2012',	//最小时间
					// maxDate : moment(), //最大时间 
					dateLimit : {
						days : 30
					}, //起止时间的最大间隔
					showDropdowns : true,
					showWeekNumbers : true, //是否显示第几周
					timePicker : true, //是否显示小时和分钟
					timePickerIncrement : 60, //时间的增量，单位为分钟
					timePicker12Hour : false, //是否使用12小时制来显示时间
					ranges : {
						//'最近1小时': [moment().subtract('hours',1), moment()],
						'今日': [moment().startOf('day'), moment()],
	                    '昨日': [moment().subtract('days', 1).startOf('day'), moment().subtract('days', 1).endOf('day')],
	                    '最近7日': [moment().subtract('days', 6), moment()],
	                    '最近30日': [moment().subtract('days', 29), moment()]
					},
					opens : 'right', //日期选择框的弹出位置
					buttonClasses : [ 'btn btn-default' ],
					applyClass : 'btn-small btn-primary blue',
					cancelClass : 'btn-small',
					format : 'YYYY-MM-DD HH:mm:ss', //控件中from和to 显示的日期格式
					separator : ' to ',
					locale : {
						applyLabel : '确定',
						cancelLabel : '取消',
						fromLabel : '起始时间',
						toLabel : '结束时间',
						customRangeLabel : '自定义',
						daysOfWeek : [ '日', '一', '二', '三', '四', '五', '六' ],
						monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月',
								'七月', '八月', '九月', '十月', '十一月', '十二月' ],
						firstDay : 1
					}
				}, function(start, end, label) {//格式化日期显示框
	                
                 	$('#reportrange span').html(start.format('YYYY-MM-DD HH:mm:ss') + ' - ' + end.format('YYYY-MM-DD HH:mm:ss'));
               });

	//设置日期菜单被选项  --开始--
     	  var dateOption ;
     	  if("${riqi}"=='day') {
			dateOption = "今日";
         }else if("${riqi}"=='yday') {
			dateOption = "昨日";
         }else if("${riqi}"=='week'){
			dateOption ="最近7日";
         }else if("${riqi}"=='month'){
			dateOption ="最近30日";
         }else if("${riqi}"=='year'){
			dateOption ="最近一年";
         }else{
			dateOption = "自定义";
         }
     	  $(".daterangepicker").find("li").each(function(){
			if($(this).hasClass("active")){

				$(this).removeClass("active");

			}
			
			if(dateOption==$(this).html()){

				$(this).addClass("active");

			}
         });
     	$('#reportrange').on('apply.daterangepicker',function() {
     		 command1();
      	 command2();
      	// exportOutExcel();
      	 updata();
     });
      //设置日期菜单被选项  --结束--
	}
</script>

</body>
</html>



