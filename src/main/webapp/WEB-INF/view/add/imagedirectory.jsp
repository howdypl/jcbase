<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<% System.setProperty("no_visible_elements", "false"); %>
<%@ include file="common/header.jsp" %>

<div>
    <ul class="breadcrumb">
        <li>
            <a href="/">主页</a>
        </li>
        <li>
            <a href="#">温度趋势</a>
        </li>
    </ul>
</div>

<div class="row">

    <div class="box col-md-12">
        <div class="box-inner">
            <div class="box-header well">
                <h2><i class="glyphicon glyphicon-list-alt"></i> 图像目录</h2>

                
            </div>
            <div class="box-content">
               <div class="alert alert-info">
               <br>
               	<button id="op_class_add" type="button" onclick="BrowseFolder()" class="btn btn-primary btn-lg" value="0" ><i
                                class="glyphicon glyphicon-chevron-left glyphicon-white"></i>打开图像目录</button>

                    <br>
               </div>
               
            </div>
        </div>
    </div>

</div><!--/row-->

<script type="text/javascript">
	var filename = "D:/backend/image";
	function open_disk(which){
		try{
	
			window.open('file://D:/backend/image/');
	
		}catch(e){
			alert("打不开我也没办法了");
		}
	}

	function BrowseFolder() {
		try {
			var Message = "请选择文件夹"; //选择框提示信息 
			var Shell = new ActiveXObject("Shell.Application");
			var Folder = Shell.BrowseForFolder(0, Message, 0x0040, 0x11); //起始目录为：我的电脑 
			//var Folder = Shell.BrowseForFolder(0,Message,0); //起始目录为：桌面 
			if (Folder != null) {
				Folder = Folder.items(); // 返回 FolderItems 对象 
				Folder = Folder.item(); // 返回 Folderitem 对象 
				Folder = Folder.Path; // 返回路径 
				if (Folder.charAt(Folder.length - 1) != "\\") {
					Folder = Folder + "\\";
				}
				document.all.savePath.value = Folder;
				return Folder;
			}
		} catch (e) {
			alert(e.message); 
		}
	}
	function command(which){
		var filename = "D";
		var obj=new ActiveXObject("wscript.shell"); 
		obj.Run("\""+filename+"\"", 1, false );
	    /* try{   
              var obj=new ActiveXObject("wscript.shell"); 
			  
              if(obj){   
                  obj.Run("\""+filename+"\"", 1, false );  
                  obj=null;   
              }   
	        }catch(e){   
	        	alert("请确定是否存在该盘符或文件");   
	    	}    */
	}
</script>

<%@ include file="common/footer.jsp" %>

