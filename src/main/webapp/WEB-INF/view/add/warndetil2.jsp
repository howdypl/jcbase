<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% System.setProperty("no_visible_elements", "false"); %>
<%-- <link href='${res_url}bower_components/colorbox/example1/colorbox.css' rel='stylesheet'> --%>
<%
	String virtualImages = "/backendimageinf";
	String baseImagePath = request.getScheme()+"://"
			+request.getServerName()+":"
			+request.getServerPort()+virtualImages+"/"; %>	
<link type="text/css" href="${res_url}css/style.css" rel="stylesheet" />
<script type="text/javascript" src="${res_url}bower_components/jquery/jquery.js"></script>
<script type="text/javascript" src="${res_url}js/scroll.js"></script>
<script type="text/javascript" src="${res_url}css/alarm/js/script.js"></script>
<script type="text/javascript" src="${res_url}css/alarm/js/moment.min.js"></script>
<script src="${res_url}ace-1.3.3/assets/js/jqGrid/jquery.jqGrid.src.js"></script>
<script src="${res_url}ace-1.3.3/assets/js/jqGrid/i18n/grid.locale-en.js"></script>

<link href="${res_url}css/final/chixuguance.css" rel="stylesheet" type="text/css">
<link href="${res_url}css/final/warndetailimage.css" rel="stylesheet" type="text/css">

<!-- The main CSS file -->
<link href="${res_url}css/alarm/style.css" rel="stylesheet" />

<jsp:include page="/WEB-INF/view/add/common/header2.jsp" flush="true" />
<%-- <jsp:include page="/WEB-INF/view/common/basecss.jsp" flush="true" /> --%>
<div class="row" hidden>
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-header well" data-original-title="">
				<h2>
					<i class="glyphicon glyphicon-search"></i> 具体信息
				</h2>

			</div>
			<div class="box-content" style="padding-bottom: 10px;">
				<div class="row">
					<div class="col-md-12">

						<div class="row" style="width:100%;padding-bottom: 30px;">
							<div class="col-md-2" style="width: 15%; margin: 0 5px;">
								<select name="work_area_id" id="work_area_class"
									onchange="getWorkAreaSelect(this)"
									class="form-control selectpicker">
									<option value='0'>---请选择工区---</option>
								</select>
							</div>
							<div class="col-md-2" style="width: 10%; margin: 0 5px;">
								<select id="station_op_class" onchange="getOpClassSelect(this)"
									class="form-control selectpicker">
									<option value='0'>---请选择班组---</option>
								</select>
							</div>
							<div class="col-md-2" style="width: 10%; margin: 0 5px;">
								<select id="add_station" onchange="managerSelect(this)"
									class="form-control selectpicker">
									<option value='0'>---请选择变电站---</option>
								</select>
							</div>
							<div class="col-md-2" style="width: 15%; margin: 0 5px;">
								<select id="add_building" onchange="typeSelect(this)"
									class="form-control selectpicker">
									<option value='0'>---请选择设备间---</option>
								</select>
							</div>
							<div class="col-md-4" style="width: 20%; margin: 0 5px;">
								<select id="add_sensor_code" onchange="command()"
									class="form-control selectpicker">
									<option value='0'>---请选择设备---</option>
								</select>
							</div>
							<div class="col-md-2">
								<button id="gotempimage" type="button" value="0"
									data-index="198" class="btn btn-primary btn-lg"
									style=" margin-top: -10px;">分析记录</button>
							</div>
						</div>
					</div>
				</div>

				<div hidden id="time_div" class="form-inline row">
					<div class="col-md-6">

						<div id="reportrange" class="pull-left dateRange"
							style="width:350px">
							<i class="glyphicon glyphicon-calendar fa fa-calendar"></i> <span
								id="searchDateRange"></span> <b class="caret"></b>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	</div>
</div>
<!--/row-->
<div class="row" style="magin:0 0;padding:10px;">
    <div class="box col-md-6">
        <div class="box-inner" style="height:700px;">
            <div class="box-header well" data-original-title="" style="margin-bottom:5px">
                <h2><i class="glyphicon glyphicon-user"></i> 最新抓拍图</h2>
            </div>
            <div class="box-content" >
            	<div style="border:1px solid #747474;margin-bottom:4px;">
			               <!-- <div class="leftpicbox1"> -->
							<div id="myCarousel" class="carousel slide"
								style="margin:0px;widht:70%;height:70%;">
								<!-- 轮播（Carousel）指标 -->
								<ol class="carousel-indicators">
									<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
									<li data-target="#myCarousel" data-slide-to="1"></li>
									<li data-target="#myCarousel" data-slide-to="2"></li>
								</ol>
								<!-- 轮播（Carousel）项目 -->
								<div class="carousel-inner" id="add_Carousel"
									style="widht:100%;height:100%;"></div>
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
							<!-- </div> -->
								<div class="picdowntxt1">
									<div class="sblefttxt1">
										<p></p>
									</div>
									<div class="sbrighttxt1">
										<div class="rttxt1">
											<p></p>
										</div>
										<div class="rttxt2">
											<p></p>
										</div>
										<div class="rttxt3">
											<p></p>
										</div>
									</div>
								</div>
					</div>
					<div class="downbuttonbox1">
					<div>
						<button type="button" id="historyImageBtn" value="0"
							data-index="225" class="btn btn-primary btn-lg downbutton1"
							style="margin-left: 10%;">
							查看历史图像
							<p></p>
						</button>
					</div>
					<div>
						<button type="button" id="historyVideoBtn" disabled value="0"
							data-index="225" class="btn btn-danger btn-lg  downbutton2"
							style="margin-left: 20%;">
							查看实时视频
							<p></p>
						</button>
					</div>
				</div>
            </div>
        </div>
        
        		<div id="div2" class="box col-md-12" style="flow:left;padding-left: 0px;margin-right:0px">					<div class="box-inner" style="height:250px;">
						<div class="box-content">
									<div class="downleftnrbox1">
										<img src="${res_url}css/images/v2_pi67b5.png">
										<div class="downrightpicbox1">
											<div id="clock" class="light">
												<div class="display">
													<div class="weekdays"></div>
													<div class="ampm"></div>
													<div class="alarm"></div>
													<div class="digits"></div>
												</div>
											</div>
										</div>
									</div>
						</div>
					</div>
				</div> <!--/span-->
    </div><!--/span-->


	<div class="box col-md-6">
        <div class="box-inner " style="height:500px;">
            	<div class="main-content" id="page-wrapper">
					<div class="page-content" id="page-content">
						<div class="row">
							<div class="col-xs-12">
					            <div class="box-content" style="padding-left:2px;padding-right:2px">
					            	<!-- PAGE CONTENT BEGINS -->
									<div class="widget-box">
						            	<!-- PAGE CONTENT BEGINS -->
										<table id="grid-table"></table>
										<!-- <div id="grid-pager"></div> -->
									</div>
					            </div>
			    			</div>
			    		</div>
			    	</div>
			    </div>
        </div>
    </div><!--/span-->
    
    
    <div class="box col-md-6">
		<div class="box-inner homepage-box" style="height:446px;width:100%">
			<div class="box-header well" style="background:coral;color:#FFFFFF">
				<h2>
					<i class="glyphicon glyphicon-warning-sign"></i> 告警推送
				</h2>
				<select id="warn_status" onchange="getWarnNews()"
					class="form-control selectpicker"
					style="width:auto;float:right;margin-top: -17px;margin-right: -18px;">
					<option value='0'>未确认</option>
					<option value='1'>已确认</option>
					<option value='2'>全部</option>
				</select>
			</div>
			
			<div class="bcon"
				style="width:auto;margin-left:10px;margin-right:10px;">
				<div class="list_lh" style="overflow-y:scroll;height: 380px;width:100%;">
					<ul id="news" style="height:380px;width:100%;margin-top:5px;">
					</ul>
				</div>
			</div>

		</div>
	</div> <!--/span-->
    
</div><!--/row-->
<link rel="stylesheet" href="${res_url}ace-1.3.3/assets/css/ui.jqgrid.css" />
<link rel="stylesheet" href="${res_url}ace-1.3.3/assets/css/jquery-ui.custom.css" />
<link rel="stylesheet" href="${res_url}ace-1.3.3/assets/css/ui.jqgrid.css" />

<script type="text/javascript">
	var work_areadd = 0;
	var op_idd = 0;
	var station_id = 0;
	var building_id = 0;
	var sensor_codee = null;
	var point_type = 0;     
	var ifirst = 0;
	var sensorName="";
	var pcName="";
   $(document).ready(function(){
   		
   		//获取URL中默认的页面查询参数
   		work_areadd = getUrlParam("area");
   		op_idd = getUrlParam("opID");
		station_id = getUrlParam("stationID");
		building_id = getUrlParam("buildingID");
		sensor_codee = getUrlParam("sensor_code");
		point_type = getUrlParam("point_type");
		// console.log("building_id:"+building_id);
        //getOperationClass();
        getWorkArea();
   		forwardTempimage();
   		forwardHistoryimage();
   		onOpenOneWarnDetailFrame();
   		
		$('.list_lh li:even').addClass('lieven');
		// getWarnNews();
	})
	/* $(function(){
		$("div.list_lh").myScroll({
			speed:60, //数值越大，速度越慢
			rowHeight:68 //li的高度
		});
	}); */
	function autoScroll(){
		$("div .list_lh").myScroll({
			speed:60, //数值越大，速度越慢
			rowHeight:68 //li的高度
		});
	}
	//获取url中的参数
    function getUrlParam(name) {
      var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
      var r = window.location.search.substr(1).match(reg); //匹配目标参数
      if (r != null) 
      	return unescape(r[2]); 
      return null; //返回参数值
    }	
	
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
				    var imageList = data.content;
		            if (result == true) { //成功添加
		            	document.getElementById("add_Carousel").innerHTML = "";
		            	//document.getElementById("add_time").innerHTML = "";
		            	var max_temp=0;
		            	var create_time = "";
		            	  $.each(imageList, function(i,value){
		            	  	create_time = value.create_time;
		            	  	max_temp = value.max_temp;
		            		 if(i==0){
		            			 $('#add_Carousel').append('<div class="item active" > <img style="height:100%;width:100%;" src="<%=baseImagePath%>'+value.url+'" alt="First slide"> </div>');
		            		 }else{
		            			 $('#add_Carousel').append('<div class="item" > <img style="height:100%;width:100%;" src="<%=baseImagePath%>'+value.url+'" alt="First slide"> </div>');
		            		 }
		            		 /* if(i==2){
		            			 $('#add_time').append('<p>'+value.create_time+'</p>');
		            		 } */
		            	  });
		            	  
		            	  $('.sblefttxt1 p').html(max_temp+'°C');
		            	  
		            	  $('.rttxt1 p').html($('#add_sensor_code').find("option:selected").text());
		            	 $('.rttxt3 p').html(create_time);
						}
		            else{
		            	//alert("ghgfd");
		            	$.toaster({ priority : 'warning', title : '提示信息', message : '当前测温点无告警图片！'});
		             }
				    }
		        });
		}


     /**
      *  告警推送 
      */
     	
      function getWarnNews(){
         var status = $('#warn_status option:selected').val(); 
         var sensor=$('#add_sensor_code').val();
     	 $.ajax({
     		    type: 'POST',
     		    dataType: 'json',
     		    url: "<%=request.getContextPath()%>"+"/warn/getWarnNews",
     		    data:{"sensor":sensor,"status":status},
     		    success: function(data) {
     		        document.getElementById("news").innerHTML = "";
     				var result = data.result;
     			    var imageList = data.content;
     	            if (result == true) { //成功添加
     	            	  $.each(imageList, function(i,value){
     	            	     var a=null;
     	            	     
     	            	     var myurl='${context_path}/warn/lookWord?id='+value.id;
     	            	     if(value.status==0){
     	            	         //a='<li><p><a href="#" target="_blank">'+value.op_name+'</a><a href="#" target="_blank" class="btn_lh">'+value.platform_code+'</a><em>未确认</em></p><p><a href="#" target="_blank" class="a_blue">'+value.station_name+'->'+value.building_name+'->'+value.sensorName+'</a><span>'+value.create_time+'</span></p></li>'
     	            	         
     	            	         a='<li style="width:100%"><p><a href="javascript:;" target="_blank">'+value.op_name+'</a><a href="javascript:;" target="_blank" class="btn_lh">'+value.platform_code+'</a><em>'+value.max_temp+'℃</em><em>未确认</em></p><p><a href="javascript:;" data-index="251" url="'+myurl+'" class="a_blue">'+value.station_name+'->'+value.building_name+'->'+value.sensorName+'</a><span>'+value.create_time+'</span></p></li>';
     	            	     	
     	            	     }else{
     	            	         //a='<li><p><a href="#" target="_blank">'+value.op_name+'</a><a href="#" target="_blank" class="btn_lh">'+value.platform_code+'</a><em style="color:green;">已确认</em></p><p><a href="#" target="_blank" class="a_blue">'+value.station_name+'->'+value.building_name+'->'+value.sensorName+'</a><span>'+value.create_time+'</span></p></li>';
     	            	         a='<li style="width:100%"><p><a href="javascript:;" target="_blank">'+value.op_name+'</a><a href="javascript:;" target="_blank" class="btn_lh">'+value.platform_code+'</a><em>'+value.max_temp+'℃</em><em style="color:green;">已确认</em></p><p><a href="javascript:;" data-index="251" url="'+myurl+'" class="a_blue">'+value.station_name+'->'+value.building_name+'->'+value.sensorName+'</a><span>'+value.create_time+'</span></p></li>'
     	            	     }	
     	  	                 $('#news').append(a); 
     	            	  });
     	            	  $('.list_lh li:even').addClass('lieven');
     	            	  
     	            	  autoScroll();
     				}else{
     	            	// alert("ghgfd");
     	            	$.toaster({ priority : 'danger', title : '提示信息', message: '当前测温点无告警记录信息！'});
     	            }
     			    }
     	        });
     	}
     
     /* function getWarn(){
         //var sindex = which.selectedIndex;
         var a=$('#warn_status option:selected').val();
        // var which = $('#warn_status');
         //alert(a);
         getWarnNews(a); 
     } */
     
     
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
					 var index = (work_areadd!=null?work_areadd:0);
				    $.each(content, function(i,value){
				    	if(index==0 || index=='undefined'){
				     		index = 1;
				     	}else{
				     		if(index==value.id){
				     			index = i+1;
				     		}
				     	}
				     	
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
	    if(sindex==0){
	    	isSelect('typealert',which);
	    }else {
	    	getOperationClass2();
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
						var index =(op_idd!=null?op_idd:0);
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
 						var index = 0 ;
 						if(ifirst==0){
 							index =(op_idd!=null?op_idd:0); // 默认打开页面时，默认的班组
 						}
 					    $.each(result, function(i,value){
 					    	if(index==0 || index=='undefined'){
					     		index = 1;
					     		op_idd = value.id;
					     	}else{
					     		if(index==value.id){
					     			index = i+1;
					     			op_idd = value.id;
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
 		//op_idd=null;
 	}
 	function getOpClassSelect(which){
 	    var sindex = which.selectedIndex;
 		if(sindex == 0){
 			isSelect('typealert',which);
 		}else{
 			getStation(which.value);
 			op_idd=which.value;
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
 						var index = 0;
 						if(ifirst==0){
 							index = (station_id=='undefined'||station_id==null)?0:station_id; // 设置默认选择的变电站; // 设置默认选择的变电站
 					    }
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
 	        //station_id=null;	        
 	}
 	function managerSelect(which){
 		station_id=which.value;
 		// console.log("station_id="+station_id);
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
 						var index = 0;
 						if(ifirst==0){
 							index = (building_id=='undefined'||building_id==null)?0:building_id; //设置默认选择的变电站;			
 					    }
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
 		building_id=which.value;					
 		//command();
 		getCode(which.value);
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
 			    url: "<%=request.getContextPath()%>"+"/galleryquery/getSensorCode",
 			    data:{//"room":room.val(),
 			    	"building_id":para},
 			    success: function(data) {
 			    	var notEmpty = data.result;
 					var result = data.content;
 					
 					if(notEmpty){
 						var index = 1;
 						
 					     $.each(result, function(i,value){
 					     	
 					     	if(ifirst==0&&sensor_codee!=null && point_type!=null){
 					     		if(sensor_codee==value.sensor_code && point_type==value.point_type){
 					     			index = i+1;
 					     			sensor_codee=value.sensor_code;
 					     			point_type=value.point_type;
 					     			sensorName=value.name;
 					     		}
 							}
 					    	$('#add_sensor_code').append("<option value='"+value.sensor_code+"/"+value.point_type+"'>"+value.name+"("+value.platform_code+")</option>"); 
 					    	
 					    });
 					    $('#add_sensor_code').get(0).selectedIndex=index;//index为索引值					   
 						//var device = document.getElementById("add_sensor_code");// $('#add_sensor_code');				       
 					}
 					timeSelect($('#add_sensor_code'));
 					ifirst++;
 			    },
 			    complete: function () {
 			    	ifirst++;
 			    }
 			   
 	        });
 	}
 	function timeSelect(which){	
 		//daterangetimeplugin();
 		/* if(which.value&&which.value.split("/")){
	 		sensor_codee=which.value.split("/")[0];
	 		point_type=which.value.split("/")[1];
	 	} */
	 	daterangetimeplugin();
 		command();
 	}
	
	function command(){
		getWarnImageDetil();
		
		getRealTemp();
		getWarnNews();
	}
	
	 function getRealTemp(){
        	var op_class= $("#station_op_class").val();
    		var station= $("#add_station").val();
    		var building = $("#add_building").val();
    		var sensor= $("#add_sensor_code").val();
    		var status = $('#warn_status option:selected').val(); 
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
                url:'${context_path}/warndetil/getDefaultTemp',
                mtype: "GET",
                datatype: "json",
                postData:{'status':status,'op_class':op_class,'station':station,'building':building,'sensor':sensor},
                colModel: [
                	{ label: '测温时间', name: 'create_time', width: 25 ,sortable:false},
                	{ label: '最高温度', name: 'max_temp', width: 15 ,sortable:false},
                    { label: '最低温度', name: 'min_temp', width: 15 ,sortable:false},
                    { label: '中心点温度', name: 'av_temp', width: 15,sortable:false},
                ],
   				sortorder:'desc',
				hoverrows:true,
				viewrecords:false,
                height: 'auto',
                scrollrows:true,
                rowNum: 20,
                multiselect: false,//checkbox多选
                loadComplete : function() {
					var table = this;
					setTimeout(function(){
						updatePagerIcons(table);
					}, 0);
				}
            });
			$(window).triggerHandler('resize.jqGrid');

        }
	
	/**
	* 当温度曲线的点过于密集时进行自适应抽样
	*/
	function reduceIndex(arr, reduceWidth,reduceIndex) {
         realWidth = arr.length;
         var newArr = []; // 需要保留第一条数据
         if (reduceWidth > 0 && realWidth > reduceWidth * reduceIndex) {
             // 需要消减，并且满足消减系数约束
             
             newArr.push(arr[0]);
             reduceStep = (realWidth - 2) / (reduceWidth - 2); // 消减步长，由于已经选择了首尾元素，计算时的分子分母都需要-2
             var cnt = 2; // 计数器
             var curP = 0; // 当前获取到的元素的下标
             while ( cnt * reduceStep < realWidth ) {
                 index = Math.floor( cnt*reduceStep );//计算本次选中的元素的下标，下标元素需要下取整
                 var temp = arr[index];
                 temp.create_time=temp.create_time.split(" ")[1];
                 newArr.push(temp);
                 curP = index;
                 cnt ++;
             }
             if (curP != realWidth-1) {
                 //最后一个元素没有取到，现在保存最后一个元素
                 newArr.push(arr[realWidth-1]);
             }
             arr = newArr
         }else {
         	$.each(arr, function(i,value){
         		arr[i]=value.create_time.substr(8,15);//.replace(" ","号");
         	}); 
         }
         return arr;
     }
	

	/**
	* tab初始化
	*/
	function tabsEventInit(){
		$('.main-content', window.parent.document).find(".page-tabs-content a").on("click",function(){
			if($(this).hasClass("active")==false){
				$('.main-content', window.parent.document).find(".page-tabs-content a").removeClass("active");
				$(this).addClass("active");
				var menu=$('.main-container', window.parent.document).find('[url="'+($(this).attr("data-id")=='/home'?'/':$(this).attr("data-id"))+'"]'); 
				
				menu.click();
			    $('.main-container', window.parent.document).find(".nav-list li").removeClass("active");
				menu.parent("li").addClass("active");
				$('.main-container', window.parent.document).find(".nav-list li").removeClass("open");
				menu.parent("li").parents("li").addClass("open");
				menu.parent("ul").css("display","block");
			}
		});
		$('.main-content', window.parent.document).find(".page-tabs-content .fa-times-circle").on("click",function(){
			if($(this).parent("a").hasClass("active")){
				var nextnode=$(this).parent("a").next();
				$('.main-content', window.parent.document).find(".page-tabs-content a").removeClass("active");
				if(nextnode.length>0){
					nextnode.addClass("active");
				}else{
					nextnode=$(this).parent("a").prev();
				}
				nextnode.addClass("active");
				var menu=$('.main-container', window.parent.document).find('[url="'+(nextnode.attr("data-id")=='/home'?'/':nextnode.attr("data-id"))+'"]'); 
				menu.click();
			    $('.main-container', window.parent.document).find(".nav-list li").removeClass("active");
				menu.parent("li").addClass("active");
				$('.main-container', window.parent.document).find(".nav-list li").removeClass("open");
				menu.parent("li").parents("li").addClass("open");
				menu.parent("ul").css("display","block");
			}
			var iframe=$("#content-main", window.parent.document).find("[data-id='"+$(this).parent("a").attr("data-id")+"']");
			iframe.remove();
			$(this).parent("a").remove();
		});
	}
	
	/**
	* tab初始化
	*/
	function tabsEventClear(){
		$('.main-content', window.parent.document).find(".page-tabs-content a").unbind("click");
		$('.main-content', window.parent.document).find(".page-tabs-content .fa-times-circle").unbind("click");
	}
	
	function forwardTempimage(){
		$("#gotempimage").on("click",function(e){
			e.preventDefault();
			var wa_idd2 = $("#work_area_class").val();
			var op_idd2 = $("#station_op_class").val();
			var station_id2 =$("#add_station").val();
			var building_id2 = $("#add_building").val();
			var sensor_codee2 = $("#add_sensor_code").val();
			var point_type2;
			if(sensor_codee2!=null){
				var sp = sensor_codee2.split("/");
				sensor_codee2=sp[0];
				point_type2=sp[1];
			}

			var url;
			// point_type = getUrlParam("point_type");
			if(op_idd2!=null && station_id2!=null&&building_id2!=null&&sensor_codee2!=null){
				url = '${context_path}/temp?work_area_id='+wa_idd2+'&opID='+op_idd2+'&stationID='+station_id2+'&buildingID='+building_id2+'&sensor_code='+sensor_codee2+'&point_type='+point_type2;
			}
			var dataIndex = 198;
			var dataId = "/temp"
			if(url){
				var history;
				$('.J_iframe', window.parent.document).each(function(){
					if($(this).css("display")=="inline"){
						history = $(this).attr("data-id");
						return false;
					}
				});
				//console.log("forwardTempimage history="+history);
				$('.main-content', window.parent.document).find("iframe").css("display","none");
				window.location.hash=url;
				if(url=="/index"||url=="/"){
					url="/home";
				};
				var str = url.split("?");
				var dataid;
				if(str!=null && str.length>0){
					dataid = str[0].substr(4,10);
				}
				
				//var iframe=$("#content-main").find("[data-id='"+url+"']");
				var iframe=$('#content-main', window.parent.document).find("[data-id='"+dataid+"']");
				$('.main-container', window.parent.document).find(".nav-list li").removeClass("active");
				$('.main-container', window.parent.document).find(".nav-list li").find("[data-index='"+$(this).attr("data-index")+"']").parent("li").addClass("active");
				
				if(iframe.length>0){
					iframe.css("display","inline");
					currentIframe=iframe;
				}else{
					var index=$(this).attr("data-index");
					var ihtml='<iframe class="J_iframe" data-history="'+history+'" data-tag="temp" name="iframe'+index+'" width="100%" height="100%" src="'+url+'" frameborder="0" data-id="'+dataid+'" seamless style="display:inline;"></iframe>';
					$('#content-main', window.parent.document).append(ihtml);
					currentIframe=$('#content-main', window.parent.document).find("[data-id='"+dataid+"']");
				}
				// currentIframe.css("display","inline");
				var $page_tabs_content = $('.main-content', window.parent.document).find("div .page-tabs-content");
				var tab = $('.main-content', window.parent.document).find("div .page-tabs-content").find("[data-id='"+dataid+"']");
				// var tab=$(".page-tabs-content").find("[data-id='"+url+"']");
				//$(".page-tabs-content a").removeClass("active");
				$page_tabs_content.find("a").removeClass("active");
				if(tab.length > 0){
					tab.addClass("active");
				}else{
					$page_tabs_content.append('<a href="javascript:;" class="J_menuTab active" data-index="'+$(this).attr("data-index")+'" data-id="'+dataid+'">测温记录<i class="fa fa-times-circle"></i></a>');
					//tabsEventClear();
					//tabsEventInit();
				}
			}
		});
	}
	function forwardHistoryimage(){
		$("#historyImageBtn").on("click",function(e){
			e.preventDefault();
			var op_idd2 = $("#station_op_class").val();
			var station_id2 =$("#add_station").val();
			var building_id2 = $("#add_building").val();
			var sensor_codee2 = $("#add_sensor_code").val();
			var point_type2;
			if(sensor_codee2!=null){
				var sp = sensor_codee2.split("/");
				sensor_codee2=sp[0];
				point_type2=sp[1];
			}
			var url;
			if(op_idd2!=null && station_id2!=null&&building_id2!=null&&sensor_codee2!=null){
				url = '${context_path}/galleryquery?opID='+op_idd2+'&stationID='+station_id2+'&buildingID='+building_id2+'&sensor_code='+sensor_codee2+'&point_type='+point_type2;
			}
			var dataIndex = 225;
			var dataId = "/galleryquery"
			if(url){
				var history;
				$('.J_iframe', window.parent.document).each(function(){
					if($(this).css("display")=="inline"){
						history = $(this).attr("data-id");
						return false;
					}
				});
				//console.log("forwardHistoryimage history="+history);
				$('.main-content', window.parent.document).find("iframe").css("display","none");
				window.location.hash=url;
				if(url=="/index"||url=="/"){
					url="/home";
				};
				var str = url.split("?");
				var dataid;
				if(str!=null && str.length>0){
					dataid = str[0].substr(4,13);
				}
				
				//var iframe=$("#content-main").find("[data-id='"+url+"']");
				var iframe=$('#content-main', window.parent.document).find("[data-id='"+dataid+"']");
				$('.main-container', window.parent.document).find(".nav-list li").removeClass("active");
				$('.main-container', window.parent.document).find(".nav-list li").find("[data-index='"+$(this).attr("data-index")+"']").parent("li").addClass("active");
				
				if(iframe.length>0){
					iframe.css("display","inline");
					currentIframe=iframe;
				}else{
					var index=$(this).attr("data-index");
					var ihtml='<iframe class="J_iframe" data-history="'+history+'" data-tag="temp" name="iframe'+index+'" width="100%" height="100%" src="'+url+'" frameborder="0" data-id="'+dataid+'" seamless style="display:inline;"></iframe>';
					$('#content-main', window.parent.document).append(ihtml);
					currentIframe=$('#content-main', window.parent.document).find("[data-id='"+dataid+"']");
				}
				// currentIframe.css("display","inline");
				var $page_tabs_content = $('.main-content', window.parent.document).find("div .page-tabs-content");
				var tab = $('.main-content', window.parent.document).find("div .page-tabs-content").find("[data-id='"+dataid+"']");
				// var tab=$(".page-tabs-content").find("[data-id='"+url+"']");
				//$(".page-tabs-content a").removeClass("active");
				$page_tabs_content.find("a").removeClass("active");
				if(tab.length > 0){
					tab.addClass("active");
				}else{
					$page_tabs_content.append('<a href="javascript:;" class="J_menuTab active" data-index="'+$(this).attr("data-index")+'" data-id="'+dataid+'">测温图库<i class="fa fa-times-circle"></i></a>');
					//tabsEventClear();
					//tabsEventInit();
				}
			}
		});
	}
	
	/**
	* 点击打开某一条告警的详细信息页面
	*/
	function onOpenOneWarnDetailFrame(){
		$("#news").on("click","a",function(e){
			e.preventDefault();
			var url=$(this).attr("url");
			if(url){
				var history;
				$('.J_iframe', window.parent.document).each(function(){
					if($(this).css("display")=="inline"){
						history = $(this).attr("data-id");
						return false;
					}
				});
				
				$('.main-content', window.parent.document).find("iframe").css("display","none");
				window.location.hash=url;
				if(url=="/index"||url=="/"){
					url="/home";
				};
				var str = url.split("?");
				var dataid;
				if(str!=null && str.length>0){
					dataid = str[0].substr(4,18);
				}
				
				//var iframe=$("#content-main").find("[data-id='"+url+"']");
				var iframe=$('#content-main', window.parent.document).find("[data-id='"+dataid+"']");
				$('.main-container', window.parent.document).find(".nav-list li").removeClass("active");
				$('.main-container', window.parent.document).find(".nav-list li").find("[data-index='"+$(this).attr("data-index")+"']").parent("li").addClass("active");
				
				if(iframe.length>0){
					iframe.css("display","inline");
					currentIframe=iframe;
				}else{
					var index=$(this).attr("data-index");
					var ihtml='<iframe class="J_iframe" data-history="'+history+'" data-tag="temp" name="iframe'+index+'" width="100%" height="100%" src="'+url+'" frameborder="0" data-id="'+dataid+'" seamless style="display:inline;"></iframe>';
					$('#content-main', window.parent.document).append(ihtml);
					currentIframe=$('#content-main', window.parent.document).find("[data-id='"+dataid+"']");
					
				}
				// currentIframe.css("display","inline");
				var $page_tabs_content = $('.main-content', window.parent.document).find("div .page-tabs-content");
				var tab = $('.main-content', window.parent.document).find("div .page-tabs-content").find("[data-id='"+dataid+"']");
				// var tab=$(".page-tabs-content").find("[data-id='"+url+"']");
				//$(".page-tabs-content a").removeClass("active");
				$page_tabs_content.find("a").removeClass("active");
				if(tab.length > 0){
					tab.addClass("active");
				}else{
					$page_tabs_content.append('<a href="javascript:;" class="J_menuTab active" data-index="'+$(this).attr("data-index")+'" data-id="'+dataid+'">告警详情<i class="fa fa-times-circle"></i></a>');
					
					//tabsEventClear();
					//tabsEventInit();
				}
			}
		});
	}
	
		function tempdometer(target,imin,imax){
		Highcharts.chart(target, {
		    chart: {
		        type: 'gauge',
		        plotBackgroundColor: null,
		        plotBackgroundImage: null,
		        plotBorderWidth: 0,
		        plotShadow: false
		    },
		
		    title: {
		        text: ''
		    },
		
		    pane: {
		        startAngle: -150,
		        endAngle: 150,
		        background: [{
		            backgroundColor: {
		                linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
		                stops: [
		                    [0, '#FFF'],
		                    [1, '#333']
		                ]
		            },
		            borderWidth: 0,
		            outerRadius: '109%'
		        }, {
		            backgroundColor: {
		                linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
		                stops: [
		                    [0, '#333'],
		                    [1, '#FFF']
		                ]
		            },
		            borderWidth: 1,
		            outerRadius: '107%'
		        }, {
		            // default background
		        }, {
		            backgroundColor: '#DDD',
		            borderWidth: 0,
		            outerRadius: '105%',
		            innerRadius: '103%'
		        }]
		    },
		
		    // the value axis
		    yAxis: {
		        min: 0,
		        max: 200,
		
		        minorTickInterval: 'auto',
		        minorTickWidth: 1,
		        minorTickLength: 10,
		        minorTickPosition: 'inside',
		        minorTickColor: '#666',
		
		        tickPixelInterval: 30,
		        tickWidth: 2,
		        tickPosition: 'inside',
		        tickLength: 10,
		        tickColor: '#666',
		        labels: {
		            step: 2,
		            rotation: 'auto'
		        },
		        title: {
		            text: '℃'
		        },
		        plotBands: [{
		            from: 0,
		            to: 120,
		            color: '#55BF3B' // green
		        }, {
		            from: 120,
		            to: 160,
		            color: '#DDDF0D' // yellow
		        }, {
		            from: 160,
		            to: 200,
		            color: '#DF5353' // red
		        }]
		    },
		
		    series: [{
		        name: '温度',
		        data: [imax,imin],
		        tooltip: {
		            valueSuffix: ' ℃'
		        }
		    }]
		
		},
		// Add some life
		function (chart) {
		    if (!chart.renderer.forExport) {
		        setInterval(function () {
		            var point = chart.series[0].points[0],
		                newVal,
		                inc = Math.round((Math.random() - 0.5) * 20);
		
		            newVal = point.y + inc;
		            if (newVal < 0 || newVal > 200) {
		                newVal = point.y - inc;
		            }
		
		            point.update(newVal);
		
		        }, 3000);
		    }
		});
	
	}
	
	
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