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
    	<!-- <div class="box col-md-12" style="width:100%;height:7%"> -->
			<div class="rightbox1">
				<div class="tongjimokuaibigbox">
					<ul>
						<li><div class="biaoqianleftbox1">
								<p id="warn_sum"></p>
							</div>
							<div class="biaoqianrightbox1">
								<p>告警总数</p>
							</div></li>
						<li><div class="biaoqianleftbox1">
								<p id="station_sum"></p>
							</div>
							<div class="biaoqianrightbox1">
								<p>告警变电站</p>
							</div></li>
						<li><div class="biaoqianleftbox2">
								<p id="today_max_temp"></p3>
							</div>
							<div class="biaoqianrightbox1">
								<p>今日最高</p>
							</div></li>
						<li><div class="biaoqianleftbox2">
								<p id="today_min_temp"></p>
							</div>
							<div class="biaoqianrightbox1">
								<p>今日最低</p>
							</div></li>
						<li><div class="biaoqianleftbox2">
								<p id="yesterday_max_temp"></p>
							</div>
							<div class="biaoqianrightbox1">
								<p>昨日最高</p>
							</div></li>
						<li><div class="biaoqianleftbox2">
								<p id="month_max_temp"></p>
							</div>
							<div class="biaoqianrightbox1">
								<p>本月最高</p>
							</div></li>
						<li><div class="biaoqianleftbox3">
								<p id="sensor_line_sum"></p>
							</div>
							<div class="biaoqianrightbox1">
								<p>在线/全部设备</p>
							</div></li>
					</ul>
				</div><!-- tongjimokuaibigbox -->
			</div><!-- rightbox1 -->
		<!-- </div> -->
		
		<div id="work_area_or_op" class="box col-md-12" style="width:100%;">
    		<!-- <div id="select_area" class="ywbxzbox1"></div> -->
            <div class="box-inner" style="height:auto;">
                <div class="box-header well">
                    <h2 id="selectHeader"><i class="glyphicon glyphicon-search"></i> 点击下面按钮切换</h2>
                </div>
                 <div class="box-content" class="table-responsive" style="padding: 0 10px 10px 10px">
                    <div id="select_area" class="ywbxzbox1"></div>
                </div>
            </div> 
        </div>
        
        	<!-- <div class="box col-md-12" style="width:100%;height:auto;">
                   <div class="rightbox1">
                   		<div style='text-align:center;width:100%;height:auto;'><span id='process_padx' class='availability_status' > </span></div>
                    <div class="tongjimokuaibox1"> 
						  <ul id="global_stat">
							  <li>
							  	<div class="tongjiboxtop1"><span>告警统计</span></div>
							  	<div class="tongjibox11"><p id="warn_sum"></p><span>警告</span></div>
							  	<div class="tongjibox11"><p id="station_sum"></p><span>变电站</span></div>
							  </li>
							  <li>
							  	<div class="tongjiboxtop1"><span>今日温度</span></div>
							 	 <div class="tongjibox11"><p id="today_max_temp"></p><span>最高</span></div>
							  	<div class="tongjibox11"><p id="today_min_temp"></p><span>最低</span></div>
							  </li>         
							  <li>
							  	<div class="tongjiboxtop1"><span>最高温度统计</span></div>
							 	<div class="tongjibox11"><p id="yesterday_max_temp"></p><span>昨日</span></div>
							  	<div class="tongjibox11"><p id="month_max_temp"></p><span>本月</span></div>
							  </li>
							  <li>
							  	<div class="tongjiboxtop1"><span>设备统计</span></div>
							  	<div class="tongjibox11"><p id="sensor_line_sum"></p><span>在线</span></div>
							  	<div class="tongjibox11"><p id="sensor_sum"></p><span>总数</span></div>
							  </li>
						  </ul>
					</div>
				</div>
        	</div> -->

		<div class="box col-md-12" style="width:100%;;height:auto;">
			<!-- <div class="guangzipaibox1">
				    <ul id="temp_pad">
				    </ul>
				</div> -->
			<div class="box-inner" style="height:auto;">
				<div class="box-header well">
					<h2>
						<i class="glyphicon glyphicon-search"></i> 实时测温监控
					</h2>
				</div>
				<div class="box-content" class="table-responsive"
					style="padding: 0 10px 10px 10px">
					<div style='text-align:center'>
						<span id='process_pad1' class='availability_status'> </span>
					</div>
	
					<div class="guangzipaibox1">
						<ul id="temp_pad">
						</ul>
					</div>
	
				</div>
			</div>
		</div>

		<div class="box col-md-12" style="width:100%">
	            <div class="box-inner" style="height:280px;">
	                <div class="box-header well">
	                    <h2><i class="glyphicon glyphicon-picture"></i> 实时测温监控及变化趋势</h2>
	                    
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
	                	 <div id="container" style="width: 50%; height: 200px; margin: 0 auto; float: left;">
	                	 	<div style='text-align:center'><span id='process_histogram' class='availability_status' > </span></div>
	                	 
	                	 </div>
	                	 <div id="container1" style="width: 50%; height: 200px; margin: 0 auto;float: left;">
	                	 	<div style='text-align:center'><span id='process_curve' class='availability_status' > </span></div>
	                	 </div>
	                </div>
	            </div>
	        </div>
			<div class="box col-md-12" style="width:100%">
				<div class="box-inner" style="height:auto;">
					<div class="box-header well">
						<h2>
							<i class="glyphicon glyphicon-picture"></i> 温度异常抓拍图像
						</h2>
					</div>
					<div class="box-content" style="padding-left:70px">
						<div style='text-align:center'>
							<span id='process_image' class='availability_status'> </span>
						</div>
						<!-- <ul id = "myquerygallery" class="thumbnails gallery"> -->
						<ul id="myquerygallery" class="thumbnails gallery">
						</ul>
					</div>
				</div>
			</div>

</div><!--/row-->
<script src="${res_url}jsto/highchart/highcharts.js"></script>
<%-- <script src="${res_url}js/jquery.contip.js"></script> --%>
<script type="text/javascript">
var work_area_default;
var operation_class_default;
var userType = "0";
$(document).ready(function(){
	work_area_default = 0;
	operation_class_default = 0;
	userType = "${sessionScope.sysUser.userType}";
	onLoadingSet();
	//getOperationClass();
	getWorkArea();
	
	/* command();
	getWarnNumber(); */
	getWord();
	//bindOpenFrame();
	onBindOpenFrame();
	
	//旧设计：异常抓拍的跳转逻辑
	//onOpenWarnDetailFrame();
	
});

	function getWord() {
		$.ajax({
			type : 'POST',
			dataType : 'json',
			url : '<%=request.getContextPath()%>/sys/user/getWord?name="${sessionScope.sysUser.name}"',
			success : function(data) {
				var result = data.word;
				if (!result) {
					$('#work_area_or_op').hide()();
				//$('#bnt-grant').remove();
				}
			}
		});
	}

	function onLoadingSet(){
	 $(".availability_status").html('<img src="${res_url}img/loader3.gif" align="absmiddle">');
	}

function onBindOpenFrame(){
	$("#temp_pad").on("click","a",function(e){
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
 * 得到统计块数据
 */
function getGlobalStat(){
	var name="${sessionScope.sysUser.name}";
	$('#global_stat').hide();
	
	 $.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: "<%=request.getContextPath()%>"+"/warn/getBaseInfo",
		    data:{"username":name,
		    	"work_area":work_area_default,
		    	"op_class":operation_class_default},
		    success: function(data) {
				var result = data.code;
			    var statics = data.data;
	            if (result == 0) { //成功添加  
	            	document.getElementById("warn_sum").innerHTML=statics.warn_sum;
	            	document.getElementById("station_sum").innerHTML=statics.station_num;
	            	document.getElementById("today_max_temp").innerHTML=statics.today_max_temp+"°C";
	            	document.getElementById("today_min_temp").innerHTML=statics.today_min_temp+"°C";
	            	document.getElementById("yesterday_max_temp").innerHTML=statics.yesterday_max_temp+"°C";
	            	document.getElementById("month_max_temp").innerHTML=statics.month_max_temp+"°C";
	            	document.getElementById("sensor_line_sum").innerHTML=statics.line_sum+"/"+statics.sum;
	            	// document.getElementById("sensor_sum").innerHTML=statics.sum;
	            	
				}else{
	            	alert("尚无相关数据!");
	            }
			},
			complete: function () {
				$('#process_padx').hide();
				$('#global_stat').show();
			}
	  });
}


/**
 * 得到各站的告警状态:光字牌
 */
function getWarnNumber(){
	var name="${sessionScope.sysUser.name}";
	$('#temp_pad').empty();
	 $.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: "<%=request.getContextPath()%>"+"/warn/getWarnNumber",
		    data:{"username":name,
		    	"work_area":work_area_default,
		    	"op_class":operation_class_default},
		    success: function(data) {
				var result = data.result;
			    var imageList = data.content;
	            if (result == true) { //成功添加             
	            	/*  $('#add_lie').append('<th>站名</th>');
	            	 $('#add_number').append('<td>告警</td>');
            		 $('#add_temp').append('<td>温度</td>'); */
            		 var myUL = document.getElementById("temp_pad");
	            	  $.each(imageList, function(i,value){
	            	  	var myLI = document.createElement('li');
	            	  	myUL.appendChild(myLI);
	            	  	
	            	  	var gzptopbox1 = document.createElement('div');
	            	  	gzptopbox1.className='gzptopbox1';
	            	  	myLI.appendChild(gzptopbox1);
	            	  	
	            	  	var gzptopbox1P = document.createElement('p');
	            	  	
	            	  	var myaddress = value.address;
	            	  	if(value.address!=null&&value.address!=undefined&&value.address!=""){
	            	  		if(value.address.length>2){
	            	  			myaddress=value.address.substr(0,2);
	            	  		}
	            	  	}
	            	  	gzptopbox1P.innerHTML=myaddress;
	            	  	
	            	  	gzptopbox1.appendChild(gzptopbox1P);
	            	  	
	            	  	var gzptopbox1INPUT = document.createElement('input');
	            	  	gzptopbox1INPUT.type='button';
	            	  	gzptopbox1INPUT.value = '警'+value.number;
	            	  	
	            	  	
	            	  	var gzpdownbox1 = document.createElement('div');
	            	  	gzpdownbox1.className='gzpdownbox1';
	            	  	myLI.appendChild(gzpdownbox1);
	            	  	
	            	  	var gzpdownbox1P = document.createElement('p');
	            	  	gzpdownbox1P.innerHTML=myaddress;
	            	  	gzpdownbox1.appendChild(gzpdownbox1P);
	            	  	
	            	  	var gzpdownbox1SPAN = document.createElement('span');
	            	  	gzpdownbox1SPAN.innerHTML=value.temper+"°C";
	            	  	gzpdownbox1.appendChild(gzpdownbox1SPAN);
	            	  	
	            	  	if(value.number!=0){
	            	  		myLI.style.cssText="background-color:#FFA700;color:white;";
	            	  		gzpdownbox1SPAN.style.cssText="color:white;";
	            	  		gzptopbox1INPUT.style.cssText="background-color:#FFA700;color:white;border-color:white;";
	            	  		
	            	  		var loc = '${context_path}/warn?work_area='+value.work_area_id+'&op_id='+value.op_id+'&station_id='+value.station_id;
	            	  		var gzptopbox1A = document.createElement('a');
	            	  		gzptopbox1A.href = 'javascript:;';
	            	  		gzptopbox1A.dataset['index'] = '224';
	            	  		$(gzptopbox1A).attr('url',loc);
	            	  		gzptopbox1A.appendChild(gzptopbox1INPUT);
	            	  		gzptopbox1.appendChild(gzptopbox1A);
	            	  	}else {
	            	  		gzptopbox1.appendChild(gzptopbox1INPUT);
	            	  	}
	            	  	
	            	  	
	            		 /* if(value.number!=0){
	            			 var loc = '${context_path}/warn?op_id='+value.op_id+'&station_id='+value.station_id;
	            			 $('#add_lie').append('<th style=" width:auto;"><a href="javascript:;" data-index="224" url="'+loc+'"><div class="g1" style="background-color: #d81e06;color: white;"><p class="big">'+value.address+'</p><img src="${res_url}img/告警.png"><p>温：'+value.temper+'</p> <p>警：'+value.number+'</p></div></a></th>');            			 
	            		 }else{
	            			 $('#add_lie').append('<th style=" width:auto;"><div class="g1"><p class="big">'+value.address+'</p><img src="${res_url}img/正常.png"><p>温：'+value.temper+'</p> <p>警：'+value.number+'</p></div></th>');
	            		 } */
	            	  });

				}else{
	            	alert("尚无相关数据!");
	            }
			},
			complete: function () {
				$('#process_pad1').hide();
			}
	  });
	}

/**
 * 温度异常抓拍图像
 */
function command(){
    var name="${sessionScope.sysUser.name}";
    document.getElementById("myquerygallery").innerHTML = "";
	$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: "<%=request.getContextPath()%>"+"/warn/getWarnImages",
		    data:{"username":name,
		    	"work_area":work_area_default,
		    	"op_class":operation_class_default},
		    success: function(data) {
				var result = data.result;
			    var imageList = data.content;
	            if (result == true) { //成功添加
	            	 
	                 $.each(imageList, function(i,value){
	                 	var paths="<%=baseImagePath%>";
				    	if(value.url!=null){
				    	    paths += value.url;
				    	}else{
				    	    paths = "${res_url}img/noimage.jpg";
				    	}
	                 
				     	var temp = document.createElement("li"); 
				     	temp.id = value.id;
				     	temp.className = "thumbnail";
				     	document.getElementById("myquerygallery").appendChild(temp);
				     	
				     	var wdpictopbox1 = document.createElement("div");
				     	wdpictopbox1.className='wdpictopbox1';
				     	temp.appendChild(wdpictopbox1);
				     	
				     	var tempa = document.createElement("a"); 
				     	tempa.href= paths;
				     	//tempa.text= value.create_time+"~"+value.sensor_name;
				     	tempa.title = value.create_time+"\n"+"        "+value.station_name+"\n"+"        "+value.sensor_name+"\n"+"        "+value.platform_code;
				     	tempa.className="gallery";
				     	wdpictopbox1.appendChild(tempa);
				     	
				     	var tempimg = document.createElement("img"); 
				     	var paths="<%=baseImagePath%>";
				    	if(value.url!=null){
				    	    paths += value.url;
				    	}
				    	else{
				    	    paths = "${res_url}img/noimage.jpg";
				    	}
				     	tempimg.src= paths;
						tempimg.className = "gallery";
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
				     	
				     	
				     	
				     	<%-- temp.className = "thumbnail";
				     	document.getElementById("myquerygallery").appendChild(temp);
				     	var tempa = document.createElement("a");
				     	var url = "${context_path}/warndetil?area="+work_area_default+"&opID="+value.opID+"&stationID="+value.stationID+"&buildingID="+value.buildingID+"&sensor_code="+value.im_sensor_code+"&point_type="+value.point_type;
				     	// 具体信息页面编号，对应数据库sys-res里的pid字段
				     	tempa.setAttribute("data-index", "197");
				     	tempa.setAttribute("url",url)
				     	tempa.href="javascript:;";
				     	
				     	
				     	tempa.title = value.create_time+"\n"+"        "+value.sensor_name;
				     	temp.appendChild(tempa);					     	
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
						div.appendChild(span5); --%>
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
 	if(userType=="2"){
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
 	if(userType=="2"){
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
	
	function getWorkArea(){
			var name="${sessionScope.sysUser.name}";
			
			var which2 = document.getElementById('select_area');
			var name="${sessionScope.sysUser.name}";
			$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/workarea/getAllListData",
			    data:{"username":name},
			    success: function(data) {
					var result = data.result;
					var content = data.content;
					var csize = data.mysize;
					if(result){
						 var index = 1;
						 if(csize===1){
						 	$.each(content, function(i,value){
					     		work_area_default = value.id;
						    	
						    });
						    flag = 1;
						    getOperationClass2(work_area_default);
						    
						 }else if(csize>1){
						 	flag = 0;
						 	$.each(content, function(i,value){
						 		$('#selectHeader').text("选择工区");
					     		var ipoint = document.createElement("div");
					     		if(i===0){
						 			work_area_default = value.id;
						 			ipoint.className="point0";
						 		}else {
						 			ipoint.className="point1";
						 		}
					     		
					     		ipoint.dataset['id'] = value.id;
		                     	which2.appendChild(ipoint);
		                     	
		                     	var pointa = document.createElement("a");
		                     	pointa.href= 'javascript:;';
					     		//pointa.url = "${context_path}/warndetil?area="+value.work_area_id+"&opID="+value.opID+"&stationID="+value.stationID+"&buildingID="+value.buildingID+"&sensor_code="+value.pp_sensor_code+"&point_type="+value.point_type;
					     		pointa.dataset['id'] = value.id;
					     		//pointa.innerHTML=value.area.substr(0, 1);
					     		ipoint.appendChild(pointa);
					     		
					     		var pointp = document.createElement("p");
					     		pointp.innerHTML = value.area.substr(0, 1);
		                     	pointa.appendChild(pointp); 
		                     	
						    });
						    
						    $("#select_area").on("click","a",function(e){
								e.preventDefault();
								$("#select_area").find("div").attr("class","point1");
								
								$(this).parent('div').attr("class","point0");
								work_area_default = $(this).data('id');
								getOperationClass();
								command();
								//getWarnNews();
								getWarnNumber();
								getGlobalStat();
							});
						 }
					    
					}else{
						showAlert('nooperationalert2');
						
					}
					//var workarea = document.getElementById("work_area_class");
					//getWorkAreaSelect(workarea);
			    },
			    complete:function(){
				    if(flag==0){
				    	getOperationClass();
				    	command();
						getWarnNumber();
						getGlobalStat();
					}
			    }
	        });
	}
	
	
	
	
	function getWorkAreaSelect(which){
	    var sindex = which.selectedIndex;
	    if(sindex>0){
	    	// isSelect('typealert',which);
	    	getOperationClass2();
	    }
	    $('#station_op_class').empty();
		$('#station_op_class').append("<option value='0'>---请选择班组---</option>"); 
		commond();
		updata();
	}
	
    function getOperationClass2(wa){
		
		var which2 = document.getElementById('select_area');
		
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
						var index =1;
					    $.each(result, function(i,value){
					    						     						    
					    	$('#selectHeader').text("选择运维班");
					    	var ipoint = document.createElement("div");
					     		if(i===0){
						 			operation_class_default = value.id;
						 			ipoint.className="point0";
						 		}else {
						 			ipoint.className="point1";
						 		}
					     		
					     		ipoint.dataset['id'] = value.id;
		                     	which2.appendChild(ipoint);
		                     	
		                     	var pointa = document.createElement("a");
		                     	pointa.href= 'javascript:;';
					     		//pointa.url = "${context_path}/warndetil?area="+value.work_area_id+"&opID="+value.opID+"&stationID="+value.stationID+"&buildingID="+value.buildingID+"&sensor_code="+value.pp_sensor_code+"&point_type="+value.point_type;
					     		pointa.dataset['id'] = value.id;
					     		ipoint.appendChild(pointa);
					     		
					     		var pointp = document.createElement("p");
					     		pointp.innerHTML = value.op_name.substr(0, 1);
		                     	pointa.appendChild(pointp);
					    	
					    	
					    	
					    });
					    $("#select_area").on("click","a",function(e){
								e.preventDefault();
								$("#select_area").find("div").attr("class","point1");
								
								$(this).parent('div').attr("class","point0");
								operation_class_default = $(this).data('id');
								
								getOperationClass();
								command();
								//getWarnNews();
								getWarnNumber();
								getGlobalStat();
							});
					   // which.get(0).selectedIndex=index;//index为索引值
					   	
					   	/* var opClass = document.getElementById("station_op_class");
        				getOpClassSelect(opClass); */
					}
					
			    },
			    complete:function(){
			    	getOperationClass();
			    	command();
					getWarnNumber();
					getGlobalStat();
			    }
	        });
		
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
			url : "<%=request.getContextPath()%>"+"/getoperation/getOpc",
			    data:{"username":name,
			    	"workarea":work_area_default},
			    success: function(data) {
					var result = data.content;
					var notEmpty = data.result;
					
					var userType = "${sessionScope.sysUser.userType}";
					if(notEmpty){
						var index =1;
						//var tt = operation_class_default+"";
					    $.each(result, function(i,value){
					    	which.append("<option value='"+value.id+"'>"+value.op_name+"</option>");
					    	
					    	if(operation_class_default==value.id){
					    		index = i+1;
					    	}
					    });
					    var opClass = document.getElementById("station_op_class");
					    which.get(0).selectedIndex=index;//index为索引值
					    if(userType == "0"){ //管理用户
					    	
					    	$('#add_station').hide();
					    	getOpClassSelectByAdminUser(opClass);
					    	
					    }else if(userType == "1"||userType == "2"){ // 工区用户
					    						    	
					    	$('#station_op_class').hide();
      				   		getOpClassSelectByOpUser(opClass);
					    }
					}
			    }
	        });
	}
	function getOpClassSelect(which){
	    if(userType === "0"){// 管理员用户
	    	getOpClassSelectByAdminUser(which);	
	    } if(userType == "1"||userType == "2"){//工区运维班用户
	    	getOpClassSelectByOpUser(which);
	    }
	   
	}
	function getOpClassSelectByAdminUser(which){
	    var sindex = which.selectedIndex;
	   // console.log("op_class selected index="+sindex); 
		if(sindex > 0){
			getStationTemp();
			getSensorTemp();
		}
	}
	
	function getOpClassSelectByOpUser(which){
	    var sindex = which.selectedIndex;
	   // console.log("op_class selected index="+sindex); 
		if(sindex > 0){
			getStationTemp();
			getStation(which.value);
		}
	}
	
	function getStation(op){
		var which = $('#add_station');
		var opclass = op;
		$(which).empty();
		$(which).append("<option  value='0'>---请选择变电站---</option>");	
		
		if(userType=="2"){
	 		opclass = "${sessionScope.sysUser.operation_class_id}";
	 	} 	
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