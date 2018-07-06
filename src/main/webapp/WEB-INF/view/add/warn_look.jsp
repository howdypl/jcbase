<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<!-- Standard Meta -->
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
<jsp:include page="/WEB-INF/view/common/basecss.jsp" flush="true" />
</head>

<body class="no-skin">
	<div class="main-container" id="main-container">
		<script type="text/javascript">
				try{ace.settings.check('main-container' , 'fixed')}catch(e){}
			</script>

		<div class="main-container-inner">
			<div class="main-content" style="margin-left: 0px;">
				<div class="page-content">

					<div class="row">
						<div class="col-xs-12">
							<input name="id" type="hidden" value="${id}" />							
							<div class="form-group">
								<label class="control-label col-xs-12 col-sm-3 no-padding-right"
									for="name">所属运维班</label>
								<div class="col-xs-12 col-sm-9">
									<div class="clearfix">
										<input type="text" name="name" ${id ne null?'readonly':'' }
											value="${item.op_name}" class="col-xs-12 col-sm-6">
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-xs-12 col-sm-3 no-padding-right"
									for="email">所属变电站</label>
								<div class="col-xs-12 col-sm-9">
									<div class="clearfix">
										<input type="text" name="op_addr" value="${item.op_addr}"
											class="col-xs-12 col-sm-6">
									</div>
								</div>
							</div>						
							<div class="form-group">
								<label class="control-label col-xs-12 col-sm-3 no-padding-right"
									for="desc">所属设备间</label>
								<div class="col-xs-12 col-sm-9">
									<div class="clearfix">
										<input type="text" name="op_desc" value="${item.op_desc}"
											class="col-xs-12 col-sm-6">
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-xs-12 col-sm-3 no-padding-right"
									for="desc">设备</label>
								<div class="col-xs-12 col-sm-9">
									<div class="clearfix">
										<input type="text" name="op_desc" value="${item.op_desc}"
											class="col-xs-12 col-sm-6">
									</div>
								</div>
							</div>				
							<div class="form-group">
								<label class="control-label col-xs-12 col-sm-3 no-padding-right"
									for="desc">告警时间</label>
								<div class="col-xs-12 col-sm-9">
									<div class="clearfix">
										<input type="text" name="op_desc" value="${item.op_desc}"
											class="col-xs-12 col-sm-6">
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-xs-12 col-sm-3 no-padding-right"
									for="desc">告警温度</label>
								<div class="col-xs-12 col-sm-9">
									<div class="clearfix">
										<input type="text" name="op_desc" value="${item.op_desc}"
											class="col-xs-12 col-sm-6">
									</div>
								</div>
							</div>
																						
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
			<!-- /.main-content -->
		</div>
		<!-- /.main-container-inner -->
	</div>
	<!-- /.main-container -->
	<jsp:include page="/WEB-INF/view/common/basejs.jsp" flush="true" />

</body>

</html>
