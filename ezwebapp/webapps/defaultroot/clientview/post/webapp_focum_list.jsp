<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>论坛</title>
  <link rel="stylesheet" href="/defaultroot/clientview/template/css/template.style.ios.min.css" />
  <link rel="stylesheet" href="/defaultroot/clientview/template/css/template.webapp-style.min.css" />
</head>

<body class="grey-bg">
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page" data-page="page-webapp-focum">
          <section class="section-focum infinite-scroll wh-section show wh-section-bottomfixed pull-to-refresh-content" id="sectionScroll" data-ptr-distance="40">
			
			<div class="pull-to-refresh-layer">
              <div class="preloader"></div>
              <div class="pull-to-refresh-arrow"></div>
            </div>
			
			

			<header id="searchBar" class="wh-search">
				<div class="wh-container">
					<div class="wh-search-input">
						<form method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar">
							<label class="fa fa-search" for="search"></label>
							<input id="searchTitle" type="search" class="nomal-search" onfocus="showCH();" placeholder="请输入帖子标题查询" style="color:#000;font-weight: bold;"/>
							<i class="fa fa-times-circle-o" style="display:none;"  onclick="removeSearchInput()"></i>
							<p class="fabu"><a href="javascript:newFocum();" class="button button-round active"><i class="fa fa-pencil-square-o"></i>发布</a></p>
                        </form>
                    </div>
                </div>
            </header>

            <div class="focum-list">
			<ul id="postList">
             <c:choose>
             <c:when test="${not empty docXml}">
             	<x:parse xml="${docXml}" var="doc"/>				
				<c:set var="recordCount"><x:out select="$doc//recordCount/text()" /></c:set>
				<c:if test="${recordCount==0}">
					<li class="swipeout" style="background-color: #fff;font-size: 17px;margin-top: .5rem;text-indent: .2rem;padding:1rem;">系统未查询到相关记录！</li>
				</c:if>
			
             <x:forEach select="$doc//list" var="n"  varStatus="status">
             <li >
             	<c:set var="time" ><x:out select="$n/forumIssueTime/text()"/></c:set>
				<c:if test="${fn:indexOf(time,'.') > 0}">
					<c:set var="time" >${fn:substringBefore(time,".")}</c:set>
				</c:if>
				<c:set var="forumKits" ><x:out select="$n/forumKits/text()"/></c:set>
				<c:set var="forumRevertNum" ><x:out select="$n/forumRevertNum/text()"/></c:set>
				<c:set var="forumTitle" ><x:out select="$n/forumTitle/text()"/></c:set>
				<c:set var="postId" ><x:out select="$n/id/text()"/></c:set>
				<c:set var="classParentName" ><x:out select="$n/classParentName/text()"/></c:set>
				<c:set var="forumAuthor" ><x:out select="$n/forumAuthor/text()"/></c:set>
				<c:set var="curClassId" ><x:out select="$n/classid/text()"/></c:set>
				<c:set var="empLivingPhoto" ><x:out select="$n/empLivingPhoto/text()"/></c:set>
				<c:set var="anonymous" ><x:out select="$n/anonymous/text()"/></c:set>
				<c:set var="nickName" ><x:out select="$n/nickName/text()"/></c:set>
				<c:set var="contentSummary" ><x:out select="$n/contentSummary/text()"/></c:set>
              	<div class="webapp-focum">
                	<div class="focum-title">
						<input type="hidden" name="imgName" value="${empLivingPhoto}" />
						<c:choose>
  							<c:when test="${empLivingPhoto == 'null' }">
  								<img id="${fn:substring(empLivingPhoto,0,25)}" src="/defaultroot/clientview/images/user3.png" />
  							</c:when>
							<c:when test="${empLivingPhoto == null }">
  								<img id="${fn:substring(empLivingPhoto,0,25)}" src="/defaultroot/clientview/images/user2.png" />
  							</c:when>
  							<c:otherwise>
  								<img id="${fn:substring(empLivingPhoto,0,25)}" src="/defaultroot/upload/peopleinfo/${empLivingPhoto}" />
  							</c:otherwise>
  						</c:choose>
                  		<div>
                    		<span>
                    			<c:choose>
                    				<c:when test="${anonymous == '1'}">
                    					匿名
                    				</c:when>
                    				<c:when test="${anonymous == '2'}">
                    					${nickName }
                    				</c:when>
                    				<c:otherwise>
                    					${forumAuthor}
                    				</c:otherwise>
                    			</c:choose>
                    		</span>
                    		<em>${time }</em>
							<font style="width: 7rem;height: 1.3rem;text-overflow: ellipsis;overflow: hidden;word-break: keep-all;word-wrap: normal;white-space: nowrap;">${classParentName }</font>
                  		</div>
                	</div>
					<a href="javascript:void(0);" onclick="openForum('${postId}','${curClassId}');">
                	<div class="focum-artical">
                  		
                  		<strong>${forumTitle }</strong>
                  		<p>${contentSummary }</p>
                	</div>
					</a>
                	<div class="focum-bottom">
                  		<div><span style="color:#3eaeff">${forumKits }</span><a href="javascript:void(0);">点击</a></div>
                  		<div><span style="color:#3eaeff">${forumRevertNum }</span><a href="javascript:void(0);">回复</a></div>
                  		<!-- <a href="javascript:goReply('${postId}','1');" class="focum-btn">回复</a> -->
                	</div>
              	</div>
              </li>
              </x:forEach>
			  </c:when>
              <c:otherwise>
			  	<li class="swipeout" style="background-color: #fff;font-size: 17px;margin-top: .5rem;text-indent: .2rem;">数据查询异常！</li>
			  </c:otherwise>
			</c:choose>
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
          
          
          
          
          
          <!-- 选择板块 -->
          <section class="section-focum wh-section wh-section-bottomfixed">
			<!-- 顶部发布按钮开始 
            <div class="focum-header clearfix">
              <div class="clearfix">
                <a href="javascript:newFocum();" class="button button-round active"><i class="fa fa-pencil-square-o"></i>&nbsp;&nbsp;发布</a>
              </div>
            </div>
            顶部发布按钮结束 -->
            <div class="webapp-focum-view">
              <table id="table" style="border-collapse:collapse; border-spacing:0; ">
                <tbody id="tbody1">
					
				</tbody>
              </table>
            </div>
          </section>
          <footer class="wh-footer wh-footer-forum">
            <div class="wh-wrapper">
              <div class="wh-container">
                <div class="footer-focum wh-footer-btn row no-gutter">
                  <a href="##" class="fbtn-matter col-50">
                    <div><i class="fa fa-forum-home"></i></div><span>论坛门户</span></a>
                  <a href="##" class="fbtn-cancle col-50">
                    <div><i class="fa fa-view-modal"></i></div><span>板块视图</span></a>
                </div>
              </div>
            </div>
          </footer>
        </div>
      </div>
    </div>
  </div>
</body>
<input type="hidden" value="${offset}" id="offset"/>
<input type="hidden" value="${nomore}" id="nomore"/>
</html>
	<script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
	<script type="text/javascript" src="/defaultroot/scripts/jquery-1.8.0.min.js"></script>
  	<script type="text/javascript">
  		var myApp = new Framework7();
  		var $$ = Dom7;

		var nomore = "${nomore}";
		var curPage = "${curPage}";
		//var offset = "";
		//var recordCount = '${recordCount}';
		//var curpage = 1;
		
		
		$(function(){
			nomore = $("#nomore").val();
			offset = $("#offset").val();
			if(nomore){
				$(".wh-load-box").css("display","block");
			}else{
				$(".wh-load-box").css("display","none");
			}
		});

		

  		$$(".footer-focum>a").click(function(){
    		var _this = $$(this);
    		var index = _this.index();

    		$$(".footer-focum>a").removeClass("fbtn-matter").addClass("fbtn-cancle");
    		_this.removeClass("fbtn-cancle").addClass("fbtn-matter");
    		$$(".section-focum").hide().eq(index).show();
    		if(index == 1){
    			loadSelectColumn();
    		}
  		});
  
  		//加载板块试图
  		function loadSelectColumn(){
  			var url = "select.controller";
  			$.ajax({
				url : url,
				type : "post",
				dataType: "text",
				success : function(data){
					if(!data){
        				return;
        			}
        			var jsonData = eval("("+data+")");
        			if(!jsonData){
        				return;
        			}
        			var dataList = jsonData.data0;
        			var postList = new Array();
        			for(var i = 0; i < dataList.length; i++){
        				var haveRightFlag = dataList[i].haveRightFlag;
        				if(haveRightFlag == '1' ){
        					postList.push(dataList[i]);
            			}
            		}
            		//alert(postList.length);
        			var result = '';
					//alert(jsonData.data0[0].className);
					var iconClassArray = ['c1','c2','c3','c4','c5','c6','c7','c8'];
        			if(jsonData.data0.length > 0){
        				for(var i = 0; i < postList.length; i++){
							//alert(i);
							var random = Math.random();
							var index = Math.round(random * (iconClassArray.length-1));
							var id = postList[i].id;//栏目ID
        					var className = postList[i].className;//栏目名称
							var haveRightFlag = postList[i].haveRightFlag;//0：不能查看或发帖 1:能查看或发帖（view时候查看 add时候为发帖） 
							var classHasJunior = postList[i].classHasJunior;//是否有下级栏目【0：没有；1：有】
							var hasForumCount = postList[i].hasForumCount;//该栏目下帖子的数目
							//var classHasJunior = jsonData.data0[i].classHasJunior;//是否有下级栏目
							
							var a = "";
							var em = "";
							if(haveRightFlag == '1' || classHasJunior == '1'){
								if(hasForumCount != '0' || classHasJunior != '0'){
									a = "<a href='javascript:openForumSection("+id+",\""+className+"\",\""+haveRightFlag+"\");'>";
								}else if(hasForumCount == '0' && classHasJunior == '0'){
									a = "";
								}
							
								if(hasForumCount == '0'){
									em = "<em></em>";
								}else{
									em = "<em>"+hasForumCount+"&nbsp;条主题帖</em>";
								}
							}
							i = i+1;
							if(i < postList.length){
								var random1 = Math.random();
								var index1 = Math.round(random * (iconClassArray.length-1));
								var id1 = postList[i].id;//栏目ID
        						var className1 = postList[i].className;//栏目名称
								var haveRightFlag1 = postList[i].haveRightFlag;//0：不能查看或发帖 1:能查看或发帖（view时候查看 add时候为发帖） 
								var classHasJunior1 = postList[i].classHasJunior;//是否有下级栏目【0：没有；1：有】
								var hasForumCount1 = postList[i].hasForumCount;//该栏目下帖子的数目

							
								var a1 = "";
								var em1 = "";
								if(haveRightFlag1 == '1' || classHasJunior1 == '1'){
									if(hasForumCount1 != '0' || classHasJunior1 != '0'){
									a1 = "<a href='javascript:openForumSection("+id1+",\""+className1+"\",\""+haveRightFlag1+"\");'>";
									}else if(hasForumCount1 == '0' && classHasJunior1 == '0'){
										a1 = "";
									}
							
									if(hasForumCount1 == '0'){
										em1 = "<em></em>";
									}else{
										em1 = "<em>"+hasForumCount1+"&nbsp;条主题帖</em>";
									}
								}
							}
							
							result += "<tr><td><div>"+a+"<div class="+iconClassArray[index]+"><i class='fa fa-forum'></i></div>";
							result += "<div><span>"+className+"</span>"+em+"</div></a></div></td>";
							if(i < postList.length){
								result += "<td><div>"+a1+"<div class="+iconClassArray[index1]+"><i class='fa fa-forum'></i></div>";
								result += "<div><span>"+className1+"</span>"+em1+"</div></a></div></td></tr>";
							}
        				}
        				$("#tbody1").html(result);
        			}else{
        				$("#tbody1").html('<tr>未获取到数据</tr>');
        			}
				},
				error:function(data){
					$(".wh-load-box").html("加载失败");
				}
			});
  		}


  		function showCH(){
			$('.fa-times-circle-o').show();
		}
		function removeSearchInput(){
			$$('.fa-times-circle-o').hide();
			$('#searchTitle').val('');
			var searchTitle = $('#searchTitle').val(); 
			var url = "/defaultroot/post/index.controller?queryTitle="+searchTitle;
			window.location = url;
		}
		
		//下滑加载 
		var loading = false;
  		$$(document).on('infinite', '#sectionScroll', function() {
			// 如果正在加载，则退出
			if (loading){ 
				return; 
			}
			loading = true;
			setTimeout(function() {
				loading = false;
				if(nomore){
					$$('.wh-load-md').show();
					loadNextPage();
				}else{
					$$('.wh-load-md').hide();
				    return;
				}
			}, 500);
		});
  		


  		
	var loadflag = '0';
  	//加载下一页内容
	function loadNextPage(setFlag){
		//alert(curPage);
		if(loadflag == '1'){
			return;
		}
		loadflag = '1';
		//标题
		var searchTitle = $('#searchTitle').val();
		//分页查询的链接
		var url = '/defaultroot/post/pagelist.controller?curPage='+curPage;
		//加载提示语
		//myApp.showPreloader('正在加载中...');
		$.ajax({
			type: 'post',
			url: url,
			dataType: 'text',
			data : {'queryTitle' : searchTitle},
	        success: function(data){
					//alert("1111111111111");
					var jsonData = eval("("+data+")");
					//alert("222222222222222");
					var postList = jsonData.data0;
					
					nomore = jsonData.data1;
					//alert("nomore------->"+nomore);
					curPage = jsonData.data2;
					//alert("curPage------->"+curPage);
					var result = '';
					if(postList){
						var empLivingPhoto = '';
						for(var i = 0; i < postList.length; i++){
							if(postList[i].empLivingPhoto && 'null' != postList[i].empLivingPhoto){
								var arr = postList[i].empLivingPhoto.split('.');
						    	var fileName = postList[i].empLivingPhoto;
						    	var id = arr[0];
						    	loadImg2(fileName,id);
								empLivingPhoto = "<img name='"+id+"'>";
						    }else{
						    	empLivingPhoto = "<img src='/defaultroot/clientview/images/user3.png'/>";
						    }
							var userName = '';
							var anonymous = postList[i].anonymous;
							var nickName = postList[i].nickName;
							if(anonymous == '1'){
								userName = '匿名';
							}else if(anonymous == '2'){
								userName = nickName;
							}else{
								userName = postList[i].forumAuthor;
							}
						    
							result += "<li><div class='webapp-focum'><div class='focum-title'>"+empLivingPhoto;
							result += "<div><span>"+userName+"</span><em>"+postList[i].forumIssueTime+"</em><font>"+postList[i].classParentName+"</font></div></div>";
							result += "<a href='javascript:void(0);' onclick='openForum(\""+postList[i].id+"\",\""+postList[i].classid+"\");'>";
							result += "<div class='focum-artical'><strong>"+postList[i].forumTitle+"</strong><p>"+postList[i].contentSummary+"</p></div></a>";
						
							result += "<div class='focum-bottom'>";
							result += "<div><span style='color:#3eaeff'>"+postList[i].forumKits+"</span>点击</div>";
							result += "<div><span style='color:#3eaeff'>"+postList[i].forumRevertNum+"</span>回复</div>";
							result += "<a href='javascript:goReply(\""+postList[i].id+"\",\""+1+"\");' class='focum-btn'>回复</div></div></lis>";
						}
					}
					if(!result){
						result = '<li class="swipeout" style="background-color: #fff;font-size: 17px;margin-top: .5rem;text-indent: .2rem;padding:1rem;">系统未查询到相关记录！</li>';
					}
					if(setFlag == '1'){
						$('#postList').html(result);
					}else{
						$('#postList').append(result);
					}
					if(nomore){
						$(".wh-load-tap").html("上滑加载更多");
						$(".wh-load-box").css("display","block");
						$(".wh-load-md").css("display","none");
					}else{
						$(".wh-load-box").css("display","none");
					}
				
				loadflag = '0';
				//myApp.hidePreloader();
			},
			error: function(xhr, type){
				nomore = '';
	            $(".wh-load-tap").html("加载失败！");
			}
		});
	}



		//打开指定板块的帖子列表
		function openForumSection(classId, className, haveRightFlag) {
			window.location = "/defaultroot/post/list.controller?classId=" + classId + "&className=" + className + "&haveRightFlag=" + haveRightFlag;
		}

		
		//打开帖子详细页面
		function openForum(postId,curClassId){
			window.location = "/defaultroot/post/info.controller?postId="+postId+"&curClassId="+curClassId;
		}


		//回帖页面跳转
		function goReply(postId,forumFloor){
			window.location = "/defaultroot/post/reply.controller?forumFloor="+forumFloor+"&postId="+postId;
		}

		
		//发帖
		function newFocum(){
			var url = "/defaultroot/post/new.controller";
			window.location = url;
		}



		// 下拉刷新页面
		var ptrContent = $$('.pull-to-refresh-content');
		// 添加'refresh'监听器
		ptrContent.on('refresh', function(e) {
  			// 模拟2s的加载过程
			setTimeout(function() {
				var url = "/defaultroot/post/index.controller";
    			window.location = url;
				myApp.pullToRefreshDone();
			}, 1000);
		});


		//搜索框进行搜索查询
		$(document).keydown(function(event){
			var searchTitle = $('#searchTitle').val();
			if(event.keyCode == 13){ //绑定回车
				if((searchTitle.length > 0 && !(searchTitle.trim())) || /[@#\$%\^&\*]+/g.test(searchTitle)){
					alert('请正确填写搜索问题标题！');
					return;
				}
				if((searchTitle.length > 0 && !(searchTitle.trim())) || /[@#\$%\^&\*]+/g.test(searchTitle)){
					alert('请正确填写搜索问题标题！');
					return;
				}
				//var url = "/defaultroot/post/index.controller?queryTitle="+searchTitle;
				//window.location = url;
				curPage = '1';
				var setFlag = '1';//查询标识
				loadNextPage(setFlag);
			} 
		});







	//加载人物图像
		$(function(){
			loadImg();
		});

		//页面开始是xml返回的数据
		function loadImg(){
			$("input[name='imgName']").each(
				function (){
					var filename = $(this).val();
					var id = filename.substring(0,25);
					if(filename == 'null'){
						//alert("1111"+filename);
						//$('#'+id).attr("src","/defaultroot/clientview/images/user3.png");
					}else{
						//alert("2222--------->"+filename);
						$.ajax({
							type : 'post',
							url : '<%=rootPath%>/download/downloadImg.controller',
							dataType : 'text',
							data : {"fileName":filename,"name":filename,"path":"peopleinfo"},
							success : function(data){
								//$('#'+id).attr("src","<%=rootPath%>"+data);
							},
							error : function (xhr,type){
								alert('数据查询异常！');
							}
						});
					}
				}
			);
		}

		//ajax返回的数据
		function loadImg2(filename,id){
			$.ajax({
				type : 'post',
				url : '/defaultroot/download/downloadImg.controller',
				dataType : 'text',
				data : {"fileName":filename,"name":filename,"path":"peopleinfo"},
				success : function(data){
					//alert(data);
					//$('#'+id).attr("src","/defaultroot/"+data);
					$('img[name='+id+']').attr("src","/defaultroot/"+data);
				},
				error : function (xhr,type){
					//alert('数据查询异常！');
				}
			});
		}

  </script>


