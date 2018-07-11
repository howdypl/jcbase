/*
 * 通过jquery  ID筛选器绑定dataTable插件
 */
$("#mainTable").dataTable({
	/*
	 * sErrMode
	 * 错误信息显示方式
	 * 分别为alert和throw，默认为alert
	 */
	"sErrMode" : "throw",
	/*
	 * sDom
	 * 布局方式，可以自定义，布局项，也可以调换布局顺序
	 * 详解：
	 * <> 表示一个闭合的div 例如：<> = <div></div>
	 * <"类名称"> 表示一个class="类名称"的闭合的div 例如： <"rad"> = <div class="rad"></div>
	 * l  每行显示的记录数
	 * f  搜索框
	 * r  加载时的进度条
	 * t  表格，即实际的<table></table>
	 * p  分页条
	 * i  数据信息，  每页显示x条数据、第x条-第x条、供x条数据，默认是英文
	 */
	"sDom" : '<lf>rt<lpi><"clear">',
	/*
	 * sServerMethod
	 * 数据获取方式
	 * POST/GET，默认是GET
	 */
	"sServerMethod" : "POST",
	/*
	 * bDeferRender
	 * 是否启用延迟加载：当你使用AJAX数据源时，可以提升速度。
	 * 默认为false
	 */
	"bDeferRender" : true,
	/*
	 * sScrollXInner
	 * 表格宽度
	 */
	"sScrollXInner" : "100%",
	/*
	 * bScrollCollapse
	 * 当显示的数据不足以支撑表格的默认的高度时，依然显示纵向的滚动条。(默认是false)
	 */
	"bScrollCollapse" : false,
	/*
	 * bPaginate
	 * 是否开启分页,默认是true
	 */
	"bPaginate" : true,
	/*
	 * bLengthChange
	 * 是否允许用户，在下拉列表自定义选择分页大小(10, 25, 50 and 100),需要分页支持
	 * 默认为true
	 */
	"bLengthChange" : false,
	/*
	 * bFilter
	 * 是否启用内置搜索功能：可以跨列搜索。
	 * 默认为true
	 */
	"bFilter" : true,
	/*
	 * bSort
	 * 是否开启列排序功能，如果想禁用某一列排序，可以在每列设置使用bSortable参数
	 */
	"bSort" : true,
	/*
	 * bInfo
	 * 是否显示表格相关信息：例如翻页信息等。
	 * 默认值：True 
	 */
	"bInfo" : true,
	/*
	 * bAutoWidth
	 * 是否启用自动适应列宽
	 * 默认值：True
	 */
	"bAutoWidth" : false,
	/*
	 * bStateSave
	 * 是否开启cookies保存当前状态信息
 	 * 默认值：false
	 */
	"bStateSave" : false,
	/*
	 * sPaginationType
	 * 分页方式 
	 * dataTable提供full_numbers和two_button，默认是two_button
 	 * 这里采用的是自定义分页myPagination，详细参见jquery.dataTable.custom.js
	 */
	"sPaginationType" : "myPagination",
	/*
	 * bProcessing
	 * 是否显示加载时进度条，默认为false
	 */
	"bProcessing" : true,
	/*
	 * iDisplayLength
	 * 默认每页显示多少条记录
	 */
	"iDisplayLength" : 10,
	/*
	 * aLengthMenu
	 * 允许用户选择每页显示多少条记录
	 */
	"aLengthMenu" : [ [ 50, 100, -1 ], [ "50", "100", "所有" ] ],
	/*
	 * oLanguage
	 * 语言设置，dataTable默认为英文，可再此设置中文显示
	 * 注意：_MENU_、_START_、_END_、_TOTAL_、_MAX_等通配
	 */
	"oLanguage" : {
		"sLengthMenu" : "每页显示 _MENU_ 条记录",
		"sZeroRecords" : "对不起，没有匹配的数据",
		"sInfo" : "第 _START_ - _END_ 条 / 共 _TOTAL_ 条数据",
		"sInfoEmpty" : "没有匹配的数据",
		"sInfoFiltered" : "(数据表中共 _MAX_ 条记录)",
		"sProcessing" : "正在加载中...",
		"sSearch" : "全文搜索：",
		"oPaginate" : {
			"sFirst" : "第一页",
			"sPrevious" : " 上一页 ",
			"sNext" : " 下一页 ",
			"sLast" : " 最后一页 "
		}
	},
	/*
	 * aoColumns
	 * 数据列
	 * mData  数据源属性
	 * sTitle 列头
	 * bSortable 是否参与排序
	 * mRender 自定义显示内容，可返回html、字符串
	 */
	"aoColumns" : [{
		"mData" : 'id',
		"sTitle" : "ID",
		"bSortable" : true
	},{
		"mData" : 'name',
		"sTitle" : "Name",
		"bSortable" : true
	},{
		"mData" : 'age',
		"sTitle" : "Age",
		"bSortable" : true,
		"mRender" : function(data, type, row) {
			return data;
		}
	},{
		"mData" : 'work',
		"sTitle" : "Work",
		"bSortable" : true
	}],
	/*
	 * fnInitComplete
	 * 表格初始化完成后的回调
	 */
	"fnInitComplete" : function(){
		
	},
	/*
	 * fnDrawCallback
	 * 表格绘制完成后的回调
	 */
	"fnDrawCallback" : function(){
		
	},
	/*
	 * 数据源url，ajax请求路径
	 */
	"sAjaxSource" : "xx/xx/xxx/xxx/xxx"
});