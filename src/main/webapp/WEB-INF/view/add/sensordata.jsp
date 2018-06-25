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
                <a href="#">状态监控</a>
            </li>
        </ul>
    </div>

    <div class="row">
    <div class="box col-md-12">
    <div class="box-inner">
    <div class="box-header well" data-original-title="">
        <h2><i class="glyphicon glyphicon-eye-open"></i> 监控详情</h2>

        <div class="box-icon">
            <a href="#" class="btn btn-setting btn-round btn-default"><i class="glyphicon glyphicon-cog"></i></a>
            <a href="#" class="btn btn-minimize btn-round btn-default"><i
                    class="glyphicon glyphicon-chevron-up"></i></a>
            <a href="#" class="btn btn-close btn-round btn-default"><i class="glyphicon glyphicon-remove"></i></a>
        </div>
    </div>
    <div class="box-content">
    <div class="alert alert-info"> </div>
    <table id="iotlist" class="table table-striped table-bordered bootstrap-datatable datatable responsive text-nowrap">
    <thead>
    <tr>
    	<th >序号</th>
        <th class="center">运维班</th>
        <th class="center">biandian站</th>
        <th class="center">大楼</th>
        <th class="center">楼层</th>
        <th class="center">工作室</th>
        <th class="center">类型</th>
        <th class="center">监控器编号</th>
        <th class="center">状态</th>
        <th class="center">开关</th>
        <th class="center">时间</th>
        <!-- <th class="center">操作</th> -->
    </tr>
    </thead>
    <tbody>
    <c:set var="row" value="0"/>
    <c:forEach var="sdList" items="${sensorDataList}">
    	<c:set var="row" value="${row+1}" />
	    <tr>
	    	<td  class="center"><c:out value="${row}"  /></td>
	    	<c:choose>
	    		<c:when test="${sdList.op_name != null}">
	    			<td  class="center"><c:out value="${sdList.op_name}"  /></td>
	    		</c:when>
	    		<c:otherwise>
	    			<td  class="center"><strong><c:out value="-" /></strong></td>
	    		</c:otherwise>
	    	</c:choose>
	    	<c:choose>
	    		<c:when test="${sdList.station_name != null}">
	    			<td  class="center"><c:out value="${sdList.station_name}"  /></td>
	    		</c:when>
	    		<c:otherwise>
	    			<td  class="center"><strong><c:out value="-" /></strong></td>
	    		</c:otherwise>
	    	</c:choose>
	    	<c:choose>
	    		<c:when test="${sdList.building_name != null}">
	    			<td  class="center"><c:out value="${sdList.building_name}"  /></td>
	    		</c:when>
	    		<c:otherwise>
	    			<td  class="center"><strong><c:out value="-" /></strong></td>
	    		</c:otherwise>
	    	</c:choose>
	    	<c:choose>
	    		<c:when test="${sdList.layer_name != null}">
	    			<td  class="center"><c:out value="${sdList.layer_name}"  /></td>
	    		</c:when>
	    		<c:otherwise>
	    			<td  class="center"><strong><c:out value="-" /></strong></td>
	    		</c:otherwise>
	    	</c:choose>
	    	<c:choose>
	    		<c:when test="${sdList.room_name != null}">
	    			<td  class="center"><c:out value="${sdList.room_name}"  /></td>
	    		</c:when>
	    		<c:otherwise>
	    			<td  class="center"><strong><c:out value="-" /></strong></td>
	    		</c:otherwise>
	    	</c:choose>
	    	<c:choose>
	    		<c:when test="${sdList.type_name != null}">
	    			<td  class="center"><c:out value="${sdList.type_name}"  /></td>
	    		</c:when>
	    		<c:otherwise>
	    			<td  class="center"><strong><c:out value="未知" /></strong></td>
	    		</c:otherwise>
	    	</c:choose>
	    	<td class="center"><c:out value="${sdList.device_code}"  /></td>
	    	<td class="center"><c:out value="${sdList.status_value}"  /></td>
	    	
	    	<c:choose>
	    		<c:when test="${sdList.status_current > 0}">
	    			<td  class="center"><span class="label-success label label-default"><c:out value="启动状态"  /></span></td>
	    		</c:when>
	    		<c:otherwise>
	    			<td  class="center"><span class="label-danger label label-default"><c:out value="关闭状态"  /></span></td>
	    		</c:otherwise>
	    	</c:choose>
	    	<td class="center"><c:out value="${sdList.create_time}"  /></td>
	       
	    </tr>
	</c:forEach>
    </tbody>
    </table>
    </div>
    </div>
    </div>
    <!--/span-->

    </div><!--/row-->
<script>


</script>

<%@ include file="common/footer.jsp" %>