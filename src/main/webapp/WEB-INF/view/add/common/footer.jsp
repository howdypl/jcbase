<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!--[if !IE]> -->
<script type="text/javascript">
	window.jQuery || document.write("<script src='${res_url}ace-1.3.3/assets/js/jquery.js'>"+"<"+"/script>");
</script>

<!-- <![endif]-->

<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='${res_url}ace-1.3.3/assets/js/jquery1x.js'>"+"<"+"/script>");
</script>
<![endif]-->
<script type="text/javascript">
if('ontouchstart' in document.documentElement) document.write("<script src='${res_url}ace-1.3.3/assets/js/jquery.mobile.custom.js'>"+"<"+"/script>");

(function($){  
	$.fn.serializeJson=function(){
		var serializeObj={};
		var array=this.serializeArray();
		var str=this.serialize();
		$(array).each(function(){
			if(serializeObj[this.name]){
				if($.isArray(serializeObj[this.name])){
					serializeObj[this.name].push(this.value);
				}else{
					serializeObj[this.name]=[serializeObj[this.name],this.value];  
				}
			}else{
				serializeObj[this.name]=this.value;
			}
		});
		return serializeObj;
	};
});

</script>

		
		

<script src="${res_url}bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

<!-- library for cookie management -->
<script src="${res_url}jsto/jquery.cookie.js"></script>
<!-- calender plugin -->
<script src='${res_url}bower_components/moment/min/moment.min.js'></script>
<script src='${res_url}bower_components/fullcalendar/dist/fullcalendar.min.js'></script>
<!-- data table plugin -->
<script src='${res_url}jsto/jquery.dataTables.min.js'></script>
<script src='${res_url}jsto/datatables.js'></script>
<!-- select or dropdown enhancer -->
<script src="${res_url}bower_components/chosen/chosen.jquery.min.js"></script>
<!-- plugin for gallery image view -->
<script src="${res_url}bower_components/colorbox/jquery.colorbox-min.js"></script>
<!-- notification plugin -->
<script src="${res_url}jsto/jquery.noty.js"></script>
<!-- library for making tables responsive -->
<script src="${res_url}bower_components/responsive-tables/responsive-tables.js"></script>
<!-- tour plugin -->
<script src="${res_url}bower_components/bootstrap-tour/build/js/bootstrap-tour.min.js"></script>
<!-- star rating plugin -->
<script src="${res_url}jsto/jquery.raty.min.js"></script>
<!-- for iOS style toggle switch -->
<script src="${res_url}jsto/jquery.iphone.toggle.js"></script>
<!-- autogrowing textarea plugin -->
<script src="${res_url}jsto/jquery.autogrow-textarea.js"></script>
<!-- multiple file upload plugin -->
<script src="${res_url}jsto/jquery.uploadify-3.1.min.js"></script>
<!-- history.js for cross-browser state change on ajax -->
<script src="${res_url}jsto/jquery.history.js"></script>
<!-- application script for Charisma demo -->
<script src="${res_url}jsto/charisma.js"></script>
<script src="${res_url}jsto/jquery.toaster.js"></script>
<!-- <script src="js/bootstrap-select.js" type="text/javascript"></script>
<script src="js/defaults-zh_CN.min.js" type="text/javascript"></script> -->

<script src="${res_url}jsto/jquery.multi-select.js"></script>

<script type="text/javascript" src="${res_url}jsto/moment.min.js"></script>
<script type="text/javascript" src="${res_url}jsto/daterangepicker-1.3.7.js"></script>

<script type="text/javascript" src="${res_url}jsto/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="${res_url}jsto/bootstrap-datetimepicker.pt-BR.js"></script> 
<script type="text/javascript" src="${res_url}jsto/respond.min.js"></script> 
<script type="text/javascript">
String.prototype.trim = function() {
		return this.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	}
</script>