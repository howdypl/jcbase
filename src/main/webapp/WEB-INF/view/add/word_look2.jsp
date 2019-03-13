<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglib.jsp"%>

<%
	String virtualImages = "/backendimageinf";
	String baseImagePath = request.getScheme()+"://"
			+request.getServerName()+":"
			+request.getServerPort()+virtualImages+"/"; %>	

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link href="${res_url}css/final/global.css" rel="stylesheet" type="text/css">
	<link href="${res_url}css/final/shouye.css" rel="stylesheet" type="text/css">
	<link href="${res_url}css/final/yijianzhuapai.css" rel="stylesheet" type="text/css">
	<link href="${res_url}css/final/chixuguance.css" rel="stylesheet" type="text/css">
	<link href="${res_url}css/final/gaojingxiangqing.css" rel="stylesheet" type="text/css">

	<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
  </head>
  
<body>
	<div class="rightbox4">
	  <div class="topbox1">
	    <blockquote>
	      <blockquote>
	        <p>设备名称</p>-红外检测报告
	      </blockquote>
	    </blockquote>
	  </div>
	  <div class="gaojingxiangqingrightbox1">
	    <h1>1.检测工况</h1>
	    <div class="biaogebox1">
	      <table width="1200" border="1" cellspacing="0" cellpadding="0">
	        <tr>
	          <td>设备名称</td>
	          <td colspan="2">池2组电容器</td>
	          <td>电压等级</td>
	          <td>10kV</td>
	          <td colspan="2">安装地点</td>
	          <td>池北变</td>
	        </tr>
	        <tr>
	          <td>运行编号</td>
	          <td colspan="2">池2组电容器</td>
	          <td>出厂日期</td>
	          <td>1999.01</td>
	          <td colspan="2">投运日期</td>
	          <td>2000.12</td>
	        </tr>
	        <tr>
	          <td> 仪器型号</td>
	          <td colspan="2">Fluke Ti32</td>
	          <td>仪器编号</td>
	          <td>Ti32-11030543</td>
	          <td colspan="2">图像编号</td>
	          <td>&nbsp;</td>
	        </tr>
	        <tr>
	          <td>负荷电流/额定电流</td>
	          <td colspan="2">780A/1250A</td>
	          <td>辐射系数</td>
	          <td>0.9</td>
	          <td colspan="2">测试距离</td>
	          <td>1.2m</td>
	        </tr>
	        <tr>
	          <td>天气</td>
	          <td>晴</td>
	          <td>温度</td>
	          <td>30℃</td>
	          <td>湿度</td>
	          <td>70%</td>
	          <td>风速</td>
	          <td>15m/s</td>
	        </tr>
	        <tr>
	          <td>检测时间</td>
	          <td colspan="7">2015年   08月   05日   13时45分</td>
	        </tr>
	      </table>
	    </div>
	    <h1>2.图像分析 </h1>
	    <div class="biaogebox2">
	      <ul>
	        <li>
	          <div class="gaojingpictxt1">
	            <p>红外图像</p>
	          </div>
	          <div class="gaojingpicbox1"><img src="images/L1D8S8ENDI3ZOVUIUI5NYUCF23P3XS888_800x450.jpg"></div>
	        </li>
	        <li>
	          <div class="gaojingpictxt1">
	            <p>可见光图像</p>
	          </div>
	          <div class="gaojingpicbox1"><img src="images/L1D8S8ENDI3ZOVUIUI5NYUCF23P3XS888_800x450.jpg"></div>
	        </li>
	      </ul>
	    </div>
	    <h1>3.诊断分析和缺陷分析 </h1>
	    <div class="biaogebox3">
	      <input name="" type="text">
	    </div>
	    <h1>4.处理意见 </h1>
	    <div class="biaogebox3">
	      <input name="" type="text">
	    </div>
	    <h1>5.备注</h1>
	    <div class="biaogebox3">
	      <input name="" type="text">
	    </div>
	    <div class="jieweitxt1">
	      <p>检测人员：李强&nbsp;&nbsp;&nbsp;    审核：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;            批准：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    日期：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
	    </div>
	    <div class="gaojingxiangqingdownbuttonbox1"><input type="button" class="gaojingxiangqinganniu1" value="保 存"><input name="" type="button" class="gaojingxiangqinganniu2" value="导 出">
	    </div>
	  </div>
	</div>
</body>
</html>
