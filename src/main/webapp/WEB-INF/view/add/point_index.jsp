<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglib.jsp"%>
<%
	String virtualImages = "/backenduploadinf";
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
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
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
												<h5 class="widget-title lighter">筛选</h5>
											</div>
											
											
											<div class="row" style="margin-top:5px;">
												<div id="work_area_div" class="col-md-2" style="width: 16%; margin-left:5px;margin-top:5px;">
													<select name="work_area_id"  id="work_area_class" 
														onchange="getWorkAreaSelect(this)" 
														class="form-control selectpicker">
														<option value='0'>---请选择工区---</option>
														</select>
												</div>
												
												 <div id="operation_class_div" class="col-md-2" style="width: 16%;margin-left:5px;margin-top:5px;margin-bottom:5px;">
													<select id="station_op_class" onchange="getOpClassSelect(this)" class="form-control selectpicker">
						                        		 <option  value='0'>---请选择班组---</option>
						                       		</select>
												</div>
												<div class="col-md-2" style="width: 16%;margin-left:5px;margin-top:5px;margin-bottom:5px;">
												   <select id="add_station" onchange="managerSelect(this)" class="form-control selectpicker">
						                        		<option  value='0'>---请选择变电站---</option>
						                       		</select>
												</div>
												<div class="col-md-2" style="width: 16%;margin-left:5px;margin-top:5px;margin-bottom:5px;">
													<select id="add_building" onchange="typeSelect(this)" class="form-control selectpicker">
						                        		<option  value='0'>---请选择设备间---</option>
							                       	</select>
												</div>
												
												<div class="col-md-2" style="width: 18%;margin-left:5px;margin-top:5px;margin-bottom:5px;">
													<select id="add_sensor_code" onchange="timeSelect(this)"
														class="form-control selectpicker">
														<option value='0'>---请选择设备---</option>
													</select>
												</div>
												<div class="col-xs-12">
													<div class="row-fluid" style="margin-bottom: 5px;">
														<div class="span12 control-group">
															<jc:button className="btn btn-success" id="btn-visible" textName="启用"/>
															<jc:button className="btn btn-warning" id="btn-unvisible1" textName="禁用"/> 
															<jc:button className="btn btn-danger" id="btn-unvisible" textName="删除"/>
															<jc:button className="btn btn-primary" id="btn-add" textName="添加"/>
															<jc:button className="btn btn-info" id="btn-edit" textName="编辑"/>
														</div>
													</div>
													<!-- PAGE CONTENT BEGINS -->
													<table id="grid-table"></table>
					
													<div id="grid-pager"></div>
													<!-- PAGE CONTENT ENDS -->
												</div><!-- /.col -->
											</div>
																					
											
											<!-- <div class="widget-body">
												<div class="widget-main">
														<div class="row">
															<div class="col-xs-12 col-sm-8">
																<div class="input-group">
																	<span class="input-group-addon">
																		<i class="ace-icon fa fa-check"></i>
																	</span>

																	<input type="text" id="name" name="name" class="form-control search-query" placeholder="请输入变电站的关键字" />
																	<span class="input-group-btn">
																		<button type="button" id="btn_search" class="btn btn-purple btn-sm">
																			<span class="ace-icon fa fa-search icon-on-right bigger-110"></span>
																			搜索站名称
																		</button>
																	</span>
																</div>
															</div>
														</div>
												</div>
											</div> -->
										</div>
							</div>
							
						</div><!-- /.row -->
				</div>
			</div>
		</div><!-- /.main-container -->
		<!-- basic scripts -->
		<jsp:include page="/WEB-INF/view/common/basejs.jsp" flush="true" />
		
		<script type="text/javascript"> 
		var user_type="0";
        $(document).ready(function () {
            var username="${sessionScope.sysUser.name}";
        	 getWorkArea();
			
			user_type = "${sessionScope.sysUser.user_type}";

		 	if(user_type==1){
		 		getWAWord();
		 	}else if(user_type==2){
		 		getWord();
		 	}
		 	
			$("#btn_search").click(function(){  
			    //此处可以添加对查询数据的合法验证  
			    var name = $("#name").val();  
			    $("#grid-table").jqGrid('setGridParam',{  
			        datatype:'json',  
			        postData:{'name':name}, //发送数据  
			        page:1  
			    }).trigger("reloadGrid"); //重新载入  
			}); 
			$("#btn-add").click(function(){//添加页面
				parent.layer.open({
					title:'添加预设点',
				    type: 2,
				    area: ['400px', '430px'],
				    fix: false, //不固定
				    maxmin: true,
				    content: '${context_path}/setpoint/add'
				});
			});

			$("#btn-visible").click(function(){
				setVisible(1);
			});
			$("#btn-unvisible1").click(function(){
				setVisible(0);
			});
			$("#btn-unvisible").click(function(){
				var rid = getOneSelectedRows();
				if(rid == -1){
					layer.msg("请选择一个预设点", {
					    icon: 2,
					    time: 2000 //2秒关闭（如果不配置，默认是3秒）
					});
				}else if(rid == -2 ){
					layer.msg("只能选择一个预设点", {
					    icon: 2,
					    time: 2000 //2秒关闭（如果不配置，默认是3秒）
					});
				}else{
					var submitData={id:rid};
					$.post("${context_path}/setpoint/deleteData", submitData,function(data) {
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
			});
		function getWord() {
			$.ajax({
				type : 'POST',
				dataType : 'json',
				url : '<%=request.getContextPath()%>/sys/user/getWord?name="${sessionScope.sysUser.name}"',
				success : function(data) {
					var result = data.word;
					if (!result) {
	
						$('#work_area_div').hide();
						$('#operation_class_div').hide();
					}
				}
			});
		}
	
		function getWAWord() {
			$.ajax({
				type : 'POST',
				dataType : 'json',
				url : '<%=request.getContextPath()%>/sys/user/getWAWord?name="${sessionScope.sysUser.name}"',
				success : function(data) {
					var result = data.word;
					if (!result) {
						//$('#btn-delect').remove();
						//$('#bnt-grant').remove();
						$('#work_area_div').hide();
					}
				}
			});
		}
			$("#btn-edit").click(function(){//修改页面
				var rid = getOneSelectedRows();
				if(rid == -1){
					layer.msg("请选择一个预设点", {
					    icon: 2,
					    time: 2000 //2秒关闭（如果不配置，默认是3秒）
					});
				}else if(rid == -2 ){
					layer.msg("只能选择一个预设点", {
					    icon: 2,
					    time: 2000 //2秒关闭（如果不配置，默认是3秒）
					});
				}else {
					parent.layer.open({
						title:'修改预设点',
					    type: 2,
					    area: ['370px', '430px'],
					    fix: false, //不固定
					    maxmin: true,
					    content: '${context_path}/setpoint/upload?id='+rid
					});
				}
			});
        });
        
       function alarmFormatter(cellvalue, options, rowdata)
            {
                if (cellvalue != "0"){
                    return '<img class="alarmimg" src="<%=baseImagePath%>' + cellvalue + '" alt="' + cellvalue + '" style="width:150px;height:80px;" />';
                }else{
                    return '<img class="alarmimg" src="${res_url}img/noimage.jpg" alt="未加载" style="width:150px;height:80px;" />';
                }
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
						 var index = 1;
					    $.each(content, function(i,value){
					     	
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
	    if(sindex>0){
	    	// isSelect('typealert',which);
	    	getOperationClass2();
	    }
	    $('#station_op_class').empty();
		$('#station_op_class').append("<option value='0'>---请选择班组---</option>"); 
		if(user_type!="2"){
			commond();
			updata();
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
						var index =0;
					    $.each(result, function(i,value){
					    	/* if(index==0 || index=='undefined'){
					     		index = 1;
					     	}else{
					     		if(index==value.id){
					     			index = i+1;
					     		}
					     	} */	
					     	if(user_type=="2"){
								index = i+1;
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
	    if(sindex > 0){
	    	getStation(which.value);
	    }
		
		$('#add_station').empty();
		$('#add_station').append("<option  value='0'>---请选择变电站---</option>");
		commond();
		updata();
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
						var index =1; // 设置默认选择的变电站
					     $.each(result, function(i,value){
					     				     	
					    	$(which).append("<option value='"+value.id+"'>"+value.station_name+"</option>"); 
					    });
					    
					    //$(which).get(0).selectedIndex=index;//index为索引值
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
		 var sindex = which.selectedIndex;
	    if(sindex > 0){
	    	getBuilding(which.value);
	    }
	
		$('#add_building').empty();
		$('#add_building').append("<option  value='0'>---请选择设备间---</option>");
		commond();
		updata();
					
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
						var index = 1;			
					     $.each(result, function(i,value){
					     		  
					    	$(which).append("<option value='"+value.id+"'>"+value.building_name+"</option>"); 
					    });
					    //which.get(0).selectedIndex=index;//index为索引值
					  
					}
					var building = document.getElementById("add_building");// $('#add_building');
				    typeSelect(building);
			    }
	        });
	}
	
	
	function typeSelect(which){
		var sindex = which.selectedIndex;
		 if(sindex > 0){
	    	getCode(which.value);
	    }
		
		$('#add_sensor_code').empty();
		$('#add_sensor_code').append("<option  value='0'>---请选择设备---</option>");					
		commond();
		//getCode(which.value);
		updata();
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
			    url: "<%=request.getContextPath()%>"+"/sensorlist/getSensorCode",
			    data:{//"room":room.val(),
			    	"building_id":para},
			    success: function(data) {
			    	var notEmpty = data.result;
					var result = data.content;
					
					if(notEmpty){
						var index = 0;
						
					     $.each(result, function(i,value){
					     	
					    	$('#add_sensor_code').append("<option value='"+value.id+"'>"+value.name+"</option>"); 
					    	
					    });
					    $('#add_sensor_code').get(0).selectedIndex=index;//index为索引值					   
						//var device = document.getElementById("add_sensor_code");// $('#add_sensor_code');				       
					}
					timeSelect();
			    },
 			    complete: function () {
 			    	//ifirst++;
 			    }
	        });
	}
	function timeSelect(){	
		commond();
		updata();
	}
	
	
	function updata(){  
	    //此处可以添加对查询数据的合法验证  
	    var workArea = $('#work_area_class').val();
		var op_class= $("#station_op_class").val();
		var station = $("#add_station").val();
		var building = $("#add_building").val();
		var sensor_code = $('#add_sensor_code').val();
	    var name="${sessionScope.sysUser.name}";
	    $("#grid-table").jqGrid('setGridParam',{  
	        datatype:'json',  
	        postData:{'workarea':workArea,'username':name,"op_id":op_class,"station":station,"building":building,"sensor_code":sensor_code},//发送数据  
	        page:1  
	    }).trigger("reloadGrid"); //重新载入  
	}
	function commond(){
		var name="${sessionScope.sysUser.name}";
       
		var workArea = $('#work_area_class').val();
		var op_class= $("#station_op_class").val();
		var station = $("#add_station").val();
		var building = $("#add_building").val();
		var sensor_code = $('#add_sensor_code').val();
		var grid_selector = "#grid-table";
			var pager_selector = "#grid-pager";
        	//resize to fit page size
			$(window).on('resize.jqGrid', function () {
				$(grid_selector).jqGrid( 'setGridWidth', $(".page-content").width());
		    });
			// Resize on sidebar collapse/expand
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
                url:'${context_path}/setpoint/getListDataNew',
                mtype: "GET",
                datatype: "json",
                postData:{'workarea':workArea,'username':name,"op_id":op_class,"station":station,"building":building,"sensor_code":sensor_code},
                colModel: [
                	{ label: '所属工区', name: 'area', width: 30,sortable:true},
                	{ label: '所属运维班', name: 'op_name', width: 25 },
                	{ label: '所属变电站', name: 'station_name', width: 25 },
                	{ label: '所属设备间', name: 'building_name', width: 40 },
                	{ label: '设备名称', name: 'sensor_name', width: 30 },
                	{ label: '预设点名称', name: 'platform_code', width: 40 },
                	{ label: '设定温度值', name: 'warn_temp', width: 25 },
                	{ label: '守望点', name: 'defaul',formatter:fmatterDefault,  width: 30 },
                    //{ label: '监控器', name: 'pp_sensor_code', width: 40 ,sortable:false},
                    { label: '图片',name: 'images', width: 50, align: "center", sortable: false, editable: false, formatter: alarmFormatter},
                    { label: '注册时间', name: 'create_time', width: 40 },
                    { label: '高危点', name: 'islook',formatter:fmatterStatus, width:20,align: "center", }
                ],
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
		function setVisible(status){
			var submitData = {
					"ids" : getSelectedRows(),
					"visible":status
			};
			$.post("${context_path}/setpoint/setVisible", submitData,function(data) {

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
		//格式化状态显示
		function fmatterStatus(cellvalue, options, rowObject){
			if(cellvalue==0){
				return '<span class="label label-sm label-warning">禁用</span>';
			}else{
				return '<span class="label label-sm label-success">启用</span>';
			}
		}
		function fmatterDefault(cellvalue, options, rowObject){
			if(cellvalue>0){
				return '<span class="label label-sm label-warning">守望观测点</span>';
			}else{
				return '<span class="label label-sm label-success">普通观测点</span>';
			}
		}
		function reloadGrid(){
			$("#grid-table").trigger("reloadGrid"); //重新载入
		}
   </script>
   		
	</body>
</html>



