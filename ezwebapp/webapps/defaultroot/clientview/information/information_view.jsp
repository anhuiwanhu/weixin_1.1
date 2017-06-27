<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>信息正文</title>
  <link rel="stylesheet" href="<%=rootPath%>/clientview/template/css/template.style.ios.min.css" />
  <link rel="stylesheet" href="<%=rootPath%>/clientview/template/css/template.webapp-style.min.css" />
  <link rel="stylesheet" href="<%=rootPath%>/clientview/template115/css/alert/template.alert.css" />
</head>

<body class="grey-bg">
  <c:if test="${not empty docXml}">
  <x:parse xml="${docXml}" var="doc"/>
  	<c:set var="informationTitle" ><x:out select="$doc//informationTitle/text()"/></c:set>
	<c:set var="informationType" ><x:out select="$doc//informationType/text()"/></c:set>
	<c:set var="informationContent" ><x:out select="$doc//informationContent/text()"/></c:set>
	<c:set var="informationIssuer" ><x:out select="$doc//informationIssuer/text()"/></c:set>
	<c:set var="informationIssueTime" ><x:out select="$doc//informationIssueTime/text()"/></c:set>
	<c:set var="informationKits" ><x:out select="$doc//informationKits/text()"/></c:set>
	<c:set var="channelName" ><x:out select="$doc//channelName/text()"/></c:set>
	<c:set var="displayTitle" ><x:out select="$doc//displayTitle/text()"/></c:set>
	<c:set var="displayImage" ><x:out select="$doc//displayImage/text()"/></c:set>
	<c:set var="informationCanRemark" ><x:out select="$doc//informationCanRemark/text()"/></c:set>
	<c:set var="commentNum" ><x:out select="$doc//commentNum/text()"/></c:set>
	
	<c:set var="content" >${content }</c:set>
	 <%
	 	 String isYzOffice = com.whir.util.PropertyUtil.getPropertyByKey("isYzOffice");
         String infoRealPath = request.getRealPath("/upload/information");
         String informationContent = org.apache.commons.lang.StringEscapeUtils.unescapeXml((String)pageContext.getAttribute("informationContent"));
         String content = org.apache.commons.lang.StringEscapeUtils.unescapeXml((String)pageContext.getAttribute("content"));
         
     %>
    <c:set var="isYzOffice" ><%=isYzOffice %></c:set>
	<c:if test="${informationType =='2'}">
		<script>
			window.location = '${informationContent}';
		</script>
	</c:if>
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page" data-page="page-webapp-infomation-artical">
          <section id="sectionHtml" class="wh-section wh-section-bottomfixed page-content hide-bars-on-scroll">
            <div class="webapp-infomation-article">
              <c:if test="${displayTitle != 0}">
	        		<h1>${informationTitle}</h1>
	          </c:if>
              <div class="artical-tip">
                <em>${channelName }</em>
                <c:set var="informationIssueOrg" ><x:out select="$doc//informationIssueOrg/text()"/></c:set>
                <%
					String infoOrgName = org.apache.commons.lang.StringEscapeUtils.unescapeXml((String)pageContext.getAttribute("informationIssueOrg"));
					infoOrgName = infoOrgName.split("\\.")[infoOrgName.split("\\.").length-1];
				%>  
                <em><%=infoOrgName %>·${informationIssuer }</em>
                <span>${fn:substring(informationIssueTime,0,16)}</span>
              </div>
              <article class="webapp-article" id="bzstyle">
				<c:if test="${displayImage != '0' && informationType != 3}">
					<x:forEach select="$doc//picList/picSaveName" var="pic" varStatus="status">
							<c:set var="filename"><x:out select="$pic/text()"/></c:set>
							<input type="hidden" name="imgName" value="${filename }">
							<img id="${fn:substring(filename,0,25)}"  width="100%" height="100%"/>
						</x:forEach>
				</c:if>
				<c:choose>
	            	<c:when test="${informationType =='0' || informationType =='1'}">
						<%
						informationContent = com.whir.util.StringUtils.resizeImgSize(informationContent, "240", "50%");
						informationContent = informationContent.replaceAll("amp;", "");
						content = content.replaceAll("amp;", "");
						%>
						<c:set var="infoContent" ><%=content%></c:set>
				      	<p style="text-indent:2em; font-size: 1.3rem;" id="zwimg">${infoContent }</p>
	            	</c:when>
	            	<c:when test="${informationType =='3'}">
					    <%
						informationContent = informationContent.replace("<![CDATA[","").replace("]]","");
						String fileName = informationContent.split("\\:")[1];
						String realFileName = informationContent.split("\\:")[0];
						if(fileName.indexOf(".jpg") > 0 || fileName.indexOf(".png") > 0 || fileName.indexOf(".gif") > 0 || fileName.indexOf(".png") > 0 || fileName.indexOf(".jpeg") > 0){
						%>
							<p>		
								<div class="wh-article-atta">
									<p>
										<i class="fa fa-paperclip"></i>
										<a href='javascript:openImgPath("<%=fileName%>");'  color='blue'>
											<strong class="atta-name">
												<%=realFileName%>
											</strong>
										</a>
									</p>
								</div>
							</p>
						<%}else{ %>
							<p>		
								<jsp:include page="../common/include_download.jsp" flush="true">
									<jsp:param name="realFileNames"	value="<%=realFileName%>" />
									<jsp:param name="saveFileNames" value="<%=fileName%>" />
									<jsp:param name="moduleName" value="information" />
								</jsp:include>
							</p>
						<%} %>
	            	</c:when>
	            	<c:when test="${informationType =='4'}">
	            		<p>		
							<jsp:include page="../common/include_download.jsp" flush="true">
								<jsp:param name="realFileNames"	value="正文.doc" />
								<jsp:param name="saveFileNames" value="${informationContent }.doc" />
								<jsp:param name="moduleName" value="information" />
							</jsp:include>
						</p>
	            	</c:when>
	            	<c:when test="${informationType =='5'}">
	            		<p>		
							<jsp:include page="../common/include_download.jsp" flush="true">
								<jsp:param name="realFileNames"	value="正文.xls" />
								<jsp:param name="saveFileNames" value="${informationContent }.xls" />
								<jsp:param name="moduleName" value="information" />
							</jsp:include>
						</p>
	            	</c:when>
	            	<c:when test="${informationType =='6'}">
	            		<p>		
							<jsp:include page="../common/include_download.jsp" flush="true">
								<jsp:param name="realFileNames"	value="正文.ppt" />
								<jsp:param name="saveFileNames" value="${informationContent }.ppt" />
								<jsp:param name="moduleName" value="information" />
							</jsp:include>
						</p>
	            	</c:when>
	            </c:choose>
              </article>
            </div>
          </section>
          <footer class="toolbar toolbar-new wh-footer wh-footer-forum">
            <div class="wh-container">
              <div class="wh-footer-btn row">
                <div class="webapp-footer-linebtn webapp-footer-linebtn-atta">
                  <c:set var="fileNum" value="0"/>
                  <c:if test="${informationType !=3 }">
	                  <x:forEach select="$doc//appList/appName" var="app"  varStatus="status">
	                  		<c:set var="fileNum">${fileNum+1 }</c:set>
	                  </x:forEach>
                  </c:if>
                  <a <c:if test="${fileNum > 0}"> id="file-atta" </c:if> data-popover=".popover-links" class="fl file-attachment link open-popover"><span>附件${fileNum }</span></a>
                  <div class="fr clearfix"> 	
                    <a href="#" class="text-grey">阅 ${informationKits }</a>
                    <c:if test="${informationCanRemark == '1' }"><a href="#">评 ${commentNum }</a></c:if>
                  </div>
                </div>
              </div>
            </div>
          </footer>
        </div>
      </div>
    </div>
  </div>
  </c:if>
  <script type="text/javascript" src="<%=rootPath%>/clientview/template/js/template.min.js"></script>
  <script type="text/javascript" src="<%=rootPath%>/clientview/template/js/plugin/zepto.js"></script>
  <script type="text/javascript" src="<%=rootPath%>/clientview/js/subClick.js"></script>
  <script type="text/javascript" src="<%=rootPath%>/clientview/js/subClickYz.js"></script>
  <script type="text/javascript" src="<%=rootPath%>/clientview/template115/js/alert/zepto.alert.js"></script>
  <script type="text/javascript">
  var myApp = new Framework7({
    hideToolbarOnPageScroll: true,//滑屏
  });
  var $$ = Dom7;
  var mainView = myApp.addView('.view');
  
  var inTitle='${informationTitle }';
  var inchannelName='${channelName }';

  
  $(function(){
  		$$('.webapp-infomation-article table').css("width","100%");
  		$$('.webapp-infomation-article p').css("margin","");
  		$$('.webapp-infomation-article p').css("overflow","hidden");
  		if(inTitle == '' && inchannelName == ''){
  			$$('.grey-bg').html('');
  			myApp.alert('该信息已删除！', function () {
				window.location = "<%=rootPath%>/information/index.controller";
			});
  		}
  		loadImg();
  		loadImgName();
  		/*
  		var picSaveName = '${picSaveName}';
  		if(picSaveName !=''){
  			openImg(picSaveName,'information/'+picSaveName.substring(0,6));
  		}*/
    });
  // page-webapp-infomation-artical
  $$('#file-atta').on('click', function() {
    var clickedLink = this;
    var popoverHTML = '<div class="fbtn-more-nav btn-fileload-nav popover popover-links" id="fbtn-more-con">' +
   	'<div class="fbtn-more-nav-inner" id="fbtn-more-list">' +
    <c:if test="${not empty docXml}">
    	<x:parse xml="${docXml}" var="doc"/>
    	<c:set var="informationType" ><x:out select="$doc//informationType/text()"/></c:set>
    	<c:if test="${informationType != 3}">
	    	<x:forEach select="$doc//appList/appName" var="app"  varStatus="status">
	    		<c:set var="filename"><x:out select="$app/following-sibling::appSaveName/text()"/></c:set>
			    <c:set var="appName"><x:out select="$app/text()"/></c:set>
			    <c:set var="aid">${fn:substring(filename,0,25)}</c:set>
	    		 '<a href="javascript:downFile(\'${filename}\',\'${appName}\',\'${aid}\')" id="${aid}"><x:out select="$app/text()"/></a>' +
	    	</x:forEach>
    	</c:if>
    </c:if>
    '</div></div>';
    myApp.popover(popoverHTML, clickedLink);
    myApp.closeModal('#fbtn-more-list a')
  });
  
  //加载图片
  function openImg(fileName,path,i) {
		$.ajax({
			 type: 'post',
			 url: "<%=rootPath%>/download/downloadImg.controller",
			 dataType:'text',
			 data : {"fileName": fileName,"name": fileName,"path":path},
			 success: function(data){
				 if(path != 'html'){
				 	 $('#imgName').attr("src", "<%=rootPath%>"+data); 
				 }else{
				 	$('#'+i).attr("src", "<%=rootPath%>"+data);
				 }
			 },error: function(xhr, type){
				 //alert('数据查询异常！');
			 }
		
		});
	}
	
  //打开附件
  function downFile(menuHtmlLink,menuFileLink,aId) {
  		var isYzOffice = "${isYzOffice}";
  		var path = 'information';
  		if(aId == undefined){
  			aId = menuHtmlLink.split('.')[0];
  			path = 'html';
  		}
  		if(menuHtmlLink.indexOf(".jpg") > 0 || menuHtmlLink.indexOf(".png") > 0 || menuHtmlLink.indexOf(".gif") > 0 || menuHtmlLink.indexOf(".png") > 0 || menuHtmlLink.indexOf(".jpeg") > 0){
  			openImgPath(menuHtmlLink);
  		}else{
  			$.ajax({
				 type: 'post',
				 url: "<%=rootPath%>/download/getOpenFileUrl_New.controller",
				 dataType:'text',
				 data : {"fileName": menuHtmlLink,"name": menuFileLink,"path":path},
				 success: function(data){
				 	var jsonData = eval("("+data+")");
				 	clickSubyz(jsonData.url,$('#'+aId),menuHtmlLink,"information",jsonData.smartInUse,jsonData.isEncrypt,jsonData.tmpurl,jsonData.apptype,'',isYzOffice);
				 },error: function(xhr, type){
					 //alert('数据查询异常！');
				 }
			});
  		}
	}
	
  //打开图片附件
  function openImgPath(fileName) {
  		myApp.showPreloader(' ');
		$.ajax({
			 type: 'post',
			 url: "<%=rootPath%>/download/downloadImg.controller",
			 dataType:'text',
			 data : {"fileName": fileName,"name": fileName,"path":"information/"+fileName.substring(0,6)},
			 success: function(data){
			 	myApp.hidePreloader();
			 	window.location= '<%=rootPath%>'+data;
			 },error: function(xhr, type){
				 //alert('数据查询异常！');
			 }
		
		});
	}
	
  //循环加载全部html编辑器图片
  function loadImg(){
	$("input[name='pictureName']").each( 
		function (){
			var filename = $(this).val();
			var id = filename.split('.')[0];
			$.ajax({
				type : 'post',
				url : '<%=rootPath%>/download/downloadImg.controller',
				dataType : 'text',
				data : {"fileName":filename,"name":filename,"path":"html"},
				success : function(data){
					$('#'+id).attr("src","<%=rootPath%>"+data);
					$('#'+id).attr("onclick","window.open('/defaultroot"+data+"')");
					$('#'+id).attr("width","50%");
					$('#'+id).attr("hight","240");
				},
				error : function (xhr,type){
					//alert('数据查询异常！');
				}
			});
		  }		
	   );
	}
	
	//循环加载全部选人页面头像
	function loadImgName(){
		$("input[name='imgName']").each( 
			function (){
				var filename = $(this).val();
				var id = filename.substring(0,25);
				$.ajax({
					type : 'post',
					url : '<%=rootPath%>/download/downloadImg.controller',
					dataType : 'text',
					data : {"fileName":filename,"name":filename,"path":"information/"+filename.substring(0,6)},
					success : function(data){
						$('#'+id).attr("src","<%=rootPath%>"+data);
					},
					error : function (xhr,type){
						//alert('数据查询异常！');
					}
				});
			}		
		);
	}
	
  </script>
</body>
