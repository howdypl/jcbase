<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<title>JC后台管理系统</title>
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

							
								<div class="row" style=" padding-top: 10px">
									<div class="col-md-3" style="width: 18%; margin: 0 20px;">
										<label class="form-label control-label">运维班：</label>
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

								</div>
								<div class="row" style="padding-bottom: 30px;">
									<div class="col-md-3" style="width: 18%; margin: 0 20px;">
										<select id="station_op_class"
											onchange="getOpClassSelect(this)"
											class="form-control selectpicker">
											<option value='0'>---请选择运维班---</option>
										</select>
									</div>
									<div class="col-md-3" style="width: 18%; margin: 0 20px;">
										<select id="add_station" onchange="managerSelect(this)"
											class="form-control selectpicker">
											<option value='0'>---请选择变电站---</option>
										</select>
									</div>
									<div class="col-md-3" style="width: 18%; margin: 0 20px;">
										<select id="add_building" onchange="typeSelect(this)"
											class="form-control selectpicker">
											<option value='0'>---请选择设备间---</option>
										</select>
									</div>
									<div class="col-md-3" style="width: 18%; margin: 0 20px;">
										<select id="add_sensor_code" onchange="timeSelect(this)"
											class="form-control selectpicker">
											<option value='0'>---请选择设备---</option>
										</select>
									</div>
								</div>
							<!-- PAGE CONTENT BEGINS -->
						<table id="grid-table"></table>

						<div id="grid-pager"></div>
						<!-- PAGE CONTENT ENDS -->
						</div>
						
					</div>
					<%-- <div class="col-xs-12">
						<div class="row-fluid" style="margin-bottom: 5px;">
							<div class="span12 control-group">
																		<jc:button className="btn btn-success" id="btn-visible" textName="启用"/>
								<jc:button className="btn btn-danger" id="btn-unvisible"
									textName="删除" />
								<jc:button className="btn btn-primary" id="btn-add"
									textName="添加" />
								<jc:button className="btn btn-info" id="btn-edit" textName="编辑" />
																		<jc:button className="btn" id="bnt-grant" textName="资源授权" permission="/sys/role"/>
							</div>
						</div>
						<!-- PAGE CONTENT BEGINS -->
						<table id="grid-table"></table>

						<div id="grid-pager"></div>
						<!-- PAGE CONTENT ENDS -->
					</div> --%>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
		</div>
	</div>
	<!-- /.main-container -->
	<!-- basic scripts -->
	<jsp:include page="/WEB-INF/view/common/basejs.jsp" flush="true" />

	<script type="text/javascript"> 
		 $(window).load(function(){
			 getOperationClass();
	   }); 
        function command(){
        	
        	var op_class= $("#station_op_class").val();
    		var station= $("#add_station").val();
    		var building = $("#add_building").val();
    		var sensor= $("#add_sensor_code").val();
    		
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
                postData:{'op_class':op_class,'station':station,'building':building,'sensor':sensor},
                colModel: [
                	{ label: '所属运维班', name: 'op_name', width: 60 },
                    { label: '所属变电站', name: 'station_name', width: 75 ,sortable:false},
                    { label: '所属设备间', name: 'building_name', width: 80 },
                    { label: '设备名称', name: 'sensorName', width: 100 ,sortable:false},
                    { label: '创建时间', name: 'create_time', width: 100 },
                    { label: '告警温度', name: 'max_temp', width: 40 },
                    { label: '操作', name: 'id',formatter:fmatterOperation, width:80,sortable:false}
                ],
				viewrecords: true,
                height: 280,
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
			/* $("#btn_search").click(function(){  
			    //此处可以添加对查询数据的合法验证  
			    var op_class= $("#station_op_class").val();
				var station= $("#add_station").val();
				var building = $("#add_building").val();
				var sensor= $("#add_sensor_code").val(); 
			    $("#grid-table").jqGrid('setGridParam',{  
			        datatype:'json',  
			        postData:{'op_class':op_class,'station':station,'building':building,'sensor':sensor},//发送数据  
			        page:1  
			    }).trigger("reloadGrid"); //重新载入  
			});  */
	/* 		$("#btn-add").click(function(){//添加页面
				parent.layer.open({
					title:'添加角色',
				    type: 2,
				    area: ['370px', '430px'],
				    fix: false, //不固定
				    maxmin: true,
				    content: '${context_path}/opclass/add'
				});
			}); */
// 			$("#bnt-grant").click(function(){
// 				var rid = getOneSelectedRows();
// 				if(rid == -1){
// 					layer.msg("请选择一个角色", {
// 					    icon: 2,
// 					    time: 2000 //2秒关闭（如果不配置，默认是3秒）
// 					});
// 				}else if(rid == -2 ){
// 					layer.msg("只能选择一个角色", {
// 					    icon: 2,
// 					    time: 2000 //2秒关闭（如果不配置，默认是3秒）
// 					});
// 				}else {
// 					if(rid==1){
// 						layer.msg("超级管理员资源不能被修改", {
// 						    icon: 2,
// 						    time: 2000 //2秒关闭（如果不配置，默认是3秒）
// 						});
// 						return;
// 					}
// 					var rowData = $("#grid-table").jqGrid('getRowData',rid);
// 					parent.layer.open({
// 						title:'给角色【'+rowData.name+'】分配资源',
// 					    type: 2,
// 					    area: ['380px', '430px'],
// 					    fix: false, //不固定
// 					    maxmin: true,
// 					    content: '${context_path}/sys/role/getZtree?roleId='+rid+'&type=1'
// 					});
// 				}
// 			});
// 			$("#btn-visible").click(function(){
// 				setVisible(1);
// 			});
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
					layer.msg("请选择一个运维班", {
					    icon: 2,
					    time: 2000 //2秒关闭（如果不配置，默认是3秒）
					});
				}else if(rid == -2 ){
					layer.msg("只能选择一个运维班", {
					    icon: 2,
					    time: 2000 //2秒关闭（如果不配置，默认是3秒）
					});
				}else {
					parent.layer.open({
						title:'修改运维班',
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
		function fmatterOperation(cellvalue, options, rowObject){
			return '<button class="btn btn-info" onclick="delete_data('+cellvalue+')">查看</button> <button class="btn btn-danger" onclick="delete_data('+cellvalue+')">删除</button>';
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
// 		//格式化状态显示
// 		function fmatterStatus(cellvalue, options, rowObject){
// 			if(cellvalue==0){
// 				return '<span class="label label-sm label-warning">禁用</span>';
// 			}else{
// 				return '<span class="label label-sm label-success">启用</span>';
// 			}
// 		}
		function reloadGrid(){
			$("#grid-table").trigger("reloadGrid"); //重新载入
		}
		function updata(){  
	    //此处可以添加对查询数据的合法验证  
	    var op_class= $("#station_op_class").val();
		var station= $("#add_station").val();
		var building = $("#add_building").val();
		var sensor= $("#add_sensor_code").val(); 
	    $("#grid-table").jqGrid('setGridParam',{  
	        datatype:'json',  
	        postData:{'op_class':op_class,'station':station,'building':building,'sensor':sensor},//发送数据  
	        page:1  
	    }).trigger("reloadGrid"); //重新载入  
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
						var result = data.oplist;
						var notEmpty = data.notempty;
						if(notEmpty){
							var index =1;
						    $.each(result, function(i,value){					     						    
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
						var result = data.stationRecords;
						var notEmpty = data.notempty;
						if(result){						
							var index =9;
						     $.each(result, function(i,value){					     	
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
						var result = data.buildingRecords;
						if(result){
							var index = 1;			
						     $.each(result, function(i,value){					  
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
			$.ajax({
				    type: 'POST',
				    dataType: 'json',
				    url: "<%=request.getContextPath()%>"+"/galleryquery/getSensorCode",
				    data:{//"room":room.val(),
				    	"building_id":building_id},
				    success: function(data) {
				    	var notEmpty = data.result;
						var result = data.records;
						
						if(notEmpty){
							var index = 5;
						     $.each(result, function(i,value){
						    	$('#add_sensor_code').append("<option value='"+value.sensor_code+"/"+value.point_type+"'>"+value.name+"("+value.platform_code+")</option>"); 
						    	
						    });
						    $('#add_sensor_code').get(0).selectedIndex=index;//index为索引值					   
							//var device = document.getElementById("add_sensor_code");// $('#add_sensor_code');				       
						}
						timeSelect();
				    }
		        });
		}
		function timeSelect(){	
			//daterangetimeplugin();
			command();
			updata();
		}
   </script>

</body>
</html>



