<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglib.jsp"%>
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
												<h5 class="widget-title lighter">设备状态</h5>
											</div>
											<div class="row" style="margin-top:5px;">
												<div class="col-md-2" style="width: 16%; margin-left:5px;margin-top:5px;">
													<select name="work_area_id"  id="work_area_class" 
														onchange="getWorkAreaSelect(this)" 
														class="form-control selectpicker">
														<option value='0'>---请选择工区---</option>
														</select>
												</div>
												
												 <div class="col-md-2" style="width: 16%;margin-left:5px;margin-top:5px;margin-bottom:5px;">
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
												<div class="col-md-2" style="width: 10%; margin: 0 5px;">
													<select id="warn_status" onchange="typeSelect()" class="form-control selectpicker" >
														<option value='0'>离线</option>
														<option value='1'>在线</option>
														<option value='2' selected>全部</option>
													</select>
												</div>
												
											</div>
											
										</div>
							</div>
							
						</div><!-- /.row -->
				</div>
			</div>
		</div><!-- /.main-container -->
		<!-- basic scripts -->
		<jsp:include page="/WEB-INF/view/common/basejs.jsp" flush="true" />
		
		<script type="text/javascript"> 
        $(document).ready(function () {
            getWorkArea();
			
        });
        
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
		command();
		updata();
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
						var index =1;
					    $.each(result, function(i,value){
					    	/* if(index==0 || index=='undefined'){
					     		index = 1;
					     	}else{
					     		if(index==value.id){
					     			index = i+1;
					     		}
					     	} */					     						    
					    	which.append("<option value='"+value.id+"'>"+value.op_name+"</option>"); 
					    });
					    
					   // which.get(0).selectedIndex=index;//index为索引值
					   	
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
		/* if(sindex == 0){
			isSelect('typealert',which);
		}else{
			getStation(which.value);
		} */
		$('#add_station').empty();
		$('#add_station').append("<option  value='0'>---请选择变电站---</option>");
		command();
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
					     	/* if(index==0 || index=='undefined'){
					     		index = 1;
					     	}else{
					     		if(index==value.id){
					     			index = i+1;
					     		}
					     	} */				     	
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
		
		command();
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
		command();
		//getCode(which.value);
		updata();
	}
	function updata(){  
	    //此处可以添加对查询数据的合法验证  
	    var workArea = $('#work_area_class').val();
		var op_class= $("#station_op_class").val();
		var station = $("#add_station").val();
		var building = $("#add_building").val();
		var status = $('#warn_status option:selected').val();
	    var name="${sessionScope.sysUser.name}";
	    $("#grid-table").jqGrid('setGridParam',{  
	        datatype:'json',  
	        postData:{'workarea':workArea,'username':name,"op_id":op_class,"station":station,"building":building,"status":status},//发送数据  
	        page:1  
	    }).trigger("reloadGrid"); //重新载入  
	}
	function command(){
		var name="${sessionScope.sysUser.name}";
       	var grid_selector = "#grid-table";
		var pager_selector = "#grid-pager";
		var status = $('#warn_status option:selected').val(); 
		var workArea = $('#work_area_class').val();
		var op_class= $("#station_op_class").val();
		var station = $("#add_station").val();
		var building = $("#add_building").val();
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
               url:'${context_path}/sensorlook/getSensorStatus',
               mtype: "GET",
               datatype: "json",
               postData:{'workarea':workArea,'username':name,"op_id":op_class,"station":station,"building":building,"status":status},
               colModel: [
               		{ label: '所属工区', name: 'area', width: 60  ,sortable:true},
               		{ label: '所属班组', name: 'op_name', width: 40  ,sortable:true},
                   { label: '所属变电站', name: 'station_name', width: 40 ,sortable:true},
                   { label: '所属设备间', name: 'building_name', width: 70 },
                   { label: '监控器编号', name: 'sensor_code', width: 70 ,sortable:false},
                   { label: '监控器名称', name: 'name', width: 80 },
                   { label: '设备状态', name: 'status',formatter:fmatterStatus, width: 50,sortable:true }, 
                    { label: '预设点数量', name: 'point_num', width: 45 },
                   /* { label: '守望点', name: 'platform_code', width: 70 }, */
                   { label: '辐射率', name: 'emittance', formatter:fmatterEmittance, width: 30 },
                   { label: '联动温度', name: 'threshold', width: 40 },
                   { label: '更新时间', name: 'create_time', width: 90,sortable:true },
               ],
				viewrecords: true,
               height: 350,
               rowNum: 10,
               //loadonce:true, //一次加载全部数据到客户端，由客户端进行排序。
               sortable: true,
               multiselect: true,//checkbox多选
               altRows: true,//隔行变色
               recordtext:"{0} - {1} 共 {2} 条",
               pgtext:"第 {0} 页 共 {1} 页",
               pager: pager_selector,
               loadComplete : function() {
				var table = this;
				console.log("获取到设备信息。");
				setTimeout(function(){
					updatePagerIcons(table);
				}, 0);
			}
           });
		$(window).triggerHandler('resize.jqGrid');
	}   
      
        //格式化状态显示
 		function fmatterStatus(cellvalue, options, rowObject){
 			if(cellvalue==0){
 				return '<span class="label label-sm label-success">失联</span>';
 			}else{
 				return '<span class="label label-sm label-warning">在线</span>';
 			}
 		}
 		
 		function fmatterEmittance(cellvalue, options, rowObject){
 			var emittance = (cellvalue/1000);
 			emittance = emittance.toFixed(2);
 			return '<span class="label label-sm label-info">'+emittance+'</span>';
 			
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
   </script>
   		
	</body>
</html>



