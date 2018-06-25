
/**
 * 初始化普通表格
 * @param tableObj table对象
 * @param url 请求地址
 * @param cols 列
 * @param colDefs 列设置
 * @param fixedColumns 锁定列
 * @param sScrollX 横向滚动条
 * @param bServerSide 服务器模式
 */
   var initAsyncPagingDT =function(tableObj, url, cols, colDefs, fixedColumns, sScrollX, rows) {
    var oTable = tableObj.DataTable({
        "sDom": "Tflt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
        "iDisplayLength": rows || 10,
        "oTableTools": {
            "aButtons": [ ]
        },
        "deferRender": true,
        "language": {
            "search": "",
            "sLengthMenu": "_MENU_",
            "info": "显示 _START_ 到 _END_ 条记录 ( 总共 _TOTAL_ 条 )",
            "oPaginate": {
                "sPrevious": "上一页",
                "sNext": "下一页"
            },
            "sInfoEmpty": "没有数据",
            "sProcessing": "正在加载数据...",
            "sInfoFiltered": "(从 _MAX_ 条数据中检索)",
        },
        "sScrollX": sScrollX || "",
        "bDestroy": true,
        "bProcessing": true,
        "bServerSide": true, //开启服务器分页模式
        "sAjaxSource": url,
        "autoWidth": false,
        "aoColumns": cols,
        "aoColumnDefs": colDefs,    //列的设置
        "aaSorting": [ ],
        "fixedColumns": fixedColumns || null,
        "fnServerData" : returnData,
        "fnServerParams": serOtherParams || null
    });
    return oTable;
};

/**
 * 处理服务器端分页返回数据
 * @param sSource 查询地址
 * @param aDataSet    
 * @param fnCallback 回调函数
 */
function returnData(sSource, aDataSet, fnCallback) {
    $.ajax({  
        "dataType" : 'json',
        "contentType": "application/json; charset=utf-8",
        "type" : "get",  
        "url" : sSource,  
        "data" :{
            "pagingData": JSON.stringify(aDataSet)//这个是把datatable的一些基本数据传给后台,比如起始位置,每页显示的行数
        },  
        "success" : function(resp){  
            fnCallback(resp);  
        }  
    });  
}   
