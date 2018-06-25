<%@ page language="java" contentType="text/html" import="java.util.*" pageEncoding="utf-8"%>
<%-- <base href="${inf}"/> --%>
<% 
	boolean no_visible_elements = true; 
	System.setProperty("no_visible_elements", "true");
%>

<%@ include file="common/header.jsp" %>

    <div class="row">
        <div class="col-md-12 center login-header">
            <h2>欢迎访问红外智能监控系统</h2>
        </div>
        <!--/span-->
    </div><!--/row-->

    <div class="row">
        <div class="well col-md-5 center login-box">
            <div class="alert alert-info">
               	 请输入用户名和密码登录.
            </div>
            <form class="form-horizontal" action="<%=request.getContextPath()%>/login" method="post">
                <fieldset>
                	<% 
                		
                	if(request.getAttribute("loginInfo")!=null){
                		//String info = (String)request.getAttribute("loginInfo");
                		
                		out.println("<div id='namepasserror' class='alert alert-danger'> <strong>");
                		out.println((String)request.getAttribute("loginInfo"));
                		out.println(" </strong></div>");
                	}
                	%>
                	
                	<div hidden id="namealert" class="alert alert-danger">
						<!-- <a href="#" class="close" data-dismiss="alert">
					        &times;
					    </a> -->
					    <strong>警告:</strong>用户名不能为空！
					</div>
                    <div class="input-group input-group-lg">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-user red"></i></span>
                        <input id= "username" name="user.userName" type="text" class="form-control" onblur="isNameEmpt(this)" onfocus="hiddenNameAlert()" placeholder="用户名">
                    </div>
                    <div class="clearfix"></div><br>
					
                	<div hidden id="passalert" class=" alert alert-danger">
					    <!-- <a href="#" class="close" data-dismiss="alert">
					        &times;
					    </a> -->
					    <strong>警告:</strong>密码不能为空！
					</div>

                    <div class="input-group input-group-lg">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock red"></i></span>
                        <input id="password" name="user.password" type="password" class="form-control" onblur="isPassEmpt(this)" onfocus="hiddenPassAlert()" placeholder="密码">
                    </div>
                    <div class="clearfix"></div>

                   <!--  <div class="input-prepend">
                        <label class="remember" for="remember"><input type="checkbox" id="remember">记住我</label>
                    </div> -->
                    <div class="clearfix"></div>

                    <p class="center col-md-5">
                        <button type="submit" class="btn btn-success">登录</button>
                    </p>
                </fieldset>
            </form>
        </div>
        <!--/span-->
    </div><!--/row-->
    
<%@ include file="common/footer.jsp" %>

<script>

	//判断用户名不为空
	function isNameEmpt(obj){
		if(obj.value == ""){
			//$('#namealert').removeClass("hidden");
			$('#namealert').show();
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
        $("#password").focus();
    });

</script>
<%@ include file="common/footer.jsp" %>
