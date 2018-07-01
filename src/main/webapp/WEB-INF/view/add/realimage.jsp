<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<% System.setProperty("no_visible_elements", "false"); %>
<%@ include file="common/header.jsp" %>

<div>
    <ul class="breadcrumb">
        <li>
            <a href="/">主页</a>
        </li>
        <li>
            <a href="#">实时拍图</a>
        </li>
    </ul>
</div>

<div class="row">

    <div class="box col-md-12">
        <div class="box-inner">
            <div class="box-header well">
                <h2><i class="glyphicon glyphicon-list-alt"></i> 实时拍图</h2>

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

<!--       					<div hidden id="nolayeralert" class="form-group alert alert-danger"> -->
<!-- 					   		 <strong>警告:</strong>没有楼层信息，请先创建楼层！ -->
<!-- 						</div> -->
<!--       					<div hidden id="add_layer_div" class="form-inline row"> -->
<!--       						<div class="col-md-2"> -->
<!--       							<label class="form-label control-label">所属楼层</label> -->
<!--       						</div> -->
<!--       						<div class="col-md-6">	 -->
<!-- 	      						<select id="add_layer" onclick="roomSelect(this)" class="form-control selectpicker"> -->
<!--                         		<option  value='0'>---请选择楼层---</option> -->	 
<!-- 	                       		</select> -->
<!--                        		</div> -->
<!--       					</div> -->
      					
      					<!-- <div hidden id="noroomalert" class="form-group alert alert-danger">
					   		 <strong>警告:</strong>没有变电室信息，请先创建！
						</div>
      					<div hidden id="add_room_div" class="form-inline row">
      						<div class="col-md-2">
      							<label class="form-label control-label">所属变电室</label>
      						</div>
      						<div class="col-md-6">	
	      						<select id="add_room" onclick="roomSelect(this)" class="form-control selectpicker">
	                        		<option  value='0'>---请选择变电室---</option>
	                       		</select>
                       		</div>
      					</div> -->
      					
<!--       					<div hidden id="notypealert" class="form-group alert alert-danger"> -->
<!-- 					   		 <strong>警告:</strong>没有类型信息，请先创建！ -->
<!-- 						</div> -->
<!--       					<div hidden id="add_type_div" class="form-inline row"> -->
<!--       						<div class="col-md-2"> -->
<!--       							<label class="form-label control-label">所属类型</label> -->
<!--       						</div> -->
<!--       						<div class="col-md-6">	 -->
<!-- 	      						<select id="add_type" onclick="typeSelect(this)" class="form-control selectpicker"> -->
<!--                       		<option  value='0'>---请选择监控器类型---</option>  -->	  
<!-- 	                       		</select> -->
<!--                        		</div> -->
<!--       					</div> -->
      					
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
      					<div hidden id="nocolouralert" class="form-group alert alert-danger">
					   		 <strong>警告:</strong>没有配置色带，请先添加！
						</div>
						<div hidden id="nocolouralert2" class="form-group alert alert-danger">
					   		 <strong>警告:</strong>该色带不存在，请确认！
						</div>
      					<div hidden id = "colour_code_div" class="form-inline row">
      						<div class="col-md-2">
        						<label class="form-label control-label">视频色带</label>
        					</div> 
        					<div class="col-md-4">
        						<select id="add_colour_code" onclick="colourSelect(this)" class="form-control selectpicker">
	                        		<option  value='0'>----请选择一种色带----</option>
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
      					<div id = "image_show_div" class="form-inline row">
      						
      					</div>

                    <button id="op_class_add" type="button" onclick="command(this)" class="btn btn-success btn-lg" value="0" disabled><i
                                class="glyphicon glyphicon-picture glyphicon-white"></i>实时抓取图片</button>
                    <br>
                </div>    
            </div>
        </div>
    </div>
</div><!--/row-->

<script type="text/javascript" src="js/highchart/highcharts.js"></script>
<script type="text/javascript" src="js/highchart/exporting.js"></script>

<script type="text/javascript">
   $(window).load(function(){
		getOperationClass();
		// $('#op_class_add').text("打开实时视频监控");
    });
    
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
		// var colour = parentdiv.find("#add_colour_code");
		// var timeArray = $('#reportrange span').html().split(" - ");
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    async: false,
			    url: "<%=request.getContextPath()%>"+"/realimage/createImage",
			    data: {"type":type.val(),
			    		"sensor_code":sensor_code.find("option:selected").val(),
			    		"station_op":station_op.val(),
			    		"station":station.val(),
			    		"building":building.val(),
			    		"layer":layer.val(),
			    		"room":room.val(),
			    		"status":status},
			    timeout:10000,
			    success: function(data) {
			    	// var source = station.val()+'--'+building.val()+'--'+layer.val()+'--'+room.val();
					var result = data.result;
					var record = data.record;
					if(result){
						
			            $.toaster.reset();
			            $.toaster({priority : 'success', title : '提示信息', message : '图片抓取命令已经下发，请稍等！'});
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
	    
	    hiddleComp('typealert',which);
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

// 	function buildingSelect(which){
// 		var sindex = which.selectedIndex;
// 		if(sindex == 0){
// 			$('#add_layer_div').hide();

// 		}else{
// 			$('#add_layer_div').show();

// 			getLayer(which.value);
// 		}
		
// 		$('#add_room_div').hide();
// 		$('#add_type_div').hide();
// 		$('#sensor_code_div').hide();	
// 		$('#op_class_add').prop('disabled', true);
// 	}
	
// 	function getLayer(op){
		
// 		var which = $('#add_layer');
		
// 		$(which).empty();
// 		$(which).append("<option  value='0'>---请选择楼层---</option>");
// 		var para = op;
// 		$.ajax({
// 			    type: 'POST',
// 			    dataType: 'json',
<%-- 			    url: "<%=request.getContextPath()%>"+"/room/getLayer", --%>
// 			    data:{"layer":para},
// 			    success: function(data) {
// 					var result = data.layerRecords;
// 					if(result){
// 						hiddleComp('nolayeralert',which);
// 					     $.each(result, function(i,value){
					     	
// 					    	//$('#operationclass').options.add(new Option(value.op_name,value.id));
// 					    	//console.log(value.id+"--"+value.user_name);
// 					    	//$('#operationclass').append("<option value='"+value.id+"'"+">"+value.op_name+"</option>");
// 					    	$(which).append("<option value='"+value.id+"'>"+value.layer_name+"</option>"); 
// 					    });
// 					}else{
// 						showAlert('nolayeralert');
// 						$('#add_layer_div').hide();
// 					}
// 			    }
// 	        });
// 	}
	
// 	function layerSelect(which){
// 		var sindex = which.selectedIndex;
		
// 		if(sindex == 0){			
// 			$('#add_room_div').hide();
			
// 		}else{
// 			$('#add_room_div').show();
			
// 			getRoom(which.value);
// 		}
// 		$('#add_type_div').hide();
// 		$('#sensor_code_div').hide();
// 		$('#op_class_add').prop('disabled', true);
// 	}
	
// 	function getRoom(op){
		
// 		var which = $('#add_room');
		
// 		$(which).empty();
// 		$(which).append("<option  value='0'>---请选择变电室---</option>");
		
// 		var para = op;
// 		$.ajax({
// 			    type: 'POST',
// 			    dataType: 'json',
<%-- 			    url: "<%=request.getContextPath()%>"+"/room/getRoom", --%>
// 			    data:{"layer":para},
// 			    success: function(data) {
// 					var result = data.roomRecords;
// 					if(result){
// 						hiddleComp('noroomalert',which);
// 					     $.each(result, function(i,value){
					     	
// 					    	//$('#operationclass').options.add(new Option(value.op_name,value.id));
// 					    	//console.log(value.id+"--"+value.user_name);
// 					    	//$('#operationclass').append("<option value='"+value.id+"'"+">"+value.op_name+"</option>");
// 					    	$(which).append("<option value='"+value.id+"'>"+value.room_name+"</option>"); 
// 					    });
// 					}else{
// 						showAlert('noroomalert');
// 						$('#add_room_div').hide();
// 					}
// 			    }
// 	        });
// 	}

// 	function roomSelect(which){
// 		var sindex = which.selectedIndex;
		
// 		if(sindex == 0){		
		
// 			$('#add_type_div').hide();
// 		}else{
// 			$('#add_type_div').show();
			
// 			getType(which.value);
// 		}
// 		$('#sensor_code_div').hide();
// 		$('#op_class_add').prop('disabled', true);
// 	}
	
// 	function getType(op){
		
// 		var which = $('#add_type');
		
// 		$(which).empty();
// 		$(which).append("<option  value='0'>---请选择监控器类型---</option>");
		
// 		var para = op;
// 		$.ajax({
// 			    type: 'POST',
// 			    dataType: 'json',
<%-- 			    url: "<%=request.getContextPath()%>"+"/temp/getSensorType", --%>
// 			    data:{"room":para},
// 			    success: function(data) {
// 					var result = data.sensorTypeList;
// 					if(result){
// 						hiddleComp('notypealert',which);
// 					     $.each(result, function(i,value){
					     	
// 					    	//$('#operationclass').options.add(new Option(value.op_name,value.id));
// 					    	//console.log(value.id+"--"+value.user_name);
// 					    	//$('#operationclass').append("<option value='"+value.id+"'"+">"+value.op_name+"</option>");
// 					    	$(which).append("<option value='"+value.id+"'>"+value.type_name+"</option>"); 
// 					    });
// 					}else{
// 						showAlert('notypealert');
// 						$('#add_type_div').hide();
// 					}
// 			    }
// 	        });
// 	}
	
	function typeSelect(which){
	
		
		var sindex = which.selectedIndex;
		if(sindex == 0){		
		
			$('#sensor_code_div').hide();
		}else{
			$('#sensor_code_div').show();
			getCode(which);
		}
		
		$('#op_class_add').prop('disabled', true);
	}
	
	function getCode(op){
		
		var which = $(op);
		
		
		var parentdiv = $(which).parents('.box-content');

// 		var room = parentdiv.find("#add_room");
// 		var sensor_type = parentdiv.find("#add_type");
        var building_id = parentdiv.find("#add_building");
		$('#add_sensor_code').empty();
		$('#add_sensor_code').append("<option  value='0'>---请选择监控器编号---</option>");
		
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/temp/getSensorCode",
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
		//console.log("code-index="+code.val());
		if(code.val() == 0){
			$('#colour_code_div').hide();
			$('#op_class_add').prop('disabled', true);
			//$('#op_class_add').text("开关监控器");
		}else{
			$('#op_class_add').prop('disabled', false);
			
			// daterangetimeplugin();
			//console.log("code="+code.find("option:selected").text());

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
	
	//获取焦点后，隐藏告警信息
	function hiddleComp(comp){
		//$('#passalert').addClass("hidden");
		var selected = "#"+comp;
		$(selected).hide();
	}
	

	function exeCMD(cmd) {
		b = new ActiveXObject("wscript.shell");
		b.run(cmd)
	}
</script>

<%@ include file="common/footer.jsp" %>

