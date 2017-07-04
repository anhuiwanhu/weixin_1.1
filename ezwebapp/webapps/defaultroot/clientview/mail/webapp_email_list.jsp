<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/weixin/common/taglibs.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>我的邮箱</title>
  <link rel="stylesheet" href="/defaultroot/clientview/template/css/template.style.ios.min.css" />
  <link rel="stylesheet" href="/defaultroot/clientview/template/css/template.webapp-style.min.css" />
</head>

<body class="grey-bg">
  <div class="views">
    <div class="view view-main">
      <div class="pages">
        <div class="page" data-page="page-webapp-mail">
          <section id="sectionScroll" class="section-mail infinite-scroll wh-section wh-section-bottomfixed pull-to-refresh-content">
            <div class="pull-to-refresh-layer">
              <div class="preloader"></div>
              <div class="pull-to-refresh-arrow"></div>
            </div>
			<div class="mail-todo">
              <div class="app-tabheader-line clearfix">
                <!-- 关联到第一个tab, 默认激活 -->
                <div class="clearfix">
                  <a href="#tab-mail-todo1" class="tab-link active" id="receiveBox" onclick="receiveBox();">
                    <span>收件箱<em id="newMailCount"></em></span>
                  </a>
                  <a href="#tab-mail-todo2" class="tab-link" id="sendBox" onclick="sendBox();">
                    <span>发件箱</span>
                  </a>
                </div>
              </div>
              <div class="tabs">
                
				<!-- Tab 1, 默认激活 收件箱-->
                <div id="tab-mail-todo1" class="tab active">
                  <div class="mail-todo-file">
                    <header id="searchBar" class="wh-search">
                      <div class="wh-container">
                        <div class="wh-search-input">
                          <form method="post" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar">
                            <label class="fa fa-search" for="search"></label>
                            <input id="searchTitleR" type="search" class="nomal-search" onfocus="showReceive();" placeholder="请输入邮件标题查询" />
                            <i id="rch" class="fa fa-times-circle-o"  style="display:none;"  onclick="removeSearchInputR()"></i>
							<p class="fabu"><a href="javascript:write();" class="button button-round active"><i class="fa fa-pencil-square-o"></i>写信</a></p>
                          </form>
                        </div>
                      </div>
                    </header>
                    <div class="todo-list">
                      <div class="list-block">
                        <ul id="receive">
							
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>
                
				<!-- Tab 2   发件箱-->
                <div id="tab-mail-todo2" class="tab">
                  <div class="mail-todo-file">
                    <header id="searchBar" class="wh-search">
                      <div class="wh-container">
                        <div class="wh-search-input">
                          <form method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar">
                            <label class="fa fa-search" for="search"></label>
                            <input id="searchTitleS" type="search" class="nomal-search" onfocus="showSend();" placeholder="请输入邮件标题查询" />
                            <i id="sch" class="fa fa-times-circle-o"  style="display:none;"  onclick="removeSearchInputS()"></i>
							<p class="fabu"><a href="javascript:write()" class="button button-round active"><i class="fa fa-pencil-square-o"></i>写信</a></p>
                          </form>
                        </div>
                      </div>
                    </header>
                    <div class="todo-list">
                      <div class="list-block">
                        <ul id="send">
							
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
			 <aside class="wh-load-box" style="display: block">
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
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
  <script type="text/javascript" src="/defaultroot/scripts/jquery-1.8.0.min.js"></script>
  <script type="text/javascript">
	var myApp = new Framework7();
	var $$ = Dom7;

	//添加视图
	var mainView = myApp.addView('.view');
	
	

	/***************进入页面就加载收件箱列表数据*****************/
	$(function(){
		//alert(1111111);
		if(sessionStorage.getItem("detailType") == "send"){
			var url = "sendBox.controller?curpage=1";
			loadSendBox(url);
			
		}else{
			var url = "receiveBox.controller?curpage=1";
			loadReceiveBox(url);
			loadnewMailCount();
		}
	});

	
	 //是否有下一页 全局变量（收件箱）
     var nomore1 = '';
     //是否有下一页 全局变量（发件箱）
     var nomore2 = '';
     //当前页页数 全局变量(收件箱)
     var curPage1 = '';
	 //当前页页数 全局变量(发件箱)
     var curPage2 = '';
	 //加载标志
	 var loading = false;
	 //总数目(收件箱)
	 var count1;
	 //总数目(发件箱)
	 var count2;
	 //收件与发件标志
	 var detailType = '';
	/********加载收件箱的列表数据*************/
	function loadReceiveBox(url,loadFlag){
		//发件箱选择
		$('#sendBox').removeClass('tab-link active');
		$$('#sendBox').addClass('tab-link');
		//收件箱选择
		$('#receiveBox').removeClass('tab-link');
		$('#receiveBox').addClass('tab-link active');
		
		var searchTitle = $("#searchTitleR").val();
    	if(searchTitle != ""){
    		url = url + "&subject=" + encodeURI(encodeURI(searchTitle));
    	}
		$$.ajax({
			type: "post",
			url: url,
			dataType: "text",
			success: function(data) {
				loading = false;
				//用于打开详情页时区分收件、发件
				detailType = "receive";
				sessionStorage.setItem("detailType",detailType);
				//让发件箱显示关闭
				$$('#tab-mail-todo2').removeClass('tab active');
				$$('#tab-mail-todo2').addClass('tab');
				//让收件箱的列表div显示。
				$$('#tab-mail-todo1').removeClass('tab');
				$$('#tab-mail-todo1').addClass('tab active');
				
				if(!data){
        			return;
        		}
        		var jsonData = eval("("+data+")");
        		if(!jsonData){
        			return;
        		}
        		if(jsonData.data0.length < 15){
		      		$$('.wh-load-md').hide();
		      		// 加载完毕，则注销无限加载事件，以防不必要的加载
				    //myApp.detachInfiniteScroll($$('#sectionScroll'));
		      	}
		      	nomore1 = jsonData.data1;
		      	//alert(nomore1);
        		curPage1 = jsonData.data2;
				//alert(curPage);
				count1 = jsonData.data3;
				//alert(count);
				
				var result = '';
				if(jsonData.data0.length > 0){
					for(var i = 0; i<jsonData.data0.length; i++){
						var li = '';
						var fj = '';
						var j = '';
						var mailId = jsonData.data0[i].mailid;
						var mailUserId = jsonData.data0[i].mailuserid;
						var notRead = jsonData.data0[i].NotRead;
						var mailpostername = jsonData.data0[i].mailpostername;
						var mailsubject = jsonData.data0[i].mailsubject;
						var mailPostTime = jsonData.data0[i].mailposttime.substring(0,16);
						var accessorySize = jsonData.data0[i].accessorySize;
						if(notRead == '1'){
							li = "<li class='swipeout mail-noread'>";
							j = "<i class='fa fa-envelope-b'></i>";
						}else{
							li = "<li class='swipeout mail-read'>";
							j = "<i class='fa fa-envelope-a'></i>";
						}
						if(accessorySize > 0){
							fj = "<em><i class='fa fa-fujian'></i></em>";
                		}else{
                			fj = '';
                		}

						result += li;
						result += "<a href='javascript:void(0);' class='swipeout-content item-content' onclick='openDetail("+mailId+","+mailUserId+",\""+detailType+"\","+accessorySize+")'><div>";
						result += "<strong class='forum-avatar'>"+j;
						result += "<span class='mail-from'>"+mailpostername+"</span></strong>";
						result += "<p>"+fj+"<span>"+mailsubject+"</span><i class='mail-time'>("+mailPostTime+")</i></p></div>";
						result += "<div class='item-after'><i class='fa fa-angle-right'></i></div></a>";
						result += "<div class='swipeout-actions-right'><a href='javascript:deleteMail("+mailUserId+")' class='swipeout-delete'>删除</a></div>";
						result += "</li>";
						
					}
					if(loadFlag == '1'){
						$$('#receive').append(result);
	                }else{
		                $$('#receive').html(result);
	                }
				}else{
					$$('.wh-load-md').hide();
		      		$$('#receive').html('<li class="swipeout" style="padding:1rem;">系统未查询到相关记录！</li>');
				}
			},
			error: function(xhr, type){
				$$('#receive').append('<li class="swipeout" style="padding:1rem;">数据查询异常！</li>');
		        $$('.wh-load-tap').hide();
		        $$('.wh-load-md').hide();
            }
		});
	}


	//加载未读数
	function loadnewMailCount(){
		$$.ajax({
			type: "post",
			url: 'loadnewMailCount.controller',
			dataType: "text",
			success: function(data) {
				if(!data){
    				return;
    			}
    			var jsonData = eval("("+data+")");
    			if(!jsonData){
    				return;
    			}
    			var newMailCount = jsonData.data0;
    			//alert(newMailCount);
    			$('#newMailCount').html(newMailCount);
			},
			error: function(xhr, type){
				
        	}
    	});
	}

	

	/****************加载发件箱数据********************/
	function loadSendBox(url,loadFlag){

		//收件箱选择
		$('#receiveBox').removeClass('tab-link active');
		$('#receiveBox').addClass('tab-link');
		//发件箱选择
		$('#sendBox').removeClass('tab-link');
		$('#sendBox').addClass('tab-link active');
		
		var searchTitle = $("#searchTitleS").val();
    	if(searchTitle != ""){
    		url = url + "&subject=" + encodeURI(encodeURI(searchTitle));
    	}
		$$.ajax({
			type: "post",
			url: url,
			dataType: "text",
			success: function(data) {
				loading = false;
				//用于打开详情页时区分收件、发件
				detailType = "send";
				sessionStorage.setItem("detailType",detailType);
				//让收件箱的列表div显示关闭。
				$$('#tab-mail-todo1').removeClass('tab active');
				$$('#tab-mail-todo1').addClass('tab');
				//发件箱开启。
				$$('#tab-mail-todo2').removeClass('tab');
				$$('#tab-mail-todo2').addClass('tab active');
				
				if(!data){
        			return;
        		}
        		var jsonData = eval("("+data+")");
        		if(!jsonData){
        			return;
        		}
				
        		if(jsonData.data0.length < 15){
		      		$$('.wh-load-md').hide();
		      		// 加载完毕，则注销无限加载事件，以防不必要的加载
				    //myApp.detachInfiniteScroll($$('#sectionScroll'));
		      	}
		      	nomore2 = jsonData.data1;
        		curPage2 = jsonData.data2;
				count2 = jsonData.data3;
				//alert(count2);
				
				var result = '';
				if(jsonData.data0.length > 0){
					for(var i = 0; i < jsonData.data0.length; i++){
						var mailId = jsonData.data0[i].mailid;
						var mailUserId = jsonData.data0[i].mailuserid;
						var mailsubject = jsonData.data0[i].mailsubject;
						var mailposttime = jsonData.data0[i].mailposttime.substring(0,16);
						var mailto = jsonData.data0[i].mailto;
						var accessorySize = jsonData.data0[i].accessorySize;
						var mailtoStr ='';

						if(mailto.length > 15){
							mailtoStr = mailto.substring(0,15);
							mailtoStr = mailtoStr + "...等";
						}else{
							mailtoStr = mailto;
						}
						var fj = '';
						if(accessorySize > 0){
							fj = "<em><i class='fa fa-fujian'></i></em>";
                		}else{
                			fj = '';
                		}
						result += "<li class='swipeout mail-send'>";
						result += "<a href='javascript:void(0);' class='swipeout-content item-content' onclick='openDetail("+mailId+","+mailUserId+",\""+detailType+"\","+accessorySize+")'>";
						result += "<div><p>"+fj+"<span>"+mailsubject+"</span><i style='font-size:0.8rem' class='mail-time'>("+mailposttime+")</i></p>";
						result += "<p class='send-state'><span class='mail-state'>已发送</span><span class='send-dom'>"+mailtoStr+"</span></p></div>";
						result += "<div class='item-after'><i class='fa fa-angle-right'></i></div></a>";
						result += "<div class='swipeout-actions-right'><a href='javascript:deleteMail("+mailUserId+")' class='swipeout-delete'>删除</a></div></li>";
					}
					if(loadFlag == '1'){
						$$('#send').append(result);
	                }else{
		                $$('#send').html(result);
	                }
				}else{
		      		$('#send').html('<li class="swipeout" style="padding:1rem;">系统未查询到相关记录！</li>');
				}
			},
			error: function(xhr, type){
				$$('#send').append('<li class="swipeout" style="padding:1rem;">数据查询异常！</li>');
		        $$('.wh-load-tap').hide();
		        $$('.wh-load-md').hide();
            }
        });
	}


	//删除邮件
	function deleteMail(mailUserId){
		myApp.confirm('您确定要删除吗？', 
			function () {
				//alert("mailUserId---->"+mailUserId);
				var url = "deleteMail.controller?mailuserids="+mailUserId;
				//alert("url---------->"+url);
				$.ajax({
					type: "post",
					url: url,
					dataType: "text",
					success: function(data) {
						//alert("进来了。。");
						if(!data){
        					return;
        				}
        				var jsonData = eval("("+data+")");
        				if(!jsonData){
        					return;
        				}
						//alert(jsonData.data0);
						if(jsonData.data0 == 1){
							myApp.alert('删除成功！');
							if(detailType == "receive"){
								var url = "receiveBox.controller?curpage=1";
								loadReceiveBox(url);
							}else if(detailType == "send"){
								var url = "sendBox.controller?curpage=1";
								loadSendBox(url);
							}
						}else{
							myApp.alert('删除失败！');
						}
					},
					error: function(xhr, type){
						myApp.alert('数据查询异常！');
					}
				});
			},
			function () {
				//myApp.alert('你点了取消按钮');
			}
		);
	}


	
	//点击收件箱
	function receiveBox(){
		
		var url = "receiveBox.controller?curpage=1";
		loadReceiveBox(url);
	}

	//点击发件箱
	function sendBox(){

		var url = "sendBox.controller?curpage=1";
		loadSendBox(url);
	}
	

	/// 搜索焦点时
    function showReceive(){
    	$$('#rch').show();
    }
	//清除搜索
	function removeSearchInputR(){ 
    	$$('#rch').hide();
		$('#searchTitleR').val('');

		searchReceiveMail();
	}

	// 搜索焦点时
    function showSend(){
    	$$('#sch').show();
    }
	//清除搜索
	function removeSearchInputS(){ 
    	$$('#sch').hide();
		$('#searchTitleS').val('');
		
		searchSendMail();
	}

	//绑定查询框回车事件
    $(document).keydown(function(event){
		if(detailType == "receive"){//收件箱查询框
			var searchTitle = $('#searchTitleR').val();
			if(event.keyCode == 13){ //绑定回车
				if((searchTitle.length > 0 && !(searchTitle.trim())) || /[@#\$%\^&\*]+/g.test(searchTitle)){
					myApp.alert('请正确填写搜索邮件标题！');
					return false;
				}
				if((searchTitle.length > 0 && !(searchTitle.trim())) || /[@#\$%\^&\*]+/g.test(searchTitle)){
					myApp.alert('请正确填写搜索邮件标题！');
					return false;
				}
				searchReceiveMail();
			} 
		}else if(detailType == "send"){//发件箱查询框
			var searchTitle = $('#searchTitleS').val();
			if(event.keyCode == 13){ //绑定回车
				if((searchTitle.length > 0 && !(searchTitle.trim())) || /[@#\$%\^&\*]+/g.test(searchTitle)){
					myApp.alert('请正确填写搜索邮件标题！');
					return false;
				}
				if((searchTitle.length > 0 && !(searchTitle.trim())) || /[@#\$%\^&\*]+/g.test(searchTitle)){
					myApp.alert('请正确填写搜索邮件标题！');
					return false;
				}
				searchSendMail();
			} 
		}
	});

	//查询收信箱
    function searchReceiveMail(){
		var url = "receiveBox.controller?curpage=1";
		loadReceiveBox(url);
    }
	//查询发件箱
	function searchSendMail(){
		var url = "sendBox.controller?curpage=1";
		loadSendBox(url);
	}

	var openFlag = 'yes';
	//打开邮件的详细信息
	function openDetail(mailId,mailUserId,detailType,accessorySize){
		//alert(accessorySize);
		window.location = 'receiveMailDetail.controller?mailid='+mailId+"&mailuserid="+mailUserId+"&detailType="+detailType+"&accessorySize="+accessorySize+"&openFlag="+openFlag;
	}

	
	//写邮件
	function write(){
		window.location = "new.controller?openType=write&openFlag="+openFlag;
	}


	
	$$(document).on('infinite', '#sectionScroll', function() {
		    // 如果正在加载，则退出
		    if (loading){
				return
			};
		    loading = true;
			//alert("detailType------>"+detailType);
			if(detailType == "receive"){
				var lastIndex = $$('#receive li').length;
				setTimeout(function() {
					
					if (lastIndex >= count1) {
						// 加载完毕，则注销无限加载事件，以防不必要的加载
				        //myApp.detachInfiniteScroll($$('#sectionScroll'));
				        // 删除加载提示符
				        $$('.wh-load-md').hide();
				        return;
				    }
				    if (count1 - lastIndex > 0) {
						//myApp.attachInfiniteScroll($$('#sectionScroll'));
						var url = "receiveBox.controller?curpage="+curPage1;
						$$('.wh-load-md').show();
				        loadReceiveBox(url,'1');
				        return;
				    }
				}, 500);
			}else if(detailType == "send"){
				var lastIndex = $$('#send li').length;
				//alert("lastIndex---》"+lastIndex);
				//alert("count2---------->"+count2);
				setTimeout(function() {
					
					if (lastIndex >= count2) {
						// 加载完毕，则注销无限加载事件，以防不必要的加载
				        //myApp.detachInfiniteScroll($$('#sectionScroll'));
				        // 删除加载提示符
				        $$('.wh-load-md').hide();
				        return;
				    }
				    if (count2 - lastIndex > 0) {
						//alert("发件箱的下一页----->"+curPage2);
						//myApp.attachInfiniteScroll($$('#sectionScroll'));
						var url = "sendBox.controller?curpage="+curPage2;
						$$('.wh-load-md').show();
				        loadSendBox(url,'1');
				        return;
				    }
				}, 500);
			}
	  });


	// 下拉刷新页面
	var ptrContent = $$('.pull-to-refresh-content');
	// 添加'refresh'监听器
	ptrContent.on('refresh', function(e) {
  		// 模拟2s的加载过程
		setTimeout(function() {
    		if(detailType == "receive"){
    			window.location = 'mailBox.controller';
			}else if(detailType == "send"){
				var url = "sendBox.controller?curpage=1";
				loadSendBox(url);
			}
			myApp.pullToRefreshDone();
		}, 1000);
	});



  </script>
</body>
