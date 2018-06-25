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
        <h2><i class="glyphicon glyphicon-eye-open"></i> 监控器类型</h2>

        <div class="box-icon">
            <a href="#" class="btn btn-setting btn-round btn-default"><i class="glyphicon glyphicon-cog"></i></a>
            <a href="#" class="btn btn-minimize btn-round btn-default"><i
                    class="glyphicon glyphicon-chevron-up"></i></a>
            <a href="#" class="btn btn-close btn-round btn-default"><i class="glyphicon glyphicon-remove"></i></a>
        </div>
    </div>
    <div class="box-content">
    <div class="alert alert-info">
    	<a class="btn btn-info" data-toggle="modal" data-target="#addSensorModal">
    		<i class="glyphicon glyphicon-edit icon-white"></i>
              	  添加监控器类型
       </a>
    </div>
    <table class="table table-striped table-bordered bootstrap-datatable datatable responsive">
    <thead>
    
    <tr>
    	<th >序号</th>
        <th class="center">监控器类型</th>
        <th class="center">添加时间</th>
        <th class="center">操作</th>
    </tr>

    </thead>
    <tbody>
    <c:set var="row" value="0"/>
    <c:forEach var="stList" items="${sensorTypeList}">
	    <tr>
	    	<td  class="center"><c:out value="${stList.id}"  /></td>
	    	<td  class="center"><c:out value="${stList.type_name}"  /></td>
	    	<td  class="center  text-nowrap">
		    	<c:choose>
		    		<c:when test="${stList.create_time != null}">
		    			<c:out value="${stList.create_time}"  />
		    		</c:when>
		    		<c:otherwise>
		    			<strong><c:out value="--" /></strong>
		    		</c:otherwise>
		    	</c:choose>
	    	</td>
	    	
	         <td class="center">
	        	<button class="btn btn-success" data-id="${stList.id}" data-toggle="modal" data-target="#viewModal${stList.id}">
	        	<i class="glyphicon glyphicon-zoom-in icon-white"></i>
	        	查看
	        	</button>
	        	<%-- <button class="btn btn-info" data-id="${sList.sensor_code}" data-toggle="modal" data-target="#editorModal${sList.sensor_code}">
	        	<i class="glyphicon glyphicon-edit icon-white"></i>
	        		编辑
	        	</button> --%>
	            <button class="btn btn-danger" data-id="${stList.id}" data-toggle="modal" data-target="#deleteModal${stList.id}">
	                <i class="glyphicon glyphicon-trash icon-white"></i>
	             	删除
	            </button>
	        </td>
	    </tr>
	    
	    <!-- view模态框（Modal） -->
		<div class="modal fade" id="viewModal${stList.id}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title" id="myModalLabel">监控器类型信息</h4>
		            </div>
		            <div class="modal-body .container">
						<div class="form-inline row">
							<div class="col-md-3">
        						<label class="form-label control-label">序号</label>
        					</div>
        					<div class="col-md-6">				
        						<input readonly type="text" class="form-control" value="${stList.id}">
        					</div>
        					
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">监控器类型</label>   
        					</div> 
        					<div class="col-md-6">				
        						<input readonly type="text" class="form-control" value="${stList.type_name}">
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
        						<input readonly type="text" class="form-control" value="${stList.create_time}">
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      			
					</div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
		            </div>
		        </div><!-- /.modal-content -->
		    </div><!-- /.modal -->
		</div><!-- view模态结束 -->
		
		 <!-- delete模态框（Modal） -->
		<div class="modal fade" id="deleteModal${stList.id}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title" id="myModalLabel">监控器类型信息</h4>
		            </div>
		            <div class="modal-body .container">
						<div class="form-inline row">
							<div class="col-md-3">
        						<label class="form-label control-label">序号</label>
        					</div>
        					<div class="col-md-6">				
        						<input readonly type="text" class="form-control" value="${stList.id}">
        					</div>
        					
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">监控器类型</label>   
        					</div> 
        					<div class="col-md-6">				
        						<input readonly type="text" class="form-control" value="${stList.type_name}">
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
        						<input readonly type="text" class="form-control" value="${stList.create_time}">
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      			
					</div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
		                <button type="button" onclick="deleteItem('${stList.id}')" class="btn btn-danger">删除确认</button>
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
		<div class="modal fade" id="addSensorModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title" id="myModalLabel">监控器类型信息</h4>
		            </div>
		            <div class="modal-body .container">
						
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div hidden id="namealert" class="form-group alert alert-danger">
					   	 <strong>警告:</strong>不能为空！
						</div>
      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">监控器类型</label>   
        					</div> 
        					<div class="col-md-6">				
        						<input  name="sensor_type.type_name" type="text"  onblur="isNameEmpt(this)" onfocus="hiddenNameAlert()" class="form-control" value="">
        					</div>
        					<div class="col-md-2">
        						<span class='availability_status'></span>
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      			
					</div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
		                <button id="sensor_type_add" type="button" onclick="addItem(this)" class="btn btn-danger" disabled>添加类型</button>
		            </div>
		        </div><!-- /.modal-content -->
		    </div><!-- /.modal -->
		</div><!-- add模态结束 -->

<script type="text/javascript">

	//判断用户名不为空
	function isNameEmpt(obj){
		if(obj.value == ""){
			//$('#namealert').removeClass("hidden");
			$('#namealert').show();
		}else{
			isExisting(obj)
		}

	}
	
	//获得焦点后，隐藏告警
	function hiddenNameAlert(obj){
		//$('#namealert').addClass("hidden");
		$('#namealert').hide();
	}


	function addItem(which){
		var parentdiv = $(which).parents('.modal-content');
		var sensorType = parentdiv.find("input[name='sensor_type.type_name']");
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "/sensortype/addItem",
			    data: {"sensortype":sensorType.val()},
			    success: function(data) {
					var result = data.result;
				    console.log("result="+result);
				        	   
		            if (result == true) { //成功添加
		                $.toaster({ priority : 'success', title : '提示信息', message : '添加'+sensorType.val()+'成功！'});
		                $('#addSensorModal').modal("hide");
		                window.location.reload(true);
		                return true;
		            }else{ //添加失败
		                $.toaster({ priority : 'warning', title : '告警信息', message : '添加类型失败！'});
						$('#addSensorModal').modal("hide");
		                return false;
		            }
		            
			    },
			    error:function(){
			    	$.toaster({ priority : 'danger', title : '错误信息', message : '请求添加错误，请确认路径正确或网络正常！'});
			    	$('#addSensorModal').modal("hide");
			    }
	        });
	        
	    //window.location.reload("/sensortype");
	    return false;
		
	}

	function isExisting(which){
	
		// Disable function
		
		if (which) {
			var obj = $(which);
	        var result;
	        if(obj.val() == ""){
	        	$.toaster({ priority : 'warning', title : '告警信息', message : '添加类型失败！'});
				return;
			}
	        //&nbsp;Checking availability...
	        // Loads checking image.
	        $(".availability_status").html('<img src="img/loader2.gif" align="absmiddle">');
	        // Sends ajax request to check the name is available or not.
	        $.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "/sensortype/isExisting",
			 	data: {"sensortype":obj.val()},
			    success: function(data) {
					var result = data.hasExisting;
				    console.log("hasExisting"+result);
		            if (result == 1) {
		                $('.availability_status').html('');
		                $('.availability_status').html('<i class="glyphicon glyphicon-remove" style="color:red"></i> 已存在');
		                /* $('.availability_status').removeClass('tick');
		                $('.availability_status').addClass('error'); */
		                $('input[name="sensor_type.type_name"]').focus();
		                //$('input[name="user.phone"]').attr("readonly","readonly")//将input元素设置为readonly
						//$('input[name="user.phone"]').removeAttr("readonly");//去除input元素的readonly属性
		                $('#sensor_type_add').prop('disabled', true);
		                return true;
		            }else if(result == 0){
		                $('.availability_status').html('');
		                $('.availability_status').html('<i class="glyphicon glyphicon-ok" style="color:green"></i> 可用');
		               /*  $('.availability_status').removeClass('error');
		                $('.availability_status').addClass('tick'); */
		                $('#sensor_type_add').prop('disabled', false);
		                return false;
		            }
				        // When the checking completed, then loaded corresponding css style.
				        /* $('.availability_status').ajaxComplete(function(event, request, settings) {
				
				        }); */
			    }
	        });
			//window.location.reload("/sensortype");
	        // Sends a asyn reqeust, return false temporary.
	        return false;
	        ////e.preventDefault();
	    }else {
	        $('.availability_status').html('');
	        
	        $('#addSensorModal').modal("hide");
	        $.toaster({ priority : 'warning', title : '提示信息', message : '请重新点击添加按钮！'});
	        return false;
	    }

	}

	function deleteItem(value) {
	    if (value) {
	        var result;
			
	        $.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "/sensortype/deleteSensorType",
			    data: {"sensorTypeId":value},
			    success: function(data) {
					var result = data.result;
				    console.log("result="+result);
				        	   
		            if (result == true) { //成功删除传感器
		                $.toaster({ priority : 'success', title : '提示信息', message : '删除监控器类型成功！'});
		                $('#deleteModal${sList.sensor_code}').modal("hide");
		                window.location.reload(true);
		                return true;
		            }else{ //删除监控器失败，请确认监控器存在
		                $.toaster({ priority : 'warning', title : '告警信息', message : '删除监控器类型失败请确认存在！'});
						$('#deleteModal${sList.sensor_code}').modal("hide");
		                return false;
		            }
		            
			    },
			    error:function(){
			    	$.toaster({ priority : 'danger', title : '错误信息', message : '请求删除监控器失败，请确认路径正确或网络正常！'});
			    }
	        });
			// window.location.reload("/sensorlist");
			
	        // Sends a asyn reqeust, return false temporary.
	        return false;
	        ////e.preventDefault();
	    }else {
	    	$('#deleteModal${userList.id}').modal("hide");
	        $.toaster({ priority : 'warning', title : '提示信息', message : '请重新选择需要删除的条目！'});
	        return false;
	    }
	}

</script>

<%@ include file="common/footer.jsp" %>