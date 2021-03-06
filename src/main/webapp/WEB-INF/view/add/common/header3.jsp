<%@page import="com.jfinal.kit.HandlerKit"%>
<%@page import="com.jfinal.plugin.activerecord.Record"%>
<%@page import="com.yanxin.common.model.User"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
System.out.println("----------------basepath:"+basePath);

response.setHeader("Access-Control-Allow-Origin", "*");

%> 
<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="utf-8">
    <title>红外测温监控系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="红外测温监控系统">
    <meta name="author" content="Guozhen Cheng">
    <!-- The styles -->
    <link id="bs-css" href="${res_url}first/cssto/bootstrap-cerulean.min.css" rel="stylesheet">
	<link href="${res_url}first/cssto/bootstrap-responsive.css" rel="stylesheet">	
    <link href="${res_url}first/cssto/charisma-app.css" rel="stylesheet">   
    <link href='${res_url}first/bower_components/fullcalendar/dist/fullcalendar.css' rel='stylesheet'>
    <link href='${res_url}first/bower_components/fullcalendar/dist/fullcalendar.print.css' rel='stylesheet' media='print'>
    <link href='${res_url}first/bower_components/chosen/chosen.min.css' rel='stylesheet'>
    <link href='${res_url}first/bower_components/colorbox/example3/colorbox.css' rel='stylesheet'>
    <link href='${res_url}first/bower_components/responsive-tables/responsive-tables.css' rel='stylesheet'>
    <link href='${res_url}first/bower_components/bootstrap-tour/build/css/bootstrap-tour.min.css' rel='stylesheet'>
    <!-- <link href='bower_components/bootstrap/dist/css/bootstrap.min.css' rel='stylesheet'> -->
    <!-- <link href='bower_components/bootstrap/dist/css/bootstrap-theme.min.css' rel='stylesheet'> --> 
    <link href='${res_url}first/cssto/jquery.noty.css' rel='stylesheet'>
    <link href='${res_url}first/cssto/noty_theme_default.css' rel='stylesheet'>
    <link href='${res_url}first/cssto/elfinder.min.css' rel='stylesheet'>
    <link href='${res_url}first/cssto/elfinder.theme.css' rel='stylesheet'>
    <link href='${res_url}first/cssto/jquery.iphone.toggle.css' rel='stylesheet'>
    <link href='${res_url}first/cssto/uploadify.css' rel='stylesheet'>
    <link href='${res_url}first/cssto/animate.min.css' rel='stylesheet'>
    <link href='${res_url}first/cssto/user-validate.css' rel='stylesheet'>
    <link rel="stylesheet" type="text/css" media="all" href="${res_url}first/cssto/daterangepicker-bs3.css" />
	<link rel="stylesheet" type="text/css" media="all" href="${res_url}first/cssto/daterangepicker-1.3.7.css" />
    
    <link rel="stylesheet" type="text/css" href="${res_url}first/cssto/build.css">
    <link rel="stylesheet" type="text/css" href="${res_url}first/cssto/font-awesome.min.css">
    <!-- <link rel="stylesheet" type="text/css" href="css/awesome-bootstrap-checkbox.css"> -->
    
    <!--<link href='css/bootstrap-select.min.css' rel='stylesheet'>  -->
    
	<link href="${res_url}first/cssto/multi-select.css" rel="stylesheet" type="text/css">
	
	<!-- <link href='css/datatables.css' rel='stylesheet'> -->
	<link href='${res_url}first/cssto/dataTables.editor.css' rel='stylesheet'>
	
    <!-- The fav icon -->
    <link rel="shortcut icon" href="${res_url}first/img/favicon.ico">
    <!-- 去除底部滚动条 -->
    <link rel="stylesheet" type="text/css" href="${res_url}css/scollset.css">
	<!-- jQuery -->
	<script src="${res_url}first/bower_components/jquery/jquery.min.js"></script>
	<link href='${res_url}first/cssto/bootstrap-combined.min.css' rel='stylesheet' type='text/css'>
	<link href='${res_url}first/cssto/bootstrap-datetimepicker.min.css' rel='stylesheet' type='text/css'>

	 <link href='${res_url}first/bower_components/bootstrap/dist/css/bootstrap.min.css' rel='stylesheet' type="text/css">
</head>

<body>
</body>
</html>