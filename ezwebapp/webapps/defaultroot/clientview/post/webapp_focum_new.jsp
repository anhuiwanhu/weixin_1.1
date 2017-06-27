<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>发帖</title>
	
    <%@ include file="../common/headerInit.jsp" %>
	
</head>
<body>	
<div class="views">
	<div class="view">
    	<div class="pages">
        	<div class="page" data-page="page-webapp-mail-edit">
				<section class="wh-section wh-section-bottomfixed" id="mainContent">
    				<article class="wh-edit wh-edit-forum">
        				<div class="mail-edit">
        					<form id="sendForm">
            					<table class="wh-table-edit">
                					<tr>
                    					<th><em class="red-em">*</em>所属版块<i class="fa fa-asterisk"></i>：</th>
                    					<td>
                        					<input onclick="selColumn();" class="edit-ipt-r edit-ipt-arrow" type="text" readonly name="className" id="className" placeholder="请选择" />
                        					<input type="hidden" name="classId" id="classId"/>
                    					</td>
                					</tr>
                					<tr>
                    					<th><em class="red-em">*</em>帖子标题<i class="fa fa-asterisk"></i>：</th>
                    					<td><input class="edit-ipt-r" type="text" placeholder="请输入" name="title" id="title"/></td>
                					</tr>
                					<tr>
                    					<th>署名方式<i class="fa fa-asterisk"></i>：</th>
                    					<td>
                        					<ul class="edit-radio" >
                            					<li data-val="0" id="shiming" class="radio-active"><span class="edit-radio-l">实名</span></li>
                            					<li data-val="1" id="niming"><span class="edit-radio-l">匿名</span></li>
                            					<li data-val="2" id="nicheng" <c:if test="${hasNick eq '0'}">style="display:none;"</c:if>><span class="edit-radio-l">昵称</span></li>
                            					<input type="hidden" name="type" id="type" value="0"/>
                        					</ul>
                    					</td>
                					</tr>
                					<tr>
                    					<th>附件<i class="fa fa-asterisk"></i>：</th>
                    					<td>
                        					<ul class="edit-upload">
                            					<li class="edit-upload-in" onclick="addImg();"><span><i class="fa fa-plus"></i></span></li>
                        					</ul>
                    					</td>
                					</tr>
                					<tr>
                    					<th>正文<i class="fa fa-asterisk"></i>：</th>
                    					<td>
                   							<style type="text/css">
											#content {
												max-height: 250px;
												height: 150px;
												background-color: white;
												border-collapse: separate; 
												border: 1px solid rgb(204, 204, 204); 
												padding: 4px; 
												box-sizing: content-box; 
												-webkit-box-shadow: rgba(0, 0, 0, 0.0745098) 0px 1px 1px 0px inset; 
												box-shadow: rgba(0, 0, 0, 0.0745098) 0px 1px 1px 0px inset;
												border-top-right-radius: 3px; border-bottom-right-radius: 3px;
												border-bottom-left-radius: 3px; border-top-left-radius: 3px;
												overflow: scroll;
												outline: none;
												font-size: 16px;
												padding-bottom:16px;
											}
											</style>
                       						<div name="" id="content" contenteditable="true" style="overflow:auto;" class="edit-txta-box">
											</div>
                        					<div class="edit-txta-box">
                            					<textarea class="edit-txta edit-txta-l" placeholder="请输入文字" name="content" id="realContent" style="display:none;"></textarea>
												<%--<span class="edit-txta-num">300</span>--%>
                        					</div>
                    					</td>
                					</tr>
                					<tr>
                    					<th colspan="2">                        
                        					<div class="edit-face-ico edit-ipt-reslut-l">
                            					<span class="face-ico-btn"><img src="/defaultroot/modules/comm/forum/images/QQ_New/1.gif" /></span>
                            					<div class="face-ico-all" style="display: none;">
                                					<img src="/defaultroot/modules/comm/forum/images/QQ_New/1.gif" />
                                					<img src="/defaultroot/modules/comm/forum/images/QQ_New/2.gif" />
                                					<img src="/defaultroot/modules/comm/forum/images/QQ_New/3.gif" />
                                					<img src="/defaultroot/modules/comm/forum/images/QQ_New/4.gif" />
                                					<img src="/defaultroot/modules/comm/forum/images/QQ_New/5.gif" />
                               						<img src="/defaultroot/modules/comm/forum/images/QQ_New/6.gif" />
                                					<img src="/defaultroot/modules/comm/forum/images/QQ_New/7.gif" />
                                					<img src="/defaultroot/modules/comm/forum/images/QQ_New/8.gif" />
                                					<img src="/defaultroot/modules/comm/forum/images/QQ_New/9.gif" />
                                					<img src="/defaultroot/modules/comm/forum/images/QQ_New/10.gif" />
                                					<img src="/defaultroot/modules/comm/forum/images/QQ_New/11.gif" />
                                					<img src="/defaultroot/modules/comm/forum/images/QQ_New/12.gif" />
                                					<img src="/defaultroot/modules/comm/forum/images/QQ_New/13.gif" />
                                					<img src="/defaultroot/modules/comm/forum/images/QQ_New/14.gif" />
                                					<img src="/defaultroot/modules/comm/forum/images/QQ_New/15.gif" />
                                					<img src="/defaultroot/modules/comm/forum/images/QQ_New/16.gif" />
                                					<img src="/defaultroot/modules/comm/forum/images/QQ_New/17.gif" />
                            					</div>
                        					</div>
                    					</th>
                					</tr>
            					</table>
            				</form>
        				</div>
      				</article>
				</section>
				
				<!-- 选择板块页面 -->
				<section id="selectContent" class="wh-section" style="display:none">
         			<div class="webapp-infomation-channel">
			  			<!-- 搜索公用 -->
			 			<header id="searchBar" class="wh-search">
			   				<div class="wh-container">
			     				<div class="wh-search-input">
			       					<form method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar">
			         					<label class="fa fa-search" for="search"></label>
			         					<input id="searchBug" name="searchChannelName" type="search" class="nomal-search"placeholder="请输入栏目标题" />
			         					<i class="fa fa-times-circle-o"  style="display:none;"  onclick="removeSearchInput()"></i>
			       					</form>
			     				</div>
			   				</div>
			 			</header>
			 			<div>
			  				<div class="tabs">
			     				<div class="list-block list-laber-block">
			      					<ul class="webapplist edit-radio" style="padding-bottom: 0rem;">
			      					
			       					</ul>
			     				</div>
			   				</div>
			 			</div>
					</div>
         		</section>
				
				<footer class="wh-footer wh-footer-forum" id="footerButton">
            		<div class="wh-container">
              			<div class="wh-footer-btn row">
                			<div class="webapp-footer-linebtn">
                  				<div class="fl clearfix" id="criteButton">
                    				<a href="javascript:sendPost();" class="panel-send-a">确定发布</a>
                  				</div>
                  				<div class="fl clearfix" id="comButton" style="display:none">
                    				<a href="javascript:clearSelect();" class="panel-return-a">清空</a>
                    				<a href="javascript:confirmSelect();" class="panel-send-a">确定</a>
                  				</div>
                			</div>
              			</div>
            		</div>
          		</footer>
		<!--  <footer class="wh-footer wh-footer-forum" style="height:6rem;" id="footerButton">
            <div class="wh-container">
              <div class="wh-footer-btn row">
                <div class="webapp-footer-linebtn">
                  <div class="fl clearfix">
					<a href="javascript:sendPost();" class="panel-return-a">确定发布</a>
                  </div>
                </div>
              </div>
            </div>
       </footer>-->
			</div>
		</div>
	</div>
</div>
</body>
</html>
<script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
<script type="text/javascript" src="/defaultroot/scripts/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/js/uploadPreview.min.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/js/common.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/js/subClick.js"></script>
<script type="text/javascript">

	var myApp = new Framework7({
		fastClicks: false,
	});
	var $$ = Dom7;


	//解决   安卓系统底部输入框太低时，输入键盘弹起会遮挡输入框
  	if(/Android [4-6]/.test(navigator.appVersion)) {
	    window.addEventListener("resize", function() {
	        if(document.activeElement.tagName=="INPUT" || document.activeElement.tagName=="TEXTAREA") {
	            window.setTimeout(function() {
	                document.activeElement.scrollIntoViewIfNeeded();
	            },0);
	        }
	    })
	}
	
	//对于footer的影响遮住输入框
  	document.write( '<style>#footerButton{visibility:hidden}@media(min-height:' + ($( window ).height() - 10) + 'px){#footerButton{visibility:visible}}</style>' );


    $(function(){
    	//单选
        var radioList = $(".edit-radio li");
        radioList.click(function(){
        	$("#type").val($(this).data("val"));
            radioList.eq($(this).index()).addClass('radio-active').siblings().removeClass('radio-active')
        });
        $('.face-ico-btn').click(function(){
            $('.face-ico-all').toggle();
        })
        //绑定点击图标事件 
        $('.face-ico-all img').bind('click',function(){
		    var src = this.src;
		    if(src.indexOf("/modules/comm/forum/images/")!=-1){
		        src = src.substring(src.indexOf("/defaultroot/modules/comm/forum/images/"));
		    }
			$("#content").append("<IMG SRC='" + src + "'/>");
        });
    });


    //搜索框操作
    function show(){
		$('.fa-times-circle-o').show();
	}
	function removeSearchInput(){
		$('.fa-times-circle-o').hide();
		$('#searchClassName').val('');
		
		selColumn();
	}
    
    
	//打开选择板块页面
	/*function selColumn(){
		var selectClassId = $("#classId").val();
		$.ajax({
			url : '/defaultroot/post/selectcolumn.controller',
			type : "post",
			data : {"selectClassId":selectClassId},
			success : function(data){
				$("#selectContent").append(data);
				hiddenContent(0);
			}
		});
	}*/

	var selFLag = 0;
	//打开选择板块页面
	function selColumn(){
		//myApp.showPreloader('加载板块中...');
		var selectClassId = $$("#classId").val();
		var searchClassName = $$("#searchBug").val();
		var classNameSel = $$("#className").val();
		$.ajax({
			url : '/defaultroot/post/selectcolumn.controller',
			type : "post",
			data : {"selectClassId" : selectClassId,"searchClassName" : searchClassName},
			success : function(data){
				var jsonData = eval("("+data+")");
				if(jsonData.data0.length == 0 && selFLag == 0){
		      		myApp.hidePreloader();
		      		myApp.alert('没有可选择的板块');
		      		return false;
		      	}
		      	var html = '';
		      	var write = '';
		      	var next = '';
		      	var selColumn = '';
				if(jsonData.data0.length>0){
					for(var i = 0; i < jsonData.data0.length; i++){
						var id = jsonData.data0[i].id;//栏目id
						var className = jsonData.data0[i].className;//栏目名称
						var hasForumCount = jsonData.data0[i].hasForumCount;//该栏目下帖子的数目
						var classHasJunior = jsonData.data0[i].classHasJunior;//是否有下级栏目【0：没有；1：有】
						var haveRightFlag = jsonData.data0[i].haveRightFlag;//0：不能查看或发帖 1:能查看或发帖
						var classUserName = jsonData.data0[i].classUserName;//
						var estopAnonymity = jsonData.data0[i].estopAnonymity;//允许匿名 0是 1否
						//判断单选按钮的显示
						if(haveRightFlag == '1'){
							write = '<span class="edit-radio-l"></span>';
						}else{
							write = '<span class="edit-radio-l" style="opacity: 0;"></span>';
						}
						//判断是否有下级版块
						if(classHasJunior != '0'){
							next = '<span>下级版块</span>';
						}else{
							next = '';
						}
						//让已选择的版块再次选中
						if(classNameSel == className){
							selColumn = '<input type="radio" name="channelRadio" checked="checked" value="'+id+','+className+','+estopAnonymity+'">';
						}else{
							selColumn = '<input type="radio" name="channelRadio" value="'+id+','+className+','+estopAnonymity+'">';
						}
						html +='<li class="swipeout">'
						+ '<label class="label-radio item-content">'
						+ selColumn
						+ write
						+ '</label>'
						+ '<a href="##" class="swipeout-content item-content">'
						+ '<div>'
						+ '<div class="tips">'+className.substring(0,1)+'</div>'
						+ '<span style="font-weight: 700;"><div onclick="selchannelRadio('+id+','+haveRightFlag+',\''+className+'\','+estopAnonymity+');">'+className+'</div></span>'
						//+ next
						+ '</div>'
						+ '</a>'
						+ '</li>';
					}
					$$("#selectContent ul").html(html);
					hiddenContent(0);
					selFLag = 1;
					setIconClass($$('.tips'));
					//myApp.hidePreloader();
				}else{
					$$("#selectContent ul").html('<li class="swipeout" style="padding:0rem;margin:0.5rem 0.2rem 0 1.2rem;"><label class="label-radio item-content"><span>系统未查询到相关记录！</span></label></li>');
		      		//myApp.hidePreloader();
				}
			},
			error: function(xhr, status) {
		    	$$("#selectContent ul").html('<li class="swipeout" style="padding:0rem;margin:0.5rem 0.2rem 0 1.2rem;"><label class="label-radio item-content"><span>系统未查询到相关记录！</span></label></li>');
		      	//myApp.hidePreloader();	 
			}
		});
	}

	//通过选择板块名 让 单选按钮选中
	function selchannelRadio(id,haveRightFlag,className,estopAnonymity){
		//alert(id+",,,,,,"+className);
		if(haveRightFlag == '1'){
			if($("input:radio[value='"+id+","+className+","+estopAnonymity+"']").is(':checked') == true){
				//alert("取消选中");
				$("input:radio[value='"+id+","+className+","+estopAnonymity+"']").attr('checked',false);
			}else{
				//alert("选中");
				$("input:radio[value='"+id+","+className+","+estopAnonymity+"']").attr('checked','true');
			}
		}else{
			return;
		}
		
	}
	
	//选人选组织代码-----开始
	function hiddenContent(flag){
		if(flag==0){
			$$("#mainContent").css("display","none");
			$$("#criteButton").css("display","none");
			$$("#comButton").css("display","block");
			$$("#selectContent").css("display","block");
		}else if(flag==1){
			$$("#selectContent").css("display","none");
			$$("#mainContent").css("display","block");
			$$("#criteButton").css("display","block");
			$$("#comButton").css("display","none");
		}
	}
	
    var index = 0;
    //添加图片
    function addImg(){
	   $(".edit-upload-in").before(       
		   '<li class="edit-upload-ed" id="imgli_'+index+'" style="display:none">'+
		       '<span>'+
		       	   '<img src="" id="imgShow_'+index+'"/>'+
			       '<em>'+
			       	 '<i onclick="removeImg('+index+');" class="fa fa-minus-circle"></i>'+
			       '</em>'+
		       '</span>'+
		       '<input type="file" id="up_img_'+index+'" style="display:none" name="imgFile"/>'+
		       '<input type="hidden" id="img_name_'+index+'" name="imgName"/>'+
		       '<input type="hidden" id="img_save_name_'+index+'" name="imgSaveName" data-filesize="0"/>'+
       	   '</li>');
	   var img_li_id = "imgli_"+index;
	   var up_img_id = "up_img_"+index;
	   new uploadPreview({ UpBtn: up_img_id, DivShow: img_li_id, ImgShow: "imgShow_"+index, callback : function(){callBackFun(up_img_id,img_li_id)} });
	   $("#up_img_"+index).click();
	   index++;
    }
   	
    //删除缩略图
    function removeImg(index){
	   $("#imgli_"+index).remove();
	   $("#up_img_"+index).remove();
    }
	
	//回调函数上传图片
	function callBackFun(upImgId,imgliId){
		myApp.showPreloader('正在上传...');
		$("#img_name_"+(index-1)).val($("#"+upImgId).val());
		var fileShowName = $("#"+upImgId).val();
		$.ajaxFileUpload({
			url: '/defaultroot/upload/fileUpload.controller?modelName=forum', //用于文件上传的服务器端请求地址
			secureuri:false,
			fileElementId: upImgId, //文件上传域的ID
			dataType: 'json', //返回值类型 一般设置为json
			success: function (msg, status){  //服务器成功响应处理函数---获取上传图片保存名
				//alert(1);
				$("#img_save_name_"+(index-1)).val(msg.data);
				$("#img_save_name_"+(index-1)).data("filesize",msg.fileSize);
				$("#img_name_"+(index-1)).val(fileShowName);
				$("#"+imgliId).show();
				myApp.hidePreloader();
			},
			error: function (data, status, e){//服务器响应失败处理函数
				//alert(2);
				myApp.alert("文件上传失败！");
			}
		});
	}
	
	//发送帖子
	function sendPost(){
		$("#realContent").val($("#content").html());
		if(checkForm()){
			$.ajax({
				url : "/defaultroot/post/saveforum.controller",
				data : $("#sendForm").serialize(),
				type : "post",
				success : function(data){
					var jsonData = eval("("+data+")");
					if(jsonData.result == 'success'){
						myApp.alert("发送成功！");
						window.history.back();
						//location.href="/defaultroot/post/index.controller";
					}else if(jsonData.result == 'fail'){
						myApp.alert("发送失败！");
					}
				},
				error : function(){
					myApp.alert("发送异常！");
				}
			});
		}
	}
	
	//验证表单数据
	function checkForm(){
		var classId = $("#classId").val();
		var title = $("#title").val();
		var type = $("#type").val();
		var content = $('#realContent').val();
		if(!classId){
			myApp.alert("请选择版块名！");
			return false;
		}
		if(!(title.trim()) || /[@#\$%\^&\*]+/g.test(title)){
			myApp.alert("请正确填写帖子标题！");
			return false;
		}
		if(title.length > 50){
			myApp.alert("帖子标题不得超过50字！");
			return false;
		}
		
		return true;
	}



	//清空已选择的栏目
	function clearSelect(){
		$("input[type='radio']").removeAttr('checked');
	}
	
	//确定选择的版块
	function confirmSelect(){
		var channelRadio = $$("input[type='radio']:checked").val();
		if(channelRadio == undefined ){
			myApp.alert('论坛版块不能为空，请选择');
			return false;
		}
		var arr = channelRadio.split(',');
		$$("#classId").val(arr[0]);//板块id
		$$("#className").val(arr[1]);//板块名称
		var estopAnonymity = arr[2];//板块是否允许匿名   
		if(estopAnonymity == '1'){//不允许
			$("#niming").css("display","none");
		}else{
			$("#niming").css("display","block");
		}
		hiddenContent(1);
	}


	//绑定查询框回车事件
    $$('#searchBug').keydown(function(event){
    	var searchTitle = $$('#searchBug').val();
		if(event.keyCode == 13){ //绑定回车 
			if((searchTitle.length > 0 && !(searchTitle.trim())) || /[@#\$%\^&\*]+/g.test(searchTitle)){
				myApp.alert('请正确填写搜索论坛版块标题')
			}else{
				selColumn();
			}
			
		} 
	});


 	// 搜索焦点时
    $$('#searchBug').on('click', function() {
    	 $$('.fa-times-circle-o').show();
    })

	//清除搜索
	function removeSearchInput(){ 
    	$$('.fa-times-circle-o').hide();
		$("#searchBug").val('');
		selColumn();
	}
</script>