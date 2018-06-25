<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

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
                <h2><i class="glyphicon glyphicon-edit"></i> 添加用户</h2>

               <!--  <div class="box-icon">
                    <a href="#" class="btn btn-setting btn-round btn-default"><i
                            class="glyphicon glyphicon-cog"></i></a>
                    <a href="#" class="btn btn-minimize btn-round btn-default"><i
                            class="glyphicon glyphicon-chevron-up"></i></a>
                    <a href="#" class="btn btn-close btn-round btn-default"><i
                            class="glyphicon glyphicon-remove"></i></a>
                </div> -->
            </div>
            <div class="box-content">
                <form role="form" action='<%=request.getContextPath()%>/useradd/addUser' method="post">
                	<div hidden id="namealert" class="form-group alert alert-danger">
					    <strong>警告:</strong>用户名不能为空！
					</div>
                    <div class="form-group">
                        <label for="username">用户名</label>
                        <input type="text" class="form-control" id="username" name="user.user_name" onchange="isNameEmpt(this)" onfocus="hiddenNameAlert()" placeholder="用户名">
                        <span class='availability_status'></span>
        		
                    </div>
                    <div hidden id="passalert" class="form-group alert alert-danger">
					    <!-- <a href="#" class="close" data-dismiss="alert">
					        &times;
					    </a> -->
					    <strong>警告:</strong>密码不能为空！
					</div>
                    <div class="form-group">
                        <label for="userpassword">密码</label>
                        <input type="password" class="form-control" id="userpassword" name="user.password" onblur="isPassEmpt(this)"  onfocus="hiddenPassAlert()"  placeholder="密码">
                    </div>
                    <div class="form-group">
                        <label for="userphone">联系电话</label>
                        <input type="text" class="form-control" id="userphone" name="user.phone"  placeholder="联系电话">
                    </div>
                    
                    <div hidden id="typealert" class="form-group alert alert-danger">
					    <strong>警告:</strong>请为新用户选择一个用户类型！
					</div>
                    <div hidden id="nooperationalert" class="form-group alert alert-danger">
					    <strong>警告:</strong>没有可用的运维组，请先创建运维组！
					</div>
                    <div class="form-group">
                        <label for="usertype">用户类型</label>
                        <select id="usertype" name="user.actor" onblur="checkSelect(this)" onfocus="hiddleComp('typealert',this)" class="form-control show-tick selectpicker" data-live-search="false">
                        	<option value="0">---请选择用户类型---</option>
                        	<option  value="1">超级用户</option>
                        	<option  value="2">运维班组</option>
                        	<option  value="3">工区人员</option>
                        </select>
                    </div>
                    
                     <div hidden id="oerationclassdiv" class="form-group">
                        <label for="operationclass">运维班组</label>
                        <select id="operationclass" name = "user.operation_class_id" class="form-control selectpicker">
                        	<option  value='0'>---请选择用户类型---</option>

                        </select>
                    </div>
                    
                    <!-- <div id="uservalid" class="checkbox">
                        <label>
                            <input checked name="user.valid" type="checkbox" > 有效
                        </label>
                    </div> -->
                    <button id="adduserbutton" type="submit" class="btn btn-success" disabled>提交</button>
                </form>

            </div>
        </div>
    </div>
    <!--/span-->

</div><!--/row-->

<script  type="text/javascript">

	//判断用户名不为空
	function isNameEmpt(obj){
		if(obj.value == ""){
			//$('#namealert').removeClass("hidden");
			$('#namealert').show();
		}else {
			check(obj);
		}

	}
	
	//获得焦点后，隐藏告警
	function hiddenNameAlert(obj){
		//$('#namealert').addClass("hidden");
		$('#namealert').hide();
	}
	
	$("#namealert").bind('closed.bs.alert', function () {
		
        $("#username").focus();
    });
	
	//判断密码不为空
	function isPassEmpt(obj){
		if(obj.value == ""){
			//$('#passalert').removeClass("hidden");
			$('#passalert').show();
		}
	}
	
	//密码框获取焦点后，隐藏告警信息
	function hiddenPassAlert(obj){
		//$('#passalert').addClass("hidden");
		$('#passalert').hide();
	}
	
	$("#passalert").bind('closed.bs.alert', function () {
        $("#userpassword").focus();
    });

	function check(which){
		var value = $(which).val();
		//console.log($(which).val());
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
				    //console.log("hasExisting"+result);
				        	   
		            if (result == 1) {
		                $('.availability_status').html('');
		                $('.availability_status').html('<i class="glyphicon glyphicon-remove" style="color:red"></i> 已存在');

		                $('input[name="user.user_name"]').focus();
						$('#adduserbutton').prop('disabled', true);
		                return true;
		            }else if(result == 0){
		                $('.availability_status').html('');
		                $('.availability_status').html('<i class="glyphicon glyphicon-ok" style="color:green"></i> 可用');
						$('#adduserbutton').prop('disabled', false);
		                return false;
		            }

			    }
	        });
			//window.location.reload("/userdata");
	        // Sends a asyn reqeust, return false temporary.
	        return false;
	        ////e.preventDefault();
	    }else {
	        $('.availability_status').html('');
	        $.toaster({ priority : 'warning', title : '提示信息', message : '请重新输入用户！'});
	        return false;
	    }
	
	}
	
	function checkSelect(which){
		var sindex = which.selectedIndex;
		console.log("selectedIndex="+which.selectedIndex);
		if(sindex == 0){
			isSelect('typealert',which);
			$('#oerationclassdiv').hide();
		}else if(sindex == 2){
			$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "<%=request.getContextPath()%>"+"/getoperation",
			    success: function(data) {
					var result = data.oplist;
					if(result){
						$('#oerationclassdiv').show();
					     $.each(result, function(i,value){
					    	//$('#operationclass').options.add(new Option(value.op_name,value.id));
					    	console.log(value.id+"--"+value.op_name);
					    	//$('#operationclass').append("<option value='"+value.id+"'"+">"+value.op_name+"</option>");
					    	$('#operationclass').append("<option value='"+value.id+"'>"+value.op_name+"</option>"); 
					    });
					}else{
						showAlert('nooperationalert');
					}
			    }
	        });
		}else{
			$('#oerationclassdiv').hide();
		}
		
		which.blur()
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

