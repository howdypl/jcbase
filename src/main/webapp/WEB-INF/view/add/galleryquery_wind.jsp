<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglib.jsp"%>

<%
	String virtualImages = "/backendimageinf";
	String baseImagePath = request.getScheme()+"://"
			+request.getServerName()+":"
			+request.getServerPort()+virtualImages+"/"; %>	

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
</head>

<body class="no-skin">
	<div class="box-inner" style="height:auto;">
           
           <div class="box-content">
              <!-- <div class="leftpicbox1"> -->
			<div id="myCarousel" class="carousel slide"
				style="margin:10px;">
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
			<div id="add_time" class="timebox1"></div>
			
           </div>
       </div>

</body>

<jsp:include page="/WEB-INF/view/common/basejs.jsp" flush="true" />

	<script type="text/javascript">
		var sensor_codee = null;
		var point_type = 0;     
		var create_time = "";
		$(window).load(function() {
		
			sensor_codee = getUrlParam("sensor_code");
			point_type = getUrlParam("point_type");
			create_time = getUrlParam("create_time");
			getWarnImageDetil();
		});
		//获取url中的参数
	    function getUrlParam(name) {
	      var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
	      var r = window.location.search.substr(1).match(reg); //匹配目标参数
	      if (r != null) 
	      	return unescape(r[2]); 
	      return null; //返回参数值
	    }
		/* jQuery(function($) {
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
			
			}); */
			
			function closeView(){
				window.parent.location.reload();
				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.layer.close(index); //再执行关闭 
			}
			/*window.parent.location.reload();
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index); */
			   //****************得到轮播图片****************  
		   function getWarnImageDetil(){
				//var point_type=$('#add_room').val();
				// var sensor=$('#add_sensor_code').val();
				 $.ajax({
					    type: 'POST',
					    dataType: 'json',
					    url: "<%=request.getContextPath()%>"+"/galleryquery/getSingleImages",
					    data:{"sensor_code":sensor_codee,
					    	"point_type":point_type,
					    	"create_time":create_time},
					    success: function(data) {
							var result = data.result;
						    var imageList = data.imageList;
				            if (result == true) { //成功添加
				            	document.getElementById("add_Carousel").innerHTML = "";
				            	document.getElementById("add_time").innerHTML = "";
				            	  $.each(imageList, function(i,value){	
				            		 if(i==0){
				            			 $('#add_Carousel').append('<div class="item active" > <img style="height:100%;width:100%;" src="<%=baseImagePath%>'+value.url+'" alt="First slide"> </div>');
				            		 }else{
				            			 $('#add_Carousel').append('<div class="item" > <img style="height:100%;width:100%;" src="<%=baseImagePath%>'+value.url+'" alt="First slide"> </div>');
				            		 }
				            		 if(i==2){
				            			 $('#add_time').append('<p>'+value.station_name+" "+value.sensor_name+" "+value.platform_code+" "+value.create_time+'</p>');
				            		 }
				            	  });
								}
				            else{
				            	//alert("ghgfd");
				            	$.toaster({ priority : 'warning', title : '提示信息', message : '当前测温点无告警图片！'});
				             }
						    }
				        });
				}
		
		
	</script>
</html>
