<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<% System.setProperty("no_visible_elements", "false"); 
 String localPathString = "/img/show_img/";
%>
<%@ include file="common/header.jsp" %>

<div>
    <ul class="breadcrumb">
        <li>
            <a href="/">主页</a>
        </li>
        <li>
            <a href="#">图片抓取</a>
        </li>
    </ul>
</div>

<div class="row">

    <div class="box col-md-12">
        <div class="box-inner">
            <div class="box-header well">
                <h2><i class="glyphicon glyphicon-camera"></i> 实时图片抓取</h2>

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
      							<label class="form-label control-label">所属班组</label>
      						</div>
      						<div class="col-md-6">	
	      						<select id="station_op_class" onchange="getOpClassSelect(this)" class="form-control selectpicker">
	                        		<option  value='0'>---请选择班组---</option>
	                       		</select>
                       		</div>
      					</div>

						<div hidden id="nostationalert" class="form-group alert alert-danger">
					   		 <strong>警告:</strong>该运维组无biandian站！
						</div>
      					<div hidden id="add_station_manager_div" class="form-inline row">
      						<div class="col-md-2">
      							<label class="form-label control-label">biandian站</label>
      						</div>
      						<div class="col-md-6">	
	      						<select id="add_station" onclick="managerSelect(this)" class="form-control selectpicker">
	                        		<option  value='0'>---请选择biandian站---</option>
	                       		</select>
                       		</div>
      					</div>
      					
      					<!-- <div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>  -->
      					<div hidden id="nobuildingalert" class="form-group alert alert-danger">
					   		 <strong>警告:</strong>没有大楼信息，请先创建大楼！
						</div>
      					<div hidden id="add_building_div" class="form-inline row">
      						<div class="col-md-2">
      							<label class="form-label control-label">所属大楼</label>
      						</div>
      						<div class="col-md-6">	
	      						<select id="add_building" onclick="buildingSelect(this)" class="form-control selectpicker">
	                        		<option  value='0'>---请选择大楼---</option>
	                       		</select>
                       		</div>
      					</div>

      					<div hidden id="nolayeralert" class="form-group alert alert-danger">
					   		 <strong>警告:</strong>没有楼层信息，请先创建楼层！
						</div>
      					<div hidden id="add_layer_div" class="form-inline row">
      						<div class="col-md-2">
      							<label class="form-label control-label">所属楼层</label>
      						</div>
      						<div class="col-md-6">	
	      						<select id="add_layer" onclick="layerSelect(this)" class="form-control selectpicker">
	                        		<option  value='0'>---请选择楼层---</option>
	                       		</select>
                       		</div>
      					</div>
      					
      					<div hidden id="noroomalert" class="form-group alert alert-danger">
					   		 <strong>警告:</strong>没有biandian室信息，请先创建！
						</div>
      					<div hidden id="add_room_div" class="form-inline row">
      						<div class="col-md-2">
      							<label class="form-label control-label">所属biandian室</label>
      						</div>
      						<div class="col-md-6">
	      						<select id="add_room" onclick="roomSelect(this)" class="form-control selectpicker">
	                        		<option  value='0'>---请选择biandian室---</option>
	                       		</select>
                       		</div>
      					</div>

      					<div hidden id="notypealert" class="form-group alert alert-danger">
					   		 <strong>警告:</strong>没有类型信息，请先创建！
						</div>
      					<div hidden id="add_type_div" class="form-inline row">
      						<div class="col-md-2">
      							<label class="form-label control-label">所属类型</label>
      						</div>
      						<div class="col-md-6">	
	      						<select id="add_type" onclick="typeSelect(this)" class="form-control selectpicker">
	                        		<option  value='0'>---请选择监控器类型---</option>
	                       		</select>
                       		</div>
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
      					<div hidden id="nocolouralert" class="form-group alert alert-danger">
					   		 <strong>警告:</strong>没有配置云台设置点，请先添加！
						</div>
						<div hidden id="nocolouralert2" class="form-group alert alert-danger">
					   		 <strong>警告:</strong>设置点不存在，请确认！
						</div>
						
						<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div> 
						
      					<div hidden id = "platform_code_div" class="form-inline row">
      						<div class="col-md-2">
        						<label class="form-label control-label">色带选择</label>
        					</div> 
        					<div class="col-md-8">
								<div id = "platform_checkbox" >
								
								</div>
								<div id = "platform_checkbox_button" >
								
								</div>
							</div>
        					
        					<div class="col-md-2">
        						<span class='availability_status'></span>
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div> 
      					<div hidden id = "image_show_div" class="form-inline row">
      						<!-- <ul id="mygallery" class="thumbnails gallery"></ul> -->
                    		<ul class="thumbnails gallery">
                    			<c:forEach var="ilist" items="${records}">
                    				<c:if test="${ilist.status > 0}">
                    					<li id="${ilist.id}" class="thumbnail">
		                                <a style="background:url(<%=request.getContextPath()+localPathString%>${ilist.id}<%=".jpg"%>)"
		                                   title="${ilist.platform_code}" href="<%=request.getContextPath()+localPathString%>${ilist.id}<%=".jpg"%>"><img
		                                        class="gallery" src="<%=request.getContextPath()+localPathString%>${ilist.id}<%=".jpg"%>">${ilist.colour}</a>
		                            	</li>
                    				
                    				</c:if>
                    				<c:if test="${ilist.status == 0}">
                    					<li hidden id="${ilist.id}" class="thumbnail">
		                                <a style="background:url(<%=request.getContextPath()+localPathString%>${ilist.id}<%=".jpg"%>)"
		                                   title="${ilist.platform_code}" href="<%=request.getContextPath()+localPathString%>${ilist.id}<%=".jpg"%>"><img
		                                        class="gallery" src="<%=request.getContextPath()+localPathString%>${ilist.id}<%=".jpg"%>">${ilist.colour}</a>
		                            	</li>
                    				
                    				</c:if>

                    			</c:forEach>
                    		</ul>
      					</div>
						
                    <button id="op_class_add2" type="button" onclick="createImage(this)" class="btn btn-success btn-lg" value="0" disabled><i
                                class="glyphicon glyphicon-camera glyphicon-white"></i>&nbsp;实时抓取图片</button>
                    <br>
               <!--  </div>  -->

            </div>
        </div>
    </div>


</div><!--/row-->

<script type="text/javascript" src="js/highchart/highcharts.js"></script>
<script type="text/javascript" src="js/highchart/exporting.js"></script>

<script type="text/javascript">
   $(window).load(function(){
		
		getOperationClass();
		// $('#op_class_add').text("设置图片色带");
		
    });
    
    //5、获取多个选中的checkbox值
    /*  var vals = [];
     $('input:checkbox:checked').each(function (index, item) {
         vals.push($(this).val());
     }); */
     
     //6、判断checkbox是否选中（jquery 1.6以前版本 用  $(this).attr("checked")）    $("input:checkbox").change
     function checkChanged() {
     	
     	var obj = document.getElementsByName("mypcode");//选择所有name="mypcode"的对象，返回数组
        //var s='';//如果这样定义var s;变量s中会默认被赋个null值
        var ul=$("ul.thumbnails");//获取所有的li元素 
        var lis = ul.children('li.thumbnail');
        var tag = false;
        var select_tag = new Array(obj.length);
        for(var i=0;i<obj.length;i++){

             if(obj[i].checked){ //取到对象数组后，我们来循环检测它是不是被选中
             	// s+=obj[i].value+','; //如果选中，将value添加到变量s中    
             	// $("ul li[class='thumbnail']").eq(i).show();
             	lis.eq(i).show();
             	tag = true;
             	select_tag[i] = 1;
             }else {
             	lis.eq(i).hide();
             	select_tag[i] = 0;
             }
        }
        if(tag){
        	$('#op_class_add').prop('disabled', false);
        }else{
        	$('#op_class_add').prop('disabled', true);
        }
     	//console.log("checked--"+s);
		return select_tag;
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
		var colour = checkChanged();
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    async: false,
			    url: "<%=request.getContextPath()%>"+"/imageset/setColour",
			    data: {"type":type.val(),
			    		"sensor_code":sensor_code.find("option:selected").val(),
			    		"station_op":station_op.val(),
			    		"station":station.val(),
			    		"building":building.val(),
			    		"layer":layer.val(),
			    		"room":room.val(),
			    		"status":status,
			    		"colour":colour},
			    timeout:10000,
			    success: function(data) {
			    	// var source = station.val()+'--'+building.val()+'--'+layer.val()+'--'+room.val();
					var result = data.result;
					var record = data.record;
					if(result){
						var port = record.port;

			            $.toaster.reset();
			            $.toaster({priority : 'success', title : '提示信息', message : '抓图色带命令已经下发，请稍等！'});
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
	
	function createImage(which){
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
		var colour = checkChanged();
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    async: false,
			    url: "<%=request.getContextPath()%>"+"/realimage2/createImage",
			    data: {"type":type.val(),
			    		"sensor_code":sensor_code.find("option:selected").val(),
			    		"station_op":station_op.val(),
			    		"station":station.val(),
			    		"building":building.val(),
			    		"layer":layer.val(),
			    		"room":room.val(),
			    		"status":status,
			    		"colour":colour},
			    timeout:10000,
			    success: function(data) {
			    	// var source = station.val()+'--'+building.val()+'--'+layer.val()+'--'+room.val();
					var result = data.result;
					var record = data.record;
					if(result){
						var port = record.port;

			            $.toaster.reset();
			            $.toaster({priority : 'success', title : '提示信息', message : '抓图色带命令已经下发，请稍等！'});
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
		
		$(which).append("<option value='0'>---请选择班组---</option>"); 
		
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/getoperation",
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
		$('#image_show_div').hide();
		$('#platform_code_div').hide();
		$('#op_class_add').prop('disabled', true);
		$('#op_class_add2').prop('disabled', true);
		
	}
	
	function getStation(op){
		var which = $('#add_station');
		var opclass = op;
		// console.log("opclass="+opclass);
		hiddleComp('nostationalert',which);
		$(which).empty();
		$(which).append("<option  value='0'>---请选择biandian站---</option>");
		
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
					    	// console.log(value.id+"--"+value.user_name);
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
		$('#platform_code_div').hide();
		$('#image_show_div').hide();
		$('#op_class_add').prop('disabled', true);
		$('#op_class_add2').prop('disabled', true);
	}
	

	function getBuilding(op){
		
		var which = $('#add_building');
		hiddleComp('nobuildingalert',which);
		$(which).empty();
		$(which).append("<option  value='0'>---请选择大楼---</option>");
		var para = op;
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/layer/getBuilding",
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

	function buildingSelect(which){
		var sindex = which.selectedIndex;
		$('div.alert-danger').hide(); 
		if(sindex == 0){
			$('#add_layer_div').hide();
			
		}else{
			$('#add_layer_div').show();

			getLayer(which.value);
		}
		
		$('#add_room_div').hide();
		$('#add_type_div').hide();
		$('#sensor_code_div').hide();
		$('#platform_code_div').hide();
		$('#image_show_div').hide();
		$('#op_class_add').prop('disabled', true);
		$('#op_class_add2').prop('disabled', true);
	}
	
	function getLayer(op){
		
		var which = $('#add_layer');
		
		$(which).empty();
		$(which).append("<option  value='0'>---请选择楼层---</option>");
		var para = op;
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/room/getLayer",
			    data:{"layer":para},
			    success: function(data) {
					var result = data.layerRecords;
					if(result){
						hiddleComp('nolayeralert',which);
					     $.each(result, function(i,value){
					     	
					    	//$('#operationclass').options.add(new Option(value.op_name,value.id));
					    	//console.log(value.id+"--"+value.user_name);
					    	//$('#operationclass').append("<option value='"+value.id+"'"+">"+value.op_name+"</option>");
					    	$(which).append("<option value='"+value.id+"'>"+value.layer_name+"</option>"); 
					    });
					}else{
						showAlert('nolayeralert');
						$('#add_layer_div').hide();
					}
			    }
	        });
	}
	
	function layerSelect(which){
		var sindex = which.selectedIndex;
		$('div.alert-danger').hide(); 
		if(sindex == 0){			
			$('#add_room_div').hide();
			
		}else{
			$('#add_room_div').show();
			
			getRoom(which.value);
		}
		$('#add_type_div').hide();
		$('#sensor_code_div').hide();
		$('#platform_code_div').hide();
		$('#image_show_div').hide();
		$('#op_class_add').prop('disabled', true);
		$('#op_class_add2').prop('disabled', true);
	}
	
	function getRoom(op){
		
		var which = $('#add_room');
		
		$(which).empty();
		$(which).append("<option  value='0'>---请选择biandian室---</option>");
		
		var para = op;
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/room/getRoom",
			    data:{"layer":para},
			    success: function(data) {
					var result = data.roomRecords;
					if(result){
						hiddleComp('noroomalert',which);
					     $.each(result, function(i,value){
					     	
					    	//$('#operationclass').options.add(new Option(value.op_name,value.id));
					    	//console.log(value.id+"--"+value.user_name);
					    	//$('#operationclass').append("<option value='"+value.id+"'"+">"+value.op_name+"</option>");
					    	$(which).append("<option value='"+value.id+"'>"+value.room_name+"</option>"); 
					    });
					}else{
						showAlert('noroomalert');
						$('#add_room_div').hide();
					}
			    }
	        });
	}

	function roomSelect(which){
		var sindex = which.selectedIndex;
		$('div.alert-danger').hide(); 
		if(sindex == 0){		
		
			$('#add_type_div').hide();
			
		}else{
			$('#add_type_div').show();
			
			getType(which.value);
		}
		$('#sensor_code_div').hide();
		$('#platform_code_div').hide();
		$('#image_show_div').hide();
		$('#op_class_add').prop('disabled', true);
		$('#op_class_add2').prop('disabled', true);
	}
	
	function getType(op){
		
		var which = $('#add_type');
		
		$(which).empty();
		$(which).append("<option  value='0'>---请选择监控器类型---</option>");
		
		var para = op;
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/temp/getSensorType",
			    data:{"room":para},
			    success: function(data) {
					var result = data.sensorTypeList;
					if(result){
						hiddleComp('notypealert',which);
					     $.each(result, function(i,value){
					     	
					    	//$('#operationclass').options.add(new Option(value.op_name,value.id));
					    	//console.log(value.id+"--"+value.user_name);
					    	//$('#operationclass').append("<option value='"+value.id+"'"+">"+value.op_name+"</option>");
					    	$(which).append("<option value='"+value.id+"'>"+value.type_name+"</option>"); 
					    });
					}else{
						showAlert('notypealert');
						$('#add_type_div').hide();
					}
			    }
	        });
	}
	
	function typeSelect(which){
	
		
		var sindex = which.selectedIndex;
		$('div.alert-danger').hide(); 
		if(sindex == 0){		
		
			$('#sensor_code_div').hide();
			
		}else{
			$('#sensor_code_div').show();
			getCode(which);
		}
		$('#platform_code_div').hide();
		$('#image_show_div').hide();
		$('#op_class_add').prop('disabled', true);
		$('#op_class_add2').prop('disabled', true);
	}
	
	function getCode(op){
		
		var which = $(op);
		
		
		var parentdiv = $(which).parents('.box-content');

		var room = parentdiv.find("#add_room");
		var sensor_type = parentdiv.find("#add_type");

		$('#add_sensor_code').empty();
		$('#add_sensor_code').append("<option  value='0'>---请选择监控器编号---</option>");
		
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/temp/getSensorCode",
			    data:{"room":room.val(),
			    	"sensor_type":sensor_type.val()},
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
		$('div.alert-danger').hide(); 
		if(code.val() == 0){
			$('#platform_code_div').hide();
			$('#op_class_add').prop('disabled', true);
		}else{
			$('#op_class_add2').prop('disabled', false);
			$('#platform_code_div').show();
			$('#image_show_div').show();
			getPlaform();
			// daterangetimeplugin();
			//console.log("code="+code.find("option:selected").text());

		}
		
		$('#op_class_add').prop('disabled', true);
		
	}
	
	
	
	function getPlaform(){

		$('#platform_checkbox').html("");
		// $('#add_angle_code').append("<option  value='0'>---请选择云台设置点---</option>");
		
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/imageset/getColour",
			    data:{},
			    success: function(data) {
			    	var notEmpty = data.result;
					var result = data.records;
					// console.log("notEmpty = "+notEmpty);
					if(notEmpty){
						hiddleComp('nocolouralert');
					     $.each(result, function(i,value){
					     	if(value.status == 0){
					    		$('#platform_checkbox').append("<input OnClick='checkChanged()' type='checkbox' disabled='disabled'  id='"+value.id+" class='styled' value='"+value.id+"' name='mypcode'/>"+value.colour+"&nbsp;&nbsp;&nbsp;");
					    	} else {
								$('#platform_checkbox').append("<input OnClick='checkChanged()' type='checkbox' checked disabled='disabled' id='"+value.id+" class='styled' value='"+value.id+"' name='mypcode'/>"+value.colour+"&nbsp;&nbsp;&nbsp;");
							}
					    });

					}else{
						showAlert('nocolouralert');
						$('#platform_code_div').hide();
						$('#image_show_div').hide();
						$('#platform_checkbox_button').html("");
					}
			    }
	        });
	}

/* 	$("#checkbox_select").click(function() {
		console.log("checbox--反选！");
		$("input[type='checkbox']").each(function() {
			if ($(this).attr("checked")) {
				$(this).removeAttr("checked");
			} else {
				$(this).attr("checked", "true");
			}
		})
	}) */

	//全选、取消全选的事件  
	function selectAll(){ 
	    console.log(1);
	    console.log($("input[type='checkbox'][name='mypcode']").prop("checked"));
	    if ($("input[type='checkbox'][name='mypcode']").prop("checked")) {
	        console.log(2);
	        $("input[type='checkbox'][name='mypcode']").prop("checked",false);//取消全选 
	    } else { 
	        console.log(3);               
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
			$('#image_show_div').hide();
			//$('#op_class_add').text("开关监控器");
		}else{
			$('#op_class_add').prop('disabled', false);
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
	

</script>

<%@ include file="common/footer.jsp" %>

