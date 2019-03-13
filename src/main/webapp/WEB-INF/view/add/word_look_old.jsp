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
		<form action="http://localhost:33334/jcbase/word/downloadExcel" method="post">

		<div class="main-container-inner" align="center">
			<div class="main-content" align="center">
				<div class="page-content">

					<div class="row">
						<div class="col-xs-12">
							<input name="id" type="hidden" value="${id}" />	
							<div align="left"> 
										 <h2> 1.检测功况</h2>
								 </div> 						
							<div class="form-group">
								 
								<div class="col-xs-12 col-sm-9">1
									 <div> 
										   设备名称: 
										   <input type="text" id="nod" value="${imageList.platform_code} ${imageList.name}" disabled="disabled" style="width:150px;"> 
										   电压等级: 
										   <input type="text" id="station_level"  style="width:90px;"> 
										   安装地点: 
										   <input type="text" id="station_name" value="${imageList.station_name}" disabled="disabled"  style="width:90px;"> 
									 </div> 
								</div>
							</div>
							<div class="form-group">
							
								<div class="col-xs-12 col-sm-9">
									  <div> 
										   运行编号: 
										   <input type="text" id="run" value="${imageList.platform_code} ${imageList.name}" disabled="disabled" style="width:150px;"> 
										   出厂日期: 
										   <input type="text" id="create_time" value="${imageList.create_time}" disabled="disabled"  style="width:90px;"> 
										   投运日期: 
										   <input type="text" id="op_time"    style="width:90px;"> 
									  </div> 
								</div>
							</div>						
							<div class="form-group">
								
								<div class="col-xs-12 col-sm-9">
									 <div> 
										   仪器型号: 
										   <input type="text" value=""  style="width:150px;"> 
										   仪器编号: 
										   <input type="text" id="sensor_code" value="${imageList.sensor_code}" disabled="disabled"    style="width:245px;"> 
									 </div> 
								</div>
							</div>
							<div class="form-group">
								
								<div class="col-xs-12 col-sm-9">
									<div> 
										   天气: 
										   <input type="text" id="weather" value="" style="width:92px;"> 
										   温度: 
										   <input type="text" id="temp" value="" style="width:92px;"> 
										   湿度: 
										   <input type="text" id="wet"  value=""  style="width:93px;"> 
										   风速: 
										   <input type="text" id="wind" value=""  style="width:95px;"> 
									 </div> 
								</div>
							</div>				
							
							<div class="form-group">
								
								<div class="col-xs-12 col-sm-9">
									 <div> 
										   检测时间: 
										   <input type="text" id="check_time"   style="width:460px;"> 
								     </div>
								</div>
							</div>
							
							
							<div class="form-group">
								
								<div class="col-xs-12 col-sm-9">
									 <div align="left"> 
										 <h2> 2.图像分析</h2>
									 </div>  
									<div> 
										<table border="1" width="600px" height="300px">
										<tr>
											<td><img src="http://116.255.207.148:33334/backendimageinf/${imageList.url}" alt="First slide" width="400px" height="300px"></td>
											<td><img src="http://116.255.207.148:33334/backendimageinf/${imgStr.url}" alt="First slide" width="400px" height="300px"></td>
					
											
										</tr>
										</table>
								    </div>  
								    
								</div>
							</div>
							
							<div class="form-group">
								
								<div class="col-xs-12 col-sm-9">
									 <div align="left"> 
										  <h2> 3.诊断和缺陷分析 </h2>
									 </div>  
									<div> 
									<textarea rows="6" cols="72" name="analysis">
										
									</textarea>
										<!--    <input type="textarea" name="analysis"  style="width:580px;height:85px">  -->
								    </div>  
								</div>
							</div>
							
							<div class="form-group">
								
								<div class="col-xs-12 col-sm-9">
									 <div align="left"> 
										<h2>  4.处理意见 </h2>
									 </div>  
									<div> 
									
									<textarea rows="6" cols="72" name="opinion">
										在w3school，你可以找到你所需要的所有的网站建设教程。
									</textarea>
										<!--     <input type="textarea" name="opinion"  style="width:580px;height:85px">  -->
								    </div>  
								</div>
							</div>

							<div class="form-group">
								
								<div class="col-xs-12 col-sm-9">
									 <div align="left"> 
										<h2> 5.备注  </h2>
									 </div>  
									<div> 
									<textarea rows="6" cols="72" name="remark">
										在w3school，你可以找到你所需要的所有的网站建设教程。
									</textarea>
									
										<!--    <input type="textarea" name="remark"  style="width:580px;height:85px">  -->
								    </div>  
								</div>
							</div>
							
							<div class="form-group">
								
								<div class="col-xs-12 col-sm-9">
									 <div align="left"> 
										<h2>  检测人员: <input type="text" id="username"  disabled="disabled" style="width:40px;"> </h2> 
										
										
										   
									 </div>
									 
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
	
		
		<button type="submit" class="btn btn-warn" >
				导出
		</button>
		</form>
	
	<jsp:include page="/WEB-INF/view/common/basejs.jsp" flush="true" />

</body>

</html>
