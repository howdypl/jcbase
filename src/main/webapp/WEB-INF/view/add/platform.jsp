<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<% System.setProperty("no_visible_elements", "false"); 
%>
<%
	String virtualImages = "/backenduploadinf";
	String baseImagePath = request.getScheme()+"://"
			+request.getServerName()+":"
			+request.getServerPort()+virtualImages+"/"; %>
<%@ include file="common/header.jsp" %>
<link href='${res_url}cssto/bootstrap-combined.min.css' rel='stylesheet' type='text/css'>
<div class="row">

    <div class="box col-md-12">
        <div class="box-inner">
            <div class="box-header well">
                <h2><i class="glyphicon glyphicon-list-alt"></i> 云台控制</h2>

            </div>
            <div class="box-content">
				<div class="row" style="padding-top: 10px">
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

				</div>
				<div class="row" style="padding-bottom: 30px;">
					<div class="col-md-3" style="width: 18%; margin: 0 20px;">
						<select id="station_op_class" onchange="getOpClassSelect(this)"
							class="form-control selectpicker">
							<option value='0'>---请选择班组---</option>
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
				<div hidden id="platform_code_div" class="form-inline row">
					<div class="col-md-2">
						<label style="padding-left: 20px;">云台预设点</label>
					</div>
					<div class="col-md-8" style="padding-left: inherit;">
						<div id="platform_checkbox"></div>
						<div id="platform_checkbox_button"></div>
					</div>

					<div class="col-md-2">
						<span class='availability_status'></span>
					</div>
				</div>
				<div class="row">
					<span> &nbsp;&nbsp;</span>
				</div>
				<div hidden id="image_show_div" class="form-inline row">
					<ul id="myquerygallery" class="thumbnails gallery">

					</ul>
				</div>
				<button id="op_class_add" type="button" onclick="command(this)" class="btn btn-success btn-lg" value="0" disabled><i
                                class="glyphicon glyphicon-hdd glyphicon-white"></i>动态拍图</button>
				<span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
				<button id="platform_scan" type="button" onclick="cmdScan(this)" class="btn btn-success btn-lg" value="0" disabled><i
                                class="glyphicon glyphicon-hdd glyphicon-white"></i>扫描预设点</button>
				
                    <br> 
            
            </div>
        </div>
    </div>


</div><!--/row-->

<div id ='tempdatarow' class="row">

    <div class="box col-md-12">
        <div class="box-inner">
            <div class="box-header well">
                <h2><i class="glyphicon glyphicon-dashboard"></i> 抓图时刻设置</h2>

            </div>

            <div id="mytabledata" class="box-content">
			    		
				
			  <div id="datetimepicker3" class="input-append">
			    <input id="time_point" type="text" ></input>
			    <span class="add-on">
			      <i data-time-icon="icon-time" data-date-icon="icon-calendar">
			      </i>
			    </span>
			  </div>
			  
			  <div class="row">
      						<span> &nbsp;&nbsp;</span>
      		  </div> 
			   <button id="add_times" type="button" onclick="command2(this)" class="btn btn-success btn-lg" value="0" disabled><i
                       class="glyphicon glyphicon-time glyphicon-white"></i>添加时间任务</button>
               <span> &nbsp;&nbsp;&nbsp;&nbsp;</span>
               <button id="set_times" type="button" onclick="submitTimes(this)" class="btn btn-danger btn-lg" value="0" disabled><i
                       class="glyphicon glyphicon-time glyphicon-white"></i>下发时间任务集</button>
               <div class="row">
      				<span> &nbsp;&nbsp;</span>
      		   </div>
               
				<table id="userTable2" class="table table-striped table-bordered bootstrap-datatable datatable responsive text-nowrap">
				    <thead>
				    <tr id="table_tr">
				    	<th>时刻选定</th>
				    	<th>序号</th>
				    	<th>监控器编号</th>
				    	<th>监控器名称</th>
				        <th>设置的时刻</th>
				        <th>创建时间</th>
				        <th>操作</th>
				    </tr>
				    </thead>
					
			    </table>
            </div>
        </div>
    </div>


</div><!--/row-->

<%-- <script type="text/javascript" src="${res_url}jsto/highchart/highcharts.js"></script>
<script type="text/javascript" src="${res_url}jsto/highchart/exporting.js"></script> --%>

<script type="text/javascript">
   $(window).load(function(){

	   getOperationClass();
		
		$('#datetimepicker3').datetimepicker({
	    	format: 'hh:mm:ss',
	      	pickDate: false
    	});

    });
    
    function checkChanged() {

     	var obj = document.getElementsByName("mypcode");//选择所有name="mypcode"的对象，返回数组
        //var s='';//如果这样定义var s;变量s中会默认被赋个null值
        var ul=$("ul.thumbnails");//获取所有的li元素 
        var lis = ul.children('li.thumbnail');
        var tag = false;
        var select_tag = new Array(obj.length);
        var select = 0;
        for(var i=0;i<obj.length;i++){

             if(obj[i].checked){ //取到对象数组后，我们来循环检测它是不是被选中
             	// s+=obj[i].value+','; //如果选中，将value添加到变量s中    
             	// $("ul li[class='thumbnail']").eq(i).show();
             	lis.eq(i).show();
             	tag = true;
             	select_tag[i] = 1;
             	select |= (0x00000001<<i);
             }else {
             	lis.eq(i).hide();
             	select_tag[i] = 0;
             }
        }
        if(tag){
        	$('#op_class_add').prop('disabled', false);
        	$('#platform_scan').prop('disabled', false);
        }else{
        	$('#op_class_add').prop('disabled', true);
        	$('#platform_scan').prop('disabled', true);
        }
		return select;
    }

    var status = 0;
	function command(which){
		var parentdiv = $(which).parents('.box-content');
		
		var type = parentdiv.find("#add_type");
		var sensor_code = parentdiv.find("#add_sensor_code");
		var station_op = parentdiv.find("#station_op_class");
		var station = parentdiv.find("#add_station");
		var building = parentdiv.find("#add_building");
		var layer = parentdiv.find("#add_layer");
		var room = parentdiv.find("#add_room");
		var colour = parentdiv.find("#add_angle_code");
		// var timeArray = $('#reportrange span').html().split(" - ");
		var platform = checkChanged();
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    async: false,
			    url: "<%=request.getContextPath()%>"+"/platform/setPlatform",
			    data: {"type":type.val(),
			    		"sensor_code":sensor_code.find("option:selected").val(),
			    		"station_op":station_op.val(),
			    		"station":station.val(),
			    		"building":building.val(),
			    		"layer":layer.val(),
			    		"room":room.val(),
			    		"status":status,
			    		"platform":platform},
			    timeout:10000,
			    success: function(data) {
			    	// var source = station.val()+'--'+building.val()+'--'+layer.val()+'--'+room.val();
					var result = data.result;
					// var record = data.record;
					if(result){
						/* var port = record.port;
					    // 加入调用命令
					    var commond = "ffplay -f h264 udp://192.168.1.118:"+port;
					    // var commond = "calc"
			            console.log(commond);
			            // exeCMD(command); */
			            $.toaster.reset();
			            $.toaster({priority : 'success', title : '提示信息', message : '云台已经转动，请稍等！'});
					}else{ //添加失败
		                $.toaster({ priority : 'warning', title : '告警信息', message : '没有数据报告！'});
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
	
	function cmdScan(which){
		var parentdiv = $(which).parents('.box-content');
		
		var type = parentdiv.find("#add_type");
		var sensor_code = parentdiv.find("#add_sensor_code");
		var station_op = parentdiv.find("#station_op_class");
		var station = parentdiv.find("#add_station");
		var building = parentdiv.find("#add_building");
		var layer = parentdiv.find("#add_layer");
		var room = parentdiv.find("#add_room");
		var colour = parentdiv.find("#add_angle_code");
		// var timeArray = $('#reportrange span').html().split(" - ");
		var platform = checkChanged();
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    async: false,
			    url: "<%=request.getContextPath()%>"+"/platform/scanPlatform",
			    data: {"type":type.val(),
			    		"sensor_code":sensor_code.find("option:selected").val(),
			    		"station_op":station_op.val(),
			    		"station":station.val(),
			    		"building":building.val(),
			    		"layer":layer.val(),
			    		"room":room.val(),
			    		"status":status,
			    		"platform":platform},
			    timeout:10000,
			    success: function(data) {
			    	// var source = station.val()+'--'+building.val()+'--'+layer.val()+'--'+room.val();
					var result = data.result;
					// var record = data.record;
					if(result){
						/* var port = record.port;
					    // 加入调用命令
					    var commond = "ffplay -f h264 udp://192.168.1.118:"+port;
					    // var commond = "calc"
			            console.log(commond);
			            // exeCMD(command); */
			            $.toaster.reset();
			            $.toaster({priority : 'success', title : '提示信息', message : '扫描预设点命令已经下发，请稍等！'});
					}else{ //添加失败
		                $.toaster({ priority : 'warning', title : '告警信息', message : '命令没有成功！'});
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
	
	// 添加任务时刻点
	function command2(which){
		var parentdiv = $('#op_class_add').parents('.box-content');
		
		var type = parentdiv.find("#add_type");
		var sensor_code = parentdiv.find("#add_sensor_code");
		var station_op = parentdiv.find("#station_op_class");
		var station = parentdiv.find("#add_station");
		var building = parentdiv.find("#add_building");
		var layer = parentdiv.find("#add_layer");
		var room = parentdiv.find("#add_room");
		var colour = parentdiv.find("#add_angle_code");
		var add_time = $("#time_point");
		// var timeArray = $('#reportrange span').html().split(" - ");
		var platform = checkChanged();
		clearData();
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    async: false,
			    url: "<%=request.getContextPath()%>"+"/platform/setTimePlatform",
			    data: {"type":type.val(),
			    		"sensor_code":sensor_code.find("option:selected").val(),
			    		"station_op":station_op.val(),
			    		"station":station.val(),
			    		"building":building.val(),
			    		"layer":layer.val(),
			    		"room":room.val(),
			    		"status":status,
			    		"sensor_name":sensor_code.find("option:selected").text(),
			    		"add_time":add_time.val()},
			    timeout:10000,
			    success: function(data) {
			    	// var source = station.val()+'--'+building.val()+'--'+layer.val()+'--'+room.val();
					var result = data.result;
					var dataList = data.records;
					if(result){
						
						 $.each(dataList, function(i,value){
						 	var checkbox;
						 	if(value.status == 1){
						 		$('#set_times').prop('disabled', false);
						 		checkbox = "<input checked OnClick='timeCheckChanged(this)' id='"+value.id+"' type='checkbox' name='timeselect' /> ";
						 	}else {
						 		checkbox = "<input OnClick='timeCheckChanged(this)' id='"+value.id+"' type='checkbox' name='timeselect' /> ";
						 	}
						 	
						 	var deleteButton = "<button class='btn btn-danger' onclick='deleteTimeItem("+value.id+")'><i class='glyphicon glyphicon-trash icon-white'></i>删除  </button>"
						 	$('#userTable2').DataTable().row.add([checkbox, value.id,value.sensor_code, value.sensor_name, value.time,value.create_time,deleteButton]).draw( false );
						 });
						
			            $.toaster.reset();
			            $.toaster({priority : 'success', title : '提示信息', message : '拍图时刻设置成功，请稍等！'});
					}else{ //添加失败
		                $.toaster({ priority : 'warning', title : '告警信息', message : '没有数据报告！'});
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
	
	function clearData(){
		// document.getElementById("container").innerHTML = "";
		$('#userTable2').DataTable().clear().draw();
	}
	
	// 下发任务时刻集合
	function submitTimes(which){
		
		var parentdiv = $('#op_class_add').parents('.box-content');
		var type = parentdiv.find("#add_type");
		var sensor_code = parentdiv.find("#add_sensor_code");
		var station_op = parentdiv.find("#station_op_class");
		var station = parentdiv.find("#add_station");
		var building = parentdiv.find("#add_building");
		var layer = parentdiv.find("#add_layer");
		var room = parentdiv.find("#add_room");
		var colour = parentdiv.find("#add_angle_code");

		clearData();
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    async: false,
			    url: "<%=request.getContextPath()%>"+"/platform/submitTimePlatform",
			    data: {"sensor_code":sensor_code.find("option:selected").val(),
			    		"station_op":station_op.val(),
			    		"station":station.val(),
			    		"building":building.val(),
			    		"layer":layer.val(),
			    		"room":room.val(),
			    		"sensor_name":sensor_code.find("option:selected").text()},
			    timeout:10000,
			    success: function(data) {
			    	// var source = station.val()+'--'+building.val()+'--'+layer.val()+'--'+room.val();
					var result = data.result;
					var dataList = data.records;
					if(result){
						
						 $.each(dataList, function(i,value){
							var checkbox;
						 	if(value.status == 1){
						 		$('#set_times').prop('disabled', false);
						 		checkbox = "<input checked OnClick='timeCheckChanged(this)' id='"+value.id+"' type='checkbox' name='timeselect' /> ";
						 	}else {
						 		checkbox = "<input OnClick='timeCheckChanged(this)' id='"+value.id+"' type='checkbox' name='timeselect' /> ";
						 	}
						 	
						 	var deleteButton = "<button class='btn btn-danger' onclick='deleteTimeItem("+value.id+")'><i class='glyphicon glyphicon-trash icon-white'></i>删除  </button>"
						 	$('#userTable2').DataTable().row.add([checkbox, value.id,value.sensor_code, value.sensor_name, value.time,value.create_time,deleteButton]).draw( false );
						 });
						
			            $.toaster.reset();
			            $.toaster({priority : 'success', title : '提示信息', message : '拍图时刻设置成功，请稍等！'});
					}else{ //添加失败
		                $.toaster({ priority : 'warning', title : '告警信息', message : '没有数据报告！'});
		                return false;
		            }
					
			    },
			    error:function(){
			    	$.toaster({ priority : 'danger', title : '错误信息', message : '请求错误，请确认路径正确或网络正常！'});
			    	//$('#addModal').modal("hide");
			    }
	        });
	        return false;
		
	
	}
	
	// 每次判断“时刻的状态”的变化，并根据状态变化，更新数据库，并改变时刻点按钮
	function timeCheckChanged(which) {
		var parentdiv = $('#op_class_add').parents('.box-content');
		var sensor_code = parentdiv.find("#add_sensor_code");
	
		var status = 0;
		 if(which.checked){
		 	status = 1;
		 }else {
		 	status = 0;
		 }
		
		$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    async: false,
		    url: "<%=request.getContextPath()%>"+"/platform/updateTimeStatus",
		    data: {"sensor_code":sensor_code.find("option:selected").val(),
		    		"id": which.id,
		    		"status":status},
		    timeout:10000,
		    success: function(data) {
		    	// var source = station.val()+'--'+building.val()+'--'+layer.val()+'--'+room.val();
				var result = data.result;
				if(result){
		            $.toaster({priority : 'success', title : '提示信息', message : '更新时刻设置状态成功，请稍等！'});
				}else{ //添加失败
	                $.toaster({ priority : 'warning', title : '告警信息', message : '没有数据报告！'});
	                return false;
	            }
				
		    },
		    error:function(){
		    	$.toaster({ priority : 'danger', title : '错误信息', message : '请求错误，请确认路径正确或网络正常！'});
		    	//$('#addModal').modal("hide");
		    }
        });
		
		
     	var obj = document.getElementsByName("timeselect");//选择所有name="mypcode"的对象，返回数组
        //var s='';//如果这样定义var s;变量s中会默认被赋个null值
		
        var tag = false;
        var select_tag = new Array(obj.length);
        var select = 0;
        for(var i=0;i<obj.length;i++){

             if(obj[i].checked){ //取到对象数组后，我们来循环检测它是不是被选中
             	tag = true;
             	select_tag[i] = obj[i].id;
             }else {
             	select_tag[i] = 0;
             }
        }
        if(tag){
        	$('#set_times').prop('disabled', false);
        }else{
        	$('#set_times').prop('disabled', true);
        }
		return select_tag;
    }
	
	function getOperationClass(){
		var which = $('#station_op_class');
		$(which).empty();
		$(which).append("<option value='0'>---请选择班组---</option>"); 
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
						var index =1; // 设置默认选择的班组
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
						var index =1; // 设置默认选择的变电站
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
						var index = 1;			
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
			    url: "<%=request.getContextPath()%>"+"/temp/getSensorCode",
			    data:{//"room":room.val(),
			    	"building_id":building_id},
			    success: function(data) {
			    	var notEmpty = data.result;
					var result = data.content;
					
					if(notEmpty){
						var index = 1;
					     $.each(result, function(i,value){
					     	if(index==0 || index=='undefined'){
					     		index = 1;
					     	}else{
					     		if(index==value.id){
					     			index = i+1;
					     		}
					     	}
					    	$('#add_sensor_code').append("<option value='"+value.sensor_code+"'>"+value.name+"</option>"); 
					    	
					    });
					    $('#add_sensor_code').get(0).selectedIndex=index;//index为索引值					   
						var device = document.getElementById("add_sensor_code");// $('#add_sensor_code');	
						timeSelect(device);
					}
					
			    }
	        });
	}	
	function timeSelect(which){
		clearData();
		var code = $(which);
		var sindex = which.selectedIndex;
		//console.log("code-index="+code.val());
		$('div.alert-danger').hide(); 
		if(code.val() == 0){
			$('#add_times').prop('disabled', true);
			$('#platform_code_div').hide();
			$('#image_show_div').hide();
		}else{
			
			$('#platform_code_div').show();
			$('#image_show_div').show();
			getExistingTime();
			getPlaform();
			// daterangetimeplugin();
			//console.log("code="+code.find("option:selected").text());
			$('#add_times').prop('disabled', false);
		}
		
		// $('#op_class_add').prop('disabled', true);
	}
	
	// 当选择监控器编号后，加载数据库中的已有的时刻点
	function getExistingTime(){
		var parentdiv = $('#op_class_add').parents('.box-content');
		
		var type = parentdiv.find("#add_type");
		var sensor_code = parentdiv.find("#add_sensor_code");
		var station_op = parentdiv.find("#station_op_class");
		var station = parentdiv.find("#add_station");
		var building = parentdiv.find("#add_building");
		var layer = parentdiv.find("#add_layer");
		var room = parentdiv.find("#add_room");
		var colour = parentdiv.find("#add_angle_code");
		clearData();
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    async: false,
			    url: "<%=request.getContextPath()%>"+"/platform/getTimePlatform",
			    data: {"type":type.val(),
			    		"sensor_code":sensor_code.find("option:selected").val(),
			    		"station_op":station_op.val(),
			    		"station":station.val(),
			    		"building":building.val(),
			    		"layer":layer.val(),
			    		"room":room.val()},
			    timeout:10000,
			    success: function(data) {
			    	// var source = station.val()+'--'+building.val()+'--'+layer.val()+'--'+room.val();
					var result = data.result;
					var dataList = data.records;
					if(result){
						
						 $.each(dataList, function(i,value){
						 	var checkbox;
						 	if(value.status == 1){
						 		$('#set_times').prop('disabled', false);
						 		checkbox = "<input checked OnClick='timeCheckChanged(this)' id='"+value.id+"' type='checkbox' name='timeselect' /> ";
						 	}else {
						 		checkbox = "<input OnClick='timeCheckChanged(this)' id='"+value.id+"' type='checkbox' name='timeselect' /> ";
						 	}
						 	
						 	var deleteButton = "<button class='btn btn-danger' onclick='deleteTimeItem("+value.id+")'><i class='glyphicon glyphicon-trash icon-white'></i>删除  </button>"
						 	$('#userTable2').DataTable().row.add([checkbox, value.id,value.sensor_code, value.sensor_name, value.time,value.create_time,deleteButton]).draw( false );
						 });
						
						
			            $.toaster.reset();
			            $.toaster({priority : 'success', title : '提示信息', message : '获取拍图的时刻集合成功！'});
					}else{ //添加失败
		                $.toaster({ priority : 'warning', title : '告警信息', message : '没有拍图时间任务报告！'});
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
	
	// 删除深刻点
	function deleteTimeItem(id) {
		clearData();
		
		var sensor_code = $("#add_sensor_code");
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    async: false,
			    url: "<%=request.getContextPath()%>"+"/platform/deleteTimePlatform",
			    data: {"id":id,
			    	   "sensor_code":sensor_code.find("option:selected").val()},
			    timeout:10000,
			    success: function(data) {
			    	// var source = station.val()+'--'+building.val()+'--'+layer.val()+'--'+room.val();
					var result = data.result;
					var dataList = data.records;
					if(result){
						
						 $.each(dataList, function(i,value){
						 	var checkbox;
						 	if(value.status == 1){
						 		$('#set_times').prop('disabled', false);
						 		checkbox = "<input checked OnClick='timeCheckChanged(this)' id='"+value.id+"' type='checkbox' name='timeselect' /> ";
						 	}else {
						 		checkbox = "<input OnClick='timeCheckChanged(this)' id='"+value.id+"' type='checkbox' name='timeselect' /> ";
						 	}
						 	
						 	var deleteButton = "<button class='btn btn-danger' onclick='deleteTimeItem("+value.id+")'><i class='glyphicon glyphicon-trash icon-white'></i>删除  </button>"
						 	$('#userTable2').DataTable().row.add([checkbox, value.id,value.sensor_code, value.sensor_name, value.time,value.create_time,deleteButton]).draw( false );
						 });
						
						
			            $.toaster.reset();
			            $.toaster({priority : 'success', title : '提示信息', message : '已删除！'});
					}else{ //添加失败
		                $.toaster({ priority : 'warning', title : '告警信息', message : '没有数据报告！'});
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
	
	// 获得所有平台预设点
	function getPlaform(){
		var sensor_code = $("#add_sensor_code");

		$('#platform_checkbox').html("");
		// $('#add_angle_code').append("<option  value='0'>---请选择云台设置点---</option>");
		$('#platform_checkbox_button').html("");
		var ul=document.getElementById("myquerygallery");//获取所有的li元素 
		ul.innerHTML = "";
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/platform/getPlatform",
			    data:{"sensor_code":sensor_code.find("option:selected").val()},
			    success: function(data) {
			    	var notEmpty = data.result;
					var result = data.records;
					// console.log("notEmpty = "+notEmpty);
					if(notEmpty){
						hiddleComp('nocolouralert');
						var tag = 0;
						var index = 1;
					     $.each(result, function(i,value){
					     	//设置查询条件初始值
					     	if(index==0 || index=='undefined'){
					     		index = 1;
					     	}else{
					     		if(index==value.id){
					     			index = i+1;
					     		}
					     	}					     
					     
					    	if(value.status > 0){
					    		tag = 1;
					    		$('#platform_checkbox').append("<input OnClick='checkChanged()' type='checkbox' id='"+value.id+" class='styled' value='"+value.id+"' name='mypcode' checked='checked'/>"+value.platform_code+"&nbsp;&nbsp;&nbsp;");
						    }else {
						    	$('#platform_checkbox').append("<input OnClick='checkChanged()' type='checkbox' id='"+value.id+" class='styled' value='"+value.id+"' name='mypcode'/>"+value.platform_code+"&nbsp;&nbsp;&nbsp;");
						    }
						    // 未选择预设点，转动云台按钮为不可选，只有选择了预设点
						    if(tag > 0){
						    	$('#op_class_add').prop('disabled', false);
						    	$('#platform_scan').prop('disabled', false);
						    }else if(tag == 0){
						    	$('#op_class_add').prop('disabled', true);
						    	$('#platform_scan').prop('disabled', true);
						    }
					    	var paths="<%=baseImagePath%>";
					    	if(value.images!=0){
					    	    paths += value.images;
					    	}
					    	else{
					    	    paths = "${res_url}img/noimage.jpg";
					    	}
					    	var backgroud = "background:url('"+paths+"')";
					    	var temp = document.createElement("li"); 
					     	temp.id = value.id;
					     	temp.className = "thumbnail";
					     	ul.appendChild(temp);					     	
					     	var tempa = document.createElement("a"); 
					     	tempa.href= paths;
					     	if(value.images==0){
					     	    tempa.title = "图片未上传";
					     	}
					     	else{
					     	    tempa.title = value.images;
					     	}   
					     	tempa.style=backgroud;
					     	tempa.className="gallery";
					     	//tempa.innerHTML=value.images;
					     	temp.appendChild(tempa);
					     	var tempimg = document.createElement("img"); 
					     	tempimg.src= paths;
					     	tempimg.className="gallery";
					     	tempa.appendChild(tempimg);
					     	//console.log("backgroud="+backgroud);
					    });
					    $("a.gallery").colorbox({
							"rel":"gallery"
						}); 
					    $('#platform_checkbox_button').append("<div class='row'><span> &nbsp;&nbsp;</span></div> <input id='checkbox_select' OnClick='selectAll()' name='mypcode' type='button' class='btn btn-primary' value='反选'>")
					    //console.log("checkbox_button--反选2！");
					}else{
						showAlert('nocolouralert');
						$('#platform_code_div').hide();
						$('#image_show_div').hide();
						$('#platform_checkbox_button').html("");
					}
			    }
	        });
	}

	//全选、取消全选的事件  
	function selectAll(){ 
	    //console.log($("input[type='checkbox'][name='mypcode']").prop("checked"));
	    if ($("input[type='checkbox'][name='mypcode']").prop("checked")) {

	        $("input[type='checkbox'][name='mypcode']").prop("checked",false);//取消全选 
	    } else { 
             
	        $("input[type='checkbox'][name='mypcode']").prop("checked",true);  //全选 
	    } 
	    
	    checkChanged();
	}  


	function colourSelect(which){
		var code = $(which);
			
		var parentdiv = code.parents('.box-content');
		var sensor = parentdiv.find("#add_sensor_code");
		
		var image = parentdiv.find("#image_show_div");
		image.html("");
		var sindex = which.selectedIndex;
		//console.log("code-index="+code.val());
		if(code.val() == 0){
			$('#op_class_add').prop('disabled', true);
			$('#platform_scan').prop('disabled', true);
			$('#image_show_div').hide();
			//$('#op_class_add').text("开关监控器");
		}else{
			$('#op_class_add').prop('disabled', false);
			$('#platform_scan').prop('disabled', false);
			// $('#platform_code_div').show();
			// daterangetimeplugin();
			//console.log("code="+code.find("option:selected").text());
			$('#image_show_div').show();
			var imgNode=document.createElement('img');
			$('#image_show_div').append(imgNode);
			imgNode.src = "../img/show_img/"+code.val()+".jpg";
			$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/temp/getSensorStatus",
			    data:{"sensor_code":sensor.find("option:selected").val()},
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
	
	//获取焦点后，隐藏告警信息
	function hiddleComp(comp){
		//$('#passalert').addClass("hidden");
		var selected = "#"+comp;
		$(selected).hide();
	}
	

</script>

<%@ include file="common/footer.jsp" %>

