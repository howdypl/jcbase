<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
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
                <a href="#">用户管理</a>
            </li>
        </ul>
    </div>

    <div class="row">
    <div class="box col-md-12">
    <div class="box-inner">
    <div class="box-header well" data-original-title="">
        <h2><i class="glyphicon glyphicon-eye-open"></i> 用户查询</h2>

        <!-- <div class="box-icon">
            <a href="#" class="btn btn-setting btn-round btn-default"><i class="glyphicon glyphicon-cog"></i></a>
            <a href="#" class="btn btn-minimize btn-round btn-default"><i
                    class="glyphicon glyphicon-chevron-up"></i></a>
            <a href="#" class="btn btn-close btn-round btn-default"><i class="glyphicon glyphicon-remove"></i></a>
        </div> -->
    </div>
    <div class="box-content">
    <div class="alert alert-info"><a class="btn btn-info" data-toggle="modal" href='<%=request.getContextPath()%>/useradd'>
    		<i class="glyphicon glyphicon-edit icon-white"></i>
              	  添加用户
       </a>
    </div>
    <table id="userTable" class="table table-striped table-bordered bootstrap-datatable datatable responsive text-nowrap">
    <thead>
    <tr>
    	<th>序号</th>
    	<th hidden>用户编号</th>
        <th class="center">用户类型</th>
        <th class="center">运维班</th>
        <th class="center">用户名</th>
        <th class="center">电话</th>
        <th class="center">上次登录</th>
        <th class="center">创建时间</th>
        <th class="center">状态</th>
        <th class="center">操作</th>
    </tr>
    </thead>
    <tbody>
    <c:set var="row" value="0"/>
    <c:set var="userType" value="未知角色" />
    <c:set var="opName" value="-" />
    <c:set var="userStatus" value="-" />
    <c:set var="iview" value="view" />
    <c:set var="iedit" value="edit" />
    <c:set var="idelete" value="delete" />
    <c:forEach var="userList" items="${userInfoList}">
    	<c:set var="row" value="${row+1}" />
	    <tr>
	    	<td  class="center"><c:out value="${row}"  /></td>
	    	<td  hidden class="center"><c:out value="${userList.id}"  /></td>
	    	<td  class="center">
		    	<c:choose>
		    		<c:when test="${userList.actor == 1}">
		    			<c:set var="userType" value="超级用户" />
		    			<span class="label-success label label-default"><c:out value="${userType}"  /></span>
		    		</c:when>
		    		<c:when test="${userList.actor == 2}">
		    			<c:set var="userType" value="运维班组" />
		    			<span class="label-primary label label-default"><c:out value="${userType}"  /></span>
		    		</c:when>
		    		<c:when test="${userList.actor == 3}">
		    			<c:set var="userType" value="工区人员" />
		    			<span class="label-info label label-default"><c:out value="${userType}"  /></span>
		    		</c:when>
		    		<c:when test="${userList.actor == 4}">
		    			<c:set var="userType" value="维修人员" />
		    			<span class="label label-default"><c:out value="${userType}"  /></span>
		    		</c:when>
		    		<c:otherwise>
		    			<c:set var="userType" value="超级用户" />
		    			<span class="label-danger label label-default"><strong><c:out value="${userType}" /></strong></span>
		    		</c:otherwise>
		    	</c:choose>
	    	</td>
	    	<td  class="center">
		    	<c:choose>
		    		<c:when test="${userList.op_name != null}">
		    			<c:set var="opName" value="${userList.op_name}" />
		    			<c:out value="${userList.op_name}"  />
		    		</c:when>
		    		<c:otherwise>
		    			<c:set var="opName" value="-" />
		    			<strong><c:out value="-" /></strong>
		    		</c:otherwise>
		    	</c:choose>
	    	</td>
	    	<td  class="center"><c:out value="${userList.user_name}"  /></td>
	    	<td  class="center">
		    	<c:choose>
		    		<c:when test="${userList.phone != null}">
		    			<c:out value="${userList.phone}"  />
		    		</c:when>
		    		<c:otherwise>
		    			<strong><c:out value="-" /></strong>
		    		</c:otherwise>
		    	</c:choose>
	    	</td>
	    	<td  class="center"><c:out value="${userList.last_login}"  /></td>
	    	<td  class="center"><c:out value="${userList.create_time}"  /></td>
	    	<td  class="center">
		    	<c:choose>
		    		<c:when test="${userList.valid == 0}">
		    			<c:set var="userStatus" value="有效" />
		    			<span class="label-success label label-default"><c:out value="${userStatus}"  /></span>
		    		</c:when>
		    		<c:when test="${userList.valid == 1}">
		    			<c:set var="userStatus" value="过期" />
		    			<span class="label label-default"><c:out value="${userStatus}"  /></span>
		    		</c:when>
		    		<c:otherwise>
		    			<span class="label-danger label label-default"><strong><c:out value="-" /></strong></span>
		    		</c:otherwise>
		    	</c:choose>
	    	</td>
	        <td class="center">
	        	<button class="btn btn-success" data-id="${userList.id}" data-toggle="modal" data-target="#viewModal${userList.id}">
	        	<i class="glyphicon glyphicon-zoom-in icon-white"></i>
	        	查看
	        	</button>
	        	<button class="btn btn-info" data-id="${userList.id}" data-toggle="modal" data-target="#editorModal${userList.id}">
	        	<i class="glyphicon glyphicon-edit icon-white"></i>
	        		编辑
	        	</button>
	            <button class="btn btn-danger" data-id="${userList.id}"  data-toggle="modal" data-target="#deleteModal${userList.id}">
	                <i class="glyphicon glyphicon-trash icon-white"></i>
	                	删除
	            </button>
	        </td>
	    </tr>

        <!-- view模态框（Modal） -->
		<div class="modal fade" id="viewModal${userList.id}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title" id="myModalLabel">用户信息</h4>
		            </div>
		            <div class="modal-body .container">
						<div class="form-inline row">
							<div class="col-md-3">
        						<label class="form-label control-label">用户类型</label>
        					</div>
        					<div class="col-md-6">				
        						<input readonly type="text" class="form-control" value="${userType}">
        					</div>
        					
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">所属运维班</label>   
        					</div> 
        					<div class="col-md-6">				
        						<input readonly type="text" class="form-control" value="${opName}">
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">用户名</label>   
        					</div> 
        					<div class="col-md-6">				
        						<input readonly type="text" class="form-control" value="${userList.user_name}">
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">电话</label>   
        					</div> 
        					<div class="col-md-6">				
        						<input readonly type="text" class="form-control" value="${userList.phone}">
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">上次登录时间</label>   
        					</div> 
        					<div class="col-md-6">				
        						<input readonly type="text" class="form-control" value="${userList.last_login}">
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
        						<input readonly type="text" class="form-control" value="${userList.create_time}">
        					</div>
      					</div>
      					
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">状态</label>   
        					</div> 
        					<div class="col-md-6">				
								<c:choose>
						    		<c:when test="${userList.valid == 0}">
						    			<span class="label-success label label-default"><strong><c:out value="有效" /></strong></span>
						    		</c:when>
						    		<c:when test="${userList.valid == 1}">
						    			<span class="label label-default"><strong><c:out value="过期" /></strong></span>
						    		</c:when>
						    		<c:otherwise>
						    			<span class="label-success label label-default"><strong><c:out value="异常" /></strong></span>
						    		</c:otherwise>
						    	</c:choose>
        					</div>
      					</div>
      					
					</div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
		            </div>
		        </div><!-- /.modal-content -->
		    </div><!-- /.modal -->
		</div><!-- view模态结束 -->
		<!-- 编辑模态框（Modal） -->
		<div class="modal fade" id="editorModal${userList.id}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<form class="modal form-horizontal" method="post" action="/userdata/update">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title" id="myModalLabel">用户信息</h4>
		            </div>
		            <div class="modal-body">
			            <div class="form-inline row">
								<div class="col-md-3">
	        						<label class="form-label control-label">用户编号</label>
	        					</div>
	        					<div class="col-md-6">
	        						<input name="user.id" readonly type="text" class="form-control" value="${userList.id}">
	        					</div>
	      					</div>
						<div class="form-inline row">
							<div class="col-md-3">
        						<label class="form-label control-label">用户类型</label>
        					</div>
        					<div class="col-md-6">				
        						<input name="user.actor" readonly type="text" class="form-control" value="${userType}">
        					</div>
        					
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">所属运维班</label>   
        					</div> 
        					<div class="col-md-6">				
        						<input name="user.operation_class_id" readonly type="text" class="form-control" value="${opName}">
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>

      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">用户名</label>   
        					</div> 
        					<div class="col-md-4">				
        						<input id="editorusername" name="user.user_name" type="text" class="form-control"  onblur="check(this.value)"  value="${userList.user_name}">
        					</div>
        					<div class="col-md-2">
        						<span class='availability_status'></span>
        					</div>
      					</div>
      			
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">电话</label>   
        					</div> 
        					<div class="col-md-6">				
        						<input id="editoruserphone" name= "user.phone" type="text" class="form-control" value="${userList.phone}">
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">上次登录时间</label>   
        					</div> 
        					<div class="col-md-6">				
        						<input name="user.last_login" readonly type="text" class="form-control" value="${userList.last_login}">
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
        						<input name="user.create_time" readonly type="text" class="form-control" value="${userList.create_time}">
        					</div>
      					</div>
      					
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">状态</label>   
        					</div> 
        					<div class="col-md-6">				
								<c:choose>
						    		<c:when test="${userList.valid == 0}">
						    			<span class="label-success label label-default"><strong><c:out value="有效" /></strong></span>
						    		</c:when>
						    		<c:when test="${userList.valid == 1}">
						    			<span class="label label-default"><strong><c:out value="过期" /></strong></span>
						    		</c:when>
						    		<c:otherwise>
						    			<span class="label-success label label-default"><strong><c:out value="异常" /></strong></span>
						    		</c:otherwise>
						    	</c:choose>
        					</div>
						</div>
					</div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-default" onclick="closeEditorModal()" data-dismiss="modal">关闭</button>
		                <button type="button" onclick="editorUser(this)" class="btn btn-primary">提交更改</button>
		            </div>
		        </div><!-- /.modal-content -->
		    </div><!-- /.modal -->
		    </form>
		</div>
		
		<!-- delete模态框（Modal） -->
		<div class="modal fade" id="deleteModal${userList.id}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title" id="myModalLabel">用户信息</h4>
		            </div>
		            <div class="modal-body .container">
						<div class="form-inline row">
							<div class="col-md-3">
        						<label class="form-label control-label">用户类型</label>
        					</div>
        					<div class="col-md-6">				
        						<input readonly type="text" class="form-control" value="${userType}">
        					</div>
        					
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">所属运维班</label>   
        					</div> 
        					<div class="col-md-6">				
        						<input readonly type="text" class="form-control" value="${opName}">
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">用户名</label>   
        					</div> 
        					<div class="col-md-6">				
        						<input readonly type="text" class="form-control" value="${userList.user_name}">
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">电话</label>   
        					</div> 
        					<div class="col-md-6">				
        						<input readonly type="text" class="form-control" value="${userList.phone}">
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">上次登录时间</label>   
        					</div> 
        					<div class="col-md-6">				
        						<input readonly type="text" class="form-control" value="${userList.last_login}">
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
        						<input readonly type="text" class="form-control" value="${userList.create_time}">
        					</div>
      					</div>
      					
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
      					<div class="form-inline row">
      						<div class="col-md-3">
        						<label class="form-label control-label">状态</label>   
        					</div> 
        					<div class="col-md-6">				
								<c:choose>
						    		<c:when test="${userList.valid == 0}">
						    			<span class="label-success label label-default"><strong><c:out value="有效" /></strong></span>
						    		</c:when>
						    		<c:when test="${userList.valid == 1}">
						    			<span class="label label-default"><strong><c:out value="过期" /></strong></span>
						    		</c:when>
						    		<c:otherwise>
						    			<span class="label-success label label-default"><strong><c:out value="异常" /></strong></span>
						    		</c:otherwise>
						    	</c:choose>
        					</div>
      					</div>
      					
					</div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
		                <button type="button" onclick="deleteItem(${userList.id})" class="btn btn-danger">删除确认</button>
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
<script type="text/javascript">
	function deleteItem(value) {
	    if (value) {
	        var result;
			
	        $.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/userdata/deleteUser",
			    data: {"userid":value},
			    success: function(data) {
					var result = data.result;
				    console.log("result="+result);
				        	   
		            if (result == true) { //成功删除用户
		                $.toaster({ priority : 'success', title : '提示信息', message : '删除用户成功！'});
		                $('#deleteModal${userList.id}').modal("hide");
		                window.location.reload(true);
		                return true;
		            }else{ //删除用户失败，请确认用户存在
		                $.toaster({ priority : 'warning', title : '告警信息', message : '删除用户失败请确认用户存在！'});
						$('#deleteModal${userList.id}').modal("hide");
		                return false;
		            }
		            
			    },
			    error:function(){
			    	$.toaster({ priority : 'danger', title : '错误信息', message : '请求删除用户失败，请确认路径正确或网络正常！'});
			    }
	        });
			// window.location.reload("/userdata");
	        // Sends a asyn reqeust, return false temporary.
	        return false;
	        ////e.preventDefault();
	    }else {
	    	$('#deleteModal${userList.id}').modal("hide");
	        $.toaster({ priority : 'warning', title : '提示信息', message : '请重新选择需要删除的用户！'});
	        return false;
	    }
	}
	function closeEditorModal(){
		$('.availability_status').html('');
	}
	
	function check(value){
		if (value) {
	        var result;
	        	if(value == ""){
				return;
			}
	        //&nbsp;Checking availability...
	        // Loads checking image.
	        $(".availability_status").html('<img src="img/loader2.gif" align="absmiddle">');
	        // Sends ajax request to check the name is available or not.
	        $.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/userdata/checkUser",
			 	data: {"username":value},
			    success: function(data) {
					var result = data.hasExisting;
				    console.log("hasExisting"+result);
				        	   
		            if (result == 1) {
		                $('.availability_status').html('');
		                $('.availability_status').html('<i class="glyphicon glyphicon-remove" style="color:red"></i> 已存在');
		                /* $('.availability_status').removeClass('tick');
		                $('.availability_status').addClass('error'); */
		                $('input[name="user.user_name"]').focus();
		                //$('input[name="user.phone"]').attr("readonly","readonly")//将input元素设置为readonly
						//$('input[name="user.phone"]').removeAttr("readonly");//去除input元素的readonly属性
		                
		                return true;
		            }else if(result == 0){
		                $('.availability_status').html('');
		                $('.availability_status').html('<i class="glyphicon glyphicon-ok" style="color:green"></i> 可用');
		               /*  $('.availability_status').removeClass('error');
		                $('.availability_status').addClass('tick'); */
		                return false;
		            }
				        // When the checking completed, then loaded corresponding css style.
				        /* $('.availability_status').ajaxComplete(function(event, request, settings) {
				
				        }); */
			    }
	        });
			//window.location.reload("/userdata");
	        // Sends a asyn reqeust, return false temporary.
	        return false;
	        ////e.preventDefault();
	    }else {
	        $('.availability_status').html('');
	        
	        $('#editorModal${userList.id}').modal("hide");
	        $.toaster({ priority : 'warning', title : '提示信息', message : '请重新选择需要删除的用户！'});
	        return false;
	    }
	
	}
	function editorUser(which){
		
		//console.log($(which).text());editorModal${userList.id}
		//console.log($(which).text());
		var parentdiv = $(which).parents('.modal-content');
		var userid= parentdiv.find("input[name='user.id']");
		var username = parentdiv.find("input[name='user.user_name']");
		var phone = parentdiv.find("input[name='user.phone']");
		console.log(username.val());
		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/userdata/updateWithAjax",
			    data: {"userId":userid.val(),"userName":username.val(),"phone":phone.val()},
			    success: function(data) {
					var result = data.result;
				    console.log("result="+result);
				        	   
		            if (result == true) { //成功修改用户
		                $.toaster({ priority : 'success', title : '提示信息', message : '修改用户'+username.val()+'成功！'});
		                $('#editorModal${userList.id}').modal("hide");
		                window.location.reload(true);
		                return true;
		            }else{ //更新用户失败，请确认用户存在
		                $.toaster({ priority : 'warning', title : '告警信息', message : '删除用户失败请确认用户存在！'});
						$('#editorModal${userList.id}').modal("hide");
		                return false;
		            }
		            
			    },
			    error:function(){
			    	$.toaster({ priority : 'danger', title : '错误信息', message : '请求删除用户失败，请确认路径正确或网络正常！'});
			    	$('#editorModal${userList.id}').modal("hide");
			    }
	        });
	        
	    // window.location.reload("/userdata");
	    return false;
		/*var input = parentdiv.find("input");
		 $(input).each(function(i){
			console.log(i+"="+$(this).val());
		}); */
		
	}
</script>

<%@ include file="common/footer.jsp" %>