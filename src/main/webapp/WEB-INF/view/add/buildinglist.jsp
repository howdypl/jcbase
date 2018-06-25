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
                <a href="#">区域配置</a>
            </li>
        </ul>
    </div>

    <div class="row">
    <div class="box col-md-12">
    <div class="box-inner">
    <div class="box-header well" data-original-title="">
        <h2><i class="glyphicon glyphicon-gift"></i> 区域信息</h2>

        <!-- <div class="box-icon">
            <a href="#" class="btn btn-setting btn-round btn-default"><i class="glyphicon glyphicon-cog"></i></a>
            <a href="#" class="btn btn-minimize btn-round btn-default"><i
                    class="glyphicon glyphicon-chevron-up"></i></a>
            <a href="#" class="btn btn-close btn-round btn-default"><i class="glyphicon glyphicon-remove"></i></a>
        </div> -->
    </div>
    <div class="box-content">
    <div class="alert alert-info">
    	<a class="btn btn-info" data-toggle="modal" data-target="#addBuildingModal">
    		<i class="glyphicon glyphicon-edit icon-white"></i>
              	  添加区域
       </a>
    </div>
    <table class="table table-striped table-bordered bootstrap-datatable datatable responsive">
    <thead>
    
    <tr>
    	<th >序号</th>
        <th class="center">大楼名称</th>
        <th class="center text-nowrap">所属变电站</th>
        <th class="center">变电站地址</th>        
        <th class="center">添加时间</th>
        <th class="center">操作</th>
    </tr>

    </thead>
    <tbody>
    <c:set var="row" value="0"/>
    <c:forEach var="bRecords" items="${buildingList}">
	    <tr>
	    	<td  class="center text-nowrap"><c:out value="${bRecords.id}"  /></td>
	    	<td  class="center  text-nowrap"><c:out value="${bRecords.building_name}"  /></td>
	    	<td  class="center text-nowrap"><c:out value="${bRecords.station_name}"  /></td>
	    	<td  class="center text-nowrap"><c:out value="${bRecords.station_addr}"  /></td>
	    	
	    	<td  class="center  text-nowrap">
		    	<c:choose>
		    		<c:when test="${bRecords.create_time != null}">
		    			<c:out value="${bRecords.create_time}"  />
		    		</c:when>
		    		<c:otherwise>
		    			<strong><c:out value="--" /></strong>
		    		</c:otherwise>
		    	</c:choose>
	    	</td>
	    	
	         <td class="center text-nowrap">
	        	<button class="btn btn-success" data-id="${bRecords.id}" data-toggle="modal" data-target="#viewModal${bRecords.id}">
	        	<i class="glyphicon glyphicon-zoom-in icon-white"></i>
	        	查看
	        	</button>
	        	<%-- <button class="btn btn-info" data-id="${sList.sensor_code}" data-toggle="modal" data-target="#editorModal${sList.sensor_code}">
	        	<i class="glyphicon glyphicon-edit icon-white"></i>
	        		编辑
	        	</button> --%>
	            <button class="btn btn-danger" data-id="${bRecords.id}" data-toggle="modal" data-target="#deleteModal${bRecords.id}">
	                <i class="glyphicon glyphicon-trash icon-white"></i>
	             	删除
	            </button>
	        </td>
	    </tr>
	    
	    <!-- view模态框（Modal） -->
		<div class="modal fade" id="viewModal${bRecords.id}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title" id="myModalLabel">查看区域信息</h4>
		            </div>
		            <div class="modal-body .container">
						<div class="form-inline row">
							<div class="col-md-2">
        						<label class="form-label control-label">序号</label>
        					</div>
        					<div class="col-md-10">				
        						<input readonly type="text" class="form-control" value="${bRecords.id}">
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-2">
        						<label class="form-label control-label">大楼名称</label>   
        					</div> 
        					<div class="col-md-10">				
        						<input readonly type="text" class="form-control" value="${bRecords.building_name}">
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-2">
        						<label class="form-label control-label">所属变电站</label>   
        					</div> 
        					<div class="col-md-10">				
        						<input readonly type="text" class="form-control" value="${bRecords.station_name}">
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-2">
        						<label class="form-label control-label">变电站地址</label>   
        					</div> 
        					<div class="col-md-10">				
        						<input readonly type="text" class="form-control" value="${bRecords.station_addr}">
        					</div>
      					</div>
      					
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-2">
        						<label class="form-label control-label">添加时间</label>   
        					</div> 
        					<div class="col-md-10">				
        						<input readonly type="text" class="form-control" value="${bRecords.create_time}">
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
		<div class="modal fade" id="deleteModal${bRecords.id}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title" id="myModalLabel">删除区域信息</h4>
		            </div>
		            <div class="modal-body .container">
						<div class="form-inline row">
							<div class="col-md-2">
        						<label class="form-label control-label">序号</label>
        					</div>
        					<div class="col-md-10">				
        						<input readonly type="text" class="form-control" value="${bRecords.id}">
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-2">
        						<label class="form-label control-label">大楼名称</label>   
        					</div> 
        					<div class="col-md-10">				
        						<input readonly type="text" class="form-control" value="${bRecords.building_name}">
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-2">
        						<label class="form-label control-label">所属变电站</label>   
        					</div> 
        					<div class="col-md-10">				
        						<input readonly type="text" class="form-control" value="${bRecords.station_name}">
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-2">
        						<label class="form-label control-label">变电站地址</label>   
        					</div> 
        					<div class="col-md-10">				
        						<input readonly type="text" class="form-control" value="${bRecords.station_addr}">
        					</div>
      					</div>
      					
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-2">
        						<label class="form-label control-label">添加时间</label>   
        					</div> 
        					<div class="col-md-10">				
        						<input readonly type="text" class="form-control" value="${bRecords.create_time}">
        					</div>
      					</div>
      			
					</div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
		                <button type="button" onclick="deleteItem('${bRecords.id}')" class="btn btn-danger">删除确认</button>
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
		<div class="modal fade" id="addBuildingModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title" id="myModalLabel">添加区域</h4>
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
        						<label class="form-label control-label">大楼名称</label>   
        					</div> 
        					<div class="col-md-6">				
        						<input  id ="add_building_name" type="text"  onblur="isNameEmpt(this)" onfocus="hiddenNameAlert()" class="form-control" value="">
        					</div>
        					<div class="col-md-2">
        						<span class='availability_status'></span>
        					</div>
      					</div>
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
	      						<select id="station_op_class" onchange="getOpClassSelect(this)" class="form-control selectpicker" disabled>
	                        		<option  value='0'>---请选择运维班---</option>
	                       		</select>
                       		</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div hidden id="nooperationalert" class="form-group alert alert-danger">
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
      					
      					
      					<!-- 
      					<div class="form-inline row">
      						<div class="col-md-3">
      							<label class="form-label control-label">负责人</label>
      						</div>
      						<div class="col-md-6">	
	      						<select id="op_manager" name = "" class="form-control selectpicker">
	                        		<option  value='0'>---请选择用户类型---</option>
	                       		</select>
                       		</div>
      					</div>
      					 -->
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
					</div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
		                <button id="op_class_add" type="button" onclick="addItem(this)" class="btn btn-danger" disabled>添加类型</button>
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
		var building_name = parentdiv.find("#add_building_name");
		var station_op = parentdiv.find("#station_op_class");
		var station = parentdiv.find("#add_station");
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/building/addItem",
			    data: {"building_name":building_name.val(),
			    		"station_op":station_op.val(),
			    		"station":station.val()
			    		},
			    success: function(data) {
					var result = data.result; 	   
		            if (result == true) { //成功添加
		                $.toaster({ priority : 'success', title : '提示信息', message : '添加成功！'});
		                $('#addSensorModal').modal("hide");
		                window.location.reload(true);
		                return true;
		            }else{ //添加失败
		                $.toaster({ priority : 'warning', title : '告警信息', message : '添加失败！'});
						$('#addSensorModal').modal("hide");
		                return false;
		            }
		            
			    },
			    error:function(){
			    	$.toaster({ priority : 'danger', title : '错误信息', message : '请求添加错误，请确认路径正确或网络正常！'});
			    	$('#addSensorModal').modal("hide");
			    }
	        });
	        
	    //window.location.reload("/station");
	    
	    return false;
	}

	function isExisting(which){
	
		// Disable function
		
		if (which) {
			var obj = $(which);
	        var result;
	        if(obj.val() == ""){
	        	$.toaster({ priority : 'warning', title : '告警信息', message : '添加失败！'});
				return;
			}
	        //&nbsp;Checking availability...
	        // Loads checking image.
	        $(".availability_status").html('<img src="img/loader2.gif" align="absmiddle">');
	        // Sends ajax request to check the name is available or not.
	        $.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/building/isExisting",
			 	data: {"buildingName":obj.val()},
			    success: function(data) {
					var result = data.hasExisting;
		            if (result == 1) {
		                $('.availability_status').html('');
		                $('.availability_status').html('<i class="glyphicon glyphicon-remove" style="color:red"></i> 已存在');
		                /* $('.availability_status').removeClass('tick');
		                $('.availability_status').addClass('error'); */
		                $('input[name="sensor_type.type_name"]').focus();
		                //$('input[name="user.phone"]').attr("readonly","readonly")//将input元素设置为readonly
						//$('input[name="user.phone"]').removeAttr("readonly");//去除input元素的readonly属性
		                $('#station_op_class').prop('disabled', true);
		                //$('#op_class_add').prop('disabled', true);
		                
		                return true;
		            }else if(result == 0){
		                $('.availability_status').html('');
		                $('.availability_status').html('<i class="glyphicon glyphicon-ok" style="color:green"></i> 可用');
		               /*  $('.availability_status').removeClass('error');
		                $('.availability_status').addClass('tick'); */
		                
		                $('#station_op_class').prop('disabled', false);
		                getOperationClass();
		                
		                
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

	
	function getOperationClass(){
	
		var which = $('#station_op_class');
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/getoperation",
			    success: function(data) {
					var result = data.oplist;
					if(result){
						 $(which).empty();
					     $(which).append("<option value='0'>---请选择负责人---</option>"); 
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
		if(sindex == 0){
			isSelect('typealert',which);
			$('#add_station_manager_div').hide();
		}else{
			hiddleComp('typealert',which);
			$('#add_station_manager_div').show();
			getStation(which.value);
		}
	}
	
	function getStation(op){
		var which = $('#add_station');
		var opclass = op;
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/building/getStation",
			    data:{"opclass":opclass},
			    success: function(data) {
					var result = data.stationRecords;
					if(result){
							$(which).empty();
					     	$(which).append("<option  value='0'>---请选择变电站---</option>");
					     $.each(result, function(i,value){
					     	
					    	//$('#operationclass').options.add(new Option(value.op_name,value.id));
					    	//console.log(value.id+"--"+value.user_name);
					    	//$('#operationclass').append("<option value='"+value.id+"'"+">"+value.op_name+"</option>");
					    	$(which).append("<option value='"+value.id+"'>"+value.station_name+"</option>"); 
					    });
					}else{
						showAlert('nooperationalert');
						$('#add_station_manager_div').hide();
					}
			    }
	        });
	        
	        
	}
	
	function managerSelect(which){
		var sindex = which.selectedIndex;
		if(sindex == 0){
			$('#op_class_add').prop('disabled', true);

		}else{
			$('#op_class_add').prop('disabled', false);
		}
	}

	function deleteItem(value) {
	    if (value) {
	        var result;
			
	        $.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/building/deleteItem",
			    data: {"Id":value},
			    success: function(data) {
					var result = data.result;
				    console.log("result="+result);
				        	   
		            if (result == true) { //成功删除传感器
		            	$('#deleteModal${bRecords.id}').modal("hide");
		                $.toaster({ priority : 'success', title : '提示信息', message : '删除成功！'});
		                window.location.reload(true);
		                return true;
		            }else{ //删除监控器失败，请确认监控器存在
		            	$('#deleteModal${bRecords.id}').modal("hide");
		                $.toaster({ priority : 'warning', title : '告警信息', message : '删除失败请确认存在！'});
						
		                return false;
		            }
		            
			    },
			    error:function(){
			    	$.toaster({ priority : 'danger', title : '错误信息', message : '请求删除失败，请确认路径正确或网络正常！'});
			    }
	        });
			//window.location.reload("/building");
			
	        // Sends a asyn reqeust, return false temporary.
	        return false;
	        ////e.preventDefault();
	    }else {
	    	$('#deleteModal${bRecords.id}').modal("hide");
	        $.toaster({ priority : 'warning', title : '提示信息', message : '请重新选择需要删除的条目！'});
	        return false;
	    }
	}

	function showAlert(comp){
		var selected = "#"+comp;
		console.log("selected="+selected);
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