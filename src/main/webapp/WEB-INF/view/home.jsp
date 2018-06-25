<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% System.setProperty("no_visible_elements", "false"); %>
<%
	String virtualImages = "/backendimage";
	String baseImagePath = request.getScheme()+"://"
			+request.getServerName()+":"
			+request.getServerPort()+virtualImages+"/"; %>	
<link type="text/css" href="${res_url}css/style.css" rel="stylesheet" />
<script type="text/javascript" src="${res_url}bower_components/jquery/jquery.js"></script>
<script type="text/javascript" src="${res_url}js/scroll.js"></script>
<jsp:include page="/WEB-INF/view/add/common/header2.jsp" flush="true" />
    <div class="row">
        <div class="box col-md-12">
            <div class="box-inner" style="height:140px;">
                <div class="box-header well">
                    <h2><i class="glyphicon glyphicon-search"></i> 各站测温动态</h2>
                </div>
                 <div class="box-content" class="table-responsive" style="padding: 0 10px 10px 10px">
                    <table id="add_table" class="table table-bordered">
                        <tr id="add_lie">

                        </tr>
                        <tr id="add_number">
                        
                        </tr>
                    </table>
                </div>
            </div>
        </div>
         <div class="box col-md-12" style="width:73%">
            <div class="box-inner" style="height:470px;">
                <div class="box-header well">
                    <h2><i class="glyphicon glyphicon-picture"></i> 温度异常抓拍图像</h2>
                </div>
                <div class="box-content">
                	 <ul id = "myquerygallery" class="thumbnails gallery" style="padding-left: 10px;">
                	
                     </ul>
                </div>
            </div>
        </div>
        <div class="box col-md-12" style="width:auto">
            <div class="box-inner" style="height:470px;">
                <div class="box-header well" style="background:  coral;">
                    <h2><i class="glyphicon glyphicon-warning-sign"></i> 告警推送</h2>
                </div>
                
            <div class="bcon">
				<div class="list_lh">
					<ul id="news">
						<!-- <li>
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
						</li> -->
					</ul>
				</div>
	         </div>
            </div>
        </div>
    </div><!--/row-->

<script type="text/javascript">
$(window).load(function(){
	command();
	getWarnNews();
	getWarnNumber();
}); 
$(document).ready(function(){
	$('.list_lh li:even').addClass('lieven');
})
$(function(){
	$("div.list_lh").myScroll({
		speed:40, //数值越大，速度越慢
		rowHeight:68 //li的高度
	});
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
	            	  $.each(imageList, function(i,value){	
	            		 if(value.number!=0){
	            			 $('#add_lie').append('<th style="background-color: #FF0000">'+value.address+'</th>');
	            		 }else{
	            			 $('#add_lie').append('<th>'+value.address+'</th>');
	            		 }
	            		 $('#add_number').append('<td>'+value.number+'</td>');
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
</script>

<jsp:include page="/WEB-INF/view/add/common/footer.jsp" flush="true" />