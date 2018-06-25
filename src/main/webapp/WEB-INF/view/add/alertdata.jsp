<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<% System.setProperty("no_visible_elements", "false"); %>
<%@ include file="common/header.jsp" %>

    <div>
        <ul class="breadcrumb">
            <li>
                <a href="#">主页</a>
            </li>
            <li>
                <a href="#">告警信息</a>
            </li>
        </ul>
    </div>

    <div class="row">
    <div class="box col-md-12">
    <div class="box-inner">
    <div class="box-header well" data-original-title="">
        <h2><i class="glyphicon glyphicon-bell"></i> 告警详情</h2>

        <div class="box-icon">
            <a href="#" class="btn btn-setting btn-round btn-default"><i class="glyphicon glyphicon-cog"></i></a>
            <a href="#" class="btn btn-minimize btn-round btn-default"><i
                    class="glyphicon glyphicon-chevron-up"></i></a>
            <a href="#" class="btn btn-close btn-round btn-default"><i class="glyphicon glyphicon-remove"></i></a>
        </div>
    </div>
    <div class="box-content">
    <div class="alert alert-info">For help with such table please check <a href="http://datatables.net/" target="_blank">http://datatables.net/</a></div>
    <table class="table table-striped table-bordered bootstrap-datatable datatable responsive">
    <thead>
    <tr>
    	<th >序号</th>
        <th class="center">运维班</th>
        <th class="center">biandian站</th>
        <th class="center">大楼</th>
        <th class="center">楼层</th>
        <th class="center">工作室</th>
        <th class="center">监控器类型</th>
        <th class="center">监控器编号</th>
        <th class="center">告警类型</th>
        <th class="center">描述</th>
        <th class="center">状态</th>
        <th class="center">时间</th>
        <!-- <th class="center">操作</th> -->
    </tr>
    </thead>
    <tbody>
    <c:set var="row" value="0"/>
    <c:forEach var="alertList" items="${alertInfoList}">
    	<c:set var="row" value="${row+1}" />
	    <tr>
	    	<td  class="center"><c:out value="${row}"  /></td>
	    	<c:choose>
	    		<c:when test="${alertList.op_name != null}">
	    			<td  class="center"><c:out value="${alertList.op_name}"  /></td>
	    		</c:when>
	    		<c:otherwise>
	    			<td  class="center"><strong><c:out value="-" /></strong></td>
	    		</c:otherwise>
	    	</c:choose>
	    	<c:choose>
	    		<c:when test="${alertList.station_name != null}">
	    			<td  class="center"><c:out value="${alertList.station_name}"  /></td>
	    		</c:when>
	    		<c:otherwise>
	    			<td  class="center"><strong><c:out value="-" /></strong></td>
	    		</c:otherwise>
	    	</c:choose>
	    	<c:choose>
	    		<c:when test="${alertList.building_name != null}">
	    			<td  class="center"><c:out value="${alertList.building_name}"  /></td>
	    		</c:when>
	    		<c:otherwise>
	    			<td  class="center"><strong><c:out value="-" /></strong></td>
	    		</c:otherwise>
	    	</c:choose>
	    	<c:choose>
	    		<c:when test="${alertList.layer_name != null}">
	    			<td  class="center"><c:out value="${alertList.layer_name}"  /></td>
	    		</c:when>
	    		<c:otherwise>
	    			<td  class="center"><strong><c:out value="-" /></strong></td>
	    		</c:otherwise>
	    	</c:choose>
	    	<c:choose>
	    		<c:when test="${alertList.room_name != null}">
	    			<td  class="center"><c:out value="${alertList.room_name}"  /></td>
	    		</c:when>
	    		<c:otherwise>
	    			<td  class="center"><strong><c:out value="-" /></strong></td>
	    		</c:otherwise>
	    	</c:choose>
	    	<c:choose>
	    		<c:when test="${alertList.type_name != null}">
	    			<td  class="center"><c:out value="${alertList.type_name}"  /></td>
	    		</c:when>
	    		<c:otherwise>
	    			<td  class="center"><strong><c:out value="未知" /></strong></td>
	    		</c:otherwise>
	    	</c:choose>
	    	<td class="center"><c:out value="${alertList.alert_obj_code}"  /></td>
	    	<td class="center"><c:out value="${alertList.alert_type}"  /></td>	  
	    	<td class="center"><c:out value="${alertList.desc}"  /></td>
	    	  	
	    	<c:choose>
	    		<c:when test="${alertList.status == 2}">
	    			<td  class="center"><span class="label-success label label-default"><c:out value="已处理"  /></span></td>
	    		</c:when>
	    		<c:when test="${alertList.status == 1}">
	    			<td  class="center"><span class="label-danger label label-default"><c:out value="未处理"  /></span></td>
	    		</c:when>
	    		<c:otherwise>
	    			<td  class="center"><span class="label-primary label label-default"><c:out value="未知"  /></span></td>
	    		</c:otherwise>
	    	</c:choose>	    	
	    	<td class="center"><c:out value="${alertList.create_time}"  /></td>
	        
	        <!-- <td class="center">
	            <a class="btn btn-success" href="#">
	                <i class="glyphicon glyphicon-zoom-in icon-white"></i>
	                View
	            </a>
	            <a class="btn btn-info" href="#">
	                <i class="glyphicon glyphicon-edit icon-white"></i>
	                Edit
	            </a>
	            <a class="btn btn-danger" href="#">
	                <i class="glyphicon glyphicon-trash icon-white"></i>
	                Delete
	            </a>
	        </td> -->
	    </tr>
	</c:forEach>
    </tbody>
    </table>
    </div>
    </div>
    </div>
    <!--/span-->

    </div><!--/row-->


<%@ include file="common/footer.jsp" %>