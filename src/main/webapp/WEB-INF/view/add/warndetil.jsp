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
                <div class="box-content" style="padding-bottom: 30px;">
						<div class="row" style="margin-left: 30px">
							<div class="col-md-3" style="padding-left: 30px">
							<label class="form-label control-label">运维班：</label>
							</div>
							<div class="col-md-3">
							<label class="form-label control-label">变电站：</label>
							</div>
							<div class="col-md-3">
							<label class="form-label control-label">设备间：</label>
							</div>
							<div class="col-md-3">
							<label class="form-label control-label">设备：</label>
							</div>
						</div>
						<div class="row" style="margin-left: 30px">
						    <div class="col-md-3" style="padding-left: 30px">
								<select id="station_op_class" onchange="getOpClassSelect(this)" class="form-control selectpicker">
	                        		<option  value='0'>---请选择运维班---</option>
	                       		</select>
							</div>
							<div class="col-md-3">
							   <select id="add_station" onclick="managerSelect(this)" class="form-control selectpicker">
	                        		<option  value='0'>---请选择变电站---</option>
	                       		</select>
							</div>
							<div class="col-md-3">
								<select id="add_building" onclick="typeSelect(this)" class="form-control selectpicker">
	                        		<option  value='0'>---请选择设备间---</option>	
		                       	</select>
							</div>
							<div class="col-md-3">
								<select id="add_sensor_code" onclick="command(this)" class="form-control selectpicker">
		                        		<option  value='0'>---请选择设备---</option>
		                       	</select>	
							</div>
						</div>
						
      					<!-- <div hidden id = "time_div" class="form-inline row">
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
      					</div> -->
                        
                   <!--  <button id="op_class_add" type="button" onclick="command(this)" class="btn btn-success btn-lg" value="0" disabled><i
                                class="glyphicon glyphicon-search glyphicon-white"></i>查询信息</button>    -->
                </div>
            </div>
        </div>    
	<div id="div1" class="box col-md-12" style="width:40%">
            <div class="box-inner" style="height:800px;">               
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
				    <a href="/#/galleryquery" target="_parent">历史图像查看</a>
				    <input type="button" value="注册" onclick="window.location.href('http://localhost:8080/#/galleryquery')" />
				</div>
		   </div>
        </div>


	<div id="div2" class="box col-md-12" style="width: 30%">
		<div style="height: 260px;">
			<div class="box-content">
				<div>
				    <table id="add_todaytime" class="table table-bordered">
				        <tr>
				            <th style="padding: 40px">今日最低</th>
				            <th style="padding: 40px">今日最高</th>
				        </tr>
				        <tr id="add_number">
				        
				        </tr>
				    </table>
				</div>
			</div>
		</div>
	</div>
	
	 <div class="box col-md-12" style="width:30%; padding-left: 0px;">
            <div class="box-inner" style="height:265px;">
                <div class="box-content">                
					 <div id="container1" style="width: 320px; height: 250px; margin: 0 -10px"></div>
                </div>
            </div>
        </div>
     <div class="box col-md-12" style="width:60%;">
            <div class="box-inner" style="height:200px;">
                <div class="box-header well" style="margin-bottom: -10px">
                    <h2><i class="glyphicon glyphicon-picture"></i> 30天内温度变化趋势</h2>
                </div>
                <div class="box-content">                
					<div id="container2" style="width: 100%; height: 150px; margin: 0 auto"></div>
                </div>
            </div>
        </div>
        <div class="box col-md-12" style="width:60%;">
            <div class="box-inner" style="height:296px;">
                <div class="box-header well" style="background:  coral;">
                    <h2><i class="glyphicon glyphicon-warning-sign"></i> 告警推送</h2>
                </div>
                <div class="box-content">                
					<!-- <div id="container2" style="width: 100%; height: 150px; margin: 0 auto"></div> -->
                </div>
            </div>
        </div>

</div><!--/row-->
<script src="${res_url}first/jsto/jquery.magnific-popup.min.js"></script> <!-- Magnific popup (http://dimsemenov.com/plugins/magnific-popup/) -->
<script src="${res_url}first/jsto/highchart/highcharts.js"></script>
<script type="text/javascript">            
   $(window).load(function(){
          getOperationClass();
    }); 
   
   //****************得到轮播图片****************  
   function getWarnImageDetil(){
		//var point_type=$('#add_room').val();
		var sensor=$('#add_sensor_code').val();
		 $.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/warndetil/getWarnImageDetil",
			    data:{"sensor":sensor},
			    success: function(data) {
					var result = data.result;
				    var imageList = data.imageList;
		            if (result == true) { //成功添加
		            	document.getElementById("add_Carousel").innerHTML = "";
		            	document.getElementById("add_time").innerHTML = "";
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
		            	//alert("ghgfd");
		             }
				    }
		        });
		}
 //****************得到今日最低和最高温度****************  
   function getTodayTemp(){
	   var sensor=$('#add_sensor_code').val();
		 $.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/warndetil/getTodayTemp",
			    data:{"sensor":sensor},
			    success: function(data) {
					var result = data.result;
				    var imageList = data.imageList;
		            if (result == true) { //成功添加
		            	document.getElementById("add_number").innerHTML = "";
		            	  $.each(imageList, function(i,value){	
		            	      $('#add_number').append('<td style="padding: 40px">'+value.min+'</td>');
		            	      $('#add_number').append('<td style="padding: 40px">'+value.max+'</td>');
		            	  });
						}
		            else{
		            	//alert("ghgfd");
		             }
				    }
		        });
		}
 //****************得到历史温度记录****************  
   function getHistogram(){
	   var sensor=$('#add_sensor_code').val();
		 $.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/warndetil/getHistogram",
			    data:{"sensor":sensor},
			    success: function(data) {
					var result = data.result;
				    var imageList = data.imageList;
				    var tempvalue=[];
				    var curse = [];
		            if (result == true) { //成功添加
		            	  $.each(imageList, function(i,value){	
		            		  tempvalue.push(value.zuigao);
		            		  tempvalue.push(value.max_temp);
		            		  tempvalue.push(value.yue);
		            	  });
		            	  curse.push({name:'温度对比', data:tempvalue});  
	            		   var chart = {
	            		      type: 'column'
	            		   };
	            		   var title = {
	            		      text: ''   
	            		   };
	            		   var subtitle = {
	            		      text: ''  
	            		   };
	            		   var xAxis = {
	            		      categories: ['历史最高','当前温度','近30天内最高温度'],
	            		      crosshair: true
	            		   };
	            		   var yAxis = {
	            		      min: 0,
	            		      title: {
	            		         text: '温度值 (℃)'         
	            		      }      
	            		   };
	            		   var tooltip = {
	            		      headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
	            		      pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
	            		         '<td style="padding:0"><b>{point.y:.1f} ℃</b></td></tr>',
	            		      footerFormat: '</table>',
	            		      shared: true,
	            		      useHTML: true
	            		   };
	            		   var plotOptions = {
	            		      column: {
	            		         pointPadding: 0.2,
	            		         borderWidth: 0
	            		      }
	            		   };  
	            		   var credits = {
	            		      enabled: false
	            		   };
	            		   
	            		   var series= curse;
	            		      
	            		   var json = {};   
	            		   json.chart = chart; 
	            		   json.title = title;   
	            		   json.subtitle = subtitle; 
	            		   json.tooltip = tooltip;
	            		   json.xAxis = xAxis;
	            		   json.yAxis = yAxis;  
	            		   json.series = series;
	            		   json.plotOptions = plotOptions;  
	            		   json.credits = credits;
	            		   $('#container1').highcharts(json);		            		  
						}
		            else{
		            	//alert("ghgfd");
		             }
				    }
		        });
		}
	
 //****************得到温度曲线图****************  
    
     function getTempCurve(){
    	 var sensor=$('#add_sensor_code').val();
		 $.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/warndetil/getTempCurve",
			    data:{"sensor":sensor},
			    success: function(data) {
					var result = data.result;
				    var imageList = data.imageList;
				    var time=[];
				    var temp=[];
				    var cause=[];
		            if (result == true) { //成功添加
		            	  $.each(imageList, function(i,value){	
		            	     time.push(value.create_time);
		            	     temp.push(value.max_temp);
		            	  });
		                  cause.push({name:'当前设备温度统计', data:temp});
		            	  var chart = {
		            		      type: 'areaspline'     
		            		   };
		            		   var title = {
		            		      text: ''   
		            		   }; 
		            		   var subtitle = {
		            		      style: {
		            		         position: 'absolute',
		            		         right: '0px',
		            		         bottom: '10px'
		            		      }
		            		   };
		            		   var legend = {
		            		      layout: 'vertical',
		            		      align: 'left',
		            		      verticalAlign: 'top',
		            		      x: 120,
		            		      y: 30,
		            		      floating: true,
		            		      borderWidth: 1,
		            		      backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
		            		   };
		            		   var xAxis = {
		            		      categories: time      
		            		   };
		            		   var yAxis = {
		            		      title: {
		            		         text: 'Fruit units'
		            		      }      
		            		   };
		            		   var tooltip = {
		            		       shared: true,
		            		       valueSuffix: ' units'
		            		   };
		            		   var credits = {
		            		       enabled: false
		            		   }
		            		   var plotOptions = {
		            		      areaspline: {
		            		         fillOpacity: 0.5
		            		      }
		            		   };   
		            		   var series= cause;     
		            		      
		            		   var json = {};   
		            		   json.chart = chart; 
		            		   json.title = title; 
		            		   json.subtitle = subtitle; 
		            		   json.xAxis = xAxis;
		            		   json.yAxis = yAxis;
		            		   json.legend = legend;   
		            		   json.plotOptions = plotOptions;
		            		   json.credits = credits;
		            		   json.series = series;
		            		   $('#container2').highcharts(json);
						}
		            else{
		            	//alert("ghgfd");
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
 	   // console.log("op_class selected index="+sindex); 
 		if(sindex == 0){
 			isSelect('typealert',which);
 		}else{
 		//	console.log("op_class selected ="+which.value);
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
 		$('#add_sensor_code').append("<option  value='0'>---请选择设备间---</option>");
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
 						var index = 7;
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
 	}
	
	function command(){
		
			
			getWarnImageDetil();
			getTodayTemp();
			getHistogram();
			getTempCurve();
		
	}
	
	
	<%-- function getPoint(op){	
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
	} --%>

	
	
	/* function codeSelect(which){
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
	});  */		
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