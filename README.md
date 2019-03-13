jcbase是基于JFinal2.x的后台业务框架通用模块，包括系统权限模块、APP版本管理、日志管理、数据字典等
### 使用的技术要点
- 后端使用JFinal2.x
- 前端页面是基于acev1.3模板改造的，更方便后台人员操作
- 前端使用到的框架都是基于jquery的，所以只要熟悉jquery就非常容易入手，部分框架有：树框架zTree,表格框架jqGrid,校验框架jquery.validate.js,弹出层框架layer.js

### 使用步骤

- 在你本地创建jcbase数据库，再导入db/jcbase.sql，在a_little_config.txt配置文件对应更改你的数据库连接相关参数
- 用eclipse选择以maven的方式导入项目
- 运行项目，执行src/test/com/jcbase/test/AppRun.java 即可
- 默认系统用户为admin,密码123456

### 部分界面截图
![输入图片说明](http://git.oschina.net/uploads/images/2016/0703/122053_ce09d6a9_387388.png "在这里输入图片标题")
![输入图片说明](http://git.oschina.net/uploads/images/2016/0703/122130_b93742c7_387388.png "在这里输入图片标题")
![输入图片说明](http://git.oschina.net/uploads/images/2016/0703/122201_e3cc617a_387388.png "在这里输入图片标题")
![输入图片说明](http://git.oschina.net/uploads/images/2016/0703/122218_10e97b38_387388.png "在这里输入图片标题")
![输入图片说明](http://git.oschina.net/uploads/images/2016/0703/122228_006c59b1_387388.png "在这里输入图片标题")

Wiki说明：[http://git.oschina.net/weicoding/jcbase/wikis/home](http://git.oschina.net/weicoding/jcbase/wikis/home)

更详细介绍可以查看《基于JFinal微信应用开发实战》：http://yuedu.baidu.com/ebook/dcf219e355270722182ef7e9



### tomcat优化配置
#### 在conf/server.xml配置线程池

    <Executor name="tomcatThreadPool" namePrefix="catalina-exec-"
        maxThreads="800" minSpareThreads="20" maxIdleTime="60000" prestartminSpareThreads="true" maxQueueSize="100" />

	<Connector port="33334" protocol="org.apache.coyote.http11.Http11Nio2Protocol"  
        connectionTimeout="20000"  
        redirectPort="8443"  
        executor="tomcatThreadPool"  
        enableLookups="false"  
        acceptCount="100"  
        maxPostSize="10485760"  
        compression="on"  
        disableUploadTimeout="true"  
        compressionMinSize="2048"  
        noCompressionUserAgents="gozilla, traviata"  
        acceptorThreadCount="2"  
        compressableMimeType="text/html,text/xml,text/plain,text/css,text/javascript,application/javascript"  
        URIEncoding="utf-8"/>

#### tomcat内存不足问题，增加tomcat的java option 配置参数

tomcat出现内存不足，内存泄露，内存溢出问题： 
tomcat在使用一段时间后，内存不足，然后便不响应了。 
解决办法： 
在tomcat的bin的catalina.bat里的 

（1）找到JAVA_OPTS,修改为

set JAVA_OPTS='-Xms512m -Xmx1024m'

（2）
rem ----- Execute The Requested Command ---------------- 
后面添加：
rem add by mysqlf
set JAVA_OPTS = -server -Xms512m -Xmx1024m -XX:PermSize=256M 
-XX:MaxNewSize=256m 
-XX:MaxPermSize=256m 
rem add by mysqlf end //意思:设置最小虚拟内存512M,最大1024M.


 
#### 在tomcat-user.xml添加管理员配置

  <role rolename="manager-gui"/> 
  <role rolename="tomcat"/>
  <role rolename="role1"/>
  <user username="tomcat" password="tomcat" roles="tomcat"/>
  <user username="both" password="tomcat" roles="tomcat,role1"/>
  <user username="role1" password="tomcat" roles="role1"/>
  <user username="admin" password="admin" roles="manager-gui"/>
  
  
  

### chrome 

chrome://settings/content/flash


