<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>jQuery带按钮向上滚动向下滚动代码</title>

<style type="text/css">
body{ color:#333; font-size:13px;}
h3,ul,li{margin:0;padding:0; list-style:none;}
.scrollbox{ width: 340px; margin: 0 auto; overflow: hidden; border: 1px solid #CFCFCF; padding: 10px; }
#scrollDiv{width:340px;height:359px; overflow:hidden;}/*这里的高度和超出隐藏是必须的*/
#scrollDiv li{height:90px; width:300px; padding:0 20px;background:url(ico-4.gif) no-repeat 10px 23px; overflow:hidden; vertical-align:bottom; zoom:1; border-bottom:#B7B7B7 dashed 1px;}
#scrollDiv li h3{ height:24px; padding-top:13px; font-size:14px; color:#353535; line-height:24px; width:300px;}
#scrollDiv li h3 a{color:#353535; text-decoration:none}#scrollDiv li h3 a:hover{ color:#F00}
#scrollDiv li div{ height:36px; width:300px; color:#416A7F; line-height:18px; overflow:hidden}
#scrollDiv li div a{ color:#416A7F; text-decoration:none}

.scroltit{ height:26px; line-height:26px; padding-bottom:4px; margin-bottom:4px;}
.scroltit h3{ width:100px; float:left;}
.scroltit .updown{float:right; width:32px; height:22px; margin-left:4px}
#but_up{ background:url(${res_url}img/up.gif) no-repeat 0 0; text-indent:-9999px}
#but_down{ background:url(${res_url}img/down.gif) no-repeat 0 0; text-indent:-9999px}
</style>

<script src="${res_url}js/jquery-1.4.4.min.js" type="text/javascript"></script>
<script src="${res_url}js/jq_scroll.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function(){
     $("#scrollDiv").Scroll({line:1,speed:500,timer:3000,up:"but_up",down:"but_down"});
});
</script>

</head>

<body>

<div class="scrollbox">
    <div id="scrollDiv">
        <ul>
            <li><h3><a href="#" class="linktit">移动娱乐业务突飞</a></h3> <div>为了探索推进公车改革后，新能源汽车分时租赁项目试点工作，并成立了试点工作小组... </div></li>
            <li><h3><a href="#" class="linktit">不停转动向上滚动可控制向上向下滚动特效</a></h3> <div>DIV CSS JS自动不断向上一个一个滚动可控制向上向下滚动特效... </div></li>
            <li><h3><a href="#" class="linktit">全国涂料总产量呈现直线下滑态势</a></h3> <div>我国涂料工业将面临涂料消费税征收全面铺开，环保压力持续增加，2015年的形势不容乐观... </div></li>
            <li><h3><a href="#" class="linktit">镂空渔网超吸睛</a></h3> <div>镂空罩衫，短短的版型穿起来显高又俏皮，内搭长款连衣裙，非常大方哦... </div></li>
            <li><h3><a href="#" class="linktit">主题创业街亮相</a></h3> <div>目前已有包括咖啡厅、酒吧、餐厅、瑜伽室在内的8家商铺入驻该火车... </div></li>
        </ul>
    </div>
    <div class="scroltit"><div class="updown" id="but_down">向上</div><div class="updown" id="but_up">向下</div></div>
</div>


</body>
</html>