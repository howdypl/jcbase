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
    <div class="row">
        <div class="box col-md-12">
            <div class="box-inner">
                <div class="box-header well" data-original-title="">
                    <h2><i class="glyphicon glyphicon-search"></i> 具体信息</h2>

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
        						<select id="add_sensor_code" onclick="pointSelect(this)" class="form-control selectpicker">
	                        		<option  value='0'>----请选择监控器编号----</option>
	                       		</select>
        					</div>
        					<div class="col-md-2">
        						<span class='availability_status'></span>
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					     					
      					<div hidden id="noroomalert" class="form-group alert alert-danger">
					   		 <strong>警告:</strong>没有预设点信息，请先创建！
						</div>
      					<div hidden id="add_room_div" class="form-inline row">
      						<div class="col-md-2">
      							<label class="form-label control-label">所属预设点</label>
      						</div>
      						<div class="col-md-6">	
	      						<select id="add_room" onclick="codeSelect(this)" class="form-control selectpicker">
	                        		<option  value='0'>---请选择预设点---</option>
	                       		</select>
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
                                class="glyphicon glyphicon-search glyphicon-white"></i>查询信息</button>
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
        
         <div hidden id="div1" class="box col-md-12" style="width:40%">
            <div class="box-inner" style="height:500px;">               
				<div id="myCarousel" class="carousel slide">
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
						<span class="sr-only">Previous</span>
					</a> <a class="right carousel-control" href="#myCarousel" role="button"
						data-slide="next"> <span
						class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
						<span class="sr-only">Next</span>
					</a>
				</div>
				<br><br>
				<!-- 图片地下显示时间 -->
				<div id="add_time" align="center" style="font-size: 25px"></div>
				<!-- 时间地下显示“历史图像查看” -->
				<div id="add_word" align="center" style="font-size: 20px">
				    <a href="#">历史图像查看</a>
				</div>
		   </div>
        </div>


	<div hidden id="div2" class="box col-md-12" style="width: 60%">
		<div style="height: 500px;">
			<div class="box-content">
				<div style="height: 200px; width: 50%; float: left">
				    <table id="add_todaytime" class="table table-bordered">
				        <tr>
				            <th style="padding: 20px">今日最低</th>
				            <th style="padding: 20px">今日最高</th>
				        </tr>
				        <tr id="add_number">
				        
				        </tr>
				    </table>
				</div>
				<div id="add_alltime" style="height: 200px; width: 50%; background-color: #FF0000; float: left"></div>
			</div>
		</div>
	</div>

</div><!--/row-->
<script src="js/jquery.magnific-popup.min.js"></script> <!-- Magnific popup (http://dimsemenov.com/plugins/magnific-popup/) -->
<script type="text/javascript">            
   $(window).load(function(){
          getOperationClass();
    }); 
   
   function command(){
		getWarnImageDetil();
		getTodayTemp();
		$('#div1').show();
		$('#div2').show();
	}	
   
   
   function getWarnImageDetil(){
		var point_type=$('#add_room').val();
		var sensor_code=$('#add_sensor_code').val();
		 $.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/warndetil/getWarnImageDetil",
			    data:{"point_type":point_type,"sensor_code":sensor_code},
			    success: function(data) {
					var result = data.result;
				    var imageList = data.imageList;
		            if (result == true) { //成功添加
		            	  $.each(imageList, function(i,value){	
		            		 if(i==0){
		            			 $('#add_Carousel').append('<div class="item active"> <img src="<%=baseImagePath%>'+value.url+'" alt="First slide"> </div>');
		            		 }else{
		            			 $('#add_Carousel').append('<div class="item"> <img src="<%=baseImagePath%>'+value.url+'" alt="First slide"> </div>');
		            		 }
		            		 if(i==2){
		            			 $('#add_time').append('<p>'+value.create_time+'</p>');
		            		 }
		            	  });
						}
		            else{
		            	alert("ghgfd");
		             }
				    }
		        });
		}
   
   function getTodayTemp(){
	    var point_type=$('#add_room').val();
		var sensor_code=$('#add_sensor_code').val();
		 $.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/warndetil/getTodayTemp",
			    data:{"point_type":point_type,"sensor_code":sensor_code},
			    success: function(data) {
					var result = data.result;
				    var imageList = data.imageList;
		            if (result == true) { //成功添加
		            	  $.each(imageList, function(i,value){	
		            	      $('#add_number').append('<td style="padding: 20px">'+value.min+'</td>');
		            	      $('#add_number').append('<td style="padding: 20px">'+value.max+'</td>');
		            	  });
						}
		            else{
		            	alert("ghgfd");
		             }
				    }
		        });
		}
   
   function getTodayTemp(){
	    var point_type=$('#add_room').val();
		var sensor_code=$('#add_sensor_code').val();
		 $.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/warndetil/getTodayTemp",
			    data:{"point_type":point_type,"sensor_code":sensor_code},
			    success: function(data) {
					var result = data.result;
				    var imageList = data.imageList;
		            if (result == true) { //成功添加
		            	  $.each(imageList, function(i,value){	
		            	      $('#add_number').append('<td style="padding: 20px">'+value.min+'</td>');
		            	      $('#add_number').append('<td style="padding: 20px">'+value.max+'</td>');
		            	  });
						}
		            else{
		            	alert("ghgfd");
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
					var result = data.oplist;
					var notEmpty = data.notempty;
					if(notEmpty){						 
					     $.each(result, function(i,value){					     						    
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
	
	function pointSelect(which){
		var sindex = which.selectedIndex;
		$('div.alert-danger').hide();
		if(sindex == 0){		
	
			$('#add_room_div').hide();
		}else{
			$('#add_room_div').show();
			getPoint(which.value);
		}
	}
	
	
	function getPoint(op){	
		var which = $('#add_room');	
		$(which).empty();
		$(which).append("<option  value='0'>---请选择预设点---</option>");
		var sensor_code = op;
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/platform/getPlatform",
			    data:{"sensor_code":sensor_code},
			    success: function(data) {
					var result = data.records;
					if(result){
						hiddleComp('noroomalert',which);
					     $.each(result, function(i,value){
					    	$(which).append("<option value='"+value.point_type+"'>"+value.platform_code+"</option>"); 
					    });
					}else{
						showAlert('noroomalert');
						$('#add_room_div').hide();
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
		}else{
			$('#op_class_add').prop('disabled', false);
			$('#time_div').show();
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
		$(document).ready(function() {
		daterangetimeplugin();
	}); 		
		function daterangetimeplugin(){
					//时间插件
					$('#reportrange span').html(moment().subtract('days', 1).format('YYYY-MM-DD HH:mm:ss') + ' - ' + moment().format('YYYY-MM-DD HH:mm:ss'));
					$('#reportrange').daterangepicker(
							{
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