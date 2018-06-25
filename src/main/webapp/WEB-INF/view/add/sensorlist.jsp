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
                <a href="#">监控管理</a>
            </li>
        </ul>
    </div>

    <div class="row">
    <div class="box col-md-12">
    <div class="box-inner">
    <div class="box-header well" data-original-title="">
        <h2><i class="glyphicon glyphicon-eye-open"></i> 监控器查询</h2>

   <!--<div class="box-icon">
            <a href="#" class="btn btn-setting btn-round btn-default"><i class="glyphicon glyphicon-cog"></i></a>
            <a href="#" class="btn btn-minimize btn-round btn-default"><i
                    class="glyphicon glyphicon-chevron-up"></i></a>
            <a href="#" class="btn btn-close btn-round btn-default"><i class="glyphicon glyphicon-remove"></i></a>
        </div> -->
        
    </div>
    <div class="box-content">
    <div class="alert alert-info">
    	<a class="btn btn-info" data-toggle="modal" data-target="#addModal">
    		<i class="glyphicon glyphicon-edit icon-white"></i>
              	  添加监控器
       </a></div>
    <table class="table table-striped table-bordered bootstrap-datatable datatable responsive">
    <thead>
    <tr>
    	<th >序号</th>
        <th class="center">运维班</th>
        <th class="center">变电站</th>
        <th class="center">区域</th>
        <th class="center">监控器编号</th>
        <th class="center">监控器名称</th>
        <th class="center">当前状态</th>
        <th class="center">添加时间</th>
        <th class="center">操作</th>
    </tr>
    </thead>
    <tbody>
    <c:set var="row" value="0"/>
    <c:forEach var="sList" items="${sensorList}">
    	<c:set var="row" value="${row+1}" />
	    <tr>
	    	<td  class="center"><c:out value="${row}"  /></td>
	    	<td  class="center">
		    	<c:choose>
		    		<c:when test="${sList.op_name != null}">
		    			<c:out value="${sList.op_name}"  />
		    		</c:when>
		    		<c:otherwise>
		    			<strong><c:out value="-" /></strong>
		    		</c:otherwise>
		    	</c:choose>
	    	</td>
	    	<td  class="center">
		    	<c:choose>
		    		<c:when test="${sList.station_name != null}">
		    			<c:out value="${sList.station_name}"  />
		    		</c:when>
		    		<c:otherwise>
		    			<strong><c:out value="-" /></strong>
		    		</c:otherwise>
		    	</c:choose>
	    	</td>
	    	
	    	<td  class="center">
		    	<c:choose>
		    		<c:when test="${sList.building_name != null}">
		    			<c:out value="${sList.building_name}"  />
		    		</c:when>
		    		<c:otherwise>
		    			<strong><c:out value="-" /></strong>
		    		</c:otherwise>
		    	</c:choose>
	    	</td>
<!-- 	    	<td  class="center"> -->
<%-- 		    	<c:choose> --%>
<%-- 		    		<c:when test="${sList.layer_name != null}"> --%>
<%-- 		    			<c:out value="${sList.layer_name}"  /> --%>
<%-- 		    		</c:when> --%>
<%-- 		    		<c:otherwise> --%>
<%-- 		    			<strong><c:out value="-" /></strong> --%>
<%-- 		    		</c:otherwise> --%>
<%-- 		    	</c:choose> --%>
<!-- 	    	</td> -->
<!-- 	    	<td  class="center"> -->
<%-- 		    	<c:choose> --%>
<%-- 		    		<c:when test="${sList.room_name != null}"> --%>
<%-- 		    			<c:out value="${sList.room_name}"  /> --%>
<%-- 		    		</c:when> --%>
<%-- 		    		<c:otherwise> --%>
<%-- 		    			<strong><c:out value="-" /></strong> --%>
<%-- 		    		</c:otherwise> --%>
<%-- 		    	</c:choose> --%>
<!-- 	    	</td> -->
<!-- 	    	<td  class="center  text-nowrap"> -->
<%-- 		    	<c:choose> --%>
<%-- 		    		<c:when test="${sList.type_name != null}"> --%>
<%-- 		    			<c:out value="${sList.type_name}"  /> --%>
<%-- 		    		</c:when> --%>
<%-- 		    		<c:otherwise> --%>
<%-- 		    			<strong><c:out value="未知" /></strong> --%>
<%-- 		    		</c:otherwise> --%>
<%-- 		    	</c:choose> --%>
<!-- 	    	</td> -->
	    	
	    	<td class="center"><c:out value="${sList.sensor_code}"  /></td>
	    	<td class="center"><c:out value="${sList.name}"  /></td>
	        <td  class="center  text-nowrap">
		    	<c:choose>
		    		<c:when test="${sList.status > 0}">
		    			<span class="label-success label label-default"><c:out value="启动状态"  /></span>
		    		</c:when>
		    		<c:otherwise>
		    			<span class="label-danger label label-default"><strong><c:out value="关闭状态" /></strong></span>
		    		</c:otherwise>
		    	</c:choose>
	    	</td>
	    	<td class="center"><c:out value="${sList.create_time}"  /></td>
	        
	         <td class="center">
	        	<button class="btn btn-success" data-id="${sList.sensor_code}" data-toggle="modal" data-target="#viewModal${sList.sensor_code}">
	        	<i class="glyphicon glyphicon-zoom-in icon-white"></i>
	        	查看
	        	</button>
	        	<%-- <button class="btn btn-info" data-id="${sList.sensor_code}" data-toggle="modal" data-target="#editorModal${sList.sensor_code}">
	        	<i class="glyphicon glyphicon-edit icon-white"></i>
	        		编辑
	        	</button> --%>
	            <button class="btn btn-danger" data-id="${sList.sensor_code}" data-toggle="modal" data-target="#deleteModal${sList.sensor_code}">
	                <i class="glyphicon glyphicon-trash icon-white"></i>
	                	删除
	            </button>
	        </td>
	    </tr>
	    
	    <!-- view模态框（Modal） -->
		<div class="modal fade" id="viewModal${sList.sensor_code}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title" id="myModalLabel">监控器信息</h4>
		            </div>
		            <div class="modal-body .container">
						<div class="form-inline row">
							<div class="col-md-3">
        						<label class="form-label control-label">所属运维班</label>
        					</div>
        					<div class="col-md-6">				
        						<input readonly type="text" class="form-control" value="${sList.op_name}">
        					</div>
        					
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">变电站</label>   
        					</div> 
        					<div class="col-md-6">				
        						<input readonly type="text" class="form-control" value="${sList.station_name}">
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">区域</label>   
        					</div> 
        					<div class="col-md-6">				
        						<input readonly type="text" class="form-control" value="${sList.building_name}">
        					</div>
      					</div>
<!--       					<div class="row"> -->
<!--       						<span> &nbsp;&nbsp;</span> -->
<!--       					</div> -->
<!--       					<div class="form-inline row"> -->
<!--       						<div class="col-md-3"> -->
<!--         						<label class="form-label control-label">楼层</label>    -->
<!--         					</div>  -->
<!--         					<div class="col-md-6">				 -->
<%--         						<input readonly type="text" class="form-control" value="${sList.layer_name}"> --%>
<!--         					</div> -->
<!--       					</div> -->
<!--       					<div class="row"> -->
<!--       						<span> &nbsp;&nbsp;</span> -->
<!--       					</div> -->
<!--       					<div class="form-inline row"> -->
<!--       						<div class="col-md-3"> -->
<!--         						<label class="form-label control-label">变压室</label>    -->
<!--         					</div>  -->
<!--         					<div class="col-md-6">				 -->
<%--         						<input readonly type="text" class="form-control" value="${sList.room_name}"> --%>
<!--         					</div> -->
<!--       					</div> -->
<!--       					<div class="row"> -->
<!--       						<span> &nbsp;&nbsp;</span> -->
<!--       					</div> -->
<!--       					<div class="form-inline row"> -->
<!--       						<div class="col-md-3"> -->
<!--         						<label class="form-label control-label">监控类型</label>    -->
<!--         					</div>  -->
<!--         					<div class="col-md-6">				 -->
<%--         						<input readonly type="text" class="form-control" value="${sList.type_name}"> --%>
<!--         					</div> -->
<!--       					</div> -->
      					
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">监控器编号</label>   
        					</div> 
        					<div class="col-md-6">				
        						<input readonly type="text" class="form-control" value="${sList.sensor_code}">
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">监控器名称</label>   
        					</div> 
        					<div class="col-md-6">				
        						<input readonly type="text" class="form-control" value="${sList.name}">
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">添加时间</label>   
        					</div> 
        					<div class="col-md-6">				
        						<input readonly type="text" class="form-control" value="${sList.create_time}">
        					</div>
      					</div>
					</div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
		            </div>
		        </div><!-- /.modal-content -->
		    </div><!-- /.modal -->
		</div><!-- view模态结束 -->
		
		 <!-- delete模态框（Modal） -->
		<div class="modal fade" id="deleteModal${sList.sensor_code}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title" id="myModalLabel">监控器信息</h4>
		            </div>
		            <div class="modal-body .container">
						<div class="form-inline row">
							<div class="col-md-3">
        						<label class="form-label control-label">所属运维班</label>
        					</div>
        					<div class="col-md-6">				
        						<input readonly type="text" class="form-control" value="${sList.op_name}">
        					</div>
        					
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">变电站</label>   
        					</div> 
        					<div class="col-md-6">				
        						<input readonly type="text" class="form-control" value="${sList.station_name}">
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">区域</label>   
        					</div> 
        					<div class="col-md-6">				
        						<input readonly type="text" class="form-control" value="${sList.building_name}">
        					</div>
      					</div>
<!--       					<div class="row"> -->
<!--       						<span> &nbsp;&nbsp;</span> -->
<!--       					</div> -->
<!--       					<div class="form-inline row"> -->
<!--       						<div class="col-md-3"> -->
<!--         						<label class="form-label control-label">楼层</label>    -->
<!--         					</div>  -->
<!--         					<div class="col-md-6">				 -->
<%--         						<input readonly type="text" class="form-control" value="${sList.layer_name}"> --%>
<!--         					</div> -->
<!--       					</div> -->
<!--       					<div class="row"> -->
<!--       						<span> &nbsp;&nbsp;</span> -->
<!--       					</div> -->
<!--       					<div class="form-inline row"> -->
<!--       						<div class="col-md-3"> -->
<!--         						<label class="form-label control-label">变压室</label>    -->
<!--         					</div>  -->
<!--         					<div class="col-md-6">				 -->
<%--         						<input readonly type="text" class="form-control" value="${sList.room_name}"> --%>
<!--         					</div> -->
<!--       					</div> -->
<!--       					<div class="row"> -->
<!--       						<span> &nbsp;&nbsp;</span> -->
<!--       					</div> -->
<!--       					<div class="form-inline row"> -->
<!--       						<div class="col-md-3"> -->
<!--         						<label class="form-label control-label">监控类型</label>    -->
<!--         					</div>  -->
<!--         					<div class="col-md-6">				 -->
<%--         						<input readonly type="text" class="form-control" value="${sList.type_name}"> --%>
<!--         					</div> -->
<!--       					</div> -->
      					
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">监控器编号</label>   
        					</div> 
        					<div class="col-md-6">				
        						<input readonly type="text" class="form-control" value="${sList.sensor_code}">
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      				<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">监控器名称</label>   
        					</div> 
        					<div class="col-md-6">				
        						<input readonly type="text" class="form-control" value="${sList.name}">
        					</div>
      					</div>
      					
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">添加时间</label>   
        					</div> 
        					<div class="col-md-6">				
        						<input readonly type="text" class="form-control" value="${sList.create_time}">
        					</div>
      					</div>
					</div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
		                <button type="button" onclick="deleteItem('${sList.sensor_code}')" class="btn btn-danger">删除确认</button>
		            </div>
		        </div><!-- /.modal-content -->
		    </div><!-- /.modal -->
		</div><!-- delete模态结束 -->
	    
	</c:forEach>
    </tbody>
    </table>
    </div>
    </div>
    </div>
    <!--/span-->

    </div><!--/row-->


		 <!-- add模态框（Modal） -->
		<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title" id="myModalLabel">添加监控器</h4>
		            </div>
		            <div class="modal-body .container">

      					
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div hidden id="typealert" class="form-group alert alert-danger">
					    	<strong>警告:</strong>请选择一个运维组！
						</div>
      					<div hidden id="nooperationalert" class="form-group alert alert-danger">
					   		 <strong>警告:</strong>没有可用的运维组，请先创建运维组！
						</div>
      					
      					<div class="form-inline row">
      						<div class="col-md-3">
      							<label class="form-label control-label">所属运维班</label>
      						</div>
      						<div class="col-md-6">	
	      						<select id="station_op_class" onchange="getOpClassSelect(this)" class="form-control selectpicker">
	                        		<option  value='0'>---请选择运维班---</option>
	                       		</select>
                       		</div>
      					</div>

      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div hidden id="nostationalert" class="form-group alert alert-danger">
					   		 <strong>警告:</strong>该运维组无变电站！
						</div>
      					<div hidden id="add_station_manager_div" class="form-inline row">
      						<div class="col-md-3">
      							<label class="form-label control-label">变电站</label>
      						</div>
      						<div class="col-md-6">	
	      						<select id="add_station" onclick="managerSelect(this)" class="form-control selectpicker">
	                        		<option  value='0'>---请选择变电站---</option>
	                       		</select>
                       		</div>
      					</div>
      					
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div hidden id="nobuildingalert" class="form-group alert alert-danger">
					   		 <strong>警告:</strong>没有区域信息，请先创建区域！
						</div>
      					<div hidden id="add_building_div" class="form-inline row">
      						<div class="col-md-3">
      							<label class="form-label control-label">所属区域</label>
      						</div>
      						<div class="col-md-6">	
	      						<select id="add_building" onclick="typeSelect(this)" class="form-control selectpicker">
	                        		<option  value='0'>---请选择区域---</option>
	                       		</select>
                       		</div>
      					</div>
<!--       					<div class="row"> -->
<!--       						<span> &nbsp;&nbsp;</span> -->
<!--       					</div> -->
<!--       					<div hidden id="nolayeralert" class="form-group alert alert-danger"> -->
<!-- 					   		 <strong>警告:</strong>没有楼层信息，请先创建楼层！ -->
<!-- 						</div> -->
<!--       					<div hidden id="add_layer_div" class="form-inline row"> -->
<!--       						<div class="col-md-3"> -->
<!--       							<label class="form-label control-label">所属楼层</label> -->
<!--       						</div> -->
<!--       						<div class="col-md-6">	 -->
<!-- 	      						<select id="add_layer" onclick="layerSelect(this)" class="form-control selectpicker"> -->
<!--                     		<option  value='0'>---请选择楼层---</option> -->	     
<!-- 	                       		</select> -->
<!--                        		</div> -->
<!--       					</div> -->
<!--       					<div class="row"> -->
<!--       						<span> &nbsp;&nbsp;</span> -->
<!--       					</div> -->
<!--       					<div hidden id="noroomalert" class="form-group alert alert-danger"> -->
<!-- 					   		 <strong>警告:</strong>没有变电室信息，请先创建！ -->
<!-- 						</div> -->
<!--       					<div hidden id="add_room_div" class="form-inline row"> -->
<!--       						<div class="col-md-3"> -->
<!--       							<label class="form-label control-label">所属变电室</label> -->
<!--       						</div> -->
<!--       						<div class="col-md-6">	 -->
<!-- 	      						<select id="add_room" onclick="roomSelect(this)" class="form-control selectpicker"> -->
<!--                  		<option  value='0'>---请选择变电室---</option> -->	        
<!-- 	                       		</select> -->
<!--                        		</div> -->
<!--       					</div> -->
<!--       					<div class="row"> -->
<!--       						<span> &nbsp;&nbsp;</span> -->
<!--       					</div> -->
<!--       					<div hidden id="notypealert" class="form-group alert alert-danger"> -->
<!-- 					   		 <strong>警告:</strong>没有类型信息，请先创建！ -->
<!-- 						</div> -->
<!--       					<div hidden id="add_type_div" class="form-inline row"> -->
<!--       						<div class="col-md-3"> -->
<!--       							<label class="form-label control-label">所属类型</label> -->
<!--       						</div> -->
<!--       						<div class="col-md-6"> -->
<!-- 	      						<select id="add_type" onclick="typeSelect(this)" class="form-control selectpicker"> -->
<!--             		<option  value='0'>---请选择监控器类型---</option> -->	             
<!-- 	                       		</select> -->
<!--                        		</div> -->
<!--       					</div> -->
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					
      					<div hidden id="namealert" class="form-group alert alert-danger">
					   		<strong>警告:</strong>不能为空！
						</div>
      					<div hidden id = "sensor_code_div" class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">监控器编号</label>
        					</div>
        					<div class="col-md-6">
        						<input  id ="add_sensor_code_value" type="text"  onblur="isNameEmpt(this)" onfocus="hiddenNameAlert()" class="form-control" value="">
        					</div>
        					<div class="col-md-2">
        						<span class='availability_status'></span>
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div hidden id = "sensor_name_div" class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">监控器名称</label>
        					</div>
        					<div class="col-md-6">
        						<input  id ="add_sensor_name_value" type="text"  onblur="isNameEmpt2(this)" onfocus="hiddenNameAlert()" class="form-control" value="">
        					</div>
        					<div class="col-md-2">
        						<span class='availability_status2'></span>
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
					</div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
		                <button id="op_class_add" type="button" onclick="addItem(this)" class="btn btn-danger" disabled>添加监控</button>
		            </div>
		        </div><!-- /.modal-content -->
		    </div><!-- /.modal -->
		</div><!-- add模态结束 -->

<script type="text/javascript">

	$('#addModal').on('shown.bs.modal', function () {
  		getOperationClass();
	})

	//判断用户名不为空
	function isNameEmpt(obj){
		if(obj.value == ""){
			//$('#namealert').removeClass("hidden");
			$('#namealert').show();
			//$('#station_op_class').prop('disabled', true);
		}else{
			//$('#station_op_class').prop('disabled', false);
			// getOperationClass();
			isExisting(obj);
		}

	}
	
		//判断用户名不为空
	function isNameEmpt2(obj){
		if(obj.value == ""){
			//$('#namealert').removeClass("hidden");
			$('#namealert').show();
			//$('#station_op_class').prop('disabled', true);
		}else{
			//$('#station_op_class').prop('disabled', false);
			// getOperationClass();
			isExisting2(obj);
		}

	}
	
	
	//获得焦点后，隐藏告警
	function hiddenNameAlert(obj){
		//$('#namealert').addClass("hidden");
		$('#namealert').hide();
	}
	
	
	function isExisting(which){
		if (which) {
			var obj = $(which);
	        var result;
	        if(obj.val() == ""){
	        	$.toaster({ priority : 'warning', title : '告警信息', message : '添加失败！'});
				return;
			}
	        
	        $(".availability_status").html('<img src="img/loader2.gif" align="absmiddle">');
	        
	        $.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/sensorlist/isExisting",
			 	data: {"name":obj.val()},
			    success: function(data) {
					var result = data.hasExisting;
				    console.log("hasExisting"+result);
		            if (result == 0) {
		                $('.availability_status').html('');
		                $('.availability_status').html('<i class="glyphicon glyphicon-remove" style="color:red"></i> 已存在');		                
		                obj.focus();
		                $('#op_class_add').prop('disabled', true);
		                return true;
		            }else if(result == 1){
		                $('.availability_status').html('');
		                $('.availability_status').html('<i class="glyphicon glyphicon-ok" style="color:green"></i> 可用');
		             	$('#op_class_add').prop('disabled', false);
		                // getOperationClass();
		                return false;
		            }
			    }
	        });
	        return false;
	    }else {
	        $('.availability_status').html('');	        
	        $('#addModal').modal("hide");
	        $.toaster({ priority : 'warning', title : '提示信息', message : '请重新点击添加按钮！'});
	        return false;
	    }
	} 
	
	function isExisting2(which){
		if (which) {
			var obj = $(which);
	        var result;
	        if(obj.val() == ""){
	        	$.toaster({ priority : 'warning', title : '告警信息', message : '添加失败！'});
				return;
			}
	        
	        $(".availability_status2").html('<img src="img/loader2.gif" align="absmiddle">');
	        console.log("name="+obj.val());
	        $.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/sensorlist/isExisting2",
			 	data: {"name":obj.val()},
			    success: function(data) {
					var result = data.hasExisting;
				    console.log("hasExisting"+result);
		            if (result == 0) {
		                $('.availability_status2').html('');
		                $('.availability_status2').html('<i class="glyphicon glyphicon-remove" style="color:red"></i> 已存在');		                
		                obj.focus();
		                $('#op_class_add').prop('disabled', true);
		                return true;
		            }else if(result == 1){
		                $('.availability_status2').html('');
		                $('.availability_status2').html('<i class="glyphicon glyphicon-ok" style="color:green"></i> 可用');
		             	$('#op_class_add').prop('disabled', false);
		                // getOperationClass();
		                return false;
		            }
			    }
	        });
	        return false;
	    }else {
	        $('.availability_status2').html('');	        
	        $('#addModal').modal("hide");
	        $.toaster({ priority : 'warning', title : '提示信息', message : '请重新点击添加按钮！'});
	        return false;
	    }
	} 
	
	function addItem(which){
		var parentdiv = $(which).parents('.modal-content');
		
//		var type = parentdiv.find("#add_type");
		var sensor_code = parentdiv.find("#add_sensor_code_value");
		var station_op = parentdiv.find("#station_op_class");
		var station = parentdiv.find("#add_station");
		var building = parentdiv.find("#add_building");
//		var layer = parentdiv.find("#add_layer");
//		var room = parentdiv.find("#add_room");
		var name = parentdiv.find("#add_sensor_name_value");
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/sensorlist/addItem",
			    data: {
			    		"sensor_code":sensor_code.val(),
//			    		"station_op":station_op.val(),
//			    		"station":station.val(),
			    		"building":building.val(),
			    		"name":name.val()},
			    success: function(data) {
					var result = data.result;
				    console.log("result="+result);
				        	   
		            if (result == true) { //成功添加
		                $.toaster({ priority : 'success', title : '提示信息', message : '添加'+sensor_code.val()+'成功！'});
		                $('#addModal').modal("hide");
		                window.location.reload(true);
		                return true;
		            }else{ //添加失败
		                $.toaster({ priority : 'warning', title : '告警信息', message : '添加失败！'});
						$('#addModal').modal("hide");
		                return false;
		            }
			    },
			    error:function(){
			    	$.toaster({ priority : 'danger', title : '错误信息', message : '请求添加错误，请确认路径正确或网络正常！'});
			    	$('#addModal').modal("hide");
			    }
	        });
	    //window.location.reload("/station");
	    return false;
	}


	
	function getOperationClass(){
	
		var which = $('#station_op_class');
		var name="${sessionScope.sysUser.name}";
		$(which).empty();
		$(which).append("<option value='0'>---请选择运维班---</option>");
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/getoperation",
			    data:{"username":name},
			    success: function(data) {
					var result = data.oplist;
					if(result){
						  
					     $.each(result, function(i,value){
					     	
					    	//$('#operationclass').options.add(new Option(value.op_name,value.id));
					    	// console.log(value.id+"--"+value.op_name);
					    	//$('#operationclass').append("<option value='"+value.id+"'"+">"+value.op_name+"</option>");
					    	$(which).append("<option value='"+value.id+"'>"+value.op_name+"</option>"); 
					    });
					}else{
						showAlert('nooperationalert');
						$('#add_station_manager_div').hide();
					}
			    }
	        });

	}
	
	function getOpClassSelect(which){
			        
	    var sindex = which.selectedIndex;
	    
	    hiddleComp('nostationalert',which);
		if(sindex == 0){
			isSelect('typealert',which);
			$('#add_station_manager_div').hide();
			$('#add_building_div').hide();
			$('#add_layer_div').hide();
			$('#add_room_div').hide();
			$('#add_type_div').hide();
			$('#sensor_code_div').hide();
			
		}else{
			// hiddleComp('typealert',which);
			$('#add_station_manager_div').show();
			$('#add_building_div').hide();
			$('#add_layer_div').hide();
			$('#add_room_div').hide();
			$('#add_type_div').hide();
			$('#sensor_code_div').hide();
			getStation(which.value);
		}
	}
	
	function getStation(op){
		var which = $('#add_station');
		var opclass = op;
		// console.log("opclass="+opclass);
		hiddleComp('nostationalert',which);
		$(which).empty();
		$(which).append("<option  value='0'>---请选择变电站---</option>");
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/building/getStation",
			    data:{"opclass":opclass},
			    success: function(data) {
					var result = data.stationRecords;
					if(result){
							
					     $.each(result, function(i,value){
					     	
					    	//$('#operationclass').options.add(new Option(value.op_name,value.id));
					    	//console.log(value.id+"--"+value.user_name);
					    	//$('#operationclass').append("<option value='"+value.id+"'"+">"+value.op_name+"</option>");
					    	$(which).append("<option value='"+value.id+"'>"+value.station_name+"</option>"); 
					    });
					}else{
						showAlert('nostationalert');
						$('#add_station_manager_div').hide();
					}
			    }
	        });
	        
	        
	}
	
	function managerSelect(which){
		var sindex = which.selectedIndex;
		
		if(sindex == 0){
			$('#add_building_div').hide();
			$('#add_layer_div').hide();
			$('#add_room_div').hide();
			$('#add_type_div').hide();
			$('#sensor_code_div').hide();
		}else{
			$('#add_building_div').show();
			$('#add_layer_div').hide();
			$('#add_room_div').hide();
			$('#add_type_div').hide();
			$('#sensor_code_div').hide();
			getBuilding(which.value);
		}
	}
	

	function getBuilding(op){
	
		hiddleComp('nobuildingalert');
		
		var which = $('#add_building');
		
		var para = op;
		$(which).empty();
		$(which).append("<option  value='0'>---请选择区域---</option>");
		
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/layer/getBuilding",
			    data:{"station":para},
			    success: function(data) {
					var result = data.buildingRecords;
					if(result){
						
					     $.each(result, function(i,value){
					     	
					    	//$('#operationclass').options.add(new Option(value.op_name,value.id));
					    	//console.log(value.id+"--"+value.user_name);
					    	//$('#operationclass').append("<option value='"+value.id+"'"+">"+value.op_name+"</option>");
					    	$(which).append("<option value='"+value.id+"'>"+value.building_name+"</option>"); 
					    });
					}else{
						showAlert('nobuildingalert');
						
						$('#add_building_div').hide();
					}
			    }
	        });
	}

	function buildingSelect(which){
		var sindex = which.selectedIndex;
		if(sindex == 0){
			$('#add_layer_div').hide();
			$('#add_room_div').hide();
			$('#add_type_div').hide();
			$('#sensor_code_div').hide();
		}else{
			$('#add_layer_div').show();
			$('#add_room_div').hide();
			$('#add_type_div').hide();
			$('#sensor_code_div').hide();
			getLayer(which.value);
		}
	}
	
	function getLayer(op){
		
		var which = $('#add_layer');
		var para = op;
		hiddleComp('nolayeralert',which);
		$(which).empty();
		$(which).append("<option  value='0'>---请选择楼层---</option>");
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/room/getLayer",
			    data:{"layer":para},
			    success: function(data) {
					var result = data.layerRecords;
					if(result){
						
					     $.each(result, function(i,value){
					     	
					    	//$('#operationclass').options.add(new Option(value.op_name,value.id));
					    	//console.log(value.id+"--"+value.user_name);
					    	//$('#operationclass').append("<option value='"+value.id+"'"+">"+value.op_name+"</option>");
					    	$(which).append("<option value='"+value.id+"'>"+value.layer_name+"</option>"); 
					    });
					}else{
						showAlert('nolayeralert');
						$('#add_layer_div').hide();
					}
			    }
	        });
	}
	
	function layerSelect(which){
		var sindex = which.selectedIndex;
		if(sindex == 0){			
			$('#add_room_div').hide();
			$('#add_type_div').hide();
			$('#sensor_code_div').hide();
		}else{
			$('#add_room_div').show();
			$('#add_type_div').hide();
			$('#sensor_code_div').hide();
			getRoom(which.value);
		}
	}
	
	function getRoom(op){
		
		var which = $('#add_room');
		var para = op;
		hiddleComp('noroomalert',which);
		
		$(which).empty();
		$(which).append("<option  value='0'>---请选择变电室---</option>");
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/room/getRoom",
			    data:{"layer":para},
			    success: function(data) {
					var result = data.roomRecords;
					if(result){
						
					     $.each(result, function(i,value){
					     	
					    	//$('#operationclass').options.add(new Option(value.op_name,value.id));
					    	//console.log(value.id+"--"+value.user_name);
					    	//$('#operationclass').append("<option value='"+value.id+"'"+">"+value.op_name+"</option>");
					    	$(which).append("<option value='"+value.id+"'>"+value.room_name+"</option>"); 
					    });
					}else{
						showAlert('noroomalert');
						$('#add_room_div').hide();
					}
			    }
	        });
	}

	function roomSelect(which){
		var sindex = which.selectedIndex;
		if(sindex == 0){		
		
			$('#add_type_div').hide();
			$('#sensor_code_div').hide();
		}else{
			$('#add_type_div').show();
			$('#sensor_code_div').hide();
			getType(which.value);
		}
	}
	
	function getType(op){
		
		var which = $('#add_type');
		var para = op;
		hiddleComp('notypealert',which);
		
		$(which).empty();
		$(which).append("<option  value='0'>---请选择监控器类型---</option>");
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/sensorlist/getSensorType",
			    data:{"room":para},
			    success: function(data) {
					var result = data.sensorTypeList;
					if(result){
						
					     $.each(result, function(i,value){
					     	
					    	//$('#operationclass').options.add(new Option(value.op_name,value.id));
					    	//console.log(value.id+"--"+value.user_name);
					    	//$('#operationclass').append("<option value='"+value.id+"'"+">"+value.op_name+"</option>");
					    	$(which).append("<option value='"+value.id+"'>"+value.type_name+"</option>"); 
					    });
					}else{
						showAlert('notypealert');
						$('#add_type_div').hide();
					}
			    }
	        });
	}
	
	function typeSelect(which){
		var sindex = which.selectedIndex;
		if(sindex == 0){		
			
			$('#sensor_code_div').hide();
			$('#sensor_name_div').hide();
		}else{
			$('#sensor_code_div').show();
			$('#sensor_name_div').show();
		}
	}
	

	function deleteItem(value) {
	    if (value) {
	        var result;
			
	        $.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/sensorlist/deleteSensor",
			    data: {"sensorcode":value},
			    success: function(data) {
					var result = data.result;
				    console.log("result="+result);
				        	   
		            if (result == true) { //成功删除传感器
		                $.toaster({ priority : 'success', title : '提示信息', message : '删除监控器成功！'});
		                $('#deleteModal${sList.sensor_code}').modal("hide");
		                window.location.reload(true);
		                return true;
		            }else{ //删除监控器失败，请确认监控器存在
		                $.toaster({ priority : 'warning', title : '告警信息', message : '删除监控器失败请确认用户存在！'});
						$('#deleteModal${sList.sensor_code}').modal("hide");
		                return false;
		            }
		            
			    },
			    error:function(){
			    	$.toaster({ priority : 'danger', title : '错误信息', message : '请求删除监控器失败，请确认路径正确或网络正常！'});
			    }
	        });
			//window.location.reload("/sensorlist");
			
	        // Sends a asyn reqeust, return false temporary.
	        return false;
	        ////e.preventDefault();
	    }else {
	    	$('#deleteModal${userList.id}').modal("hide");
	        $.toaster({ priority : 'warning', title : '提示信息', message : '请重新选择需要删除的用户！'});
	        return false;
	    }
	}

	
	function showAlert(comp){
		var selected = "#"+comp;
		$(selected).show();
	}
	
		//判断密码不为空
	function isSelect(comp,obj){
		var selected = "#"+comp;
		if(obj.selectedIndex == 0){
			//$('#passalert').removeClass("hidden");
			$(selected).show();
		}
	}
	
	//获取焦点后，隐藏告警信息
	function hiddleComp(comp,obj){
		//$('#passalert').addClass("hidden");
		var selected = "#"+comp;
		$(selected).hide();
	}
	

</script>

<%@ include file="common/footer.jsp" %>