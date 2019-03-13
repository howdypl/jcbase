<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
  <!-- Standard Meta -->
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
<jsp:include page="/WEB-INF/view/common/basecss.jsp" flush="true" />
<link href="${res_url}css/final/global.css" rel="stylesheet" type="text/css">
<link href="${res_url}css/final/shouye.css" rel="stylesheet" type="text/css">
<link href="${res_url}css/final/gjtc.css" rel="stylesheet" type="text/css">
</head>

<body class="no-skin">
	<div class="rightbox11">
		<div class="gjtcboxtop1">
			<img src="${res_url}css/images/gaojingtop.png">
			<p>超出设定温度告警</p>
		</div>
		<div class="gjtcboxdown1">
			<div class="leftgaojingbox1">
				<img src="${res_url}css/images/gaojingbig.png">
			</div>
			<form id="validation-form" method="post">
				<input name="warnID" type="hidden" value="${id}"/>
				<input name="create_time" type="hidden" value="${item.create_time}"/>
				<input name="sensor_code" type="hidden" value="${item.sensor_name}"/>
				<div class="rightgaojingbox1">
					<ul>
						<li>
							<p id="warn_localtion"></p>
						</li>
						<li><span id="sensor_name"></span></li>
						<li>
							<h1 id="warn_desc"></h1>
						</li>
						<li><span >请工作人员到现场确认情况</span></li>
						<li>
							<h2 id="warn_time"></h2>
						</li>
					</ul>
				</div>
				
				<div class="gaojingtanchuangdownbox1">
					<div class="xiaochuanniubox1">
						<button id="submit-btn" type="submit" data-last="Finish">
							<!-- <i class="ace-icon fa fa-check bigger-110"></i> -->
							<i class="fa fa-bell-slash" aria-hidden="true"></i>
							确定
						</button>
					</div>
					<!-- <div class="xiaochuanniubox1">
						<img src="images/图层 3.png">
						<p>确定</p>
					</div> -->
					
				</div>
			</form>
			<audio id="audioPlay" loop="loop" src="${res_url}audio/9394.mp3" hidden="true" preload="auto"></audio>
		</div>
	</div>

</body>

<jsp:include page="/WEB-INF/view/common/basejs.jsp" flush="true" />

	<script type="text/javascript">
		var parameter;
		var op_name;
		var sensor;
		var station;
		var building;
		var platform;
		var create_time;
		var temp;
		var playPromise;
		$(window).load(function() {
			/* parameter = "${item}";
			station = "${item.station_name}";
			building = "${item.building_name}";
			sensor = "${item.sensor_name}";
			platform = "${item.platform_code}";
			create_time = "${item.create_time}";
			temp = "${item.temp}";
			document.getElementById("warn_localtion").innerHTML=station+" "+building;
			document.getElementById("sensor_name").innerHTML=sensor+" "+platform;
			document.getElementById("warn_desc").innerHTML="当前温度达到了"+temp+"°C";
			document.getElementById("warn_time").innerHTML=create_time;
			
			var audio = $("#audioPlay")[0];
		    // var audio = document.getElementById("audioPlay");
			if(audio.paused){                 
				audio.play();// 这个就是播放  
			} */
			
		});
	
		jQuery(function($) {
			parameter = "${item}";
			station = "${item.station_name}";
			building = "${item.building_name}";
			sensor = "${item.sensor_name}";
			platform = "${item.platform_code}";
			create_time = "${item.create_time}";
			temp = "${item.temp}";
			document.getElementById("warn_localtion").innerHTML=station+" "+building;
			document.getElementById("sensor_name").innerHTML=sensor+" "+platform;
			document.getElementById("warn_desc").innerHTML="当前温度达到了"+temp+"°C";
			document.getElementById("warn_time").innerHTML=create_time;
			
			var audio = $("#audioPlay")[0];
			//audio.play();
		    setTimeout(()=>{audio.play()}, 200);
			
				var $validation = true;
				$('#validation-form').validate({
					errorElement: 'div',
					errorClass: 'help-block',
					focusInvalid: false,
					rules: {
						name:{
							required: true
						},
						sensor_code:{
							required: true
						}
					},
					messages: {
						name:{
							required: "请输入监控器名称"
						},
						sensor_code:{
							required: "请输入监控器编号"
						}
					},
					highlight: function (e) {
						$(e).closest('.form-group').removeClass('has-info').addClass('has-error');
					},
			
					success: function (e) {
						$(e).closest('.form-group').removeClass('has-error');//.addClass('has-info');
						$(e).remove();
					},
			
					errorPlacement: function (error, element) {
						if(element.is(':checkbox') || element.is(':radio')) {
							var controls = element.closest('div[class*="col-"]');
							alert(controls.find(':checkbox,:radio').length);
							if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
							else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
						}
						else if(element.is('.select2')) {
							error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
						}
						else if(element.is('.chosen-select')) {
							error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
						}
						else error.insertAfter(element.parent());
					},
			
					submitHandler: function (form) {
						var $form = $("#validation-form");
						var $btn = $("#submit-btn");
						if($btn.hasClass("disabled")) return;
						var postData=$("#validation-form").serializeJson();
			        	 $.post("${context_path}/setTempCancelv2" ,postData, 
			        			function(data){
			        				//console.log("parent="+parent);
			        				if(data.code==0){
			        					//parent.reloadGrid(); //重新载入
			        					//closeView();
			        					layer.msg('操作成功', {
			        					    icon: 1,
			        					    time: 2000 //2秒关闭（如果不配置，默认是3秒）
			        					},function(){
			        						
			        						var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			        						parent.layer.close(index); //再执行关闭 
			        					});
			        				}else {
			        					layer.msg(data.msg, {
			        					    icon: 2,
			        					    time: 2000 //2秒关闭（如果不配置，默认是3秒）
			        					});
			        				}
			        				if(!audio.paused){
			        				    setTimeout(audio.pause(), 200);
									}
			        		 		$("#btn-submit").removeClass("disabled");
			        		},"json");
						return false;
					},
					invalidHandler: function (form) {
					}
				});
			
			});
			
			function closeView(){
				window.parent.location.reload();
				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.layer.close(index); //再执行关闭 
			}
			/* window.parent.location.reload();
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index); */
			
	</script>
</html>
