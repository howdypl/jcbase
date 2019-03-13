<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta charset="utf-8" />
		<title>热成像测温监测应用</title>

		<meta name="description" content="overview &amp; stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
		<jsp:include page="/WEB-INF/view/common/basecss.jsp" flush="true" />
		<link rel="stylesheet" href="${res_url}css/conTabs.css?v=1.11" />
	</head> 
	 <style type="text/css">
	 
		
	 
	</style>
 
	<body class="no-skin full-height-layout" style="overflow-x:hidden;overflow-y:auto;">
	<div id="wrapper">
	<div id="navbar" class="navbar navbar-default navbar-fixed-top">
			<script type="text/javascript">
				try{ace.settings.check('navbar' , 'fixed')}catch(e){}
			</script>

			<div class="navbar-container" id="navbar-container">
				<!-- #section:basics/sidebar.mobile.toggle -->
				<button type="button" class="navbar-toggle menu-toggler pull-left" id="menu-toggler" data-target="#sidebar">
					<span class="sr-only">Toggle sidebar</span>

					<span class="icon-bar"></span>

					<span class="icon-bar"></span>

					<span class="icon-bar"></span>
				</button>

				<jsp:include page="/WEB-INF/view/common/top.jsp" flush="true" />

				<!-- /section:basics/navbar.dropdown -->
			</div><!-- /.navbar-container -->
		</div>
		<!-- /section:basics/navbar.layout -->
		<div class="main-container" id="main-container">
		<script type="text/javascript">
				try{ace.settings.check('main-container' , 'fixed')}catch(e){}
			</script>
			<div id="sidebar" class="sidebar sidebar-fixed responsive">
				<script type="text/javascript">
					try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
				</script>

				<div class="sidebar-shortcuts" id="sidebar-shortcuts" style="background: rgba(0, 149, 149, 1);" >
					<div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
					<!-- <button class="btn btn-success">
							<i class="ace-icon fa fa-signal"></i>
						</button>

						<button class="btn btn-info">
							<i class="ace-icon fa fa-pencil"></i>
						</button>

						#section:basics/sidebar.layout.shortcuts
						<button class="btn btn-warning">
							<i class="ace-icon fa fa-users"></i>
						</button>

						<button class="btn btn-danger">
							<i class="ace-icon fa fa-cogs"></i>
						</button>
					-->
						
					</div>
					
					<div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
						<span class="btn btn-success"></span>

						<span class="btn btn-info"></span>

						<span class="btn btn-warning"></span>

						<span class="btn btn-danger"></span>
					</div>
					<!-- <hr style="height:1px;border:none;border-top:dashed #0066CC;" /> -->
					<hr style="height:0px;border:none;border-top:0px double;background: rgba(0, 149, 149, 1);" />
				</div> 
				<!-- /section:basics/sidebar.layout.shortcuts -->
				<!-- /.sidebar-shortcuts -->
				
				<!-- 菜单 -->
				<jc:menu />
				<!-- /.nav-list -->

				<!-- #section:basics/sidebar.layout.minimize -->
				<div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
					<i class="ace-icon fa fa-angle-double-left" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
				</div>
				
				<!-- /section:basics/sidebar.layout.minimize -->
				<script type="text/javascript">
					try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
				</script>
			</div>
			<div class="main-content" id="page-wrapper">
				<div class="breadcrumbs breadcrumbs-fixed" id="breadcrumbs">
						<script type="text/javascript">
							try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){console.log(e.message);}
						</script>

						<!-- 面包屑 -->
					<%-- <jc:breadcrumb />  --%>
				<div class="row content-tabs">
                <button id="gobackbutton" data-toggle="tooltip" data-placement="left"  title="点击返回上一页面" class="roll-nav roll-left J_tabLeft" style="width:40px;display:inline-block;">
                  <i class=" fa fa-mail-reply-all"></i> <!-- <span class="glyphicon glyphicon-arrow-left"></span> -->
                </button>
                <nav class="page-tabs J_menuTabs">
                    <div class="page-tabs-content" style="margin-left: 0px;">
                        <a href="javascript:;" class="J_menuTab active" data-id="/home">首页</a>
                    </div>
                </nav>
                
                <button class="roll-nav roll-right J_tabRight" click="window.history.back(-1);"><!-- <i class="fa fa-forward"></i> --><span class="glyphicon glyphicon-arrow-right"></span>
                </button>
            </div>
		</div>
				<div class="page-content" id="page-content">
					<div class="row J_mainContent" id="content-main">
	                <iframe class="J_iframe" name="iframe0" width="100%" height="100%" src="${context_path}/home" frameborder="0" data-id="/home" seamless></iframe>
	            	</div>				
				</div>
			</div>
		</div><!-- /.main-container -->
</div>
<!-- basic scripts -->
<jsp:include page="/WEB-INF/view/common/basejs.jsp" flush="true" />
<script src="${res_url}js/contabs.min.js"></script>

<script type="text/javascript"> 
	var currentIframe;
	$(document).ready(function(){
		initGoBackClick();
		menuEventInit();
		tabsEventInit();
		initPwdSettingEvent();
		
		websocketFTN();
		var url = location.href; 
		if(url.indexOf("#")>-1){
			var postUrl = url.substring(url.indexOf("#")+1,url.length); 
			if(postUrl=="/index"||postUrl=="/"){
				postUrl="/";
			};
			var menu=$('[url="'+postUrl+'"]'); 
			menu.click();
		    $(".nav-list li").removeClass("active");
			menu.parent("li").addClass("active");
			$(".nav-list li").removeClass("open");
			menu.parent("li").parents("li").addClass("open");
		}
	});

	function websocketFTN(){
	 	var websocket = null;
	 	var name = "${sessionScope.sysUser.name}";
	    //判断当前浏览器是否支持WebSocket
	    if('WebSocket' in window){
	        websocket = new WebSocket("ws://116.255.207.148:33334/inf/websocket/"+name);
	    }else{
	        // alert('Not support websocket');
	        console.log("不支持 websocket.");
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
			    //console.log('id='+value.warnID+'&station_name='+value.station_name+'&building_name='+value.building_name+'&sensor_name='+value.name+'&platform_code='+value.platform_code+'&create_time='+value.warn_create_time+'&temp='+value.max_temp);
				layer.open({
							title: false,
						    type: 2,
						    shade:[0.1,'#000',false],
						    area: ['620px','381px'],
						    closeBtn: 0,
						    fix: true, //不固定
						    shadeClose:false,
						    maxmin: false,
						    zIndex: layer.zIndex,
						  	success: function(layero){
								layer.setTop(layero); 
							},
						    content: '${context_path}/warn/warnWindows?id='+value.warnID+'&station_name='+value.station_name+'&sensor_name='+value.name+'&platform_code='+value.platform_code+'&create_time='+value.warn_create_time+'&temp='+value.max_temp+'&sensor_code='+value.pp_sensor_code+'&building_name='+value.building_name   
							
						});
				//break;
	         }); 
		}
	}
	function reloadGridTable(){
		$("#grid-table").trigger("reloadGrid");
	}
	function tabsEventInit(){
		
		$(".page-tabs-content").on("click", "a", function(){
			var test = $(".page-tabs-content a");
			//if($(this).hasClass("active")==false){
				$(".page-tabs-content a").removeClass("active");
				$(this).addClass("active");
				
				tabMenuClick($(this));
				
				var menu=$('[url="'+($(this).attr("data-id")=='/home'?'/':$(this).attr("data-id"))+'"]'); 
				menu.click();
			    $(".nav-list li").removeClass("active");
				menu.parent("li").addClass("active");
				$(".nav-list li").removeClass("open");
				menu.parent("li").parents("li").addClass("open");
				menu.parent("ul").css("display","block");
				
			//}
		});
		$(".page-tabs-content .fa-times-circle").on("click",function(){
			if($(this).parent("a").hasClass("active")){
				var nextnode=$(this).parent("a").next();
				$(".page-tabs-content a").removeClass("active");
				if(nextnode.length>0){
					nextnode.addClass("active");
				}else{
					nextnode=$(this).parent("a").prev();
				}
				nextnode.addClass("active");

				tabMenuClick(nextnode);
				
				var menu=$('[url="'+(nextnode.attr("data-id")=='/home'?'/':nextnode.attr("data-id"))+'"]'); 
				menu.click();
			    $(".nav-list li").removeClass("active");
				menu.parent("li").addClass("active");
				$(".nav-list li").removeClass("open");
				menu.parent("li").parents("li").addClass("open");
				menu.parent("ul").css("display","block");
			}
			var iframe=$("#content-main").find("[data-id='"+$(this).parent("a").attr("data-id")+"']");
			iframe.remove();
			$(this).parent("a").remove();
		});
	}
	function tabsEventClear(){
		$(".page-tabs-content a").unbind("click");
		$(".page-tabs-content .fa-times-circle").unbind("click");
	}
	function menuEventInit(){
		$(".nav-list ").on("click", "a", function(e){
			e.preventDefault();
			var url=$(this).attr("url");
			if(url){
				$("iframe").css("display","none");
				window.location.hash=url;
				if(url=="/index"||url=="/"){
					url="/home";
				};
				var iframe=$("#content-main").find("[data-id='"+url+"']");
				$(".nav-list li").removeClass("active");
				$(this).parent("li").addClass("active");
				if(iframe.length>0){
					iframe.css("display","inline");
					currentIframe=iframe[0];
				}else{
					var index=$(this).attr("data-index");
					var ihtml='<iframe class="J_iframe" name="iframe'+index+'" width="100%" height="100%" src="${context_path}'+url+'" frameborder="0" data-id="'+url+'" seamless></iframe>';
					$("#content-main").append(ihtml);
					currentIframe=$("#content-main").find("[data-id='"+url+"']")[0];
					$("#content-main").find("[data-id='"+url+"']").css("display","inline");
				}
				var tab=$(".page-tabs-content").find("[data-id='"+url+"']");
				$(".page-tabs-content a").removeClass("active");
				if(tab.length > 0){
					tab.addClass("active");
				}else{
					$(".page-tabs-content").append('<a href="javascript:;" class="J_menuTab active" data-index="'+$(this).attr("data-index")+'" data-id="'+url+'">'+$(this).text()+'<i class="fa fa-times-circle"></i></a>');
					tabsEventClear();
					tabsEventInit();
				}
			}
		});
	}
	
	function tabMenuClick(topevent){
		var url = topevent.attr("data-id");//=='/home'?'/':tab.attr("data-id"); 
		var index = topevent.attr("data-index");
		if(url){
			$("iframe").css("display","none");
			window.location.hash=url;
			if(url=="/index"||url=="/"){
				url="/home";
			};
			var iframe=$("#content-main").find("[data-id='"+url+"']");
			$(".nav-list li").removeClass("active");
			
			
			if(iframe.length>0){
				iframe.css("display","inline");
				currentIframe=iframe[0];
			}else{
				var index=$(this).attr("data-index");
				var ihtml='<iframe class="J_iframe" name="iframe'+index+'" width="100%" height="100%" src="${context_path}'+url+'" frameborder="0" data-id="'+url+'" seamless></iframe>';
				$("#content-main").append(ihtml);
				currentIframe=$("#content-main").find("[data-id='"+url+"']")[0];
				$("#content-main").find("[data-id='"+url+"']").css("display","inline");
			}
			var tab=$(".page-tabs-content").find("[data-id='"+url+"']");
			$(".page-tabs-content a").removeClass("active");
			if(tab.length > 0){
				tab.addClass("active");
			}else{
				$(".page-tabs-content").append('<a href="javascript:;" class="J_menuTab active" data-index="'+index+'" data-id="'+url+'">'+$(this).text()+'<i class="fa fa-times-circle"></i></a>');
				tabsEventClear();
				tabsEventInit();
			}
			
		}
	}
	function reloadGrid(){
		currentIframe.contentWindow.reloadGrid();
	}
	function initPwdSettingEvent(){
		$("#pwd-update").click(function(){//添加页面
			layer.open({
				title:'修改密码',
			    type: 2,
			    area: ['770px', '400px'],
			    fix: false, //不固定
			    maxmin: true,
			    content: '${context_path}/pwdSetting'
			});
		});
	}
	function initGoBackClick(){
		$("#gobackbutton").on("click",function(){
			var currentFrame;// = $("#content-main").find("[data-tag='temp']");//find("iframe[style='display:inline']");
			var currentFrame=$("#content-main").find("[data-tag='temp']");// .css('display','inline');
			$("#content-main").find("[data-tag='temp']").each(function(){
				if($(this).css("display")=="inline"){
					currentFrame = $(this);
					return false;
				}
			});
			
			// var currentFrame = $("#content-main").find("iframe").css("display","inline");
			var history = currentFrame.attr("data-history");
			if(history!=null){
				currentFrame.css("display","none");
				var ffff = currentFrame.data("id");
				
				var historyFrame = $("iframe[data-id='"+history+"']");
				historyFrame.css("display","inline");
				currentFrame.remove(); 
				//===========================================
				var url=history;//historyFrame.attr("url");
				if(url){
					$("iframe").css("display","none");
					window.location.hash=url;
					if(url=="/index"||url=="/"){
						url="/home";
					};
					
					
					var atab = $(".page-tabs-content a.J_menuTab.active");// .find(".active");
					atab.remove();
					
					var iframe=$("#content-main").find("[data-id='"+url+"']");
					$(".nav-list li").removeClass("active");
					historyFrame.parent("li").addClass("active");
					if(iframe.length>0){
						iframe.css("display","inline");
						currentIframe=iframe[0];
					}else{
						var index=historyFrame.attr("data-index");
						var ihtml='<iframe class="J_iframe" name="iframe'+index+'" width="100%" height="100%" src="${context_path}'+url+'" frameborder="0" data-id="'+url+'" seamless></iframe>';
						$("#content-main").append(ihtml);
						currentIframe=$("#content-main").find("[data-id='"+url+"']")[0];
					}
					var tab=$(".page-tabs-content").find("[data-id='"+url+"']");
					$(".page-tabs-content a").removeClass("active");
					if(tab.length > 0){
						tab.addClass("active");
					}else{
						$(".page-tabs-content").append('<a href="javascript:;" class="J_menuTab active" data-id="'+url+'">'+$(this).text()+'<i class="fa fa-times-circle"></i></a>');
						tabsEventClear();
						tabsEventInit();
					}
				}
			}
		});
	}

</script>
   		
	</body>
</html>
