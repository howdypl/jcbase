<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% System.setProperty("no_visible_elements", "false"); %>
<%
	String virtualImages = "/backendimage";
	String baseImagePath = request.getScheme()+"://"
			+request.getServerName()+":"
			+request.getServerPort()+virtualImages+"/"; %>	
<link type="text/css" href="${res_url}css/style.css" rel="stylesheet" />
<jsp:include page="/WEB-INF/view/add/common/header.jsp" flush="true" />
    <div class="row">
        <div class="box col-md-12" style="width:100%">
            <div class="box-inner" style="height:190px;">
                <div class="box-header well">
                    <h2><i class="glyphicon glyphicon-search"></i> 测温动态光字牌</h2>
                </div>
                 <div class="box-content" class="table-responsive" style="padding: 0 10px 10px 10px">
                    <table id="add_table" class="table table-bordered">
                        <tr id="add_lie">

                        </tr>
                        <tr id="add_number">
                        
                        </tr>
                        <tr id="add_temp">
                        
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div class="box col-md-12" style="width:100%">
            <div class="box-inner" style="height:470px;">
                <div class="box-header well">
                    <h2><i class="glyphicon glyphicon-picture"></i> 设备实时测温及变化趋势</h2>
                    
                    <select id="add_station" onchange="managerSelect(this)" class="form-control selectpicker" style=" width:auto; float:right; margin-top: -17px;">
                		<option  value='0'>---请选择变电站---</option>
               		</select>
               		<h2 style="float:right; margin-right: 10px;">变电站：</h2>
               		<select id="station_op_class" onchange="getOpClassSelect(this)" class="form-control selectpicker" style=" width:auto; float:right; margin-top: -17px; margin-right: 25px;">
                		<option  value='0'>---请选择运维班---</option>
               		</select>
               		<h2 style="float:right; margin-right: 10px;">运维班：</h2>
                </div>
                <div class="box-content">
                	 <div id="container" style="width: 50%; height: 390px; margin: 0 auto; float: left;"></div>
                	 <div id="container1" style="width: 50%; height: 390px; margin: 0 auto;float: left;"></div>
                </div>
            </div>
        </div>
         <div class="box col-md-12" style="width:100%">
            <div class="box-inner" style="height:470px;">
                <div class="box-header well">
                    <h2><i class="glyphicon glyphicon-picture"></i> 温度异常抓拍图像</h2>
                </div>
                <div class="box-content">
                	 <ul id = "myquerygallery" class="thumbnails gallery">
                	
                     </ul>
                </div>
            </div>
        </div>
<!--         <div class="box col-md-12" style="width:auto">
            <div class="box-inner" style="height:470px;">
                <div class="box-header well" style="background:  coral;">
                    <h2><i class="glyphicon glyphicon-warning-sign"></i> 告警推送</h2>
                </div>
                
            <div class="bcon">
				<div class="list_lh">
					<ul id="news">
						<li>
							<p><a href="http://www.16sucai.com/" target="_blank">1000000</a><a href="http://www.16sucai.com/" target="_blank" class="btn_lh">领号</a><em>获得</em></p>
							<p><a href="http://www.16sucai.com/" target="_blank" class="a_blue">网游战江湖公测豪华礼包</a><span>17:28:05</span></p>
						</li>
						<li>
							<p><a href="http://www.16sucai.com/" target="_blank">2000000</a><a href="http://www.16sucai.com/" target="_blank" class="btn_lh">领号</a><em>获得</em></p>
							<p><a href="http://www.16sucai.com/" target="_blank" class="a_blue">网游战江湖公测豪华礼包</a><span>17:28:05</span></p>
						</li>
						<li>
							<p><a href="http://www.16sucai.com/" target="_blank">3000000</a><a href="http://www.16sucai.com/" target="_blank" class="btn_lh">领号</a><em>获得</em></p>
							<p><a href="http://www.16sucai.com/" target="_blank" class="a_blue">网游战江湖公测豪华礼包</a><span>17:28:05</span></p>
						</li>
						<li>
							<p><a href="http://www.16sucai.com/" target="_blank">4000000</a><a href="http://www.16sucai.com/" target="_blank" class="btn_lh">领号</a><em>获得</em></p>
							<p><a href="http://www.16sucai.com/" target="_blank" class="a_blue">网游战江湖公测豪华礼包</a><span>17:28:05</span></p>
						</li>
						<li>
							<p><a href="http://www.16sucai.com/" target="_blank">5000000</a><a href="http://www.16sucai.com/" target="_blank" class="btn_lh">领号</a><em>获得</em></p>
							<p><a href="http://www.16sucai.com/" target="_blank" class="a_blue">网游战江湖公测豪华礼包</a><span>17:28:05</span></p>
						</li>
						<li>
							<p><a href="http://www.16sucai.com/" target="_blank">6000000</a><a href="http://www.16sucai.com/" target="_blank" class="btn_lh">领号</a><em>获得</em></p>
							<p><a href="http://www.16sucai.com/" target="_blank" class="a_blue">网游战江湖公测豪华礼包</a><span>17:28:05</span></p>
						</li>
						<li>
							<p><a href="http://www.16sucai.com/" target="_blank">7000000</a><a href="http://www.16sucai.com/" target="_blank" class="btn_lh">领号</a><em>获得</em></p>
							<p><a href="http://www.16sucai.com/" target="_blank" class="a_blue">网游战江湖公测豪华礼包</a><span>17:28:05</span></p>
						</li>
						<li>
							<p><a href="http://www.16sucai.com/" target="_blank">8000000</a><a href="http://www.16sucai.com/" target="_blank" class="btn_lh">领号</a><em>获得</em></p>
							<p><a href="http://www.16sucai.com/" target="_blank" class="a_blue">网游战江湖公测豪华礼包</a><span>17:28:05</span></p>
						</li>
						<li>
							<p><a href="http://www.16sucai.com/" target="_blank">9000000</a><a href="http://www.16sucai.com/" target="_blank" class="btn_lh">领号</a><em>获得</em></p>
							<p><a href="http://www.16sucai.com/" target="_blank" class="a_blue">网游战江湖公测豪华礼包</a><span>17:28:05</span></p>
						</li>
						<li>
							<p><a href="http://www.16sucai.com/" target="_blank">1000000</a><a href="http://www.16sucai.com/" target="_blank" class="btn_lh">领号</a><em>获得</em></p>
							<p><a href="http://www.16sucai.com/" target="_blank" class="a_blue">网游战江湖公测豪华礼包</a><span>17:28:05</span></p>
						</li>
						<li>
							<p><a href="http://www.16sucai.com/" target="_blank">1100000</a><a href="http://www.16sucai.com/" target="_blank" class="btn_lh">领号</a><em>获得</em></p>
							<p><a href="http://www.16sucai.com/" target="_blank" class="a_blue">网游战江湖公测豪华礼包</a><span>17:28:05</span></p>
						</li>
						<li>
							<p><a href="http://www.16sucai.com/" target="_blank">1200000</a><a href="http://www.16sucai.com/" target="_blank" class="btn_lh">领号</a><em>获得</em></p>
							<p><a href="http://www.16sucai.com/" target="_blank" class="a_blue">网游战江湖公测豪华礼包</a><span>17:28:05</span></p>
						</li>
					</ul>
				</div>
	         </div>
            </div>
        </div> -->
    </div><!--/row-->
<script src="${res_url}jsto/highchart/highcharts.js"></script>
<script type="text/javascript">
$(window).load(function(){
	getOperationClass();
	command();
	getWarnNews();
	getWarnNumber();
	
	
}); 
/**
 * 得到各站的告警状态
 */
function getWarnNumber(){
	var name="${sessionScope.sysUser.name}";
	 $.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: "<%=request.getContextPath()%>"+"/warn/getWarnNumber",
		    data:{"username":name},
		    success: function(data) {
				var result = data.result;
			    var imageList = data.imageList;
	            if (result == true) { //成功添加
	            	 $('#add_lie').append('<th>站名</th>');
	            	 $('#add_number').append('<td>告警</td>');
            		 $('#add_temp').append('<td>温度</td>');
	            	  $.each(imageList, function(i,value){	
	            		 if(value.number!=0){
	            			 $('#add_lie').append('<th style="background-color: #FF0000">'+value.address+'</th>');
	            		 }else{
	            			 $('#add_lie').append('<th>'+value.address+'</th>');
	            		 }
	            		 $('#add_number').append('<td>'+value.number+'</td>');
	            		 $('#add_temp').append('<td>'+value.temper+'</td>');
	            	  });
					}
	            else{
	            	alert("ghgfd");
	            }
			    }
	        });
	}


/**
 * 温度异常抓拍图像
 */
function command(){
	$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: "<%=request.getContextPath()%>"+"/warn/getWarnImages",
		    success: function(data) {
				var result = data.result;
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
				     	//tempa.innerHTML = value.create_time+">>>"+value.sensor_name; 
				     	tempa.className="gallery";
				     	temp.appendChild(tempa);					     	
				     	/* var br=document.createElement("br");
				     	temp.appendChild(br); */					     	
				      	var div1=document.createElement("div");
				      	div1.innerHTML = value.create_time;
				     	div1.style.cssText += 'text-align:center';
				     	temp.appendChild(div1); 					     	
				     	var tempimg = document.createElement("img"); 
				     	tempimg.src= '<%=baseImagePath%>' + value.url;
						tempimg.className = "gallery";
						tempa.appendChild(tempimg);
						var div = document.createElement("div");
						div.className = "tags";
						tempa.appendChild(div);

						var span1 = document.createElement("span");
						span1.className = "label-holder";
						var span2 = document.createElement("span");
						span2.className = "label label-info";
						span2.innerHTML = "Max : " + value.max + "°C";
						span1.appendChild(span2);
						div.appendChild(span1);

						var span3 = document.createElement("span");
						span3.className = "label-holder";
						var span4 = document.createElement("span");
						span4.className = "label label-danger";
						span4.innerHTML = "Avg : " + value.av + "°C";
						span3.appendChild(span4);
						div.appendChild(span3);

						var span5 = document.createElement("span");
						span5.className = "label-holder";
						var span6 = document.createElement("span");
						span6.className = "label label-success";
						span6.innerHTML = "Min : " + value.min + "°C";
						span5.appendChild(span6);
						div.appendChild(span5);
					});
					$("a.gallery").colorbox({
						"rel" : "gallery"
					});
					return true;
				} else { //添加失败
					document.getElementById("myquerygallery").innerHTML = "";
					$.toaster({
						priority : 'warning',
						title : '告警信息',
						message : '没有告警图片'
					});
					return false;
				}
			},
			error : function() {
				$.toaster({
					priority : 'danger',
					title : '错误信息',
					message : '请求下发指令错误，请确认路径正确或网络正常！'
				});
				//$('#addModal').modal("hide");
			}
		});
		//window.location.reload("/station");
		return false;
	}
/**
 *  告警推送 
 */
	
 function getWarnNews(){
	 $.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: "<%=request.getContextPath()%>"+"/warn/getWarnNews",
		    success: function(data) {
				var result = data.result;
			    var imageList = data.imageList;
	            if (result == true) { //成功添加
	            	  $.each(imageList, function(i,value){	
	  	                 $('#news').append('<li><p><a href="#" target="_blank">'+value.op_name+'</a><a href="#" target="_blank" class="btn_lh">'+value.platform_code+'</a><em>告警</em></p><p><a href="#" target="_blank" class="a_blue">'+value.station_name+'->'+value.building_name+'->'+value.name+'</a><span>'+value.create_time+'</span></p></li>'); 
	            	  });
	            	  $('.list_lh li:even').addClass('lieven');
					}
	            else{
	            	alert("ghgfd");
	            }
			    }
	        });
	}
	/*
	 得到变电站的历史最高温度和当前温度
	*/
 function getStationTemp(){
	 var op_class= $("#station_op_class").val();
	 var station= $("#add_station").val();
	 $.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: "<%=request.getContextPath()%>"+"/warn/getStationTemp",
		    data:{"op_class":op_class},
		    success: function(data) {
				var result = data.result;
			    var tempList = data.tempList;
			    var maxTemp=[];
			    var currentTemp=[];
			    var stationName=[];
			    var curse=[];
	            if (result == true) { //成功添加
	            	  $.each(tempList, function(i,value){	
	            		  maxTemp.push(value.max_temp);
	            		  currentTemp.push(value.current_temp);
	            		  stationName.push(value.station_name);
	            	  });
	            	  curse.push({name:'历史最高', data:maxTemp});
	            	  curse.push({name:'当前温度', data:currentTemp});
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
	            		      categories: stationName,
	            		      crosshair: true
	            		   };
	            		   var yAxis = {
	            		      min: 0,
	            		      title: {
	            		         text: '温度 (℃)'         
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
	            		   $('#container').highcharts(json);
					}
	            else{
	            	document.getElementById("container").innerHTML = "";
	            	$.toaster({ priority : 'warning', title : '告警信息', message : '没有数据'});
	            }
			    }
	        });
	}
	/*
	得到当前变电站每个设备的折线图
	*/
 function getSensorTemp(){
	 var op_class= $("#station_op_class").val();
	 var station= $("#add_station").val();
	 $.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: "<%=request.getContextPath()%>"+"/warn/getSensorTemp",
		    data:{"op_class":op_class,"station":station},
		    success: function(data) {
				var result = data.result;
			    var tempList = data.tempList;
			    var time=[];
			    var curse=[];
			    var list=new Set();
	            if (result == true) { //成功添加
	            	  $.each(tempList, function(i,value){
	            		  var name=value.sensor_name+"("+value.platform_point_name+")";
	            		  if(!list.has(name)){
	            			  list.add(name);
	            		  }
	            		  time.push(value.create_time);
	            	  });
	            	  list.forEach(function (x, sameElement, set) {
	            		  var temp=[];
	            		  var eachTime=new Set();
	            		  $.each(tempList, function(i,value){
	            			  var name=value.sensor_name+"("+value.platform_point_name+")";
	            			  if(x==name){
	            				  eachTime.add(value.create_time);
	            			  }
		            	  });
	            		  $.each(tempList, function(i,value){
	            			  var name=value.sensor_name+"("+value.platform_point_name+")";
	            			  if(x==name && eachTime.has(value.create_time)){
	            				  temp.push(value.max_temp);
	            			  }
	            			  else{
	            				  temp.push(null);
	            			  }
		            	  });
	            		 curse.push({name:x, data:temp}); 
	            		});	            	  	            	  
	            	  var title = {
	            		      text: ''   
	            		   };
	            		   var subtitle = {
	            		      text: ''
	            		   };
	            		   var xAxis = {
	            		      categories: time
	            		   };
	            		   var yAxis = {
	            		      title: {
	            		         text: '温度（℃）'
	            		      },
	            		      plotLines: [{
	            		         value: 0,
	            		         width: 1,
	            		         color: '#808080'
	            		      }]
	            		   };   

	            		   var tooltip = {
	            		      valueSuffix: '\xB0C'
	            		   }

	            		   var legend = {
            				  layout: 'horizontal',
           				      align: 'center',
           				      verticalAlign: 'bottom',
           				      borderWidth: 0
	            		   };

	            		   var series =curse;

	            		   var json = {};

	            		   json.title = title;
	            		   json.subtitle = subtitle;
	            		   json.xAxis = xAxis;
	            		   json.yAxis = yAxis;
	            		   json.tooltip = tooltip;
	            		   json.legend = legend;
	            		   json.series = series;

	            		   $('#container1').highcharts(json);
					}
	            else{
	            	document.getElementById("container1").innerHTML = "";
	            	$.toaster({ priority : 'warning', title : '告警信息', message : '没有数据'});
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
			getStationTemp();
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
		getSensorTemp();			
	}	
</script>

<jsp:include page="/WEB-INF/view/add/common/footer.jsp" flush="true" />