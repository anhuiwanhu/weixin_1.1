<%@ page language="java"  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page isELIgnored ="false" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
</head>
<body class="grey-bg">
</body>
</html>
<script type="text/javascript" src="/defaultroot/scripts/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="https://g.alicdn.com/ilw/ding/0.9.2/scripts/dingtalk.js?spm=a219a.7629140.0.0.JCKFOE&file=dingtalk.js"></script>
<%
  String agentid = request.getAttribute("agentid")+"";
  String corpid = request.getAttribute("corpid")+"";
  String timeStamp = request.getAttribute("timeStamp")+"";
  String nonceStr = request.getAttribute("nonceStr")+"";
  String signature = request.getAttribute("signature")+"";
  String url = request.getAttribute("url")+"";

  //System.out.println("----------------------------------getCodeMain.jsp--------------------------------------------");
 // System.out.println("agentid--->"+agentid);
 // System.out.println("corpid--->"+corpid);
 // System.out.println("timeStamp--->"+timeStamp);
 // System.out.println("nonceStr--->"+nonceStr);
 // System.out.println("signature--->"+signature);
 // System.out.println("url--->"+url);
%>
<script type="text/javascript">

	dd.config({
			agentId :'<%=agentid%>',
			corpId :'<%=corpid%>',
			timeStamp :<%=timeStamp%>,
			nonceStr :'<%=nonceStr%>',
			signature :'<%=signature%>',
			jsApiList : ['runtime.permission.requestAuthCode' ]
		});


	 dd.ready(function(){

		 dd.runtime.permission.requestAuthCode({
			corpId :"<%=corpid%>",
			onSuccess: function(result) {
			
				var param ={};
				param.code=result.code
				$.ajax({
				url : '/defaultroot/dinglogin/firstlogon.controller',
				type : 'post',
				async : false,
				dataType : 'text',
				data : param,
				
				success : function(data) {
					if(data!=""){
					   alert(data);
					}else{
					   window.location.href="<%=url%>";
					}
				},
				error : function(xhr, errorType, error) {
					
					alert(errorType + ', ' + error);
				}
				}); 
				
			 
			},
			onFail : function(err) {
				
			}
		 
		})
     
     });

	 dd.error(function(error){
		
       /**
        {
           message:"错误信息",//message信息会展示出钉钉服务端生成签名使用的参数，请和您生成签名的参数作对比，找出错误的参数
           errorCode:"错误码"
        }
       **/
      alert('dd error: ' + JSON.stringify(error));
	});


	
	</script>