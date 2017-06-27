<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.math.RoundingMode"%>
<%@ page import="com.whir.util.PropertyUtil"%>
<%@ page import="com.whir.util.Base64Util"%>
<%@ page import="com.whir.util.WebServiceUtils"%>
<%@ page import="com.whir.webplatform.manage.bd.WebAppPlatformBD"%>
<%@ page import="com.whir.aop.WebAppAuth"%>


<link rel="stylesheet" href="/defaultroot/clientview/template115/css/alert/template.alert.css" />

<script type="text/javascript" src="/defaultroot/clientview/template115/js/zepto.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/template115/js/alert/zepto.alert.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/js/subClickYz.js"></script>
<%
request.setCharacterEncoding("UTF-8");

int smartInUse = 0;
if("1".equals(""+session.getAttribute("fileType"))){
  smartInUse=0;
}else{
  smartInUse=1;
}

String apptype = new WebAppAuth().getAppType(request);

//真实文件名
String realFileNames = request.getParameter("realFileNames") != null ? request.getParameter("realFileNames") : "";
//保存文件名
String saveFileNames = request.getParameter("saveFileNames") != null ? request.getParameter("saveFileNames") : "";
//实时下载
String realtime = request.getParameter("realtime") != null ? request.getParameter("realtime") : "";
//模块名称
String moduleName = request.getParameter("moduleName") != null ? request.getParameter("moduleName") : "";

String[] realFileNamesArray = realFileNames.split("\\|");
String[] saveFileNamesArray = saveFileNames.split("\\|");

File file = null;
String fileUrl = "";
String fileSizeStr = "";
double fileSize = 0;
BigDecimal bd = null;

String webAppUrl = PropertyUtil.getPropertyByKey("webAppUrl"); 
String downloadFileLink = "";

//判断是否启用永中office转换附件
String isYzOffice = PropertyUtil.getPropertyByKey("isYzOffice"); 
%>
<div class="wh-article-atta">
<%
for(int i = 0,length = realFileNamesArray.length ;i < length ;i ++){

	//downloadFileLink = webAppUrl+"download/file.controller?";
	downloadFileLink = "/defaultroot/download/file.controller?";

	String   realFileName = realFileNamesArray[i];
    realFileName = realFileName.replaceAll("&", "").replaceAll(" ", "").replaceAll(":", "").replaceAll("/", "").replaceAll("\\\\", "");

	String   httpserver=(String)PropertyUtil.getPropertyByKey("webserviceUrl");
	String   isEncrypt = new WebAppPlatformBD().getFileEncrypt(saveFileNamesArray[i],request);
    String   vkey = PropertyUtil.getPropertyByKey("key");
    String   key  = new com.whir.util.MD5().toMD5(vkey);  //加密
	String TMP_url = httpserver+"DownloadServlet?modeType=1&encrypt="+isEncrypt+"&path="+moduleName+"&name="+realFileName+"&FileName="+saveFileNamesArray[i]+"&key="+key;
	//System.out.println("-TMP_url------>"+TMP_url);
	String url = Base64Util.encodeAsString(TMP_url);
    downloadFileLink += "url="+url;
    downloadFileLink += "&filename="+saveFileNamesArray[i];
	downloadFileLink += "&uploadPath="+moduleName;
	downloadFileLink += "&encrypt="+isEncrypt;
	downloadFileLink += "&isDecode=true";
	downloadFileLink += "&realtime="+realtime;
	//System.out.println("-downloadFileLink------>"+downloadFileLink);
%>
	<p>
		<i class="fa fa-paperclip"></i>
		<a href='javascript:void(0);' onclick='clickSubyz("<%=downloadFileLink%>",this,"<%=saveFileNamesArray[i]%>","<%=moduleName%>","<%=smartInUse%>","<%=isEncrypt%>","<%=url%>","<%=apptype%>","<%=realtime%>","<%=isYzOffice%>");' color='blue'>
			<strong class="atta-name">
				<%=realFileNamesArray[i]%>
			</strong>
		</a>
	</p>
<%
}
%>
</div>
