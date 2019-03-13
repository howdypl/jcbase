<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% System.setProperty("no_visible_elements", "false"); %>
<%
	String virtualImages = "/backenduploadinf";
	String baseImagePath = request.getScheme()+"://"
			+request.getServerName()+":"
			+request.getServerPort()+virtualImages+"/"; %>	
<jsp:include page="/WEB-INF/view/add/common/header.jsp" flush="true" />
<%-- <link rel="stylesheet" type="text/css" href="${res_url}css/demo.css"> --%>
<link rel="stylesheet" type="text/css" href="${res_url}css/ladda.min.css">
<link href="${res_url}css/final/global.css" rel="stylesheet" type="text/css">
<link href="${res_url}css/final/shouye.css" rel="stylesheet" type="text/css">
<link href="${res_url}css/final/yijianzhuapai.css" rel="stylesheet" type="text/css">



    <div class="row" style="position:-webkit-sticky;position:sticky;background-color:#FFFFFF;opacity: 1;z-index:9999;top:0;padding-top:-5px;">
        <div class="box col-md-12">
            <div class="box-inner">
                <div class="box-header well" style="margin:5px;">
                    <h2><i class="glyphicon glyphicon-search"></i> 测温查看</h2>

                </div>
                <div class="box-content" style="padding: 0 5px 5px 5px">
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
						</div>-->
						<div class="row" style="margin-left: 15px;margin-right:5px;">
								<div id="work_area_div" class="col-md-2" style="width: 15%; margin: 0 5px;">
									<select name="work_area_id"  id="work_area_class" 
										onchange="getWorkAreaSelect(this)" 
										class="form-control selectpicker">
										<option value='0'>---请选择工区---</option>
										</select>
								</div>
							    <div id="operation_class_div" class="col-md-2" style="width: 12%">
									<select id="station_op_class" onchange="getOpClassSelect(this)" class="form-control selectpicker">
		                        		 <option  value='0'>---请选择班组---</option>
		                       		</select>
								</div>
								<div class="col-md-2" style="width: 12%">
								   <select id="add_station" onchange="managerSelect(this)" class="form-control selectpicker">
		                        		<option  value='0'>---请选择变电站---</option>
		                       		</select>
								</div>
								<div class="col-md-2" style="width: 16%">
									<select id="add_building" onchange="typeSelect(this)" class="form-control selectpicker">
		                        		<option  value='0'>---请选择设备间---</option>
			                       	</select>
								</div>
								<div class="col-md-4" style="margin-top:0px;">
									<!-- <button id="btn" class="laddda-button" onclick="createImage(this)" data-color="green" data-style="expand-left">
										<span class="ladda-label">一键全拍</span><span class="ladda-spinner"></span><div class="ladda-progress" style="width: 0px;"></div>
									</button> -->
									
									<button id="btn" class="ladda-button" data-color="green" data-style="expand-right" data-size="s" onclick="createImage(this)" ><span class="glyphicon glyphicon-camera"></span>一键全拍</button>
									<!-- <span style="background-color:#FFFFFF" >对如下测温点即时拍摄,抓图就绪估计需要3-4分钟！</span>  -->
									<button id="btn2" onclick="flushCntl(this)" class="ladda-button" data-color="red" data-style="expand-left" data-size="s" ><span class="glyphicon glyphicon-eye-close"></span>刷镜头</button>
									
								</div>
								
								<!-- <div class="col-md-3" style="width: 16%">
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
								</div> -->
							
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
                    
                    
                   <!-- <ul id = "myquerygallery" class="thumbnails"></ul> -->
                   
                </div>
            </div>
            
        </div>
        <!--/span-->
    </div><!--/row-->
    
    <div class="row">
        <div class="box col-md-12">
            <div class="box-inner">
                <div class="box-content" style="padding: 0 10px 10px 10px">
                	<div class="row" style="margin-left: 15px;margin-right:5px;">
	                	<div class="rightbox2" id="imagegallerylist" style="margin-left:0px;"></div>
		                <div style='text-align:center;margin-top:50px'><span id='process_image' class='availability_status' > </span></div>
    				</div>
    			</div><!--/box-content-->
    		</div><!--/box-inner-->
    	</div><!--/col-md-12-->
    </div><!--/row-->
    
<script src="${res_url}jsto/jquery.magnific-popup.min.js"></script> <!-- Magnific popup (http://dimsemenov.com/plugins/magnific-popup/) -->
<%-- <script src="${res_url}js/ladda.jquery.min.js"></script> --%>
<script src="${res_url}js/spin.js"></script>
<script src="${res_url}js/ladda.js"></script>

<script type="text/javascript">            

    $(document).ready(function(){
		getWorkArea();
		onLoadingSet();
		onOpenWarnDetailFrame();

		Ladda.bind( '#btn', 
			{ 	callback: function(instance){
					// 180秒
					$.toaster({ priority : 'warning', title : '通知信息', message : '一键抓拍命令下发成功，等待图片上传！'});
					var progress = 0.1;
					var interval = setInterval( function() {
						
						progress = Math.min( progress + 0.01, 1 );
						instance.setProgress( progress );
						
						if( progress === 1 ) {
							instance.stop();
							clearInterval( interval );
						}
					}, 2000 );
				}
			}
		);
		
		var user_type = "${sessionScope.sysUser.user_type}";

	 	if(user_type==1){
	 		getWAWord();
	 	}else if(user_type==2){
	 		getWord();
	 	}
		
	});	
	
	function getWord() {
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: '<%=request.getContextPath()%>/sys/user/getWord?name="${sessionScope.sysUser.name}"',
			    success: function(data) {
					var result = data.word;
					if(!result){
						
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
	
	function onLoadingSet(){
	 $(".availability_status").html('<img src="${res_url}img/loader3.gif" align="absmiddle">');
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
	* 点击打开告警具体信息页面
	*/
	function onOpenWarnDetailFrame(){
		$("#imagegallerylist").on("click","a",function(e){
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
					dataid = str[0].substr(4);
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
					$page_tabs_content.append('<a href="javascript:;" class="J_menuTab active" data-id="'+dataid+'">具体信息<i class="fa fa-times-circle"></i></a>');
					//tabsEventClear();
					//tabsEventInit();
				}
			}
			return false;
		});
	}
    
    var status = 0;
	function command(){
		var name="${sessionScope.sysUser.name}";
		var work_area = $("#work_area_class").val();
		var op_class= $("#station_op_class").val();
		var station= $("#add_station").val();
		var building = $("#add_building").val();
		/* var sensor= $("#add_sensor_code").val();
		var timeArray = $('#reportrange span').html().split(" - ");	 */
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/looktemp/getImages",
			    data: {
			    		"name":name,
			    		"work_area":work_area,
			    	    "op_class":op_class,
			    	    "station":station,
			    	    "building":building,
			    		/* "sensor":sensor,	
			    		"create_time":timeArray[0],
			    		"end_time":timeArray[1], */
			    		},
			    success: function(data) {
					var result = data.result;
				    //console.log("result="+result);
				    var imageList = data.content;
		            if (result == true) { //成功添加
		            	
		            	 document.getElementById("imagegallerylist").innerHTML = ""; 
		            	 var lastSensorName = "";
		            	 //var ul1 = document.createElement("li");;
		            	 var downbtbox1ul1 =null;
		            	 var galleryDiv = document.getElementById("imagegallerylist");
		                 $.each(imageList, function(i,value){
		                 
		                 	var paths="<%=baseImagePath%>";
					    	
		                     
		                     var sensorname = value.building_name+" "+value.sensor_name;
		                     
		                     //if(lastSensorName!=sensorname){
		                     	
		                     	var xqliebiaobox1 = document.createElement("div");
		                     	xqliebiaobox1.className="xqliebiaobox1";
		                     	
		                     	galleryDiv.appendChild(xqliebiaobox1);
		                     	
		                     	var topbtbox1 = document.createElement("div");
		                     	topbtbox1.className="topbtbox1";
		                     	xqliebiaobox1.appendChild(topbtbox1);
		                     	
		                     	var round1 = document.createElement("div");
		                     	round1.className="round1";
		                     	topbtbox1.appendChild(round1);
		                     	
		                     	var topbtbox1span = document.createElement("span");
		                     	topbtbox1span.innerHTML = value.station_name+" "+sensorname;
		                     	topbtbox1.appendChild(topbtbox1span);
		                     	
		                     	var downbtbox1 = document.createElement("div");
		                     	downbtbox1.className="downbtbox1";
		                     	xqliebiaobox1.appendChild(downbtbox1);
		                     	
		                     	downbtbox1ul1 = document.createElement("ul");
		                     	downbtbox1ul1.id= 'myquerygallery';
		                     	//downbtbox1ul1.className="thumbnails";
		                     	downbtbox1.appendChild(downbtbox1ul1);
		                    
		                     	lastSensorName = sensorname;
		                    // }
		                     <%-- if(value.warn_temp<value.current_temp){
		                         url = "<li id='"+value.id+"' class='thumbnail' style='margin: 20px; width: 345px;'><a href='javascript:;' data-index='197' url='${context_path}/warndetil?area="+value.work_area_id+"&opID="+value.opID+"&stationID="+value.stationID+"&buildingID="+value.buildingID+"&sensor_code="+value.pp_sensor_code+"&point_type="+value.point_type+"' style='width: auto;' > <img style='width: auto;' src='<%=baseImagePath%>"+value.images+"'></a><div style='font-size: 40px;margin-top: 5px;float: left;color:red;'>"+value.current_temp+"℃</div><div style='float: right;'>"+value.station_name+"<br>"+value.sensor_name+"("+value.platform_code+")<br>"+value.update_time+"</div></li>"
		                     }else{
		                         url = "<li id='"+value.id+"' class='thumbnail' style='margin: 20px; width: 345px;'><a href='javascript:;' data-index='197' url='${context_path}/warndetil?area="+value.work_area_id+"&opID="+value.opID+"&stationID="+value.stationID+"&buildingID="+value.buildingID+"&sensor_code="+value.pp_sensor_code+"&point_type="+value.point_type+"' style='width: auto;' > <img style='width: auto;' src='<%=baseImagePath%>"+value.images+"'></a><div style='font-size: 40px;margin-top: 5px;float: left;'>"+value.current_temp+"℃</div><div style='float: right;'>"+value.station_name+"<br>"+value.sensor_name+"("+value.platform_code+")<br>"+value.update_time+"</div></li>"
		                     }
		                     if(ul1!=null){
		                     	ul1.appendChild(url);
		                     } --%>
		                   
		                    if(value.points!=null){
		                    
			                    $.each(value.points, function(j,point){
			                    	if(point.images!=null){
							    	    paths += point.images;
							    	}else{
							    	    paths = "${res_url}img/noimage.jpg";
							    	}
			                    	//$('#myquerygallery').append(url);
		 		                   	var temp = document.createElement("li"); 
							     	temp.id = point.id;
							     	//temp.className = "thumbnail";
							     	//temp.style.cssText='margin: 20px; width: 345px;';
							     	if(downbtbox1ul1!=null){
				                     	downbtbox1ul1.appendChild(temp);
				                    }
							     	
							     	var pictopbox1 = document.createElement("div"); 
							     	pictopbox1.className = 'pictopbox1';
							     	temp.appendChild(pictopbox1);
							     	
							     	var picbox1 = document.createElement("div"); 
							     	picbox1.className = 'picbox1';
							     	pictopbox1.appendChild(picbox1);
							     	
									var tempa = document.createElement("a"); 
							     	if(point.defaul >0){//打开守望点页面
							     		tempa.href= 'javascript:;';
								     	var loc = "${context_path}/warndetil/getWarnDefault?area="+value.work_area_id+"&opID="+value.opID+"&stationID="+value.stationID+"&buildingID="+value.buildingID+"&sensor_code="+point.pp_sensor_code+"&point_type="+point.point_type;
								     	$(tempa).attr('url',loc);
								     	tempa.title = point.update_time+"\n"+"        "+value.sensor_name+"\n"+"        "+point.platform_code;
								     	tempa.dataset['index'] = '231';
							     	}else{//打开非守望点页面
							     		tempa.href= 'javascript:;';
								     	var loc = "${context_path}/warndetil?area="+value.work_area_id+"&opID="+value.opID+"&stationID="+value.stationID+"&buildingID="+value.buildingID+"&sensor_code="+point.pp_sensor_code+"&point_type="+point.point_type;
								     	$(tempa).attr('url',loc);
								     	tempa.title = point.update_time+"\n"+"        "+value.sensor_name+"\n"+"        "+point.platform_code;
								     	tempa.dataset['index'] = '197';
							     	}
							     	tempa.className="gallery";
								    picbox1.appendChild(tempa);
							     	
							     	var tempimg = document.createElement("img");
							     	var imagesrc = '<%=baseImagePath%>'+point.images;
							     	tempimg.src= imagesrc; 
							     	//tempimg.style.cssText='height: 170px;width: 260px;z-index:1;';
									tempa.appendChild(tempimg); 
							     	
							     	var zhezhaobox1 = document.createElement("div"); 
							     	zhezhaobox1.className = 'zhezhaobox1';
							     	picbox1.appendChild(zhezhaobox1);
							     	
							     	
							     	var zhezhaobox1p = document.createElement("p"); 
							     	var myname = value.sensor_name;
							     	if(myname.length>4){
			            	  			myname=myname.substr(0,4);
			            	  			myname+="...";
			            	  		}
							     	zhezhaobox1p.innerHTML = myname;
							     	zhezhaobox1.appendChild(zhezhaobox1p);
							     	
							     	var zhezhaobox1span = document.createElement("span"); 
							     	zhezhaobox1span.innerHTML = point.platform_code;
							     	zhezhaobox1.appendChild(zhezhaobox1span);
							     	
							     	var picdowntxt1 = document.createElement("div");
							     	picdowntxt1.className = 'picdowntxt1';
							     	temp.appendChild(picdowntxt1);
							     	
							      	var div11=document.createElement("div");
							      	div11.className = 'sblefttxt1';
							      	picdowntxt1.appendChild(div11);
							      	
							      	var div11p = document.createElement("p"); 
							     	div11p.innerHTML = point.current_temp+"°C";
							     	div11.appendChild(div11p);
							     	
							     	var sbrighttxt1=document.createElement("div");
							      	sbrighttxt1.className = 'sbrighttxt1';
							      	picdowntxt1.appendChild(sbrighttxt1);
							      	
							      	var rttxt1 = document.createElement("div"); 
							      	rttxt1.className = 'rttxt1';
							     	sbrighttxt1.appendChild(rttxt1);
							      	var rttxt1p = document.createElement("p"); 
							     	rttxt1p.innerHTML =value.station_name+" "+value.sensor_name;//value.station_name+" "+value.building_name;
							     	rttxt1.appendChild(rttxt1p);
							     	
							     	var rttxt2 = document.createElement("div"); 
							     	rttxt2.className = 'rttxt2';
							     	sbrighttxt1.appendChild(rttxt2);
							     	
							     	if(point.defaul >0){
								     	var defaultImg = document.createElement("img");
								     	var defaultImgSrc = "${res_url}css/images/default_point.png";
								     	defaultImg.src= defaultImgSrc;
								     	rttxt2.appendChild(defaultImg);
							     	}
							     	
							      	var rttxt2p = document.createElement("p"); 
							     	rttxt2p.innerHTML =point.platform_code;
							     	rttxt2.appendChild(rttxt2p);
							     	
							     	var rttxt3 = document.createElement("div"); 
							     	rttxt3.className = 'rttxt3';
							     	sbrighttxt1.appendChild(rttxt3);
							      	var rttxt3p = document.createElement("p"); 
							     	rttxt3p.innerHTML =point.update_time;
							     	rttxt3.appendChild(rttxt3p);
			                    	
			                    });
		                    }
 		                    
					     	<%-- var temp = document.createElement("li"); 
					     	temp.id = value.id;
					     	//temp.setAttribute("class", "thumbnail");
					     	temp.className = "thumbnail";
					     	document.getElementById("myquerygallery").appendChild(temp);
					     	// $('#myquerygallery').appendChild(temp);				     	
					     	var tempa = document.createElement("a"); 
					     	tempa.href= '<%=baseImagePath%>'+value.images;
					     	//tempa.text= value.create_time+"~"+value.sensor_name;
					     	tempa.title = value.create_time+"\n"+"        "+value.pp_sensor_code;
					     	tempa.className="gallery";
					     	temp.appendChild(tempa);					     						     	
					      	var div1=document.createElement("div");
					      	div1.innerHTML = value.create_time;
					     	div1.style.cssText += 'text-align:center';
					     	temp.appendChild(div1); 					     	
					     	var tempimg = document.createElement("img"); 
					     	tempimg.src= '<%=baseImagePath%>'+value.images;
					     	tempimg.className="gallery";
					     	tempa.appendChild(tempimg);				 --%>	     	
					     	/* var div=document.createElement("div");
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
					     	div.appendChild(span5);				 */	     						     	
					    }); 					    
 					   /*  $("a.gallery").colorbox({
 							"rel":"gallery"
 						}); 	 */
 						
 														
		                return true;
		            }else{ //添加失败
		            	// document.getElementById("myquerygallery").innerHTML = "";
		            	document.getElementById("imagegallerylist").innerHTML = ""; 
		                $.toaster({ priority : 'warning', title : '告警信息', message : '尚未设置抓图预设点！'});
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
						var index =0;
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
						var index =1;
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
		$(which).get(0).selectedIndex=0;	
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
	}
	function managerSelect(which){
		var sindex = which.selectedIndex;
		if(sindex>0){
	    	getBuilding(which.value);
	    }
	    command();			
	}	
	function getBuilding(op){
		
		var which = $('#add_building');
		$(which).empty();
		$(which).append("<option  value='0'>---请选择设备间---</option>");
		$(which).get(0).selectedIndex=0;//index为索引值 
		var para = op;
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/building/getBuilding",
			    data:{"station":para},
			    success: function(data) {
					var result = data.content;
					if(result){
						var index = 1;			
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
					    //which.get(0).selectedIndex=index;//index为索引值
					  
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
		command();
		//getCode(which.value);
	}
	<%-- function getCode(op){		
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
						var index = 7;
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
	} --%>
	
	function createImage(which){
		var parentdiv = $(which).parents('.box-content');
				
		var station_op = parentdiv.find("#station_op_class");
		var station = parentdiv.find("#add_station");
		var building = parentdiv.find("#add_building");
		
		// var timeArray = $('#reportrange span').html().split(" - ");
		// var colour = checkChanged();
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    async: false,
			    url: "<%=request.getContextPath()%>"+"/looktemp/createImage",
			    data: {"station_op":station_op.val(),
			    		"station":station.val(),
			    		"building":building.val()
			    		},
			    timeout:10000,
			    success: function(data) {
			    	// var source = station.val()+'--'+building.val()+'--'+layer.val()+'--'+room.val();
					var result = data.result;
					var record = data.record;
					if(result){
			            $.toaster.reset();
			            $.toaster({priority : 'success', title : '提示信息', message : '抓图命令已经下发，图片上传可能需要几分钟，请稍等！'});
					}else{ //添加失败
		                $.toaster({ priority : 'warning', title : '告警信息', message : '没有数据报告！'});
		                return false;
		            }
					
			    },
			    error:function(){
			    	$.toaster({ priority : 'danger', title : '错误信息', message : '请求错误，请确认路径正确或网络正常！'});
			    	//$('#addModal').modal("hide");
			    }
	        });
	        
	    //window.location.reload("/station");
	    return false;
	}
	
	function flushCntl(which){
		var parentdiv = $(which).parents('.box-content');
				
		var station_op = parentdiv.find("#station_op_class");
		var station = parentdiv.find("#add_station");
		var building = parentdiv.find("#add_building");
		
		// var timeArray = $('#reportrange span').html().split(" - ");
		// var colour = checkChanged();
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    async: false,
			    url: "<%=request.getContextPath()%>"+"/looktemp/flushCntl",
			    data: {"station_op":station_op.val(),
			    		"station":station.val(),
			    		"building":building.val()
			    		},
			    timeout:10000,
			    success: function(data) {
			    	// var source = station.val()+'--'+building.val()+'--'+layer.val()+'--'+room.val();
					var result = data.result;
					var record = data.record;
					if(result){
			            $.toaster.reset();
			            $.toaster({priority : 'success', title : '提示信息', message : '雨刷控制已下发！'});
					}else{ //添加失败
		                $.toaster({ priority : 'warning', title : '告警信息', message : '没有数据报告！'});
		                return false;
		            }
					
			    },
			    error:function(){
			    	$.toaster({ priority : 'danger', title : '错误信息', message : '请求错误，请确认路径正确或网络正常！'});
			    	//$('#addModal').modal("hide");
			    }
	        });
	        
	    //window.location.reload("/station");
	    return false;
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