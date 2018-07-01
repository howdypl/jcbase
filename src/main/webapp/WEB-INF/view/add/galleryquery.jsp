<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% System.setProperty("no_visible_elements", "false"); %>
<%-- <link href='${res_url}bower_components/colorbox/example1/colorbox.css' rel='stylesheet'> --%>
<%
	String virtualImages = "/backendimage";
	String baseImagePath = request.getScheme()+"://"
			+request.getServerName()+":"
			+request.getServerPort()+virtualImages+"/"; %>	
<jsp:include page="/WEB-INF/view/add/common/header.jsp" flush="true" />
    <div>
        <ul class="breadcrumb">
            <li>
                <a href="/">主页</a>
            </li>
            <li>
                <a href="#">红外图像查询</a>
            </li>
        </ul>
    </div>

    <div class="row">
        <div class="box col-md-12">
            <div class="box-inner">
                <div class="box-header well" data-original-title="">
                    <h2><i class="glyphicon glyphicon-search"></i> 红外监控图像</h2>

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
                        
                    <button id="op_class_add" type="button" onclick="command(this)" class="btn btn-success btn-lg" value="0" disabled><i
                                class="glyphicon glyphicon-search glyphicon-white"></i>查询图像</button>
                    <br>
                <!-- </div> end of alert-info-->    
                    <div class="row">
      						<span> &nbsp;&nbsp;</span>
      				</div>
                   <ul id = "myquerygallery" class="thumbnails gallery">
                   </ul>
                </div>
            </div>
        </div>
        <!--/span-->
    </div><!--/row-->
<script src="js/jquery.magnific-popup.min.js"></script> <!-- Magnific popup (http://dimsemenov.com/plugins/magnific-popup/) -->
<script type="text/javascript">            
   $(window).load(function(){
          getOperationClass();
    }); 
    var status = 0;
	function command(which){
		var parentdiv = $(which).parents('.box-content');	
		var type = parentdiv.find("#add_type");
		var sensor_code = parentdiv.find("#add_sensor_code");
		var building = parentdiv.find("#add_building");
		var timeArray = $('#reportrange span').html().split(" - ");	
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/galleryquery/getImages",
			    data: {"type":type.val(),
			    		"sensor_code":sensor_code.find("option:selected").val(),
			    		"building":building.val(),
			    		"create_time":timeArray[0],
			    		"end_time":timeArray[1],
			    		},
			    success: function(data) {
					var result = data.result;
				    //console.log("result="+result);
				    var imageList = data.imageList;
		            if (result == true) { //成功添加
		            	 document.getElementById("myquerygallery").innerHTML = ""; 
		                 $.each(imageList, function(i,value){		                	 
<%-- 		                $('#myquerygallery').append(" <li id='"+value.id+"' class='thumbnail'> <a style='background:url(<%=baseImagePath%>" + value.url + ")' title='"+value.create_time+"' href='<%=baseImagePath %>"+value.url+"'> <img class='gallery' src='<%=baseImagePath %>"+value.url+"' alt='"+value.create_time+"'>"+value.id+"</a></li>"); --%>
					     	var temp = document.createElement("li"); 
					     	temp.id = value.id;
					     	//temp.setAttribute("class", "thumbnail");
					     	temp.className = "thumbnail";
					     	document.getElementById("myquerygallery").appendChild(temp);
					     	// $('#myquerygallery').appendChild(temp);				     	
					     	var tempa = document.createElement("a"); 
					     	tempa.href= '<%=baseImagePath%>'+value.url;
					     	//tempa.text= value.create_time+"~"+value.sensor_name;
					     	tempa.title = value.create_time+"\n"+"        "+value.sensor_name;
					     	tempa.className="gallery";
					     	temp.appendChild(tempa);					     						     	
					      	var div1=document.createElement("div");
					      	div1.innerHTML = value.create_time;
					     	div1.style.cssText += 'text-align:center';
					     	temp.appendChild(div1); 					     	
					     	var tempimg = document.createElement("img"); 
					     	tempimg.src= '<%=baseImagePath%>'+value.url;
					     	tempimg.className="gallery";
					     	tempa.appendChild(tempimg);					     	
					     	var div=document.createElement("div");
					     	div.className="tags";
					     	tempa.appendChild(div);
					     	
					     	var span1=document.createElement("span");
					     	span1.className="label-holder";
					     	var span2=document.createElement("span");
					     	span2.className="label label-info";
					     	span2.innerHTML="Max : "+value.max+"°C";
					     	span1.appendChild(span2);
					     	div.appendChild(span1);
					     	
					     	var span3=document.createElement("span");
					     	span3.className="label-holder";
					     	var span4=document.createElement("span");
					     	span4.className="label label-danger";
					     	span4.innerHTML="Avg : "+value.av+"°C";
					     	span3.appendChild(span4);
					     	div.appendChild(span3);
					     	
					     	var span5=document.createElement("span");
					     	span5.className="label-holder";
					     	var span6=document.createElement("span");
					     	span6.className="label label-success";
					     	span6.innerHTML="Min : "+value.min+"°C";
					     	span5.appendChild(span6);
					     	div.appendChild(span5);					     						     	
					    }); 					    
 					    $("a.gallery").colorbox({
 							"rel":"gallery"
 						}); 												
		                return true;
		            }else{ //添加失败
		            	document.getElementById("myquerygallery").innerHTML = "";
		                $.toaster({ priority : 'warning', title : '告警信息', message : '在时间区间没有图片！'});
		                return false;
		            }		            
			    },
			    error:function(){
			    	$.toaster({ priority : 'danger', title : '错误信息', message : '请求下发指令错误，请确认路径正确或网络正常！'});
			    }
	        });	        
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
// 	function buildingSelect(which){
// 		var sindex = which.selectedIndex;
// 		$('div.alert-danger').hide();
// 		if(sindex == 0){
// 			$('#add_layer_div').hide();

// 		}else{
// 			$('#add_layer_div').show();

// 			getLayer(which.value);
// 		}
// 		$('#add_room_div').hide();
// 		$('#add_type_div').hide();
// 		$('#sensor_code_div').hide();
// 		$('#time_div').hide();
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
// 		$('div.alert-danger').hide();
// 		if(sindex == 0){			
// 			$('#add_room_div').hide();

// 		}else{
// 			$('#add_room_div').show();

// 			getRoom(which.value);
// 		}
// 		$('#add_type_div').hide();
// 		$('#sensor_code_div').hide();
// 		$('#time_div').hide();
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
// 		$('div.alert-danger').hide();
// 		if(sindex == 0){		
		
// 			$('#add_type_div').hide();
// 		}else{
// 			$('#add_type_div').show();
// 			getType(which.value);
// 		}
// 		$('#sensor_code_div').hide();
// 		$('#time_div').hide();
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
<%-- 			    url: "<%=request.getContextPath()%>"+"/galleryquery/getSensorType", --%>
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