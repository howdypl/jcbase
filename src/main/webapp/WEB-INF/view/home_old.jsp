<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% System.setProperty("no_visible_elements", "false"); %>
<%
	String virtualImages = "/backendimageinf";
	String baseImagePath = request.getScheme()+"://"
			+request.getServerName()+":"
			+request.getServerPort()+virtualImages+"/"; %>	
<link type="text/css" href="${res_url}css/style2.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="${res_url}css/main.css">
<link href="${res_url}css/final/global.css" rel="stylesheet" type="text/css">
<link href="${res_url}css/final/shouye.css" rel="stylesheet" type="text/css">
<!-- <style type="text/css">
#loading {

	padding: 5px 0 5px 29px;
	background: url(${res_url}img/loadingwy.gif) no-repeat 10px top;
	left: 0;
	top: 0;
	width: auto;
	height: auto
}
</style> -->

<jsp:include page="/WEB-INF/view/add/common/header.jsp" flush="true" />
    <div class="row">
    	
        <div class="box col-md-12" style="width:100%;">
            <div class="box-inner" style="height:auto;">
                <div class="box-header well">
                    <h2><i class="glyphicon glyphicon-search"></i> 测温动态光字牌</h2>
                </div>
                 <div class="box-content" class="table-responsive" style="padding: 0 10px 10px 10px">
                    <div style='text-align:center'><span id='process_pad' class='availability_status' > </span></div>
                    <table id="add_table" class="table table-bordered">
                        <tr id="add_lie">

                        </tr>
                       
                    </table>
                </div>
            </div>
        </div>
        
        <div class="box col-md-12" style="width:100%">
            <div class="box-inner" style="height:470px;">
                <div class="box-header well">
                    <h2><i class="glyphicon glyphicon-picture"></i> 实时测温监控</h2>
                    
                     <select id="add_station" onchange="managerSelect(this)" class="form-control selectpicker" style=" width:auto; float:right; margin-top: -17px;">
                		<option  value='0'>---请选择变电站---</option>
                		</select>
                		<!-- <h2 style="float:right; margin-right: 10px;">变电站：</h2> -->
               		<select id="station_op_class" onchange="getOpClassSelect(this)" class="form-control selectpicker" style=" width:auto; float:right; margin-top: -17px; margin-right: 25px;">
                		<option  value='0'>---请选择班组---</option>
               		</select>
               		<!-- <h2 style="float:right; margin-right: 10px;">班组：</h2> -->
                </div>
                <div class="box-content">
                	 <div id="container" style="width: 50%; height: 390px; margin: 0 auto; float: left;">
                	 	<div style='text-align:center'><span id='process_histogram' class='availability_status' > </span></div>
                	 
                	 </div>
                	 <div id="container1" style="width: 50%; height: 390px; margin: 0 auto;float: left;">
                	 	<div style='text-align:center'><span id='process_curve' class='availability_status' > </span></div>
                	 </div>
                </div>
            </div>
        </div>
         <div class="box col-md-12" style="width:100%">
            <div class="box-inner" style="height:470px;">
                <div class="box-header well">
                    <h2><i class="glyphicon glyphicon-picture"></i> 温度异常抓拍图像</h2>
                </div>
                <div class="box-content" style="padding-left:70px">
                	<div style='text-align:center'><span id='process_image' class='availability_status' > </span></div>
                	 <!-- <ul id = "myquerygallery" class="thumbnails gallery"> -->
                	<ul id = "myquerygallery" class="thumbnails">
                     </ul>
                </div>
            </div>
        </div>

    </div><!--/row-->
<script src="${res_url}jsto/highchart/highcharts.js"></script>
<%-- <script src="${res_url}js/jquery.contip.js"></script> --%>
<script type="text/javascript">

$(document).ready(function(){
	var isOp = 0;
	onLoadingSet();
	getOperationClass();
	command();
	//getWarnNews();
	getWarnNumber();
	//bindOpenFrame();
	onBindOpenFrame();
	onOpenWarnDetailFrame();
	
});

function onLoadingSet(){
	 $(".availability_status").html('<img src="${res_url}img/loader3.gif" align="absmiddle">');
}

function onBindOpenFrame(){
	$("#add_table").on("click","a",function(e){
		e.preventDefault();
		var url=$(this).attr("url");
		if(url){
		
			var history ;
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
				dataid = str[0].substr(4,10);
			}
			//var iframe=$("#content-main").find("[data-id='"+url+"']");
			var iframe=$('#content-main', window.parent.document).find("[data-id='"+dataid+"']");
			$('.main-container', window.parent.document).find(".nav-list li").removeClass("active");
			$('.main-container', window.parent.document).find(".nav-list li").find("[data-index='"+$(this).attr("data-index")+"']").parent("li").addClass("active");
			// var history = $('.J_iframe', window.parent.document).attr("data-id");
			if(iframe.length>0){
				iframe.css("display","inline");
				currentIframe=iframe[0];
			}else{
				var index=$(this).attr("data-index");
				var ihtml='<iframe class="J_iframe" data-history="'+history+'" data-tag="temp" name="iframe'+index+'" width="100%" height="100%" src="'+url+'" frameborder="0" data-id="'+dataid+'" seamless  style="display:inline;"></iframe>';
				$('#content-main', window.parent.document).append(ihtml);
				currentIframe=$('#content-main', window.parent.document).find("[data-id='"+dataid+"']")[0];
				$("#content-main").find("[data-id='"+dataid+"']").css("display","inline");
			}
			
			var $page_tabs_content = $('.main-content', window.parent.document).find("div .page-tabs-content");
			var tab = $page_tabs_content.find("[data-id='"+dataid+"']");
			// var tab=$(".page-tabs-content").find("[data-id='"+url+"']");
			//$(".page-tabs-content a").removeClass("active");
			$page_tabs_content.find("a").removeClass("active");
			if(tab.length > 0){
				tab.addClass("active");
			}else{
				$page_tabs_content.append('<a href="javascript:;" class="J_menuTab active" data-index="'+$(this).attr("data-index")+'" data-id="'+dataid+'">告警信息<i class="fa fa-times-circle"></i></a>');
				//tabsEventClear();
				//tabsEventInit();
			}
		}
	});
}
/**
* 点击打开告警具体信息页面
*/
function onOpenWarnDetailFrame(){
	$("#myquerygallery").on("click","a",function(e){
		e.preventDefault();
		var url=$(this).attr("url");
		if(url){
		
			var history ;
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
				dataid = str[0].substr(4,15);
			}
			//var iframe=$("#content-main").find("[data-id='"+url+"']");
			var iframe=$('#content-main', window.parent.document).find("[data-id='"+url+"']");
			$('.main-container', window.parent.document).find(".nav-list li").removeClass("active");
			$('.main-container', window.parent.document).find(".nav-list li").find("[data-index='"+$(this).attr("data-index")+"']").parent("li").addClass("active");
			// var history = $('.J_iframe', window.parent.document).attr("data-id");
			if(iframe.length>0){
				iframe.css("display","inline");
				currentIframe=iframe[0];
			}else{
				var index=$(this).attr("data-index");
				var ihtml='<iframe class="J_iframe" data-history="'+history+'" data-tag="temp" name="iframe'+index+'" width="100%" height="100%" src="'+url+'" frameborder="0" data-id="'+dataid+'" seamless  style="display:inline;"></iframe>';
				$('#content-main', window.parent.document).append(ihtml);
				currentIframe=$('#content-main', window.parent.document).find("[data-id='"+dataid+"']")[0];
				$("#content-main").find("[data-id='"+dataid+"']").css("display","inline");
			}
			
			var $page_tabs_content = $('.main-content', window.parent.document).find("div .page-tabs-content");
			var tab = $page_tabs_content.find("[data-id='"+dataid+"']");
			// var tab=$(".page-tabs-content").find("[data-id='"+url+"']");
			//$(".page-tabs-content a").removeClass("active");
			$page_tabs_content.find("a").removeClass("active");
			if(tab.length > 0){
				tab.addClass("active");
			}else{
				$page_tabs_content.append('<a href="javascript:;" class="J_menuTab active" data-index="'+$(this).attr("data-index")+'" data-id="'+dataid+'">具体信息<i class="fa fa-times-circle"></i></a>');
				/* tabsEventClear();
				tabsEventInit(); */
			}
		}
		return false;
	});
}

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
	function tabsEventClear(){
		$('.main-content', window.parent.document).find(".page-tabs-content a").unbind("click");
		$('.main-content', window.parent.document).find(".page-tabs-content .fa-times-circle").unbind("click");
	}

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
			    var imageList = data.content;
	            if (result == true) { //成功添加             
	            	/*  $('#add_lie').append('<th>站名</th>');
	            	 $('#add_number').append('<td>告警</td>');
            		 $('#add_temp').append('<td>温度</td>'); */
	            	  $.each(imageList, function(i,value){	
	            		 if(value.number!=0){
	            			 //$('#add_lie').append('<th style="background-color: #FF0000">'+value.address+'</th>');
	            			/*  $('#add_number').append('<td><a href="${context_path}/warn?op_id='+value.op_id+'&station_id='+value.station_id+'">'+value.number+'</a></td>');
	            		      $('#add_temp').append('<td>'+value.temper+'</td>'); */
	            			 
	            			 //$('#add_lie').append('<th style=" width:auto;"><a href="${context_path}/warn?op_id='+value.op_id+'&station_id='+value.station_id+'"><div class="g1" style="background-color: #d81e06;color: white;"><p class="big">'+value.address+'</p><img src="${res_url}img/告警.png"><p>温：'+value.temper+'</p> <p>警：'+value.number+'</p></div></a></th>');
	            			 
	            			 var loc = '${context_path}/warn?op_id='+value.op_id+'&station_id='+value.station_id;
	            			 $('#add_lie').append('<th style=" width:auto;"><a href="javascript:;" data-index="224" url="'+loc+'"><div class="g1" style="background-color: #d81e06;color: white;"><p class="big">'+value.address+'</p><img src="${res_url}img/告警.png"><p>温：'+value.temper+'</p> <p>警：'+value.number+'</p></div></a></th>');            			 
	            		 }else{
	            			 //$('#add_lie').append('<th>'+value.address+'</th>');
	            			 /* $('#add_number').append('<td>'+value.number+'</td>');
	            		     $('#add_temp').append('<td>'+value.temper+'</td>'); */
	            			 $('#add_lie').append('<th style=" width:auto;"><div class="g1"><p class="big">'+value.address+'</p><img src="${res_url}img/正常.png"><p>温：'+value.temper+'</p> <p>警：'+value.number+'</p></div></th>');
	            		 }
	            	  });

				}else{
	            	alert("尚无相关数据!");
	            }
			},
			complete: function () {
				$('#process_pad').hide();
			}
	  });
	}

/**
 * 温度异常抓拍图像
 */
function command(){
    var name="${sessionScope.sysUser.name}";
	$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: "<%=request.getContextPath()%>"+"/warn/getWarnImages",
		    data:{"username":name},
		    success: function(data) {
				var result = data.result;
			    var imageList = data.content;
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
				     	var url = "${context_path}/warndetil?opID="+value.opID+"&stationID="+value.stationID+"&buildingID="+value.buildingID+"&sensor_code="+value.im_sensor_code+"&point_type="+value.point_type;
				     	// 具体信息页面编号，对应数据库sys-res里的pid字段
				     	tempa.setAttribute("data-index", "197");
				     	tempa.setAttribute("url",url)
				     	tempa.href="javascript:;";
				     	
				     	// tempa.href= "${context_path}/warndetil?opID="+value.opID+"&stationID="+value.stationID+"&buildingID="+value.buildingID+"&sensor_code="+value.im_sensor_code+"&point_type="+value.point_type;
				     	
				     	//tempa.text= value.create_time+"~"+value.sensor_name;
				     	tempa.title = value.create_time+"\n"+"        "+value.sensor_name;
				     	//tempa.innerHTML = value.create_time+">>>"+value.sensor_name; 
				     	//tempa.className="gallery";
				     	temp.appendChild(tempa);					     	
				     	/* var br=document.createElement("br");
				     	temp.appendChild(br); */					     	
				      	var div1=document.createElement("div");
				      	div1.innerHTML = value.create_time;
				     	div1.style.cssText += 'text-align:center';
				     	
				     	var div2=document.createElement("div");
				      	div2.innerHTML = value.station_name+"-"+value.platform_code;
				     	div2.style.cssText += 'text-align:center';
				     	
				     	temp.appendChild(div1);
				     	temp.appendChild(div2);				     	
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
						var div = document.createElement("div");
						div.className = "tags";
						tempa.appendChild(div);

						var span1 = document.createElement("div");
						span1.className = "label-holder";
						span1.style="margin-bottom:8px";
						var span2 = document.createElement("span");
						span2.className = "label label-info";
						span2.innerHTML = "Max : " + value.max + "°C";
						span1.appendChild(span2);
						div.appendChild(span1);

						var span3 = document.createElement("div");
						span3.className = "label-holder";
						span3.style="margin-bottom:8px";
						var span4 = document.createElement("span");
						span4.className = "label label-danger";
						span4.innerHTML = "Avg : " + value.av + "°C";
						span3.appendChild(span4);
						div.appendChild(span3);

						var span5 = document.createElement("div");
						span5.className = "label-holder";
						span1.style="margin-bottom:8px";
						var span6 = document.createElement("span");
						span6.className = "label label-success";
						span6.innerHTML = "Min : " + value.min + "°C";
						span5.appendChild(span6);
						div.appendChild(span5);
					});
					/* $("a.gallery").colorbox({
						"rel" : "gallery"
					}); */
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
					message : '加载数据失败了！'
				});
				//$('#addModal').modal("hide");
			},
			complete: function () {
				$('#process_image').hide();
			}
		});
		//window.location.reload("/station");
		return false;
	}
/**
 *  告警推送 
 */
	
 function getWarnNews(){
     var name="${sessionScope.sysUser.name}";
	 $.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: "<%=request.getContextPath()%>"+"/warn/getWarnNews",
		    data:{"username":name},
		    success: function(data) {
				var result = data.result;
			    var imageList = data.content;
	            if (result == true) { //成功添加
	            	  $.each(imageList, function(i,value){	
	  	                 $('#news').append('<li><p><a href="#" target="_blank">'+value.op_name+'</a><a href="#" target="_blank" class="btn_lh">'+value.platform_code+'</a><em>告警</em></p><p><a href="#" target="_blank" class="a_blue">'+value.station_name+'->'+value.building_name+'->'+value.sensorName+'</a><span>'+value.create_time+'</span></p></li>'); 
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
 	if(isOp==1){
 		op_class = "${sessionScope.sysUser.operation_class_id}";
 	}
	 var station= $("#add_station").val();
	 $.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: "<%=request.getContextPath()%>"+"/warn/getStationTemp",
		    data:{"op_class":op_class},
		    success: function(data) {
				var result = data.result;
			    var tempList = data.content;
			    var maxTemp=[];
			    var currentTemp=[];
			    var stationName=[];
			    var curse=[];
	            if (result == true) { //成功添加
	            	  $.each(tempList, function(i,value){	
	            		  var name=value.station_name+"#"+value.name+"("+value.platform_code+")";
	            		  maxTemp.push(value.max_temp);
	            		  currentTemp.push(value.current_temp);
	            		  stationName.push(name);
	            	  });
	            	  curse.push({name:'历史最高', data:maxTemp,color:"#d81e06"});
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
	            		      labels:{
	            		          formatter: function(){
	            		              var a = this.value;
	            		              var b = a.indexOf("#");
	            		              reallyVal = a.substr(0,b)+"<br/>"+a.substring(b+1);
	            		              return reallyVal;
	            		          }
	            		      }
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
			},
			complete: function () {
				$('#process_histogram').hide();
			}
	    });
	}

/*得到当前变电站每个设备的折线图*/
 function getSensorTemp(){
 	var op_class= $("#station_op_class").val();
 	if(isOp==1){
 		op_class = "${sessionScope.sysUser.operation_class_id}";
 	}
	 var station= $("#add_station").val();
	 $.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: "<%=request.getContextPath()%>"+"/warn/getSensorTemp",
		    data:{"op_class":op_class,"station":station},
		    success: function(data) {
				var result = data.result;
			    var tempList = data.content;
			    var time=[];
			    var curse=[];
			    var list=new Set();
	            if (result == true) { //成功添加
	            	 $.each(tempList, function(i,value){
	            	 		//var station = value.station_name;
	            		  var name= value.station_name+"/"+value.sensor_name+"("+value.platform_point_name+")";
	            		  if(!list.has(name)){
	            			  list.add(name);
	            		  }
	            		  if(time.indexOf(value.sj)==-1){
	            		     time.push(value.sj);
	            		  }
	            		  
	            	  });
	            	  list.forEach(function (x, sameElement, set) {
	            		  var temp=[];
	            		  $.each(tempList, function(i,value){
	            				// console.log(value.station_name);
	            			  var name=value.station_name+"/"+value.sensor_name+"("+value.platform_point_name+")";
	       
	            			  if(x==name){
	            				  temp.push(value.maxTemp);
	            			  }
		            	  });
	            		  
	            		 curse.push({name:x, data:temp}); 
	            		 //time.push(eachTime);
	            		});	     
	            	  var title = {
	            		      text: ''   
	            		   };
	            		   var subtitle = {
	            		      text: ''
	            		   };
	            		   var xAxis = {
	            		      categories:time 
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

	            		   var series = curse;

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
			},
			complete: function () {
				$('#process_curve').hide();
			}
	     });
	}
	

	function convertDateFromString(dateString) {
		if (dateString) {
			var arr1 = dateString.split(" ");
			var sdate = arr1[0].split('-');
			var fen=arr1[1].split(':');
			//alert(sdate[0]+" "+sdate[1]+" "+sdate[2]+" "+fen[0]+" "+fen[1]+" "+fen[2]);
			var date = Date.UTC(sdate[0], sdate[1]-1, sdate[2],fen[0],fen[1],fen[2],0);
			//alert(data);
			return date;
		}
	}
	
	

	function getOperationClass() {
		// $('#station_op_class').show();
		$('#add_station').show();
		var which = $('#station_op_class');
		$(which).empty();
		$(which).append("<option value='0'>---请选择班组---</option>");
		var name = "${sessionScope.sysUser.name}";
		$.ajax({
			type : 'POST',
			dataType : 'json',
			url : "<%=request.getContextPath()%>"+"/getoperation",
			    data:{"username":name},
			    success: function(data) {
					var result = data.content;
					var notEmpty = data.result;
					isOp = data.isOp;
					if(notEmpty){
						var index =0;
					    $.each(result, function(i,value){
					    	which.append("<option value='"+value.id+"'>"+value.op_name+"</option>");
					    	index = value.id;
					    });
					    var opClass = document.getElementById("station_op_class");
					    if(isOp == 1){ //运维班用户
					    	which.get(0).selectedIndex=index;//index为索引值
					    	$('#station_op_class').hide();
					    	
					    	getOpClassSelectByOpUser(opClass);
					    	
					    }else if(isOp == 0){ // 管理员用户
					    	which.get(0).selectedIndex=1;//index为索引值
					    	$('#add_station').hide();
					    	
      				   		getOpClassSelectByAdminUser(opClass);
      				   		
					    }  
					}
			    }
	        });
	}
	function getOpClassSelect(which){
	    if(isOp == 1){ //运维班用户
	    	getOpClassSelectByOpUser(which);
	    }else if(isOp == 0){ // 管理员用户
  			getOpClassSelectByAdminUser(which);		   		
		}  
	}
	function getOpClassSelectByAdminUser(which){
	    var sindex = which.selectedIndex;
	   // console.log("op_class selected index="+sindex); 
		if(sindex == 0){
			isSelect('typealert',which);
		}else{
			getStationTemp();
			getSensorTemp();
			//getStation(which.value);
		}
	}
	
	function getOpClassSelectByOpUser(which){
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
		opclass = "${sessionScope.sysUser.operation_class_id}";	
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