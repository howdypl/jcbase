/**
 * 
 */

function getInervalHour(startDate, endDate) {
    var ms = endDate.getTime() - startDate.getTime();
    if (ms < 0) return 0;
    return Math.floor(ms/1000/60/60);
}

//给Number原型添加左边补位函数
Number.prototype.padLeft = function(lng, chr) {
 if (!lng) lng = 0;
 if (!chr) chr = '0';
 var vStr = this.toString();
 
 if (vStr.length > lng) {
     return vStr.substring(vStr.length - lng,vStr.length);
 } else if (vStr.length < lng) {
     var tnum = Math.pow(10,lng - vStr.length).toString();
     return tnum.substring(1, tnum.length).replace("0",chr) + this.toString();
 }
 return this.toString();
};
//给Date原型添加转化成字符串格式yyyy-MM-dd HH:mm:ss函数
Date.prototype.toMyStr = function() {
  return this.getFullYear()
     + '-' + (this.getMonth() + 1).padLeft(2)
     + '-' + this.getDate().padLeft(2)
     + ' ' + this.getHours().padLeft(2)
     + ':' + this.getMinutes().padLeft(2) 
     + ':' + this.getSeconds().padLeft(2);
};

/*//使用示例
//日期字符串中含有空格能字符，HTML页面传递日期字符串时可以先用encodeURIComponent编码，在接收页面再用decodeURIComponent解码
var timeStr = '2015-09-07 13:40:36';
var ct = new Date(timeStr.replace(/-/g, '/'));
var addHours = 13;
ct.setHours(ct.getHours() + addHours);
console.log(ct.toMyStr());*/
