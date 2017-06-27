<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ include file="/clientview/common/headerInit.jsp" %>
<!DOCTYPE html>
<html>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>文件办理</title>
  <link rel="stylesheet" href="<%=rootPath%>/clientview/template/css/template.style.ios.min.css" />
  <link rel="stylesheet" href="<%=rootPath%>/clientview/template/css/template.webapp-style.min.css" />
</head>

<body class="grey-bg">
  <div class="views">
    <div class="view view-main">
      <div class="pages">
        <div class="page" data-page="page-webapp-step-start">
          <!-- 流程待办 -->
          <section id="sectionScroll" class="section-step wh-section infinite-scroll wh-section-bottomfixed show pull-to-refresh-content">
		    <div class="pull-to-refresh-layer">
              <div class="preloader"></div>
              <div class="pull-to-refresh-arrow"></div>
            </div>
            <div class="step-todo">
              <div class="app-tabheader-line clearfix">
                <!-- 关联到第一个tab, 默认激活 -->
                <div class="clearfix">
                  <a href="#tab-step-todo1" class="tab-link active" id="hrf0" onclick="change('0')">
                    <span>待办<em id="dealNum"></em></span>
                  </a>
                  <a href="#tab-step-todo2" class="tab-link " id="hrf1" onclick="change('1')">
                    <span>待阅<em id="readNum"></em></span>
                  </a>
                </div>
              </div>
              <div class="tabs">
                <!-- Tab 1, 默认激活 -->
                <div id="tab-step-todo1" class="tab active">
                  <div class="step-todo-file">
                    <header id="searchBar" class="wh-search">
                      <div class="wh-container">
                        <div class="wh-search-input">
                          <form method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar">
                            <label class="fa fa-search" for="search"></label>
                            <input id="searchDeal" type="search" class="nomal-search" placeholder="请输入流程标题查询" />
                            <a href="#" class="searchbar-cancel" onclick="removeSearch(this);loadDealFileList('/defaultroot/dealfile/getListData.controller','0');">取消</a>
                          </form>
                        </div>
                      </div>
                    </header>
                    <div class="todo-list">
                      <div class="list-block">
                        <ul id="dealul">
                         
                        </ul>
						<aside class="wh-load-box" style="display: block">
							 <div class="wh-load-tap">上滑加载更多</div>
							 <div class="wh-load-md" id="whDeal">
							 <span></span>
							 <span></span>
							 <span></span>
							 <span></span>
							 <span></span>
							 </div>
						</aside>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- Tab 2 -->
                <div id="tab-step-todo2" class="tab">
                  <div class="step-todo-file">
                    <header id="searchBar" class="wh-search">
                      <div class="wh-container">
                        <div class="wh-search-input">
                          <form method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar">
                            <label class="fa fa-search" for="search"></label>
                            <input id="searchRead" type="search" class="nomal-search" placeholder="请输入流程标题查询" />
                            <a href="#" class="searchbar-cancel" onclick="removeSearch(this);loadDealFileReadList('/defaultroot/dealfile/getListData.controller','0');">取消</a>
                          </form>
                        </div>
                      </div>
                    </header>
                    <div class="todo-list">
                      <div class="list-block">
                        <ul id="dealulread">
                         
                        </ul>
						<aside class="wh-load-box" style="display: block">
							 <div class="wh-load-tap">上滑加载更多</div>
							 <div class="wh-load-md" id="whRead">
							 <span></span>
							 <span></span>
							 <span></span>
							 <span></span>
							 <span></span>
							 </div>
						</aside>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </section> 
          <!-- 流程已办 -->
          <section id="sectionScrollDealed" class="section-step wh-section infinite-scroll wh-section-bottomfixed pull-to-refresh-content">
		    <div class="pull-to-refresh-layer">
              <div class="preloader"></div>
              <div class="pull-to-refresh-arrow"></div>
            </div>
            <div class="step-todo">
              <div class="app-tabheader-line clearfix">
                <!-- 关联到第一个tab, 默认激活 -->
                <div class="clearfix">
                  <a href="#tab-step-over1" class="tab-link active" id="hrf2" onclick="change('2')">
                    <span>已办<em id="dealedNum"></em></span>
                  </a>
                  <a href="#tab-step-over2" class="tab-link " id="hrf3" onclick="change('3')">
                    <span>已阅<em id="readedNum"></em></span>
                  </a>
                </div>
              </div>
              <div class="tabs">
                <!-- Tab 1, 默认激活 -->
                <div id="tab-step-over1" class="tab active">
                  <div class="step-todo-file">
                    <header id="searchBar" class="wh-search">
                      <div class="wh-container">
                        <div class="wh-search-input">
                          <form method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar">
                            <label class="fa fa-search" for="search"></label>
                            <input id="searchDealed" type="search" class="nomal-search" placeholder="请输入流程标题查询" />
                            <a href="#" class="searchbar-cancel" onclick="removeSearch(this);loadDealFileDealedList('/defaultroot/dealfile/getListData.controller','0');">取消</a>
                          </form>
                        </div>
                      </div>
                    </header>
                    <div class="todo-list">
                      <div class="list-block">
                        <ul id="dealedul">
                                    
                        </ul>
						<aside class="wh-load-box" style="display: block">
							 <div class="wh-load-tap">上滑加载更多</div>
							 <div class="wh-load-md" id="whDealed">
							 <span></span>
							 <span></span>
							 <span></span>
							 <span></span>
							 <span></span>
							 </div>
						</aside>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- Tab 2 -->
                <div id="tab-step-over2" class="tab">
                  <div class="step-todo-file">
                    <header id="searchBar" class="wh-search">
                      <div class="wh-container">
                        <div class="wh-search-input">
                          <form method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar">
                            <label class="fa fa-search" for="search"></label>
                            <input id="searchReaded" type="search" class="nomal-search" placeholder="请输入流程标题查询" />
                            <a href="#" class="searchbar-cancel" onclick="removeSearch(this);loadDealFileDealedReadList('/defaultroot/dealfile/getListData.controller','0');">取消</a>
                          </form>
                        </div>
                      </div>
                    </header>
                    <div class="todo-list">
                      <div class="list-block">
                        <ul id="dealedulread">
                          
                        </ul>
						<aside class="wh-load-box" style="display: block">
							 <div class="wh-load-tap">上滑加载更多</div>
							 <div class="wh-load-md" id="whReaded">
							 <span></span>
							 <span></span>
							 <span></span>
							 <span></span>
							 <span></span>
							 </div>
						</aside>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </section>
          <!-- 我的流程 -->
          <section id="sectionScrollMy"  class="section-step wh-section infinite-scroll wh-section-bottomfixed pull-to-refresh-content">
		    <div class="pull-to-refresh-layer">
              <div class="preloader"></div>
              <div class="pull-to-refresh-arrow"></div>
            </div>
            <div class="step-todo">
              <header id="searchBar" class="wh-search">
                <div class="wh-container">
                  <div class="wh-search-input">
                    <form method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar">
                      <label class="fa fa-search" for="search"></label>
                      <input id="searchMy" type="search" class="nomal-search" placeholder="请输入流程标题查询" />
                      <a href="#" class="searchbar-cancel" onclick="removeSearch(this);loadDealFileMyList('/defaultroot/dealfile/getListData.controller','0');">取消</a>
                    </form>
                  </div>
                </div>
              </header>
              <div class="todo-list">
                <div class="list-block">
                  <ul id="dealulmy">
                    
                  </ul>
				  <aside class="wh-load-box" style="display: block">
					 <div class="wh-load-tap">上滑加载更多</div>
					 <div class="wh-load-md" id="whDealMy">
					 <span></span>
					 <span></span>
					 <span></span>
					 <span></span>
					 <span></span>
					 </div>
				 </aside>
                </div>
              </div>
            </div>
          </section>
          <!-- 发起流程 -->
          <section class="section-step wh-section wh-section-bottomfixed">
            <div class="step-strat">
              <div class="app-tabheader-line clearfix">
                <div class="clearfix">
                  <a href="#tab-step-start1" class="tab-link active" id="hrf4" onclick="change('4')">
                    <span>常用流程</span>
                  </a>
                  <a href="#tab-step-start2" class="tab-link " id="hrf5" onclick="change('5')">
                    <span>全部分类</span>
                  </a>
                </div>
              </div>
              <!-- Tabs, 标签内容区容器 -->
              <div class="tabs">
                <!-- Tab 1, 默认激活 -->
                <div id="tab-step-start1" class="tab active">
                  <div class="list-block">
                    <ul class="step-common" id="topworkflow">
                     
                    </ul>
                  </div>
                </div>
                <!-- Tab 2 -->
                <div id="tab-step-start2" class="tab">
                  <div class="step-all">
                    <!-- 普通搜索公用 -->
                    <header id="searchBar" class="wh-search">
                      <div class="wh-container">
                        <div class="wh-search-input">
                          <form method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar">
                            <label class="fa fa-search" for="search"></label>
                            <input id="searchAll" type="search" class="nomal-search" placeholder="请输入流程标题查询" />
                            <a href="#" class="searchbar-cancel" onclick="removeSearch(this);listFlowData('/defaultroot/workflow/listFlowData.controller','0');">取消</a>
                          </form>
                        </div>
                      </div>
                    </header>
                    <ul id="allworkflow">
                     
                    </ul>
                  </div>
                </div>
              </div>
            </div>
          </section>
          <!-- 底部导航 -->
          <footer class="wh-footer wh-footer-forum">
            <div class="wh-wrapper">
              <div class="wh-container">
                <div class="footer-step wh-footer-btn row no-gutter">
                  <a href="##" class="fbtn-matter col-25" id="hrf6" onclick="change('6')">
                    <div><i class="fa fa-step-pre"></i></div><span>待办</span></a>
                  <a href="##" class="fbtn-cancle col-25" id="hrf7" onclick="change('7')">
                    <div><i class="fa fa-step-over"></i></div><span>已办</span></a>
                  <a href="##" class="fbtn-cancle col-25" id="hrf8" onclick="change('8')">
                    <div><i class="fa fa-step-mine"></i></div><span>我的</span></a>
                  <a href="##" class="fbtn-cancle col-25" id="hrf9" onclick="change('9')">
                    <div><i class="fa fa-share-alt"></i></div><span>发起</span></a>
                </div>
              </div>
            </div>
          </footer>
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
  <script type="text/javascript">
  var myApp = new Framework7();
  var $$ = Dom7;

  //添加视图
  var mainView = myApp.addView('.view');

  //右下角菜单弹框
  $$('#fbtn-form-more').on('click', function() {
    console.log("ss1111");
    var clickedLink = this;
    var popoverHTML = '<div class="fbtn-more-nav popover popover-links" id="fbtn-form-more-con">' +
      '<div class="fbtn-more-nav-inner" id="fbtn-form-more-list">' +
      '<a href="##" class="panel-add-a close-popover">加签</a>' +
      '<a href="##" class="panel-turn-a fbtn-grey close-popover">转办</a>' +
      '<a href="##" class="panel-read-a close-popover">阅件</a>' +
      '<a href="##" class="panel-press-a close-popover">催办</a>' +
      '</div></div>';
    myApp.popover(popoverHTML, clickedLink);
    myApp.closeModal('#fbtn-form-more-list a');
  });

  //加签
  $$('.panel-add-a').on('click', function() {
    $$(".panel-sub").hide();
    $$(".panel-add").show();
    myApp.openPanel('right');
  });
  //转办
  $$('.panel-turn-a').on('click', function() {
    $$(".panel-sub").hide();
    $$(".panel-turn").show();
    myApp.openPanel('right');
  });
  //阅件
  $$('.panel-read-a').on('click', function() {
    $$(".panel-sub").hide();
    $$(".panel-read").show();
    myApp.openPanel('right');
  });
  //催办
  $$('.panel-press-a').on('click', function() {
    $$(".panel-sub").hide();
    $$(".panel-press").show();
    myApp.openPanel('right');
  });
  //关闭
  $$('.panel-close').on('click', function(e) {
    myApp.closePanel();
  });  
  //退回
  $$('.panel-return-a').on('click', function() {
    $$(".panel-sub").hide();
    $$(".panel-return").show();
    myApp.openPanel('right');
  });
  //发送
  $$('.panel-send-a').on('click', function() {
        $$(".panel-sub").hide();
        $$(".panel-send").show();
        myApp.openPanel('right');

        //成功办理
        var modal;

        $$('.panel-send-btn').on('click', function(e) {

          modal = myApp.modal({
            title: ' ',
            text: ' ',
            afterText: '<div class="panel-modal"><i class="fa fa-check-circle"></i><p>办理成功,返回中...</p></div>',
            buttons: []
          })
          myApp.swiper($$(modal).find('.swiper-container'), {
            pagination: '.swiper-pagination'
          });

          setTimeout(function() {
            myApp.hidePreloader();
          }, 2000);
        });
  }); 

  //底部切换
  $$(".footer-step>a").click(function(){
    var _this = $$(this);
    var index = _this.index();

    $$(".footer-step>a").removeClass("fbtn-matter").addClass("fbtn-cancle");
    _this.removeClass("fbtn-cancle").addClass("fbtn-matter");
    $$(".section-step").hide().eq(index).show();
  }); 

  $(document).ready(function(){ 
	 var flg = sessionStorage.getItem("flg");
     if(flg == '0'){
		$$("#hrf0").click();
	 }else if(flg == '1'){
		$$("#hrf6").click();
	    $$("#hrf1").click();
	 }else if(flg == '2'){
	    $$("#hrf2").click();
	 }else if(flg == '3'){
        $$("#hrf7").click();
	    $$("#hrf3").click();
	 }else if(flg == '4'){
	    $$("#hrf4").click();
	 }else if(flg == '5'){
        $$("#hrf9").click();
	    $$("#hrf5").click();
	 }else if(flg == '6'){
	    $$("#hrf6").click();
	 }else if(flg == '7'){
	    $$("#hrf7").click();
	 }else if(flg == '8'){
	    $$("#hrf8").click();
	 }else if(flg == '9'){
	    $$("#hrf9").click();
	 }

	 loadDealFileList('/defaultroot/dealfile/getListData.controller');
	 loadDealFileReadList('/defaultroot/dealfile/getListData.controller');
	 loadDealFileDealedList('/defaultroot/dealfile/getListData.controller');
	 loadDealFileDealedReadList('/defaultroot/dealfile/getListData.controller');
	 loadDealFileMyList('/defaultroot/dealfile/getListData.controller');
	 listFlowData('/defaultroot/workflow/listFlowData.controller');
	 listFlowTopData('/defaultroot/workflow/topWorkFlowList.controller');
  });
    //页签标记
	var dealFlag = 'waitDeal';
    //待办列表
    var maxItems ="";
	var loading = false;
    var offset = '0';
    //是否有下一页标志
    var nomore = '';
    //加载状态，0：未加载，1：已加载，防止重复加载数据
    var loadStatus = '0';
    //加载列表数据
    function loadDealFileList(url,empNum){
		if(empNum=='0'){
			offset = '0';
			$('#dealul').empty();
		}
		var workStatus = '0';
    	if(loadStatus == '1'){
    		return;
    	}
    	loadStatus = '1';
        $.ajax({
            type: 'post',
            url: url,
            dataType: 'text',
            data : {'workStatus' : workStatus,'offset' : offset,'title' : $('#searchDeal').val()},
            success: function(data){
                if(!data){
                	return;
                }
                var jsonData = eval("("+data+")");
                if(!jsonData){
                	return;
                }
                var listData = jsonData.data0;
                if(!listData){
                	return;
                }
                var addDom = '';
               // var empLivingPhoto = '';
                offset = jsonData.data2;           
				if(jsonData.data3 != '0'){
					maxItems = jsonData.data3;	
					//$('#numOne').show();
					$('#dealNum').html(jsonData.data3);
				}
                
				if(maxItems>15){
					$('#whDeal').show();
				}else{
					$('#whDeal').hide();
				}
				if(listData.length<15){
					$('#whDeal').hide();
				}
                for(var i = 0,length = listData.length; i < length; i++){
					var title =listData[i].workTitle;					
                	addDom +='<li class="swipeout">'
                            +'<a href="javascript:void(0)" class="swipeout-content item-content" onclick="getDealFileDetailUrl(\''+listData[i].workMainLinkFile+'\',\''+workStatus+'\',\''+listData[i].workId+'\');">'
                               +'<div class="webapp-div">'
                               +'  <strong>'+ title +' </strong>'
                               +'  <P>'
                                 +'  <span>'+listData[i].workSubmitTime.substring(0,16)+'</span>'
                                 +'  <em class="skyblue">'+listData[i].workCurStep+'</em>'
                                +' </P>'
                              +' </div>'
                              +' <div class="item-after"><i class="fa fa-angle-right"></i></div>'
                             +'</a>'
                         +'  </li>';   
                }
                if(!addDom){
                	addDom = '<li><p><a>系统没有查询到任何记录！</a></p></li>';
                }
                $('#dealul').append(addDom);				
                //将加载状态重置为0
                loadStatus = '0';
            },
            error: function(xhr, type){
                myApp.alert('加载中请勿频繁操作！');
            }
        });
    }

    //待阅列表
	var maxItemsRead ="";
	var loadingRead = false;
    var offsetRead = '0';
    //是否有下一页标志
    var nomoreRead = '';
    //加载状态，0：未加载，1：已加载，防止重复加载数据
    var loadStatusRead = '0';
    //加载列表数据
    function loadDealFileReadList(url,empNum){
		if(empNum=='0'){
			offsetRead = '0';
			$('#dealulread').empty();
		}
		var workStatus = '2';
    	if(loadStatusRead == '1'){
    		return;
    	}
    	loadStatusRead = '1';
        $.ajax({
            type: 'post',
            url: url,
            dataType: 'text',
            data : {'workStatus' : workStatus,'offset' : offsetRead,'title' : $('#searchRead').val()},
            success: function(data){
                if(!data){
                	return;
                }
                var jsonData = eval("("+data+")");
                if(!jsonData){
                	return;
                }
                var listData = jsonData.data0;
                if(!listData){
                	return;
                }
                var addDom = '';
               // var empLivingPhoto = '';
                offsetRead = jsonData.data2;
				if(jsonData.data3 != '0'){
					maxItemsRead = jsonData.data3;			
					$('#readNum').html(jsonData.data3);
				}
                if(maxItemsRead>15){
					$('#whRead').show();
				}else{
					$('#whRead').hide();
				}
				if(listData.length<15){
					$('#whRead').hide();
				}
                for(var i = 0,length = listData.length; i < length; i++){
					var title =listData[i].workTitle;
                	addDom +='<li class="swipeout">'
                            +'<a href="javascript:void(0)" class="swipeout-content item-content" onclick="getDealFileDetailUrl(\''+listData[i].workMainLinkFile+'\',\''+workStatus+'\',\''+listData[i].workId+'\');">'
                               +'<div class="webapp-div">'
                               +'  <strong>'+ title +' </strong>'
                               +'  <P>'
                                 +'  <span>'+listData[i].workSubmitTime.substring(0,16)+'</span>'
                                 +'  <em class="skyblue">'+listData[i].workCurStep+'</em>'
                                +' </P>'
                              +' </div>'
                              +' <div class="item-after"><i class="fa fa-angle-right"></i></div>'
                             +'</a>'
                         +'  </li>';   
                }
                if(!addDom){
                	addDom = '<li><p><a>系统没有查询到任何记录！</a></p></li>';
                }
                $('#dealulread').append(addDom);				
                //将加载状态重置为0
                loadStatusRead = '0';
            },
            error: function(xhr, type){
                myApp.alert('加载中请勿频繁操作！');
            }
        });
    }
	
    $$(document).on('infinite', '#sectionScroll', function() {
            if(dealFlag == 'waitDeal'){
				if (loading) return;
				loading = true;
				var lastIndex = $$('#dealul li').length;
				 setTimeout(function() {
					  loading = false;
					  if (lastIndex >= maxItems) {
							// 加载完毕，则注销无限加载事件，以防不必要的加载
							//myApp.detachInfiniteScroll($$('#sectionScroll'));
							// 删除加载提示符
							$$('#whDeal').hide();
							return;
						}
						if (maxItems - lastIndex > 0) {
							//alert(curPage);
							loadDealFileList('getListData.controller');
							return;
						}
				}, 500);
			}else if(dealFlag == 'waitRead'){
			   // 如果正在加载，则退出
				if (loadingRead) return;
				loadingRead = true;
				var lastIndex = $$('#dealulread li').length;
				 setTimeout(function() {
					  loadingRead = false;
					  if (lastIndex >= maxItemsRead) {
							// 加载完毕，则注销无限加载事件，以防不必要的加载
							//myApp.detachInfiniteScroll($$('#sectionScroll'));
							// 删除加载提示符
							$$('#whRead').hide();
							return;
						}
						if (maxItemsRead - lastIndex > 0) {
							//alert(curPage);
							loadDealFileReadList('getListData.controller');
							return;
						}
				}, 500);
			}
	 });

	   // 下拉刷新页面
	var ssContent = $$('#sectionScroll');
	// 添加'refresh'监听器
	ssContent.on('refresh', function(e) {
  		// 模拟2s的加载过程
		setTimeout(function() {
    		if(dealFlag == 'waitDeal'){
				loadDealFileList('getListData.controller','0');
			}else if(dealFlag == 'waitRead'){
				loadDealFileReadList('getListData.controller','0')
			}
			myApp.pullToRefreshDone();
		}, 1000);
	});

	 //已办列表
	//页签标记
	var dealedFlag = 'dealed';
	var maxItemsDealed ="";
	var loadingDealed = false;
    var offsetDealed = '0';
    //是否有下一页标志
    var nomoreDealed = '';
    //加载状态，0：未加载，1：已加载，防止重复加载数据
    var loadStatusDealed = '0';
    //加载列表数据
    function loadDealFileDealedList(url,empNum){
		if(empNum=='0'){
			offsetDealed = '0';
			$('#dealedul').empty();
		}
		var workStatus = '101';
    	if(loadStatusDealed == '1'){
    		return;
    	}
    	loadStatusDealed = '1';
        $.ajax({
            type: 'post',
            url: url,
            dataType: 'text',
            data : {'workStatus' : workStatus,'offset' : offsetDealed,'title' : $('#searchDealed').val()},
            success: function(data){
                if(!data){
                	return;
                }
                var jsonData = eval("("+data+")");
                if(!jsonData){
                	return;
                }
                var listData = jsonData.data0;
                if(!listData){
                	return;
                }
                var addDom = '';
               // var empLivingPhoto = '';
                offsetDealed = jsonData.data2;
				if(jsonData.data3 != '0'){
					maxItemsDealed = jsonData.data3;			
					$('#dealedNum').html(jsonData.data3);
				}
                
				if(maxItemsDealed>15){
					$('#whDealed').show();
				}else{
					$('#whDealed').hide();
				}
				if(listData.length<15){
					$('#whDealed').hide();
				}
                for(var i = 0,length = listData.length; i < length; i++){
					var nameArr = listData[i].workCurDealName.split(" ");
					var nameSplit = '';
					if (nameArr.length>2){
					   nameSplit = nameArr[0]+" "+nameArr[1]+'等';
					}else{
					   nameSplit = listData[i].workCurDealName;
					}//办理人超过两个用等代替
					var dealName = '<em class="skyblue">'+nameSplit+'</em>';
                    if(nameSplit == '' || nameSplit == null){
						dealName = '';
					}
					var colorval = 'skyblue';//标签颜色
					if(listData[i].workCurStep == '退回'){
						colorval ='pink';
						dealName='';
					}else if(listData[i].workCurStep == '办理完毕'){
						colorval ='green';
						dealName='';
					}
					var title =listData[i].workTitle;
                	addDom +='<li class="swipeout">'
                            +'<a href="javascript:void(0)" class="swipeout-content item-content" onclick="getDealFileDetailUrl(\''+listData[i].workMainLinkFile+'\',\''+workStatus+'\',\''+listData[i].workId+'\');">'
                               +'<div class="webapp-div">'
                               +'  <strong>'+ title +' </strong>'
                               +'  <P>'
                                 +'  <span>'+listData[i].workSubmitTime.substring(0,16)+'</span>'
                                 +'  <em class="'+colorval+'">'+listData[i].workCurStep+'</em>'
								 +dealName
                                +' </P>'
                              +' </div>'
                              +' <div class="item-after"><i class="fa fa-angle-right"></i></div>'
                             +'</a>'
                         +'  </li>';   
                }
                if(!addDom){
                	addDom = '<li><p><a>系统没有查询到任何记录！</a></p></li>';
                }
                $('#dealedul').append(addDom);				
                //将加载状态重置为0
                loadStatusDealed = '0';
            },
            error: function(xhr, type){
                myApp.alert('加载中请勿频繁操作！');
            }
        });
    }

	 //已阅读列表
	var maxItemsDealedRead ="";
	var loadingDealedRead = false;
    var offsetDealedRead = '0';
    //是否有下一页标志
    var nomoreDealedRead = '';
    //加载状态，0：未加载，1：已加载，防止重复加载数据
    var loadStatusDealedRead = '0';
    //加载列表数据
    function loadDealFileDealedReadList(url,empNum){
		if(empNum=='0'){
			offsetDealedRead = '0';
			$('#dealedulread').empty();
		}
		var workStatus = '102';
    	if(loadStatusDealedRead == '1'){
    		return;
    	}
    	loadStatusDealedRead = '1';
        $.ajax({
            type: 'post',
            url: url,
            dataType: 'text',
            data : {'workStatus' : workStatus,'offset' : offsetDealedRead,'title' : $('#searchReaded').val()},
            success: function(data){
                if(!data){
                	return;
                }
                var jsonData = eval("("+data+")");
                if(!jsonData){
                	return;
                }
                var listData = jsonData.data0;
                if(!listData){
                	return;
                }
                var addDom = '';
               // var empLivingPhoto = '';
                offsetDealedRead = jsonData.data2;
				if(jsonData.data3 != '0'){
					maxItemsDealedRead = jsonData.data3;			
					$('#readedNum').html(jsonData.data3);
				}
                if(maxItemsDealedRead>15){
					$('#whReaded').show();
				}else{
					$('#whReaded').hide();
				}
				if(listData.length<15){
					$('#whReaded').hide();
				}
                for(var i = 0,length = listData.length; i < length; i++){
					var title =listData[i].workTitle;
                	addDom +='<li class="swipeout">'
                            +'<a href="javascript:void(0)" class="swipeout-content item-content" onclick="getDealFileDetailUrl(\''+listData[i].workMainLinkFile+'\',\''+workStatus+'\',\''+listData[i].workId+'\');">'
                               +'<div class="webapp-div">'
                               +'  <strong>'+ title +' </strong>'
                               +'  <P>'
                                 +'  <span>'+listData[i].workSubmitTime.substring(0,16)+'</span>'
                                 +'  <em class="skyblue">'+listData[i].workCurStep+'</em>'
                                +' </P>'
                              +' </div>'
                              +' <div class="item-after"><i class="fa fa-angle-right"></i></div>'
                             +'</a>'
                         +'  </li>';   
                }
                if(!addDom){
                	addDom = '<li><p><a>系统没有查询到任何记录！</a></p></li>';
                }
                $('#dealedulread').append(addDom);				
                //将加载状态重置为0
                loadStatusDealedRead = '0';
            },
            error: function(xhr, type){
                myApp.alert('加载中请勿频繁操作！');
            }
        });
    }
	
    $$(document).on('infinite', '#sectionScrollDealed', function() {
            if(dealedFlag == 'dealed'){
				// 如果正在加载，则退出
				if (loadingDealed) return;
				loadingDealed = true;
				var lastIndex = $$('#dealedul li').length;
				 setTimeout(function() {
					  loadingDealed = false;
					  if (lastIndex >= maxItemsDealed) {
							// 加载完毕，则注销无限加载事件，以防不必要的加载
							myApp.detachInfiniteScroll($$('#sectionScrollDealed'));
							// 删除加载提示符
							$$('#whDealed').hide();
							return;
						}
						if (maxItemsDealed - lastIndex > 0) {
							//alert(curPage);
							loadDealFileDealedList('getListData.controller');
							return;
						}
				}, 500);
			}else if(dealedFlag == 'readed'){
			   // 如果正在加载，则退出
				if (loadingDealedRead) return;
				loadingDealedRead = true;
				var lastIndex = $$('#dealedulread li').length;
				 setTimeout(function() {
					  loadingDealedRead = false;
					  if (lastIndex >= maxItemsDealedRead) {
							// 加载完毕，则注销无限加载事件，以防不必要的加载
							myApp.detachInfiniteScroll($$('#sectionScrollDealed'));
							// 删除加载提示符
							$$('#whReaded').hide();
							return;
						}
						if (maxItemsDealedRead - lastIndex > 0) {
							//alert(curPage);
							loadDealFileDealedReadList('getListData.controller');
							return;
						}
				}, 500);
			}
	 });

	 // 下拉刷新页面
	var ssdContent = $$('#sectionScrollDealed');
	// 添加'refresh'监听器
	ssdContent.on('refresh', function(e) {
  		// 模拟2s的加载过程
		setTimeout(function() {
    		if(dealedFlag == 'dealed'){
				loadDealFileDealedList('/defaultroot/dealfile/getListData.controller','0');
			}else if(dealedFlag == 'readed'){
				loadDealFileDealedReadList('/defaultroot/dealfile/getListData.controller','0');
			}
			myApp.pullToRefreshDone();
		}, 1000);
	});

     
    //我的流程列表
	var maxItemsMy ="";
	var loadingMy = false;
    var offsetMy = '0';
    //是否有下一页标志
    var nomoreMyd = '';
    //加载状态，0：未加载，1：已加载，防止重复加载数据
    var loadStatusMy = '0';
    //加载列表数据
    function loadDealFileMyList(url,empNum){
		if(empNum=='0'){
			offsetMy = '0';
			$('#dealulmy').empty();
		}
		var workStatus = '1100';
    	if(loadStatusMy== '1'){
    		return;
    	}
    	loadStatusMy = '1';
        $.ajax({
            type: 'post',
            url: url,
            dataType: 'text',
            data : {'workStatus' : workStatus,'offset' : offsetMy,'title' : $('#searchMy').val()},
            success: function(data){
                if(!data){
                	return;
                }
                var jsonData = eval("("+data+")");
                if(!jsonData){
                	return;
                }
                var listData = jsonData.data0;
                if(!listData){
                	return;
                }
                var addDom = '';
               // var empLivingPhoto = '';
                offsetMy = jsonData.data2;
				if(jsonData.data3 != '0'){
					maxItemsMy = jsonData.data3;			
				}
                
				if(maxItemsMy>15){
					$('#whDealMy').show();
				}else{
					$('#whDealMy').hide();
				}
				if(listData.length<15){
					$('#whDealMy').hide();
				}
                for(var i = 0,length = listData.length; i < length; i++){
					var colorval = 'skyblue';
					var nameArr = listData[i].workCurDealName.split(" ");
					var nameSplit = '';
					if (nameArr.length>2){
					   nameSplit = nameArr[0]+" "+nameArr[1]+'等';
					}else{
					   nameSplit = listData[i].workCurDealName;
					}//办理人超过两个用等代替
					var dealName = '<em class="skyblue">'+nameSplit+'</em>';
                    if(nameSplit == '' || nameSplit == null){
						dealName = '';
					}
					if(listData[i].workCurStep == '退回'){
						colorval ='pink';
						dealName ='';
					}else if(listData[i].workCurStep == '办理完毕'){
						colorval ='green';
						dealName=''
					}
					var title =listData[i].workTitle;
                	addDom +='<li class="swipeout">'
                            +'<a href="javascript:void(0)" class="swipeout-content item-content" onclick="getDealFileDetailUrl(\''+listData[i].workMainLinkFile+'\',\''+workStatus+'\',\''+listData[i].workId+'\');">'
                               +'<div class="webapp-div">'
                               +'  <strong>'+ title +' </strong>'
                               +'  <P>'
                                 +'  <span>'+listData[i].workSubmitTime.substring(0,16)+'</span>'
                                 +'  <em class="'+colorval+'">'+listData[i].workCurStep+'</em>'
								 +dealName
                                +' </P>'
                              +' </div>'
                              +' <div class="item-after"><i class="fa fa-angle-right"></i></div>'
                             +'</a>'
                         +'  </li>';   
                }
                if(!addDom){
                	addDom = '<li><p><a>系统没有查询到任何记录！</a></p></li>';
                }
                $('#dealulmy').append(addDom);				
                //将加载状态重置为0
                loadStatusMy = '0';
            },
            error: function(xhr, type){
                myApp.alert('加载中请勿频繁操作！');
            }
        });
    }
	
    $$(document).on('infinite', '#sectionScrollMy', function() {
		   // 如果正在加载，则退出
		    if (loadingMy) return;
		    loadingMy = true;
		    var lastIndex = $$('#dealulmy li').length;
		     setTimeout(function() {
			      loadingMy = false;
			      if (lastIndex >= maxItemsMy) {
				        // 加载完毕，则注销无限加载事件，以防不必要的加载
				        myApp.detachInfiniteScroll($$('#sectionScrollMy'));
				        // 删除加载提示符
						$$('#whDealMy').hide();
				        return;
				    }
				    if (maxItemsMy - lastIndex > 0) {
				    	//alert(curPage);
				        loadDealFileMyList('getListData.controller');
				        return;
				    }
		    }, 500);
	 });

	 
	 // 下拉刷新页面
	var ssmContent = $$('#sectionScrollMy');
	// 添加'refresh'监听器
	ssmContent.on('refresh', function(e) {
  		// 模拟2s的加载过程
		setTimeout(function() {
    		loadDealFileMyList('/defaultroot/dealfile/getListData.controller','0');
			myApp.pullToRefreshDone();
		}, 1000);
	});

     
	 //绑定查询框回车事件
     $('#searchDeal').keydown(function(event){ 
		if(event.keyCode == 13){ //绑定回车 
			if(($('#searchDeal').val()).indexOf('<')>-1 || ($('#searchDeal').val()).indexOf('>')>-1){
				myApp.alert('搜索值不能为特殊字符，请重新输入！');
			}else{
				offset = '0';
				$('#dealul').empty();
				loadDealFileList('getListData.controller');
			}
		} 
	 });

	 //绑定查询框回车事件
     $('#searchRead').keydown(function(event){
		if(event.keyCode == 13){ //绑定回车 
			if($('#searchRead').val().indexOf('<')>-1 || $('#searchRead').val().indexOf('>')>-1){
				myApp.alert('搜索值不能为特殊字符，请重新输入！');
		    }else{ 
				offsetRead = '0';
				$('#dealulread').empty();
				loadDealFileReadList('getListData.controller');
			}
		} 
	 });

	 //绑定查询框回车事件
     $('#searchDealed').keydown(function(event){ 
		if(event.keyCode == 13){ //绑定回车 
			if($('#searchDealed').val().indexOf('<')>-1 || $('#searchDealed').val().indexOf('>')>-1){
				myApp.alert('搜索值不能为特殊字符，请重新输入！');
		    }else{ 
				offsetDealed = '0';
				$('#dealedul').empty();
				loadDealFileDealedList('getListData.controller');
			}
		} 
	 });

      //绑定查询框回车事件
     $('#searchReaded').keydown(function(event){ 
		if(event.keyCode == 13){ //绑定回车
			if($('#searchReaded').val().indexOf('<')>-1 || $('#searchReaded').val().indexOf('>')>-1){
				myApp.alert('搜索值不能为特殊字符，请重新输入！');
		    }else{ 
				offsetDealedRead = '0';
				$('#dealedulread').empty();
				loadDealFileDealedReadList('getListData.controller');
			}
		} 
	 });

	  //绑定查询框回车事件
     $('#searchMy').keydown(function(event){ 
		if(event.keyCode == 13){ //绑定回车 
			if($('#searchMy').val().indexOf('<')>-1 || $('#searchMy').val().indexOf('>')>-1){
				myApp.alert('搜索值不能为特殊字符，请重新输入！');
		    }else{
				offsetMy = '0';
				$('#dealulmy').empty();
				loadDealFileMyList('getListData.controller');
			}
		} 
	 });

	 //全部流程列表数据
    /*function listFlowData(url,empNum){
		if(empNum=='0'){
			$('#allworkflow').empty();
		}
		var val= $('#searchAll').val();
		var liclass = 'accordion-item';
		var divhtml = '<div class="accordion-item-content">';
		if(val != ''){//搜索后展开
			liclass = 'accordion-item accordion-item-expanded';
			divhtml = '<div class="accordion-item-content" style="height: auto;">';
		}
        $.ajax({
            type: 'post',
            url: url,
            dataType: 'text',
            data : {'processName': val},
            success: function(data){
                if(!data){
                	return;
                }
                var jsonData = eval("("+data+")");
                if(!jsonData){
                	return;
                }
                var groups = jsonData.data;
                var addDom = '';
				if(groups instanceof Array){
					for(var i = 0;i < groups.length; i++){
						addDom +='<li class="'+liclass+'">'
							+'<a href="#" class="item-content item-link">'
							  +' <p>'
							   +'  <strong>'+groups[i].packageName+'</strong>'
							   +'  <strong >('+groups[i].processNum+')</strong>'
							  +' </p>'
						   +'  </a>'
							+divhtml
							+'   <div class="cate-lists">'
							 +'    <ul>'
								+'   <li class="accordion-item">'
								+ creatList(groups[i].process,groups[i].moduleId)
								  +' </li>'
							   +'  </ul>'
							  +' </div>'
							+' </div>'
						 +'  </li>';
						  
					}
				}else if(groups instanceof Object){
					addDom ='<li class="'+liclass+'">'
						+'<a href="#" class="item-content item-link">'
						  +' <p>'
						   +'  <strong>'+groups.package.packageName+'</strong>'
						   +'  <strong >('+groups.package.processNum+')</strong>'
						  +' </p>'
					   +'  </a>'
						+divhtml
						+'   <div class="cate-lists">'
						 +'    <ul>'
							+'   <li class="accordion-item">'
							+ creatList(groups.package.process,groups.package.moduleId)
							  +' </li>'
						   +'  </ul>'
						  +' </div>'
						+' </div>'
					 +'  </li>';						  
				}
                if(!addDom){
                	addDom = '<li><p><a>系统没有查询到任何记录！</a></p></li>';
                }
                $('#allworkflow').append(addDom);	
            },
            error: function(xhr, type){
                myApp.alert('加载中请勿频繁操作！');
            }
        });
    }*/

	  //全部流程列表数据
    var listFlowFlag =  '0';
    function listFlowData(url,empNum){
		if(empNum=='0'){
			$('#allworkflow').empty();
			listFlowFlag =  '0';
		}
		if(listFlowFlag  == '1'){
			return;
		}
		var val= $('#searchAll').val();
		var dhtml = '<div class="wh-article-lists" style="display: none;">';
		
		var divhtml = '<div class="wh-cate-libox wh-cate-libox1 " onclick="menu(this)">';
		if(val != ''){//搜索后展开
			dhtml = '<div class="wh-article-lists" style="display: block;">';
			divhtml = '<div class="wh-cate-libox wh-cate-libox1 wh-cate-libox-active" onclick="menu(this)">';
		}
        $.ajax({
            type: 'post',
            url: url,
            dataType: 'text',
            data : {'processName': val},
            success: function(data){
                if(!data){
                	return;
                }
                var jsonData = eval("("+data+")");
                if(!jsonData){
                	return;
                }
                var groups = jsonData.data;
                var addDom = '';
				if(groups instanceof Array){
					for(var i = 0;i < groups.length; i++){
						addDom +='<li class="swipeout transitioning">'
							+divhtml
							 +' <a href="#" class="item-content item-open">'
							+'	<p>'
							+'	  <strong>'+groups[i].packageName+'（'+groups[i].processNum+'）</strong>'
							+'	</p>'
							+'  </a>'
							+'</div>'
							+dhtml
							+'  <div class="accordion-item-content" style="height: auto;">'
								+'<div class="cate-lists">'
								+'  <ul style="padding: 0">'
								+'	<li class="accordion-item">'
								+ creatList(groups[i].process,groups[i].moduleId)								
									+'</li>'
								 +' </ul>'
								+'</div>'
							 +' </div>'
							+'</div>'
						 +' </li>'
						  
					}
				}else if(groups instanceof Object){
					addDom ='<li class="swipeout transitioning">'
							+divhtml
							 +' <a href="#" class="item-content item-open">'
							+'	<p>'
							+'	  <strong>'+groups.package.packageName+'（1）</strong>'
							+'	</p>'
							+'  </a>'
							+'</div>'
							+dhtml
							+'  <div class="accordion-item-content" style="height: auto;">'
								+'<div class="cate-lists">'
								+'  <ul style="padding: 0">'
								+'	<li class="accordion-item">'
								+ creatList(groups.package.process,groups.package.moduleId)							
									+'</li>'
								 +' </ul>'
								+'</div>'
							 +' </div>'
							+'</div>'
						 +' </li>'
				}
                if(!addDom){
                	addDom = '<li><p><a>系统没有查询到任何记录！</a></p></li>';
                }
				listFlowFlag = '1';
                $('#allworkflow').append(addDom);	
            },
            error: function(xhr, type){
                myApp.alert('加载中请勿频繁操作！');
            }
        });
    }

     function creatList(list,moduleId){
		var clist ='';
		if(list instanceof Array){
			for(var j =0;j<list.length;j++){
				clist +='      <div class="webapp-div">'
					 +'      <i></i>'
					+'       <span onclick="openWf(\''+list[j].pool_process_type+'\',\''+moduleId+'\',\''+list[j].pool_oldprocess_id+'\',\''+list[j].pool_oldprocess_formid+'\',\''+list[j].pool_ezflowprocess_defid+'\',\''+list[j].pool_ezflowprocess_formKey+'\',\''+list[j].pool_processName+'\')">'+list[j].pool_processName+'</span>'
					  +'   </div>';
			}
	    }else if(list instanceof Object){
			clist +='      <div class="webapp-div">'
				 +'      <i></i>'
				+'       <span onclick="openWf(\''+list.pool_process_type+'\',\''+moduleId+'\',\''+list.pool_oldprocess_id+'\',\''+list.pool_oldprocess_formid+'\',\''+list.pool_ezflowprocess_defid+'\',\''+list.pool_ezflowprocess_formKey+'\',\''+list.pool_processName+'\')">'+list.pool_processName+'</span>'
				  +'   </div>';
		}
		return clist;	    
	 }


     //绑定查询框回车事件
     $('#searchAll').keydown(function(event){ 
		listFlowFlag = '0'; 
		if(event.keyCode == 13){ //绑定回车 
			if($('#searchAll').val().indexOf('<')>-1 || $('#searchAll').val().indexOf('>')>-1){
				myApp.alert('搜索值不能为特殊字符，请重新输入！');
		    }else{
				$('#allworkflow').empty();
				listFlowData('/defaultroot/workflow/listFlowData.controller');
			}
		} 
	 });
	//常用流程列表数据
    function listFlowTopData(url){
        $.ajax({
            type: 'post',
            url: url,
            dataType: 'text',
            data : '',
            success: function(data){
                if(!data){
                	return;
                }
                var jsonData = eval("("+data+")");
                if(!jsonData){
                	return;
                }
               var listData = jsonData.data0;
                if(!listData){
                	return;
                }
                var addDom = '';    
                for(var i = 0;i < listData.length; i++){
                	addDom +='<li class="swipeout">'
                       +' <a href="javascript:void(0)" class="swipeout-content item-content" onclick="openWf(\''+listData[i].pool_process_type+'\',\''+listData[i].moduleid+'\',\''+listData[i].pool_oldprocess_id+'\',\''+listData[i].pool_oldprocess_formid+'\',\''+listData[i].pool_ezflowprocess_defid+'\',\''+listData[i].pool_ezflowprocess_formKey+'\',\''+listData[i].pool_processName+'\')">'
                         +'  <div class="webapp-div clearfix">'
                         +'    <span>'+(i+1)+'</span>'
                         +'    <div>'
                          +'     <p>'+listData[i].pool_processName+' </p>'
                           +'    <em>已发起'+listData[i].processnum+'次</em>'
                           +'  </div>'
                           +'</div>'
                         +'  <div class="item-after"><i class="fa fa-angle-right"></i></div>'
                         +'</a>'
                      +' </li>';
                      
                }
                if(!addDom){
                	addDom = '<li><p><a>系统没有查询到任何记录！</a></p></li>';
                }
                $('#topworkflow').append(addDom);	
            },
            error: function(xhr, type){
                myApp.alert('加载中请勿频繁操作！');
            }
        });
    }

	 //获取文件办理url
    function getDealFileDetailUrl(workMainLinkFile,workStatus,workId){
    	if(!workMainLinkFile){
    		return '';
    	}
		if(workMainLinkFile.indexOf('/defaultroot/GovDocSendProcess!') > -1){
			window.location='/defaultroot/doc/sendGovProcess.controller?workStatus='+workStatus+'&workId='+workId+'&fromFlag=1';
    	}else if(workMainLinkFile.indexOf('/defaultroot/GovSendFileLoadAction.do') > -1){
            window.location='/defaultroot/doc/sendGovProcess.controller?workStatus='+workStatus+'&workId='+workId+'&fromFlag=1';
    	}else if(workMainLinkFile.indexOf('/defaultroot/wfopenflow!') > -1){
    		 window.location='/defaultroot/dealfile/process.controller?workStatus='+workStatus+'&workId='+workId+'&fromFlag=1';
    	}else if(workMainLinkFile.indexOf('/defaultroot/WorkFlowProcAction.do') > -1){
    		 window.location='/defaultroot/dealfile/process.controller?workStatus='+workStatus+'&workId='+workId+'&fromFlag=1';
    	}else if(workMainLinkFile.indexOf('/defaultroot/Information!') > -1){
			 window.location='/defaultroot/information/process.controller?workStatus='+workStatus+'&workId='+workId+'&fromFlag=1';
       	}else if(workMainLinkFile.indexOf('/defaultroot/InformationAction.do') > -1){
			 window.location='/defaultroot/information/process.controller?workStatus='+workStatus+'&workId='+workId+'&fromFlag=1';
    	}else if(workMainLinkFile.indexOf('/defaultroot/GovDocReceiveProcess!') > -1){
			 window.location='/defaultroot/doc/receiveGovProcess.controller?workStatus='+workStatus+'&workId='+workId+'&fromFlag=1';
    	}else if(workMainLinkFile.indexOf('/defaultroot/GovReceiveFileLoadAction.do') > -1){
			 window.location='/defaultroot/doc/receiveGovProcess.controller?workStatus='+workStatus+'&workId='+workId+'&fromFlag=1';
    	}else if(workMainLinkFile.indexOf('/defaultroot/voitureApply!modi.action') > -1){
			 window.location='/defaultroot/dealfile/voitureProcess.controller?workStatus='+workStatus+'&workId='+workId+'&fromFlag=1';
		}else if(workMainLinkFile.indexOf('/defaultroot/outStockAction!modifyFlow.action') > -1){
			 window.location='/defaultroot/dealfile/getOutStockResult.controller?workStatus='+workStatus+'&workId='+workId+'&fromFlag=1';
		}else if(workMainLinkFile.indexOf('/defaultroot/intoStockAction!modifyFlow.action') > -1){
			 window.location='/defaultroot/dealfile/getIntoStockResult.controller?workStatus='+workStatus+'&workId='+workId+'&fromFlag=1';
		}else if(workMainLinkFile.indexOf('/defaultroot/GovDocSendCheckProcess!') > -1){
			 window.location='/defaultroot/doc/sendfileCheckProcess.controller?workStatus='+workStatus+'&workId='+workId+'&fromFlag=1';
		}else{
			 window.location='/defaultroot/dealfile/process.controller?workStatus='+workStatus+'&workId='+workId+'&fromFlag=1';
    	}
    }
    //发起流程
	function openWf(param1,param2,param3,param4,param5,param6,param7){
		if(param1 == '0'){
			if(param2 =='11'){
				newCarForm(param4,param3,param7,param1);
			}else{
				newform(param4,param3,param7);
			}
		}else if(param1 == '1'){
			if(param2 =='11'){
				newCarEzForm(param6,param5,param7,param1);
			}else{
				newezform(param6,param5,param7);
			}
		}
	
	}
    
    //新建老流程
    function newform(pageId,processId,processName){
		window.location = '/defaultroot/workflow/newform.controller?pageId='+pageId+'&processId='+processId+'&processName='+encodeURIComponent(processName);
	}

    //新建新流程
	function newezform(pageId,processId,processName){
		window.location = '/defaultroot/workflow/newezform.controller?pageId='+pageId+'&processId='+processId+'&processName='+encodeURIComponent(processName);
	}

	//新建车辆老流程
    function newCarForm(pageId,processId,processName,process_type){
		window.location = '/defaultroot/workflow/getVoitureNewInfo.controller?pageId='+pageId+'&processId='+processId+'&processName='+processName+'&process_type='+process_type;
	}

    //新建车辆新流程
	function newCarEzForm(pageId,processId,processName,process_type){
		window.location = '/defaultroot/workflow/getVoitureNewInfo.controller?pageId='+pageId+'&processId='+processId+'&processName='+processName+'&process_type='+process_type;
	}

	// 清除搜索区域焦点bug
    function removeSearch(schElmID) {
      $$(schElmID).prev('.nomal-search').val('');
      $$(schElmID).blur().val(""); //主动清除焦点
      $$(schElmID).next('.searchbar-cancel').hide();
    }

    // 搜索焦点时
    $$('#fbtn-save').on('click', function() {
      $$(this).next('.searchbar-cancel').show();
    })
    //改变页签标记
	function change(val){
		if(val == '0'){
		   dealFlag = 'waitDeal';
		   sessionStorage.setItem("flg","0");
		}else if(val == '1'){
		   dealFlag = 'waitRead';
		   sessionStorage.setItem("flg","1");
		}else if(val == '2'){
		   dealedFlag = 'dealed';
		   sessionStorage.setItem("flg","2");
		}else if(val == '3'){
		   dealedFlag = 'readed';
		   sessionStorage.setItem("flg","3");
		}else if(val == '4'){
		   sessionStorage.setItem("flg","4");	  
		}else if(val == '5'){
		  sessionStorage.setItem("flg","5");
		}else if(val == '6'){
		  sessionStorage.setItem("flg","6");
		}else if(val == '7'){
		  sessionStorage.setItem("flg","7");
		}else if(val == '8'){
		  sessionStorage.setItem("flg","8");
		}else if(val == '9'){
		  sessionStorage.setItem("flg","9");
		}
	}
    
  function menu(obj){
	  if($$(obj).hasClass("wh-cate-libox-active")){
		  $$(obj).removeClass("wh-cate-libox-active");
		  $$(obj).next(".wh-article-lists").hide();

	  }
	  else{
		  $$(obj).addClass("wh-cate-libox-active");
		   $$(obj).next(".wh-article-lists").show();
	  }
  }
  </script>


</body>
