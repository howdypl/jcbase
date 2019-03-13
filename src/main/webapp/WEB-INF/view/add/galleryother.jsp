<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% System.setProperty("no_visible_elements", "false"); %>
<link href='${res_url}css/page.css' rel='stylesheet'>
<link href="${res_url}css/final/global.css" rel="stylesheet" type="text/css">
<link href="${res_url}css/final/shouye.css" rel="stylesheet" type="text/css">
<%
	String virtualImages = "/backendimageinf";
	String baseImagePath = request.getScheme()+"://"
			+request.getServerName()+":"
			+request.getServerPort()+virtualImages+"/"; %>	
<jsp:include page="/WEB-INF/view/add/common/header.jsp" flush="true" />

    <div class="row" style="margin-bottom:20px;">
        <div class="box col-md-12">
            <div class="box-inner" style="overflow:hidden">
                <div class="box-header well" data-original-title="">
                    <h2><i class="glyphicon glyphicon-search"></i> 可疑自然图像</h2>

                </div>
                <div class="box-content" style="overflow:hidden"> 
                    	<!-- <div class="row" style="margin-left: 15px">
							<div class="col-md-3" style="width: 16%">
							<label class="form-label control-label">班组：</label>
							</div>
							<div class="col-md-3" style="width: 16%">
							<label class="form-label control-label">变电站：</label>
							</div>
							<div class="col-md-3" style="width: 16%">
							<label class="form-label control-label">设备间：</label>
							</div>
							<div class="col-md-3" style="width: 16%">
							<label class="form-label control-label">设备：</label>
							</div>
							<div class="col-md-3" style="width: 16%">
							<label class="form-label control-label">起止时间</label> 
							</div>
						</div> -->
						<div class="row" style="padding-bottom: 5px;margin-top: 5px;">
							<div id="work_area_div" class="col-md-2" style="width: 10%;">
								<select name="work_area_id"  id="work_area_class" 
									onchange="getWorkAreaSelect(this)" 
									class="form-control selectpicker">
									<option value='0'>---请选择工区---</option>
									</select>
							</div>
						
						    <div id="operation_class_div" class="col-md-3" style="width: 10%">
								<select id="station_op_class" onchange="getOpClassSelect(this)" class="form-control selectpicker">
	                        		 <option  value='0'>---请选择班组---</option>
	                       		</select>
							</div>
							<div class="col-md-3" style="width: 12%">
							   <select id="add_station" onchange="managerSelect(this)" class="form-control selectpicker">
	                        		<option  value='0'>---请选择变电站---</option>
	                       		</select>
							</div>
							<div class="col-md-3" style="width: 13%">
								<select id="add_building" onchange="typeSelect(this)" class="form-control selectpicker">
	                        		<option  value='0'>---请选择设备间---</option>
		                       	</select>
							</div>
							<div class="col-md-3" style="width: 14%">
								<select id="add_sensor_code" onchange="timeSelect(this)"  class="form-control selectpicker">
		                        		<option  value='0'>---请选择设备---</option>
		                       	</select>	
							</div>
							<div class="col-md-3" style="width: 16%">
								<div id="reportrange" class="pull-left dateRange" style="width:350px">
									<i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
									<span id="searchDateRange"></span>
									<b class="caret"></b>
								</div>	
							</div>
						</div> <!-- END div class="row" style="padding-bottom: 10px;margin-top: 20px;"> -->
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
	      					</div> -->			
	                   <!-- <div style='text-align:center;margin-top:50px'><span id='process_image' class='availability_status' > </span></div> -->

	                   <div class="wdpicbox1" style="overflow:hidden">
	                   		<ul id = "myquerygallery" style="width:105%;margin-bottom:30px;">
	                   		</ul> 
	                   </div>
	                   
						
                	</div><!--END <div class="box-content">  -->
                	
                	
            </div>
            
        </div>
        <!--/span-->
    </div><!--/row-->
    <div class="row" style="margin-top:20px;">
	    <div class="page-wrap" style="position: fixed;left:0;bottom: 0;">
			<div class="page-info" style="padding-left: 32%">
				<span>共有:</span><span id="listCount">0</span><span>条</span> 
				<span>共有:</span><span id="pageCount">0</span><span>页</span> 
				<span>页面显示:</span><span id="currentCount">0</span> <span>条</span> 
				<span class="current " id="firstPage"><<</span> 
				<span class="current " id="PreviousPage"><</span> 
				<span class="current " id="pageIndex">1</span> 
				<span class="current " id="nextPage">></span>
				<span class="current " id="lastPage">>></span> 
				<input type="text" id="go_index" />
				<span class="current"  id="go">转</span>
			</div>
		</div><!-- <div class="page-wrap"> -->
	</div>
<%-- <script src="${res_url}jsto/jquery.magnific-popup.min.js"></script> <!-- Magnific popup (http://dimsemenov.com/plugins/magnific-popup/) --> --%>
<script src="${res_url}js/spin.js"></script>
<script src="${res_url}js/ladda.js"></script>
<script type="text/javascript"> 
	var op_idd = 0;
	var station_id = 0;
	var building_id = 0;
	var sensor_codee = null;
	var point_type = 0;        
   //***********************分页***********************
   var pageIndex = 1,pageCount;
   $(document).ready(function(){
   
   		//获取URL中默认的页面查询参数
   		op_idd = getUrlParam("opID");
		station_id = getUrlParam("stationID");
		building_id = getUrlParam("buildingID");
		sensor_codee = getUrlParam("sensor_code");
		point_type = getUrlParam("point_type");
		//console.log("op_idd="+op_idd+",station_id="+station_id+",building_id="+building_id+",sensor_codee="+sensor_codee+",point_type="+point_type)
        getWorkArea();
   
   		var user_type = "${sessionScope.sysUser.user_type}";

	 	if(user_type==1){//隐藏工区选择
	 		getWAWord();
	 	}else if(user_type==2){//隐藏运维选择
	 		getWord();
	 	}
   
   
		//首页
		$("#firstPage").click(function(){		
			pageIndex = 1;
			Page();		
		});
		
		//上一页
	    $("#PreviousPage").click(function(){    	
	    	pageIndex = pageIndex - 1;
			if(pageIndex == 0){
				pageIndex = 1;
			}
			Page();		
		});
	
	    //下一页
	    $("#nextPage").click(function(){    	
	    	pageIndex = pageIndex + 1;
			if(pageIndex >= pageCount){
				pageIndex = pageCount;
			}
			Page();
	    });
		
	    //尾页
	    $("#lastPage").click(function(){		
	    	pageIndex = pageCount;
	    	Page();	
		});
	    
	    // Go
	    $("#go").click(function(){    	
	    	var _index = $("#go_index").val().trim(); 
	        if( _index > 0 && _index <= pageCount){
	        	pageIndex = _index;        	
	        }else {  
	        	 $.toaster({ priority : 'warning', title : '告警信息', message : '请输入正确页码！'});    	
	        }
	        Page();
			$("#go_index").val("");   	
	    });	
	});
	
	
	function getWord() {
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: '<%=request.getContextPath()%>/sys/user/getWord?name="${sessionScope.sysUser.name}"',
			    success: function(data) {
					var result = data.word;
					if(!result){
						 $('#btn-delect').remove();
						 //$('#bnt-grant').remove();
						 $('#work_area_div').hide();
						  $('#operation_class_div').hide();
					}
			    }
	        });
  	} 
  	
	 function getWAWord() {
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: '<%=request.getContextPath()%>/sys/user/getWAWord?name="${sessionScope.sysUser.name}"',
			    success: function(data) {
					var result = data.word;
					if(!result){
						 //$('#btn-delect').remove();
						 //$('#bnt-grant').remove();
						 $('#work_area_div').hide();
					}
			    }
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
	function onLoadingSet(){
		$(".availability_status").html('<img src="${res_url}img/loader3.gif" align="absmiddle">');
	}
	function Page(){
		var op_class= $("#station_op_class").val();
		var station= $("#add_station").val();
		var building = $("#add_building").val();
		var sensor= $("#add_sensor_code").val();
		var timeArray = $('#reportrange span').html().split(" - ");	
		onLoadingSet();
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/othergallery/getImages",
			    data: {
			    	    "op_class":op_class,
			    	    "station":station,
			    		"sensor":sensor,
			    		"building":building,
			    		"create_time":timeArray[0],
			    		"end_time":timeArray[1],
			    		"page":pageIndex
			    		},
			    success: function(data) {
					var result = data.result;
				    var imageList = data.imageList;
				    var _page = data.pageInfo;
		            if (result == true) {
		            	 //添加列表图片
		            	 document.getElementById("myquerygallery").innerHTML = ""; 
		                 $.each(imageList, function(i,value){
		                    var paths="<%=baseImagePath%>";
					    	if(value.url!=null){
					    	    paths += value.url;
					    	}else{
					    	    paths = "${res_url}img/noimage.jpg";
					    	}
						   	var temp = document.createElement("li"); 
					     	temp.id = value.id;
					     	//temp.className = "thumbnail";
					     	document.getElementById("myquerygallery").appendChild(temp);
					     	
					     	var wdpictopbox1 = document.createElement("div");
					     	wdpictopbox1.className='wdpictopbox1';
					     	temp.appendChild(wdpictopbox1);
					     	
					     	var tempa = document.createElement("a"); 
					     	//tempa.href= paths;
					     	tempa.href= "javascript:;";
					     	tempa.title = value.create_time+"\n"+"        "+value.station_name+"\n"+"        "+value.sensor_name+"\n"+"        "+value.platform_code;
					     	tempa.className="gallery";
					     	wdpictopbox1.appendChild(tempa);
					     	
					     	$(tempa).on("click",function(e){
					     		e.preventDefault();
					     		
					     		parent.layer.open({
  									title: '图片查看',
								    type: 2,
								    anim: 2,
								    shadeClose: true,
								    area: ['700px','600px'],
								    content: '${context_path}/othergallery/openGallery?id='+value.id+'&sensor_code='+value.im_sensor_code+'&create_time='+value.create_time+'&point_type='+value.point_type   
								});
					     		
					     	});
					     	
					     	
					     	var tempimg = document.createElement("img"); 
					     	var paths="<%=baseImagePath%>";
					    	if(value.url!=null){
					    	    paths += value.url;
					    	}
					    	else{
					    	    paths = "${res_url}img/noimage.jpg";
					    	}
					     	tempimg.src= paths;
							//tempimg.className = "gallery";
							tempa.appendChild(tempimg);
					     	
					     	var wdpicdownbox1 = document.createElement("div");
					     	wdpicdownbox1.className='wdpicdownbox1';
					     	temp.appendChild(wdpicdownbox1);
					     	
					     	var wdpicdowntxt1 = document.createElement("div");
					     	wdpicdowntxt1.className='wdpicdowntxt1';
					     	wdpicdownbox1.appendChild(wdpicdowntxt1);
					     	
					     						     	
					     	var wdpicdowntxt1P = document.createElement("p"); 
						    wdpicdowntxt1P.innerHTML = value.max+"°C";
						    wdpicdowntxt1.appendChild(wdpicdowntxt1P);
					     	
					     	/* if(value.warn_temp<=value.max){
					     		wdpicdowntxt1P.style.cssText += 'color:red;';
					     	}else {
					     		wdpicdowntxt1P.style.cssText += 'color:blue;';
					     	} */
					     	
					     	var wdpicdowntxt2 = document.createElement("div");
					     	wdpicdowntxt2.className='wdpicdowntxt2';
					     	wdpicdownbox1.appendChild(wdpicdowntxt2);
					     	
					     	var timetoptxt1 = document.createElement("div");
					     	timetoptxt1.className='timetoptxt1';
					     	wdpicdowntxt2.appendChild(timetoptxt1);
					     	
					     	var timetoptxt1P = document.createElement("p"); 
						    timetoptxt1P.innerHTML = value.station_name+" "+value.sensor_name;
						    timetoptxt1.appendChild(timetoptxt1P);
					     	
							var timedowntxt1 = document.createElement("div");
					     	timedowntxt1.className='timedowntxt1';
					     	wdpicdowntxt2.appendChild(timedowntxt1);
					     	
					     	var timedowntxt1P = document.createElement("p"); 
						    timedowntxt1P.innerHTML = value.create_time;
						    timedowntxt1.appendChild(timedowntxt1P);
					    	    						     	
					    }); 					    
 					    /* $("a.gallery").colorbox({
 							"rel":"gallery"
 						}); */
 					    //添加分页信息
 					    pageCount = _page.pageCount;
		
						$("#listCount").html(_page.count);
						$("#pageCount").html(pageCount);
						$("#currentCount").html(imageList.length);
						$("#pageIndex").html(_page.pageIndex);
		                return true;
		            }else{ //添加失败
		            	document.getElementById("myquerygallery").innerHTML = "";
		                $.toaster({ priority : 'warning', title : '告警信息', message : '在时间区间没有图片！'});
		                return false;
		            }		            
			    },
			    error:function(){
			    	$.toaster({ priority : 'danger', title : '错误信息', message : '请求下发指令错误，请确认路径正确或网络正常！'});
			    },
				complete: function () {
					$('#process_image').hide();
				}
	        });	        
	    return false;
	}
	
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
	    if(sindex==0){
	    	isSelect('typealert',which);
	    }else {
	    	getOperationClass2();
	    }
	    /* $('#station_op_class').empty();
		$('#station_op_class').append("<option value='0'>---请选择班组---</option>"); 
		commond();
		updata(); */
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
	    // op_idd=null;
	}
	function getOpClassSelect(which){
	    var sindex = which.selectedIndex;
		if(sindex == 0){
			isSelect('typealert',which);
		}else{
			getStation(which.value);
			//op_idd=which.value;
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
						var index =(station_id=='undefined'||station_id==null)?0:station_id;
					     $.each(result, function(i,value){
					     	if(index==0 || index=='undefined'){
					     		index = 0;
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
		// station_id=which.value;
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
						var index = (building_id=='undefined'||building_id==null)?0:building_id;			
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
		//building_id=which.value;				
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
					var result = data.content;
					
					if(notEmpty){
						var index = 0;
					     $.each(result, function(i,value){
						     if(sensor_codee!=null && point_type!=null){
					     		if(sensor_codee==value.sensor_code && point_type==value.point_type){
					     			index = i+1;
					     			sensor_codee=value.sensor_code;
 					     			point_type=value.point_type;
					     		}
	 						 } 
						     
						    $('#add_sensor_code').append("<option value='"+value.sensor_code+"/"+value.point_type+"'>"+value.name+"("+value.platform_code+")</option>"); 
						    	
					    });
					    $('#add_sensor_code').get(0).selectedIndex=index;//index为索引值	
					   /*  console.log("tempimage index="+index);
					    console.log("tempimage point_type="+point_type); */				   
						//var device = document.getElementById("add_sensor_code");// $('#add_sensor_code');				       
					}
					timeSelect();
			    }
	        });
	}
	function timeSelect(){	
		daterangetimeplugin();
		//command();
		//alert("1");
		pageIndex = 1;
		Page();
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
	      	$('#reportrange').on('apply.daterangepicker',function() {
	      		pageIndex = 1;
	      		Page();
	      	});
		      //设置日期菜单被选项  --结束--
	}
</script>

<jsp:include page="/WEB-INF/view/add/common/footer.jsp" flush="true" />