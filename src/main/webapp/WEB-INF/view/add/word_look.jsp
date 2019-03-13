<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
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
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
<jsp:include page="/WEB-INF/view/common/basecss.jsp" flush="true" />

<link href="${res_url}css/final/global.css" rel="stylesheet" type="text/css">
<link href="${res_url}css/final/shouye.css" rel="stylesheet" type="text/css">
<link href="${res_url}css/final/yijianzhuapai.css" rel="stylesheet" type="text/css">
<link href="${res_url}css/final/chixuguance.css" rel="stylesheet" type="text/css">
<link href="${res_url}css/final/gaojingxiangqing.css" rel="stylesheet" type="text/css">

<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
	<script type="text/javascript">
	</script>
</head>
<body class="no-skin">

	<div class="main-container" id="main-container">
		<script type="text/javascript">
				try{ace.settings.check('main-container' , 'fixed')}catch(e){}
			</script>
		
		<div class="main-container-inner" align="center">
			<div class="main-content" align="center">
				<div class="page-content">

					<div class="row">
						<div class="col-xs-12">
							<div class="widget-box">
									<div class="widget-header widget-header-small">
										<h5 class="widget-title lighter left">红外检测报告</h5>
									</div>
									<input name="id" type="hidden" value="${id}" />	
									
									 <div class="row" style="margin-top:5px;margin-left:5px;">
										<form action="${context_path}/word/downloadExcel" method="post">
												<div class="gaojingxiangqingrightbox1">
														<div align="left"> 
															<h1> 1.检测功况</h1>
														 </div>
														<div class="biaogebox1">
																<table class='table-content table-content-hidden'>
																	<tr>
																		<div class="form-group">
																			<div class="col-xs-12 col-sm-9">
																				 <div> 
																				 	<td hidden><input type="text" id="id" name="id" value="${id}" ></td> 
																					<!-- <td ><label>设备名称</label></td> -->
																					<td ><label>设备名称</label><input type="text" id="nod" value="${imageList.name} ${imageList.platform_code}" disabled="disabled"> 
																					</td>
																					<!-- <td ><label>电压等级</label> </td> -->
																					<td ><label>电压等级</label><input type="text" id="station_level" value="${imageList.station_name}" disabled="disabled"> 
																					  	</td>
																					<!-- <td ><label> 安装地点</label></td> -->
																					<td ><label> 安装地点</label><input type="text" id="station_name" value="${imageList.station_name} ${imageList.building_name}" disabled="disabled" > </td>
																				 </div> 
																			</div>
																		</div>
																	</tr>
																	<tr>
																		<div class="form-group">
																			<div class="col-xs-12 col-sm-9">
																				  <div> 
																					   <!-- <td><label>运行编号</label></td> --> 
																					   <td ><label>运行编号</label><input type="text" id="run" value="${imageList.name} ${imageList.platform_code}" disabled="disabled" > 
																					   </td> 
																					   
																					   <!-- <td><label> 出厂日期</label></td> --> 
																					   <td ><label> 出厂日期</label><input type="text" id="create_time" value="${imageList.maintence_time}" > 
																					   </td> 
																					   
																					   <!-- <td><label>投运日期</label></td> --> 
																					   <td ><label>投运日期</label><input type="text" id="op_time"  value="${imageList.op_time}" > 
																				  	   </td> 
																				  </div> 
																			</div>
																		</div>
																	</tr>
																	<tr>
																		<div class="form-group">
																			
																			<div class="col-xs-12 col-sm-9">
																				 <div> 
																					  <!-- <td><label>仪器型号</label></td> -->
																					   <%-- <td colspan="2"><input type="text" value="${imageList.sensor_model}"></td> --%>
																					   <td ><label>仪器型号</label><input type="text" value="IR-160W" disabled="disabled"></td>
																					    <!-- <td><label>仪器编号</label></td> -->
																					   <td ><label>仪器编号</label><input type="text" id="sensor_code" value="${imageList.sensor_id}" disabled="disabled"  ></td>
																					  <!--  <td><label>图像编号</label></td> -->
																					   <%-- <td colspan="2"><input type="text" id="platform_code" value="${imageList.sensor_code}-${imageList.point_type}-${imageList.max_temp}-${imageList.create_time}" disabled="disabled" ></td> --%>
																					   <td ><label>图像编号</label><input type="text" id="platform_code" value="${imageList.create_time}" disabled="disabled" ></td>
																				 </div> 
																			</div>
																		</div>
																	</tr>
																	
																	<tr>
																		<div class="form-group">
																			
																			<div class="col-xs-12 col-sm-9">
																				 <div>
																				 	<!-- <td><label>负荷电流/额定电流</label></td> -->
																					   <td ><label>负荷电流/额定电流</label><input type="text" class="input-mini"  id="payload" value="-" ></td>
																					   
																					  <!-- <td><label>辐射系数</label></td> -->
																					   <td ><label>辐射系数</label>
																					   		<input type="text" id="emittance" disabled="disabled" value='<fmt:formatNumber type="number" value="${imageList.emittance*0.001}" maxFractionDigits="2"/>'>
																					   			
																					   	</td>
																					   <!--  <td><label>测试距离</label></td> -->
																					   <td ><label>测试距离</label><input type="text" id="distance" value="${imageList.distance}" disabled="disabled" ></td>
																					  
																				 </div> 
																			</div>
																		</div>
																	</tr>
																	
																	<tr>
																		<div class="form-group">
																			
																			<div class="col-xs-12 col-sm-9">
																				<div> 
																					   <!-- <td style='width:1px;white-space:nowrap;word-break:keep-all;'><label>天气</label></td> -->
																					   <td ><label style='padding-right:10px'>天气</label><input type="text" disabled="disabled" class="input-mini" id="weather" value="${imageList.weather}"> 
																					   <!-- <td><label> 温度</label></td> -->
																					   <label style='padding-right:10px'> 温度</label><input type="text" disabled="disabled" class="input-mini"  id="temp" value="${imageList.weather_temp}">
																					   <!-- <td><label> 湿度</label>--></td>  
																					   <td><label > 湿度</label><input type="text" class="input-mini" disabled="disabled"  id="wet"  value="${imageList.humidity}">
																					   <!-- <td><label> 风速</label></td> -->  
																					   </td>
																					   <td><label style='padding-right:10px'> 风速</label><input type="text" disabled="disabled"  id="wind" value="${imageList.wind}"> </td>
																				 </div> 
																			</div>
																		</div>
																	</tr>
																	<tr>
																		<div class="form-group">
																			
																			<div class="col-xs-12 col-sm-9">
																				 <div> 
																					  <td><div><label>检测时间</label></div></td>  
																					  <td ><div><input type="text" id="check_time" value="${imageList.create_time}" disabled="disabled" > <div></td>
																					  <td ><div></div></td> 
																			     </div>
																			</div>
																		</div>
																	</tr>
																</table>
																
														</div>
														
														<div align="left"> 
															<h1>2.图像分析</h1>
														</div>
														
														<div class="biaogebox2" align="left">
																<div class="form-group">
																	<ul>
																        <li>
																          <div class="gaojingpictxt1">
																            <p id="inf_images">红外图像</p>
																          </div>
																          <div class="gaojingpicbox1"><img src="${image_url_prefix}${imageList.urls[1].url}" width="400px" height="300px"></div>
																        </li>
																        <li>
																          <div class="gaojingpictxt1">
																            <p id="non_inf_images">可见光图像</p>
																          </div>
																          <div class="gaojingpicbox1"><img src="${image_url_prefix}${imageList.urls[0].url}" width="400px" height="300px"></div>
																        </li>
																      </ul>
															    </div>
														  </div>
														  
													    <div align="left">
															  <h1> 3.诊断和缺陷分析 </h1>
														 </div>
   														<div class="biaogebox3">
															<div class="form-group">
																<div class="col-xs-12 col-sm-9" style="text-align:left;margin-left:30px">
																	
																		<textarea id="analysis" rows="6" cols="165" name="analysis" placeholder="例：该设备负荷较大造成电器连接处发热" >${imageList.reason}</textarea>
																</div>
															</div>
														</div>
														
														 <div align="left"> 
															<h1> 4.处理意见 </h1>
														 </div> 
														<div class="biaogebox3">
															<div class="form-group">
																<div class="col-xs-12 col-sm-9" style="text-align:left;margin-left:30px">
																	<textarea id="opinion" rows="6" cols="165" name="opinion" placeholder="例：需要对设备进行停电处理" >${imageList.suggestion}</textarea>	
																</div>		
															</div>  
														</div>
														 <div align="left">
															<h1> 5.现场检查情况  </h1>
														 </div>
														<div class="biaogebox3">
															<div class="form-group">
																<div class="col-xs-12 col-sm-9" style="text-align:left;margin-left:30px">
																	<textarea id="remark" rows="6" cols="165" name="remark" placeholder="例：值班人员到现场实际检查情况说明" >${imageList.remark}</textarea>
																</div>
															</div>
														</div>
														 <div class="jieweitxt1">
														 	<p>检测人员:<input type="text" id="confirm_user" value="${imageList.confirm_user}" style="margin-left:5px;"> </p> 
														 </div>
														<div class="gaojingxiangqingdownbuttonbox1">	
															<input id="isave" type="button" class="btn btn-lg btn-primary" value="保存">
															<button type="submit" class="btn btn-lg btn-danger" >导出</button>
														</div>
											</div>
									</form>
								</div>
						</div>																
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
			<!-- /.main-content -->
		</div>
		<!-- /.main-container-inner -->
	</div>
	<!-- /.main-container -->
	
	<jsp:include page="/WEB-INF/view/common/basejs.jsp" flush="true" />

</body>

<script type="text/javascript">
	
	/**
	 * 校验文本是否为空
	 * tips：提示信息
	 * 使用方法：$("#id").validate("提示文本");
	 * @itmyhome
	 */
	$.fn.validate = function(tips){
	
	    if($(this).val() == "" || $.trim($(this).val()).length == 0){
	    	layer.msg(tips, {
					    icon: 2,
					    time: 2000 //2秒关闭（如果不配置，默认是3秒）
					});
	        return 0;
	    }else {
	    	return 1;
	    }
	}

	$(document).ready(function () {
        var username="${sessionScope.sysUser.name}";
        /* var colorBar1 = "${imageList.urls[0].color_bar}";
		if(colorBar1==0){
			document.getElementById("inf_images").innerHTML="可见光图像";
		}else{
			document.getElementById("inf_images").innerHTML="红外图像";
		}
		
		var colorBar2 = "${imageList.urls[1].color_bar}";
		if(colorBar2==0){
			document.getElementById("non_inf_images").innerHTML="可见光图像";
		}else{
			document.getElementById("non_inf_images").innerHTML="红外图像";
		} */
		
		$("#isave").on("click",function(e){
			//调用validate()
		    if($("#create_time").validate("设备出厂日期未设置")==0){
		    	$("#create_time").focus();
		    	return;
		    }
		    if($("#op_time").validate("设备投运日期未设置")==0){
		    	$("#op_time").focus();
		    	return;
		    }
		    if($("#analysis").validate("诊断和缺陷分析未设置")==0){
		    	$("#analysis").focus();
		    	return;
		    }
		    if($("#opinion").validate("处理意见")==0){
		    	$("#opinion").focus();
		    	return;
		    }
		    if($("#remark").validate("现场检测情况未填写")==0){
		    	$("#remark").focus();
		    	return;
		    }
		    if($("#confirm_user").validate("检测人员姓名未填写")==0){
		    	$("#confirm_user").focus();
		    	return;
		    }
		    if($("#payload").validate("负荷电流/额定电流未填写")==0){
		    	$("#payload").focus();
		    	return;
		    }
		    $.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/sensorlook/saveWarnInfo",
			    data:{"id":$("#id").val(),
			    	"create_time":$("#create_time").val(),
			    	"op_time":$("#op_time").val(),
			    	"analysis":$("#analysis").val(),
			    	"opinion":$("#opinion").val(),
			    	"remark":$("#remark").val(),
			    	"confirm_user":$("#confirm_user").val(),
			    	"payload":$("#payload").val()},
			    success: function(data) {
					var result = data.data;
					var code = data.code;
					if(code==0){
						layer.msg("保存成功", {
						    icon: 1,
						    time: 2000 //2秒关闭（如果不配置，默认是3秒）
						});
					}else{
						layer.msg("保存失败", {
						    icon: 2,
						    time: 2000 //2秒关闭（如果不配置，默认是3秒）
						});
					}
			    }
	        });
		    
		});
     });
	
</script>

</html>
