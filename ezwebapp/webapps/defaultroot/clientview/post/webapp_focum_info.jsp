<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<c:if test="${not empty docXml3}">
	<x:parse xml="${docXml3}" var="doc3"/>  
	<c:set var="notFlow" ><x:out select="$doc3//notFlow/text()"/></c:set>
</c:if>
<!DOCTYPE html>
<html>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>论坛帖子详情</title>
  <%@ include file="../common/headerInit.jsp" %>
  <link rel="stylesheet" href="/defaultroot/clientview/template115/css/alert/template.alert.css" />
  <style>
  #did>p{line-height: inherit;}
  </style>
</head>

<body class="grey-bg">
<c:choose>
<c:when test="${recordCount > 0}">
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page" data-page="page-webapp-focum">
          <section id="sectionScroll" class="section-focum infinite-scroll wh-section show wh-section-bottomfixed pull-to-refresh-content" data-ptr-distance="40">
            	<div class="focum-list">
				   <div style="width: 100%;margin: 1rem 0;padding: 1rem 0;text-align: center;background-color: #fff;margin-top:3.5rem;">
				    <h1>${topicForumTitle}</h1>
				   </div>
				<ul id="postList" data-loadflag="0">
            	<x:parse xml="${docXml}" var="doc"/>
				<c:set var="recordCount"><x:out select="$doc//recordCount/text()" /></c:set>
				<x:forEach select="$doc//list" var="n"  varStatus="status">
					<c:set var="forumType" ><x:out select="$n/forumType/text()"/></c:set>
					<c:set var="id" ><x:out select="$n/id/text()"/></c:set>
					<c:set var="anonymous" ><x:out select="$n/anonymous/text()"/></c:set>
					<c:set var="curName">匿名</c:set>
					<c:if test="${anonymous == '0'}">
						<c:set var="curName" ><x:out select="$n/empName/text()"/></c:set>
					</c:if>       
					<c:if test="${anonymous == '2'}">
						<c:set var="curName" ><x:out select="$n/nickName/text()"/></c:set> 
					</c:if>
					<c:set var="authorPhoto"><c:out value="${authorPhotoArr[status.index]}"/></c:set>
					<%  String pic=(String)pageContext.getAttribute("authorPhoto");
						String photoPath = "";
						if(null != pic && !pic.equals("") && !"null".equals(pic)){
							photoPath = "/defaultroot/upload/peopleinfo/"+pic;
						}else{
							photoPath = "/defaultroot/clientview/images/user3.png";
						}
						if("1".equals((String)pageContext.getAttribute("anonymous"))) {
							photoPath = "/defaultroot/clientview/images/user3.png";
					} %>
					<c:set var="floor" >${(status.index+1)+(offset-1)*15}</c:set>
					<c:set var="floorName" >${floor-1}楼</c:set>
					<c:if test="${floor == 1}">
						<c:set var="floorName" >楼主</c:set>
					</c:if>
					<c:set var="time" ><x:out select="$n/forumIssueTime/text()"/></c:set>
					<c:if test="${fn:indexOf(time,'.') > 0}">
						<c:set var="time">${fn:substringBefore(time,".")}</c:set>
					</c:if> 
					<c:set var="forumAuthorOrg" ><x:out select="$n/forumAuthorOrg/text()"/></c:set>
					<c:if test="${anonymous == '1'}">
						<c:set var="forumAuthorOrg" ></c:set>
					</c:if>       
					<c:set var="content" ><x:out select="$n/forumContent/text()"/></c:set>
					<%
						String aContent = org.apache.commons.lang.StringEscapeUtils.unescapeXml((String)pageContext.getAttribute("content"));
						//String aContent = (String) pageContext.getAttribute("content");
						aContent = org.apache.commons.lang.StringEscapeUtils.unescapeXml(aContent);
						aContent = com.whir.util.StringUtils.resizeImgSize(aContent, "200", "");
						aContent=com.whir.util.RegularUtils.replaceAllImages(aContent);
						aContent=com.whir.util.RegularUtils.candownloadHtmlfile(aContent);
					%>     
					<c:set var="newContent" value="<%=aContent%>" />

					<c:set var="sign" ><x:out select="$n/forumSign/text()"/></c:set>
					<%
						
						//String sign = (String) pageContext.getAttribute("sign");
						String sign = org.apache.commons.lang.StringEscapeUtils.unescapeXml((String)pageContext.getAttribute("sign"));
						if(sign.equals("null")){
							sign = "";
						}
						System.out.println("sign---------------->"+sign);
						sign = com.whir.util.RegularUtils.replaceAllImages(sign);
						sign = com.whir.util.RegularUtils.candownloadHtmlfile(sign);
						
						//sign = HtmlUtils.htmlUnescape(sign);
					%>
					<c:set var="newSign" value="<%=sign%>" />

              		<!-- 区分楼主与其他用户的区别 -->
					<li>
              		<div class="webapp-focum">
                		<div class="focum-title">
                  			<img src="<%=photoPath%>" />
                  			<div>
								 <%
									String forumAuthorOrg = (String)pageContext.getAttribute("forumAuthorOrg");
									String authorOrg = "";
									if(!"".equals(forumAuthorOrg) && forumAuthorOrg != null){
										authorOrg = forumAuthorOrg.substring(forumAuthorOrg.lastIndexOf(".")+1, forumAuthorOrg.length());
									}
			                     %>
                    			<span><%=authorOrg%>·${curName}
                    				
                    			</span>
                    			<em>${fn:substring(time,0,16)}&nbsp;&nbsp;${floorName}</em>
                  			</div>
                		</div>
                		<div class="focum-artical" >
                  			
                  			<strong></strong>
                  			<div id="did" style="FONT-SIZE: 16px;FONT-FAMILY:宋体;">
                  				${newContent}
                  				<c:if test="${newSign != ''}">
                  					<p style="color: #3eaeff;">签名档：</p>${newSign }
                  				</c:if>
                  			</div>
                		</div>
                		<div class="focum-bottom">
                  			<div></div>
                 			<div></div>
							<c:if test="${notFlow != '1' && forumType != '2'}">
                  				<a href="javascript:toReply('toReplyForm_${id}');" class="focum-btn">引用</a>
							</c:if>
                		</div>
						<x:if select="$n/forumAttachName">
							<c:set var="names" ><x:out select="$n/forumAttachName/text()"/></c:set>
							<c:set var="savenames" ><x:out select="$n/forumAttachSave/text()"/></c:set>
							<c:if test="${ not empty names}">
								<%
									String names = (String)pageContext.getAttribute("names");
									names = names.replace("||", "|");
									if(names.substring(0, 1).equals("|")){
										names = names.substring(1, names.length());
									}
									String savenames = (String)pageContext.getAttribute("savenames");
									savenames = savenames.replace("||", "|");
									if(savenames.substring(0, 1).equals("|")){
										savenames = savenames.substring(1, savenames.length());
									}
								%>
							
								<jsp:include page="../common/include_download.jsp" flush="true">
									<jsp:param name="realFileNames"	value="<%=names%>" />
									<jsp:param name="saveFileNames" value="<%=savenames%>" />
									<jsp:param name="moduleName" value="forum" />
								</jsp:include>
							</c:if>
						</x:if>
              		</div>
					</li>
					<c:if test="${floor == 1}">
			            <hr />
			        </c:if>
					<form action="/defaultroot/post/reply.controller" id="toReplyForm_${id}" method="get">
						<input type="hidden" value="${postId}" name="postId"/>
						<input type="hidden" value="${content}" name="content"/>
						<input type="hidden" value="${floor}" name="forumFloor"/>
						<input type="hidden" value="${curName}" name="forumUserName"/>
						<input type="hidden" value="${time}" name="forumIssueTime"/>
						<input type="hidden" value="${id}" name="forumId"/>
					</form>
              	</x:forEach>
				</ul>
            	</div>
            
			<aside class="wh-load-box" style="display: none">
     			<div class="wh-load-tap">上滑加载更多</div>
     			<div class="wh-load-md">
     				<span></span>
     				<span></span>
     				<span></span>
     				<span></span>
     				<span></span>
     			</div>
			</aside>
          </section>
          
          <footer class="wh-footer wh-footer-forum">
            <div class="wh-container">
              <div class="wh-footer-btn row">
                <div class="webapp-footer-linebtn">
                  <div class="fl clearfix" style="padding-top: 1.3rem;">
					<c:choose>
                		<c:when test="${notFlow != '1' && topicForumType != '2'}">
							<a href="/defaultroot/post/list.controller?classId=${param.curClassId}&className=${forumClassName}" style="width: 8rem;float: left;display: inline-block;text-overflow: ellipsis;overflow: hidden;word-break: keep-all;word-wrap: normal;white-space: nowrap;margin-right: 1rem;" class="fbtn-link col-xs-6"><i class="fa fa-list"></i>${forumClassName}</a>
							<a href="javascript:goReply('${postId}','1');" style="float: left;" class="fbtn-matter col-xs-6"><i class="fa fa-reply-all"></i>回复</a>
                		</c:when>
                		<c:otherwise>
							<a href="/defaultroot/post/list.controller?classId=${param.curClassId}&className=${forumClassName}" class="fbtn-link col-xs-6 fbtn-single"><i class="fa fa-list"></i>${forumClassName}</a>
                		</c:otherwise>
					</c:choose>
                  </div> 
                </div>
              </div>
            </div>
          </footer>
        
        </div>
      </div>
    </div>
  </div>
  </c:when>
  <c:otherwise>
  	<script>
 		//wx.ready(function(){
	 	//	alert('抱歉，此页面不存在或被删除！');
	 	//	wx.closeWindow();
 		//});
 		$(function(){
 			myApp.alert('抱歉，此页面不存在或被删除！', function () {
        		window.history.back();
    		});
 			
 		});
 	</script> 
  </c:otherwise>
</c:choose>
</body>
<input id="offset" value="${offset}" type="hidden"/>
<input id="nomore" value="${nomore}" type="hidden"/>
</html>
<script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
<script type="text/javascript" src="/defaultroot/webplatform/scripts/plugins/jquery/jquery.min.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/js/subClick.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/template115/js/alert/zepto.alert.js"></script>
<script type="text/javascript">
	var myApp = new Framework7();
	var $$ = Dom7;

	var nomore = "";
	var offset = "";
	var recordCount = '${recordCount}';
	var loading = false;
	$(function(){
		nomore = $("#nomore").val();
		offset = $("#offset").val();
		if(nomore){
			$(".wh-load-box").css("display","block");
		}else{
			$(".wh-load-box").css("display","none");
		}
	});
	


	$(function(){
		loadImg();
	});

	function loadImg(){
		$("input[name='pictureName']").each( 
			function (){
				var filename = $(this).val();
				//alert(filename);
				var id = filename.substring(0,17);
				if(filename == 'null'){
					//alert("1111"+filename);
					//$('#'+id).attr("src","/defaultroot/clientview/images/user3.png");
				}else{
					//alert("2222--------->"+filename);
					$.ajax({
						type : 'post',
						url : '<%=rootPath%>/download/downloadImg.controller',
						dataType : 'text',
						data : {"fileName":filename,"name":filename,"path":"html"},
						success : function(data){
							$('#'+id).attr("width","100%");
							$('#'+id).attr("height","100%");
							$('#'+id).attr("src","<%=rootPath%>"+data);
						},
						error : function (xhr,type){
							//alert('数据查询异常！');
						}
					});
				}
			}		
		);
	}
	
	//打开附件
	  function downFile(menuHtmlLink,menuFileLink,aId) {
	  		var path = 'information';
	  		if(aId == undefined){
	  			aId = menuHtmlLink.split('.')[0];
	  			path = 'html';
	  		}
	  		
	  			$.ajax({
					 type: 'post',
					 url: "<%=rootPath%>/download/getOpenFileUrl_New.controller",
					 dataType:'text',
					 data : {"fileName": menuHtmlLink,"name": menuFileLink,"path":path},
					 success: function(data){
					 	var jsonData = eval("("+data+")");
					 	clickSub(jsonData.url,$('#'+aId),menuHtmlLink,"information",jsonData.smartInUse,jsonData.isEncrypt,jsonData.tmpurl,jsonData.apptype);
					 },error: function(xhr, type){
						 //alert('数据查询异常！');
					 }
				});
	  		
		}




	//下拉加载数据
	$$(document).on('infinite', '#sectionScroll', function() {
		//alert("下滑加载开始");
		// 如果正在加载，则退出
		if (loading){ 
			return; 
		}
		loading = true;
		var postList = $$('#postList li').length;
		//alert(postList+",,,,,"+recordCount);
		setTimeout(function() {
			loading = false;
			if (postList >= recordCount) {
				// 加载完毕，则注销无限加载事件，以防不必要的加载
				myApp.detachInfiniteScroll($$('#sectionScroll'));
				// 删除加载提示符
				$$('.wh-load-md').hide();
				return;
			}
			if (recordCount - postList > 0) {
				//curpage = curpage + 1;
				loadNextPage();
			}
		}, 500);
	});


	//加载下一页内容
	function loadNextPage(){
		var $postList = $('#postList');
		if($postList.data('loadflag') == '1'){
			return;
		}
		$postList.data('loadflag','1');
		if(nomore){
			offset = parseInt(offset) + 1 + "";
			var nextPageUrl = "/defaultroot/post/pageInfo.controller?pageSize="+offset+"&postId=${postId}";
			$(".wh-load-md").css("display","block");
			$(".wh-load-tap").html("正在加载...");
			$.ajax({
				url : nextPageUrl,
				type : "post",
				success : function(data){
					//alert(data);
					nomore = $($(data)[25]).val();
					offset = $($(data)[23]).val();
					//alert(nomore+",,,,,,,,,,"+offset);
					if(nomore){
						$(".wh-load-tap").html("上滑加载更多");
						$(".wh-load-box").css("display","block");
						$(".wh-load-md").css("display","none");
					}else{
						$(".wh-load-box").css("display","none");
					}
					$("#postList").append($("li",data));
					//$content.data('loadflag','0');
				},
				error:function(data){
					$(".wh-load-box").html("加载失败！");
				}
			});
		}
	}


	//回复页面跳转
	function goReply(postId,forumFloor){
		window.location = "/defaultroot/post/reply.controller?forumFloor="+forumFloor+"&postId=${postId}";
	}

	//引用
	function toReply(id){
		$("#"+id).submit();
	}



	

	

</script>
