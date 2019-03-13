<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script src="${res_url}sweetalert2-master/dist/sweetalert2.min.js"></script>
<link rel="stylesheet" href="${res_url}sweetalert2-master/dist/sweetalert2.min.css"> 
<script src="${res_url}bower_components/jquery/jquery.min.js"></script>
<link href="${res_url}css/final/tianqichajian.css" rel="stylesheet" type="text/css">

<div class="row">

<div class="navbar-header pull-left"  style="margin-top:-8px;">
	
	<a href="javascript:;" class="navbar-brand">
		
		<small>
			<img alt="" src="${res_url}/img/logo_circle.png" style="height:40px;width=40px" >
			<!-- <i class="fa fa-leaf"></i> -->
			
			热成像测温监测应用
		</small>
	</a>
	
</div>
<!-- <div class="navbar-header pull-left navbar-brand"  style="margin-top:-5px;">
<small>|</small>
</div>
<div class="navbar-header pull-left"  style="margin-top:-5px;">
<small>
	<div id="tp-weather-widget" class=" navbar-brand"></div>
</small>
</div> -->

<input id="sessionId" type="hidden" value="${pageContext.session.id}"/>

<div class="navbar-buttons navbar-header pull-right" role="navigation"  style="margin-top:-5px;">
	<ul class="nav ace-nav">
		<!-- #section:basics/navbar.user_menu -->
		<li class="light-blue">
			<a data-toggle="dropdown" href="#" class="dropdown-toggle">
				<!--  img class="nav-user-photo" src="${res_url}ace-1.3.3/assets/avatars/user.jpg" alt="Jason's Photo" /-->
				<span class="user-info">
					<div>&nbsp;</div>
					${sessionScope.sysUser.name}
				</span>

				<i class="ace-icon fa fa-caret-down"></i>
			</a>
			
			<ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
				<li>
					<a href="javascript:;" id="pwd-update">
						<i class="ace-icon fa fa-cog"></i>
						密码设置
					</a> 
				</li>
				<li class="divider"></li>
				<li>
					<a href="${context_path}/loginOut">
						<i class="ace-icon fa fa-power-off"></i>
						退出
					</a>
				</li>
			</ul>
		</li>
	</ul>
</div>

<div class="tqcjbox1">
	<ul>
		
		<li><p id="humidity"></p>
			<span>湿度</span><img src="${res_url}css/images/shidu.png"></li>
		<li><p id="now_wind"></p>
			<span>风力</span><img src="${res_url}css/images/fengsu.png"></li>
		<li><p id="now_temp_min">最低：17℃</p>
			<p id="now_temp_max">最高：37℃</p>
			<p id="now_temp_current">当前：23℃</p>
			<span>温度</span><img src="${res_url}css/images/wendu.png" width="158"
			height="158"></li>
		<li><p id="now_weather">多云</p>
			<span>天气</span><img id="weather_pic" src="${res_url}css/images/tianqi.png" width="158"
			height="158"></li>
		
		<li><p id="my_login_time"></p></li>
		<li><p id="work_area_by_user"></p></li>
	</ul>
</div>
</div>

<!-- 知心天气API -->
<!-- <script>
(function(T, h, i, n, k, P, a, g, e) {
		g = function() {
			P = h.createElement(i);
			a = h.getElementsByTagName(i)[0];
			P.src = k;
			P.charset = "utf-8";
			P.async = 1;a.parentNode.insertBefore(P, a)
		};
		T["ThinkPageWeatherWidgetObject"] = n;T[n] || (T[n] = function() {
			(T[n].q = T[n].q || []).push(arguments)
		});
		T[n].l = +new Date();
		if (T.attachEvent) {
			T.attachEvent("onload", g)
		} else {
			T.addEventListener("load", g, false)
		}
	}(window, document, "script", "tpwidget", "//widget.seniverse.com/widget/chameleon.js"))
</script>
<script>
	tpwidget("init", {
		"flavor" : "slim",
		"location" : "WW0V9QP93VS8",
		"geolocation" : "enabled",
		"language" : "zh-chs",
		"unit" : "c",
		"theme" : "chameleon",
		"container" : "tp-weather-widget",
		"bubble" : "enabled",
		"alarmType" : "badge",
		"color" : "#FFFFFF",
		"uid" : "UCB2351607",
		"hash" : "22a54b43ccd6124c3af98e723cfc1c87"
	});
	tpwidget("show");
</script> -->


<script type="text/javascript">

$(window).load(function(){
	var work_areaa = "${sessionScope.sysUser.work_area_id}";
	var d = new Date();
	var idate = d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
	document.getElementById("my_login_time").innerHTML=idate;
	getUserWorkArea();
	getWeather();
	
 });
 
 function websocketFTN(){
 		var websocket = null;
 
 	var name = "${sessionScope.sysUser.name}";
    //判断当前浏览器是否支持WebSocket
    if('WebSocket' in window){
        websocket = new WebSocket("ws://116.255.207.148:33334/inf/websocket/"+name);
    }else{
        // alert('Not support websocket');
        console.log("不支持 websocket.")
    }
 
    //连接发生错误的回调方法
    websocket.onerror = function(){
        console.log("websocket 错误");
    }
 
    //连接成功建立的回调方法
    websocket.onopen = function(event){
       
        console.log("websocket打开");
    }
 
    //接收到消息的回调方法
    websocket.onmessage = function(event){
        // setMessageInnerHTML(event.data);
        // console.log(event.data);
        success(event.data);
    }
 
    //连接关闭的回调方法
    websocket.onclose = function(){
        console.log("websocket关闭");
    }
 
    //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
    window.onbeforeunload = function(){
        websocket.close();
    }
     
 
 }
 
 function success(resultList) {
	
	if(resultList){
		 $.each($.parseJSON(resultList), function(i,value){
			 //sweetAlert("超温告警", value.op_name+"->"+value.station_name+"->"+value.building_name+"->"+value.name+"("+value.platform_code+")当前温度为"+value.max_temp, "error");
		
			parent.layer.open({
						title: false,
					    type: 2,
					    shade:0,
					    area: ['620px','380px'],
					    closeBtn: 0,
					    fix: false, //不固定
					    maxmin: false,
					    content: '${context_path}/warn/warnWindows?id='+value.warnID+'&station_name='+value.station_name+'&building_name='+value.building_name+'&sensor_name='+value.name+'&platform_code='+value.platform_code+'&create_time='+value.create_time+'&temp='+value.max_temp
						
					});
			
			/* swal({
			  title: '高温告警', 
			  html: '<p>'+value.create_time+":"+value.op_name+"->"+value.station_name+"->"+value.building_name+"->"+value.name+"("+value.platform_code+")"+'</p>'+'<p>'+"当前温度达到了"+value.max_temp+"度", 
			  showCancelButton: true, 
			  cancelButtonText: '稍后处理',
			  allowOutsideClick:false,
			  confirmButtonText: '立即消除', 
			 }).then(function(isConfirm) {
					  if(isConfirm === true) {
					    
					   	setOneStatus(value.warnID,value.create_time,value.pp_sensor_code);
						if(!audio.paused){                 
							audio.pause();	//这个停止
						}
					  }else if (isConfirm === false) {
					    cancelOneStatus(value.warnID,value.create_time,value.pp_sensor_code);
					   	audio.pause();
					  }else {
					    // Esc, close button or outside click
					    // isConfirm is undefined
					  }
					});  */

         }); 
	}
}
 
function getOperationClass(){
    var name = "${sessionScope.sysUser.name}";
	$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: "${context_path}/getTemp2",
		    data:{"username":name},
		    success: function(data) {
				var resultList = data.resultList;
				var notEmpty = data.notempty;
				if(notEmpty){
					 $.each(resultList, function(i,value){
						 //sweetAlert("超温告警", value.op_name+"->"+value.station_name+"->"+value.building_name+"->"+value.name+"("+value.platform_code+")当前温度为"+value.max_temp, "error");
					    var audio = $("#audioPlay")[0];
					    // var audio = document.getElementById("audioPlay");
						if(audio.paused){                 
							audio.play();//audio.play();// 这个就是播放  
						}

						swal({
						  title: '高温告警'+i, 
						  imageUrl: "/jcbase/res/img/warn.png",
						  html: '<p>'+value.create_time+":"+value.op_name+"->"+value.station_name+"->"+value.building_name+"->"+value.name+"("+value.platform_code+")"+'</p>'+'<p>'+"当前温度达到了"+value.max_temp+"度", 
						  showCancelButton: false, 
						  allowOutsideClick:false,
						 /*  cancelButtonColor: '#d33', */
						  confirmButtonText: '高温消除', 
						 /*  cancelButtonText: '暂不处理', */
						  /* cancelButtonClass: 'btn btn-danger', */
						}).then(function() {
							setOneStatus(value.warnID,value.create_time,value.pp_sensor_code);
							
							if(!audio.paused){                 
								audio.pause();	//这个停止
							}
							  
						}, function(dismiss) {
						  // dismiss的值可以是'cancel', 'overlay',
						  // 'close', 'timer'
						  if (dismiss === 'cancel') {
						   	;
						  } 
						});
	            	  }); 
					
				}
		    }
        });
}

function setOneStatus(warnID,create_time,sensor_code){
    var name = "${sessionScope.sysUser.name}";
	$.ajax({
	       type: 'POST',
	       dataType: 'json',
	       url: "${context_path}/setTempStatus2",
	       data:{"username":name,
	     		"warnID":warnID,
	     		"create_time":create_time,
	     		"sensor_code":sensor_code
	     	},
		    success: function(data) {
				var notEmpty = data.notempty;
				if(notEmpty){ 
					swal(
					    '已处理！',
					    '高温告警纪录已标记为处理。',
					    'success'
					  ); 
				}
		    }
        }); 
}

function cancelOneStatus(warnID,create_time,sensor_code){
    var name = "${sessionScope.sysUser.name}";
	$.ajax({
	       type: 'POST',
	       dataType: 'json',
	       url: "${context_path}/setTempCancel",
	       data:{"username":name,
	     		"warnID":warnID,
	     		"create_time":create_time,
	     		"sensor_code":sensor_code
	     	},
		    success: function(data) {
				var notEmpty = data.notempty;
				if(notEmpty){ 
					swal(
					    '稍后处理',
					    '此告警稍后处理。',
					    'error'
					  ); 
				}
		    }
        }); 
}

function setStatus(){
    var name = "${sessionScope.sysUser.name}";
	$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: "${context_path}/setTempStatus",
		     data:{"username":name},
		    success: function(data) {
				var notEmpty = data.notempty;
				if(notEmpty){ 
					
				}
		    }
        }); 
}

	/*tab选项卡*/
	function getUserWorkArea(){
		var name="${sessionScope.sysUser.name}";

		$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: "<%=request.getContextPath()%>"+"/workarea/getMyArea",
		    data:{"username":name},
		    success: function(data) {
				var result = data.result;
				var content = data.content;
				if(result){
				    document.getElementById("work_area_by_user").innerHTML=content;
				}
		    },
		    complete:function(){
			   ;
		    }
        });
	}
		/*tab选项卡*/
	function getWeather(){
		https://route.showapi.com/9-2?showapi_appid=20063&showapi_sign=0fbfcc9c47604ee983e5b94008c9da67&needAlarm=1&area=%E9%83%91%E5%B7%9E
		var showapi_appid = '20063';
		var showapi_sign = '0fbfcc9c47604ee983e5b94008c9da67';
		var needAlarm = '1';
		var user_type="${sessionScope.sysUser.user_type}";
		var area = '郑州';
		if(user_type!=0){
			area = "${sessionScope.sysUser.des}";
			//console.log("天气地区："+area);
		}
		if(area==""|| area==null){
			area = "郑州";
		}
		
		$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: "https://route.showapi.com/9-2",
		    data:{"showapi_appid":showapi_appid,
		    	"showapi_sign":showapi_sign,
		    	"needAlarm":needAlarm,
		    	"area":area},
		    success: function(data) {
		   		//console.log(data);
				var showapi_res_body = data.showapi_res_body;
				var day_air_temperature = showapi_res_body.f1.day_air_temperature;
				var night_air_temperature = showapi_res_body.f1.night_air_temperature;
				
				var sd = showapi_res_body.now.sd;
				var temperature = showapi_res_body.now.temperature;
				var weather = showapi_res_body.now.weather;
				var weather_pic = showapi_res_body.now.weather_pic;
				
				var wind_direction = showapi_res_body.now.wind_direction;
				var wind_power = showapi_res_body.now.wind_power;
				
				document.getElementById("humidity").innerHTML=sd;
				document.getElementById("now_wind").innerHTML=wind_direction+wind_power;
				document.getElementById("now_temp_min").innerHTML="最低："+night_air_temperature+"℃";
				document.getElementById("now_temp_max").innerHTML="最高："+day_air_temperature+"℃";
				document.getElementById("now_temp_current").innerHTML="当前："+temperature+"℃";
				document.getElementById("now_weather").innerHTML=weather;
				document.getElementById("weather_pic").src = weather_pic;
		
		    },
		    complete:function(){
			   ;
		    }
        });
	}
	
	
</script>			
				