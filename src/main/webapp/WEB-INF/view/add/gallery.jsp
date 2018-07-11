<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<% System.setProperty("no_visible_elements", "false"); %>

<%
	String virtualImages = "/backendimage";
	String baseImagePath = request.getScheme()+"://"
			+request.getServerName()+":"
			+request.getServerPort()+virtualImages+"/"; %>
<jsp:include page="/WEB-INF/view/add/common/header.jsp" flush="true" />
    <div>
        <ul class="breadcrumb">
            <li>
                <a href="/">主页</a>
            </li>
            <li>
                <a href="#">红外图像概览</a>
            </li>
        </ul>
    </div>

    <div class="row">
        <div class="box col-md-12">
            <div class="box-inner">
                <div class="box-header well" data-original-title="">
                    <h2><i class="glyphicon glyphicon-picture"></i> 红外监控图像</h2>
                </div>
                <div class="box-content">
                	<!-- <div class="alert alert-info">
                	</div> -->

                    <br>
                    <ul class="thumbnails gallery">
                    	<c:forEach var="ilist" items="${imageList}">
                    		
	                    		 <li id="${ilist.id}" class="thumbnail">
	                                <a style="background:url(<%=baseImagePath%>${ilist.url})"
	                                   title="${ilist.create_time} ${ilist.station_name}>>${ilist.building_name}>>${ilist.sensor_name}" href="<%=baseImagePath %>${ilist.url}"><img
	                                        class="gallery" src="<%=baseImagePath %>${ilist.url}"
	                                        alt="${ilist.create_time} ${ilist.station_name}>>${ilist.building_name}>>${ilist.sensor_name}">${ilist.create_time} ${ilist.station_name}</a>
	                            </li>

                    	</c:forEach>
                    </ul>
                </div>
            </div>
        </div>
        <!--/span-->

    </div><!--/row-->
    
<!--         <script src="js/jquery.magnific-popup.min.js"></script> Magnific popup (http://dimsemenov.com/plugins/magnific-popup/)
        <script>     
       
          $(window).load(function(){
                
                $('.tm-header-gallery').magnificPopup({
                    delegate: 'a', // child items selector, by clicking on it popup will open
                    type: 'image',
                    gallery:{enabled:true}                
                });
                           
            }); 
        </script> -->
<jsp:include page="/WEB-INF/view/add/common/footer.jsp" flush="true" />