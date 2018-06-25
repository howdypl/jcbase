<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta charset="utf-8" />
		<title>红外监控测温系统</title>
		<meta name="description" content="overview &amp; stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
		<link rel="stylesheet" href="${res_url}ace-1.3.3/assets/css/font-awesome.css" />
		<link rel="stylesheet" href="${res_url}ace-1.3.3/assets/css/ui.jqgrid.css" />
		<link rel="stylesheet" href="${res_url}ace-1.3.3/assets/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
		<script src="${res_url}ace-1.3.3/assets/js/ace-extra.js"></script>
        <link href='${res_url}bower_components/bootstrap/dist/css/bootstrap.min.css' rel='stylesheet'> 
        <link rel="stylesheet" type="text/css" media="all" href="${res_url}cssto/daterangepicker-1.3.7.css" />
        <link rel="stylesheet" type="text/css" media="all" href="${res_url}cssto/daterangepicker-bs3.css" />
        <link href="${res_url}cssto/charisma-app.css" rel="stylesheet">
	</head>
	<body class=>
	   <div class="row">
        <div class="box col-md-12">
            <div class="box-inner">
                <div class="box-header well" data-original-title="">
                    <h2><i class="glyphicon glyphicon-warning-sign"></i> 告警信息</h2>

                </div>
                <div class="box-content">
                	<!-- <div class="alert alert-info"> -->
      					<div hidden id="typealert" class="form-group alert alert-danger">
					    	<strong>警告:</strong>请选择一个运维组！
						</div>
      					<div hidden id="nooperationalert" class="form-group alert alert-danger">
					   		 <strong>警告:</strong>没有可用的运维组，请先创建运维组！
						</div>

      					<div class="form-inline row">
      						<div class="col-md-2">
      							<label class="form-label control-label">所属运维班</label>
      						</div>
      						<div class="col-md-6">	
	      						<select id="station_op_class" onchange="getOpClassSelect(this)" class="form-control selectpicker">
	                        		<option  value='0'>---请选择运维班---</option>
	                       		</select>
                       		</div>
      					</div>
      					
                        <div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					
					    <div hidden id="nostationalert" class="form-group alert alert-danger">
					   		 <strong>警告:</strong>该运维组无变电站！
						</div>
      					<div hidden id="add_station_manager_div" class="form-inline row">
      						<div class="col-md-2">
      							<label class="form-label control-label">所属变电站</label>
      						</div>
      						<div class="col-md-6">	
	      						<select id="add_station" onclick="managerSelect(this)" class="form-control selectpicker">
	                        		<option  value='0'>---请选择变电站---</option>
	                       		</select>
                       		</div>
      					</div>
      					
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					
      					<div hidden id="nobuildingalert" class="form-group alert alert-danger">
					   		 <strong>警告:</strong>没有设备间信息，请先创建设备间！
						</div>
      					<div hidden id="add_building_div" class="form-inline row">
      						<div class="col-md-2">
      							<label class="form-label control-label">所属设备间</label>
      						</div>
      						<div class="col-md-6">	
	      						<select id="add_building" onclick="typeSelect(this)" class="form-control selectpicker">
                        		<option  value='0'>---请选择设备间---</option>	
	                       		</select>
                       		</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					
      					<div hidden id="nosensoralert" class="form-group alert alert-danger">
					   		 <strong>警告:</strong>没有监控器，请先添加！
						</div>
						<div hidden id="nosensoralert2" class="form-group alert alert-danger">
					   		 <strong>警告:</strong>该监控器不存在，请确认！
						</div>
      					<div hidden id = "sensor_code_div" class="form-inline row">
      						<div class="col-md-2">
        						<label class="form-label control-label">监控器编号</label>
        					</div> 
        					<div class="col-md-6">
        						<select id="add_sensor_code" onclick="codeSelect(this)" class="form-control selectpicker">
	                        		<option  value='0'>----请选择监控器编号----</option>
	                       		</select>
        						<!-- <input  id ="add_sensor_code_value" type="text"  onblur="isNameEmpt(this)" onfocus="hiddenNameAlert()" class="form-control" value=""> -->
        					</div>
        					<div class="col-md-2">
        						<span class='availability_status'></span>
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div hidden id = "time_div" class="form-inline row">
      						<div class="col-md-2">
        						<label class="form-label control-label">起止时间</label> 
        					</div> 
        					<div class="col-md-6">
        						
        						<div id="reportrange" class="pull-left dateRange" style="width:350px">
									<i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
									<span id="searchDateRange"></span>
									<b class="caret"></b>
								</div>
        					</div>
        					
      					</div>
      					
                        <div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
                        
                    <button id="op_class_add" type="button" class="btn btn-success btn-lg" value="0" disabled><i
                                class="glyphicon glyphicon-search glyphicon-white"></i>查询告警信息</button>

                    <br>
                <!-- </div> end of alert-info-->    
                    <div class="row">
      						<span> &nbsp;&nbsp;</span>
      				</div>
       <div class="main-container" id="main-container">
		<script type="text/javascript">
			try{ace.settings.check('main-container' , 'fixed')}catch(e){}
		</script>
			<div class="main-content" id="page-wrapper">
				<div class="page-content" id="page-content">
					<div class="row">
							<div class="col-xs-12">
								<!-- PAGE CONTENT BEGINS -->
								<table id="grid-table"></table>

								<div id="grid-pager"></div>
								<!-- PAGE CONTENT ENDS -->
							</div><!-- /.col -->
						</div><!-- /.row -->
				</div>
			</div>
		</div><!-- /.main-container -->
                </div>
            </div>
        </div>
        <!--/span-->

    </div><!--/row-->
		<jsp:include page="/WEB-INF/view/common/basejs.jsp" flush="true" />
		
		<script type="text/javascript"> 
       
		    $("#op_class_add").click(function(){
		    	 $(document).ready(function () {
		         	var grid_selector = "#grid-table";
		 			var pager_selector = "#grid-pager";
		         	//resize to fit page size
		 			$(window).on('resize.jqGrid', function () {
		 				$(grid_selector).jqGrid( 'setGridWidth', $(".page-content").width() );
		 		    });
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
		                url:'${context_path}/sensorlist/getListData',
		                mtype: "GET",
		                datatype: "json",
		                colModel: [
		                	{ label: '所属运维班', name: 'opName', width: 60 },
		                    { label: '所属变电站', name: 'stationName', width: 75 ,sortable:false},
		                    { label: '所属设备间', name: 'buildingName', width: 100 },
		                    { label: '监控器编号', name: 'sensor_code', width: 150 ,sortable:false},
		                    { label: '监控器名称', name: 'name', width: 80 },
		                    { label: '创建时间', name: 'create_time', width: 100 },
		                    { label: 'ID', name: 'id', width: 40 },
		                    { label: '操作', name: 'id',formatter:fmatterOperation, width:80,sortable:false}
		                ],
		                viewrecords: true,
		                height: 280,
		                rowNum: 10,
		                sortname:"id",
		                sortorder:"desc",
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
// 					$("#btn_search").click(function(){  
// 					    //此处可以添加对查询数据的合法验证  
// 					    var name = $("#name").val();  
// 					    $("#grid-table").jqGrid('setGridParam',{  
// 					        datatype:'json',  
// 					        postData:{'name':name}, //发送数据  
// 					        page:1  
// 					    }).trigger("reloadGrid"); //重新载入  
// 					}); 
// 					$("#btn-add").click(function(){//添加页面
// 						parent.layer.open({
// 							title:'添加监控器',
// 						    type: 2,
// 						    area: ['370px', '430px'],
// 						    fix: false, //不固定
// 						    maxmin: true,
// 						    content: '${context_path}/sensorlist/add'
// 						});
// 					});
					
// 					$("#btn-unvisible").click(function(){
// 						var rid = getOneSelectedRows();
// 						var submitData={id:rid};
// 						$.post("${context_path}/sensorlist/deleteData", submitData,function(data) {
// 							if (data.code ==0) {
// 								layer.msg("删除成功", {
// 			        				icon: 1,
// 			        			    time: 2000 //2秒关闭（如果不配置，默认是3秒）
// 			        			},function(){
// 									 $("#grid-table").trigger("reloadGrid"); //重新载入
// 								});
// 							}else{
// 								layer.msg(data.msg);
// 							}
// 						},"json");
// 					});
					
					$("#btn-edit").click(function(){//添加页面
						var rid = getOneSelectedRows();
						if(rid == -1){
							layer.msg("请选择一个监控器", {
							    icon: 2,
							    time: 2000 //2秒关闭（如果不配置，默认是3秒）
							});
						}else if(rid == -2 ){
							layer.msg("只能选择一个监控器", {
							    icon: 2,
							    time: 2000 //2秒关闭（如果不配置，默认是3秒）
							});
						}else {
							parent.layer.open({
								title:'修改监控器信息',
							    type: 2,
							    area: ['370px', '430px'],
							    fix: false, //不固定
							    maxmin: true,
							    content: '${context_path}/sensorlist/add?id='+rid
							});
						}
					});
		    });		
        });
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
		function fmatterOperation(cellvalue, options, rowObject){
			return '<button class="btn btn-info" onclick="delete_data('+cellvalue+')">查看</button> <button class="btn btn-danger btn-sm" onclick="delete_data('+cellvalue+')">删除</button>';
		}
		function delete_data(id){
			var submitData={id:id};
			$.post("${context_path}/sensorlist/deleteData", submitData,function(data) {
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
   </script>
   	<script src="js/jquery.magnific-popup.min.js"></script> <!-- Magnific popup (http://dimsemenov.com/plugins/magnific-popup/) -->
<script type="text/javascript">            
   $(window).load(function(){     
          getOperationClass();
    }); 
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
					var result = data.oplist;
					var notEmpty = data.notempty;
					if(notEmpty){
						 
					     $.each(result, function(i,value){
					     	
					    	//$('#operationclass').options.add(new Option(value.op_name,value.id));
					    	// console.log(value.id+"--"+value.op_name);
					    	//$('#operationclass').append("<option value='"+value.id+"'"+">"+value.op_name+"</option>");
					    	$(which).append("<option value='"+value.id+"'>"+value.op_name+"</option>"); 
					    });
					}else{
						showAlert('nooperationalert');
						$('#add_station_manager_div').hide();
					}
			    }
	        });

	}
	
	function getOpClassSelect(which){
			        
	    var sindex = which.selectedIndex;
	    
	    $('div.alert-danger').hide();
		if(sindex == 0){
			isSelect('typealert',which);
			$('#add_station_manager_div').hide();

		}else{
			
			$('#add_station_manager_div').show();
			

			
			getStation(which.value);
		}
		$('#add_building_div').hide();
		$('#add_layer_div').hide();
		$('#add_room_div').hide();
		$('#add_type_div').hide();
		$('#sensor_code_div').hide();
		$('#time_div').hide();
		
		$('#op_class_add').prop('disabled', true);
	}
	
	function getStation(op){
		var which = $('#add_station');
		var opclass = op;
		// console.log("opclass="+opclass);
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
					var notEmpty = data.notempty;
					if(result){
						
					     $.each(result, function(i,value){
					     	
					    	//$('#operationclass').options.add(new Option(value.op_name,value.id));
					    	//console.log(value.id+"--"+value.user_name);
					    	//$('#operationclass').append("<option value='"+value.id+"'"+">"+value.op_name+"</option>");
					    	$(which).append("<option value='"+value.id+"'>"+value.station_name+"</option>"); 
					    });
					}else{
						// console.log('nostationalert');
						showAlert('nostationalert');
						$('#add_station_manager_div').hide();
					}
			    }
	        });
	        
	        
	}
	
	function managerSelect(which){
		var sindex = which.selectedIndex;
		$('div.alert-danger').hide();
		if(sindex == 0){
			$('#add_building_div').hide();

		}else{
			$('#add_building_div').show();
			
			getBuilding(which.value);
		}
		$('#add_layer_div').hide();
		$('#add_room_div').hide();
		$('#add_type_div').hide();
		$('#sensor_code_div').hide();
		$('#time_div').hide();
		$('#op_class_add').prop('disabled', true);
	}
	

	function getBuilding(op){
		
		var which = $('#add_building');
		hiddleComp('nobuildingalert',which);
		$(which).empty();
		$(which).append("<option  value='0'>---请选择设备间---</option>");
		var para = op;
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/building/getBuilding",
			    data:{"station":para},
			    success: function(data) {
					var result = data.buildingRecords;
					if(result){
						
					     $.each(result, function(i,value){
					     	
					    	//$('#operationclass').options.add(new Option(value.op_name,value.id));
					    	//console.log(value.id+"--"+value.user_name);
					    	//$('#operationclass').append("<option value='"+value.id+"'"+">"+value.op_name+"</option>");
					    	$(which).append("<option value='"+value.id+"'>"+value.building_name+"</option>"); 
					    });
					}else{
						showAlert('nobuildingalert');
						$('#add_building_div').hide();
					}
			    }
	        });
	}
	
	function typeSelect(which){
	
		$('div.alert-danger').hide();
		var sindex = which.selectedIndex;
		if(sindex == 0){		
		
			$('#sensor_code_div').hide();
		}else{
			$('#sensor_code_div').show();
			getCode(which);
		}
		$('#time_div').hide();
		$('#op_class_add').prop('disabled', true);
	}
	
	function getCode(op){
		
		var which = $(op);
		
		
		var parentdiv = $(which).parents('.box-content');

		//var room = parentdiv.find("#add_room");
		var building_id = parentdiv.find("#add_building");

		$('#add_sensor_code').empty();
		$('#add_sensor_code').append("<option  value='0'>---请选择监控器编号---</option>");
		
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/galleryquery/getSensorCode",
			    data:{//"room":room.val(),
			    	"building_id":building_id.val()},
			    success: function(data) {
			    	var notEmpty = data.result;
					var result = data.records;
					
					if(notEmpty){
						hiddleComp('nosensoralert',which);
					     $.each(result, function(i,value){
					     	l=i+1;
					    	$('#add_sensor_code').append("<option value='"+value.sensor_code+"'>"+value.name+"</option>"); 
					    	// console.log("add_sensor_code value="+l);
					    });
					}else{
						showAlert('nosensoralert');
						$('#sensor_code_div').hide();
					}
			    }
	        });
	}
	
	function codeSelect(which){
		var code = $(which);
		var sindex = which.selectedIndex;
		$('div.alert-danger').hide();
		if(code.val() == 0){		
			$('#op_class_add').prop('disabled', true);
			$('#time_div').hide();
			//$('#op_class_add').text("开关监控器");
		}else{
			$('#op_class_add').prop('disabled', false);
			$('#time_div').show();
			//console.log("code="+code.find("option:selected").text());
			$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/galleryquery/getSensorStatus",
			    data:{"sensor_code":code.find("option:selected").val()},
			    success: function(data) {
					var result = data.record;
					if(result){
						if(result.status == 0){
							status = 1;
							//$('#op_class_add').text("启动监控器");
							$('#op_class_add').attr('value', '0');
						}else{
							//$('#op_class_add').text("关闭监控器");
							$('#op_class_add').attr('value', '1');
							status = 0;
						}
					}else{
						showAlert('nosensoralert2');
					}
			    }
	        });
		}
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
	
       /* $(document).ready(function() {
       		$('#reportrange span').html(moment().subtract('days', 1).format('YYYY-MM-DD HH:mm:ss') + ' - ' + moment().format('YYYY-MM-DD HH:mm:ss'));

			$('#reportrange').daterangepicker({
	           timePicker: true,
	           timePickerIncrement: 30,
	           format: 'YYYY-MM-DD HH:mm:ss'
        	}, function(start, end, label) {
           console.log(start.toISOString(), end.toISOString(), label);
         });
      }); */
	
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
			      //设置日期菜单被选项  --结束--
		}
</script>

<jsp:include page="/WEB-INF/view/add/common/footer.jsp" flush="true" />	
	</body>
</html>