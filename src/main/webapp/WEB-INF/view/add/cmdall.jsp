<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<% System.setProperty("no_visible_elements", "false"); %>
<%@ include file="common/header.jsp" %>

<div>
    <ul class="breadcrumb">
        <li>
            <a href="#">主页</a>
        </li>
        <li>
            <a href="#">命令测试</a>
        </li>
    </ul>
</div>

<div class="row">
    <div class="box col-md-12">
        <div class="box-inner">
            <div class="box-header well" data-original-title="">
                <h2><i class="glyphicon glyphicon-edit"></i> 下发命令</h2>

                <div class="box-icon">
                    <a href="#" class="btn btn-setting btn-round btn-default"><i
                            class="glyphicon glyphicon-cog"></i></a>
                    <a href="#" class="btn btn-minimize btn-round btn-default"><i
                            class="glyphicon glyphicon-chevron-up"></i></a>
                    <a href="#" class="btn btn-close btn-round btn-default"><i
                            class="glyphicon glyphicon-remove"></i></a>
                </div>
            </div>
            <div class="box-content">
                <!-- <form role="form" action="/useradd/addUser" method="post"> -->
 
      					<div hidden id="namealert" class="form-group alert alert-danger">
					   		 <strong>警告:</strong>不能为空，请输入监控器编号！
						</div>
						<div hidden id="nosensoralert2" class="form-group alert alert-danger">
					   		 <strong>警告:</strong>该监控器不存在，请确认！
						</div>
      					<div  id = "sensor_code_div" class="form-inline row">
      						<div class="col-md-2">
        						<label class="form-label control-label">监控器编号</label>
        					</div> 
        					<div class="col-md-8">
        						
        						<input  id ="add_sensor_code_value" type="text"  onblur="isNameEmpt(this)" onfocus="hiddenNameAlert()" class="form-control" value="" placeholder="请输入监控器编号">
        					</div>
        					<div class="col-md-2">
        						<span class='availability_status'></span>
        					</div>
      					</div>
      					<div class="row">
      						<span> &nbsp;&nbsp;</span>
      					</div>
                    <button id="op_class_add" type="button" onclick="command(this)" class="btn btn-danger" value="0" disabled>开关监控器</button>
                <!-- </form> -->

            </div>
        </div>
    </div>
    <!--/span-->

</div><!--/row-->

<script  type="text/javascript">

	$(document).ready(function () {
  		// getOperationClass();
  		$('#op_class_add').text("开关监控器");
	});

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
	
	//获得焦点后，隐藏告警
	function hiddenNameAlert(obj){
		//$('#namealert').addClass("hidden");
		$('#namealert').hide();
	}
		
	var status = 0;
	var type = 0;
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
			    url: "/cmdall/isExisting",
			 	data: {"sensor_code":obj.val()},
			    success: function(data) {
					var result = data.hasExisting;
				    console.log("hasExisting"+result);
		            if (result == 1) {
		            	
		                $('.availability_status').html('');
		                $('.availability_status').html('<i class="glyphicon glyphicon-ok" style="color:green"></i> 可用');		                
		                
		                $('#op_class_add').prop('disabled', false);
		                
		                type = data.record.type_id;
		                if(data.record.status > 0){
		                	$('#op_class_add').text('关闭监控器');
		                	status = 0;
		                }else{
		                	$('#op_class_add').text('启动监控器');
		                	status = 1;
		                }
		                return true;
		            }else if(result == 0){
		                $('.availability_status').html('');
		                $('.availability_status').html('<i class="glyphicon glyphicon-remove" style="color:red"></i> 不存在');
		                obj.focus();
		             	$('#op_class_add').prop('disabled', true);
		                // getOperationClass();
		                return false;
		            }
			    }
	        });
	        return false;
	    }else {
	        $('.availability_status').html('');	        
	        $.toaster({ priority : 'warning', title : '提示信息', message : '请重新点击添加按钮！'});
	        return false;
	    }
	} 

	function command(which){
		var parentdiv = $(which).parents('.box-content');
		

		var sensor_code = parentdiv.find("#add_sensor_code_value");

		$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "/cmdall/installCmd",
			    data: {"sensor_code":sensor_code.val(),
			    		"type":type,
			    		"status":status},
			    success: function(data) {
					var result = data.result;
				    //console.log("result="+result);
				        	   
		            if (result == true) { //成功添加
		                $.toaster({ priority : 'success', title : '提示信息', message : '下发'+sensor_code.val()+'成功！'});
		                
		                if(status > 0){
		                	$(which).text('关闭监控器');
		                	status = 0;
		                }else{
		                	$(which).text('启动监控器');
		                	status = 1;
		                }
		                //window.location.reload(true);
		                return true;
		            }else{ //添加失败
		                $.toaster({ priority : 'warning', title : '告警信息', message : '下发失败！'});
		                return false;
		            }
		            
			    },
			    error:function(){
			    	$.toaster({ priority : 'danger', title : '错误信息', message : '请求下发指令错误，请确认路径正确或网络正常！'});
			    	//$('#addModal').modal("hide");
			    }
	        });
	        
	    //window.location.reload("/station");
	    return false;
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

