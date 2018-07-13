<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% System.setProperty("no_visible_elements", "false"); %>
<%-- <link href='${res_url}bower_components/colorbox/example1/colorbox.css' rel='stylesheet'> --%>
<%
	String virtualImages = "/backendimageinf";
	String baseImagePath = request.getScheme()+"://"
			+request.getServerName()+":"
			+request.getServerPort()+virtualImages+"/"; %>	
<jsp:include page="/WEB-INF/view/add/common/header.jsp" flush="true" />
    <div class="row">
        <div class="box col-md-12">
            <div class="box-inner">
                <div class="box-header well" data-original-title="">
                    <h2><i class="glyphicon glyphicon-search"></i> 图库</h2>

                </div>
                <div class="box-content">
                    <div class="row" style="margin-left: 15px">
							<div class="col-md-3" style="width: 16%">
							<label class="form-label control-label">运维班：</label>
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
						</div>
						<div class="row" style="margin-left: 15px">
						    <div class="col-md-3" style="width: 16%">
								<select id="station_op_class" onchange="getOpClassSelect(this)" class="form-control selectpicker">
	                        		 <option  value='0'>---请选择运维班---</option>
	                       		</select>
							</div>
							<div class="col-md-3" style="width: 16%">
							   <select id="add_station" onchange="managerSelect(this)" class="form-control selectpicker">
	                        		<option  value='0'>---请选择变电站---</option>
	                       		</select>
							</div>
							<div class="col-md-3" style="width: 16%">
								<select id="add_building" onchange="typeSelect(this)" class="form-control selectpicker">
	                        		<option  value='0'>---请选择设备间---</option>
		                       	</select>
							</div>
							<div class="col-md-3" style="width: 16%">
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
      					</div>      		 -->			
                    
                   <ul id = "myquerygallery" class="thumbnails gallery" style="margin-top: 30px">
                   </ul>
                </div>
            </div>
        </div>
        <!--/span-->
    </div><!--/row-->
<%-- <script src="${res_url}jsto/jquery.magnific-popup.min.js"></script> <!-- Magnific popup (http://dimsemenov.com/plugins/magnific-popup/) --> --%>
<script type="text/javascript">            
   $(window).load(function(){
			
        getOperationClass();
           
    }); 
    var status = 0;
	function command(){
		var op_class= $("#station_op_class").val();
		var station= $("#add_station").val();
		var building = $("#add_building").val();
		var sensor= $("#add_sensor_code").val();
		var timeArray = $('#reportrange span').html().split(" - ");	
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/galleryquery/getImages",
			    data: {
			    	    "op_class":op_class,
			    	    "station":station,
			    		"sensor":sensor,
			    		"building":building,
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
		daterangetimeplugin();
		command();
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
		      	 command();
		      	});
			      //设置日期菜单被选项  --结束--
		}
</script>

<jsp:include page="/WEB-INF/view/add/common/footer.jsp" flush="true" />