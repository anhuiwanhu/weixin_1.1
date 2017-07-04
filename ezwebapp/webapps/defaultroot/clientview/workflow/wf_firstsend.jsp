<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ include file="/clientview/common/headerInit.jsp" %>
<!DOCTYPE html>
<html>
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>发送流程</title>
  <link rel="stylesheet" href="/defaultroot/clientview/template/css/template.style.ios.min.css" />
  <link rel="stylesheet" href="/defaultroot/clientview/template/css/template.webapp-style.min.css" />
</head>
<body class="grey-bg">
	<div class="panel panel-right panel-reveal" style="width:22rem;"> 
		<div class="panel-title">
	        <p style="text-align: center;">已选列表</p>
	    </div>
	    <div class="todo-list">
	       <div class="list-block">
	             <ul id="selectedPer">
	             </ul>
	      </div>
	    </div>
	</div>
  <div class="views">
    <div class="view view-main">
      <div class="pages">
        <div class="page" data-page="page-webapp-step-operation">
          <section class="wh-section wh-section-bottomfixed" id="mainContent">
           <div class="step-operation" style="display: block;">
            <div class="panel-sub panel-return" style="display: block;">
              <div class="panel-title">
                <p class="panel-title-p">发送选项</p>
              </div>
              <form id="sendForm" action="/defaultroot/workflow/sendezflowprocess.controller" method="post">
				<input type="hidden" id="userId" name="userId" value=""/>
		     	<input type="hidden" id="scopeId" name="scopeId" value=""/>
		     	<input type="hidden" id="businessId" name="businessId" value="${businessId}"/>
			 	<input type="hidden" id="processId" name="processId" value="${param.processId}"/>
			 	<input id="frommodule" type="hidden" name="frommodule" value="${param.frommodule}" />
				<input id="menuId" type="hidden" name="menuId" value="${param.menuId}" />
				<input id="menuName" type="hidden" name="menuName" value="${param.menuName}" />
		     	<c:set var="docTitle" value="${docTitle }"></c:set>
				<input type="hidden"  name="docTitle" value="${docTitle }"/>
				<c:set var="docTitle" value="${docTitle }"></c:set>
				<c:set var="mainLinkFile">${param.mainLinkFile}</c:set>
			 	<c:choose>
			 		<c:when test="${not empty mainLinkFile}">
			 			<input type="hidden" id="mainLinkFile" name="mainLinkFile" value="${param.mainLinkFile}"/>
			 		</c:when>
			 		<c:otherwise>
			 			<input type="hidden" id="mainLinkFile" name="mainLinkFile" value=""/>
			 		</c:otherwise>
			 	</c:choose>
			 	<div class="panel-con">
	                <p class="panel-title-p">下一办理环节：</p>
	                <div class="panel-direct" style="position:relative;">
	                    <c:if test="${not empty docXml}">
							<x:parse xml="${docXml}" var="doc"/>
							<c:set var="nextActivityListNum" value="0"/>
							<x:forEach select="$doc//activity" var="n" varStatus="statusc">
								<c:set var="nextActivityListNum" value="${nextActivityListNum+1}"/>
								<c:set var="activitys"><x:out select="$n/activityId/text()"/></c:set>
								<c:set var="activityName1"><x:out select="$n/activityName/text()"/></c:set>
							</x:forEach>
							<c:if test="${nextActivityListNum == 1}">
								<div class="edit-sel-show">
									<p>${activityName1}</p>
								</div>
								 <select onchange="setSpanHtml(this);" class="btn-bottom-pop" name="activity"  id="activity">
									<option selected="true" value="${activitys}">${activityName1}</option>
								 </select> 
							</c:if>
							<c:if test="${nextActivityListNum != 1}">
								<div class="edit-sel-show">
									<p>请选择</p>
								</div>
								 <select onchange="setSpanHtml(this);" class="btn-bottom-pop" name="activity"  id="activity">
								 	<option value="">请选择</option>
								 	<x:forEach select="$doc//activity" var="n" varStatus="statusc"> 
										<c:set var="activitys"><x:out select="$n/activityId/text()"/></c:set>
										<option value='<x:out select="$n/activityId/text()"/>'><x:out select="$n/activityName/text()"/></option>
									</x:forEach>
								 </select> 
							</c:if>		
						</c:if>
	                </div>
	            </div>
	            <div id="person" class="panel-con">
	                <p class="panel-title-p">下一办理人：</p>
	                <div class="panel-direct">
	                    <input type="text" class="edit-ipt-r" id="userName" name="userName"  placeholder="请选择" value="" readonly onclick='selectUser("1","userName","userId",$("#scopeId").val());'/>
	                </div>
	            </div>
			</form>
            </div>
          </div>
        </section>
        <div class="panel-btn" id="footerButton">
           	<a href="javascript:send();" class="panel-btn-a panel-close">发送</a>
        </div>
       <section id="selectContent" style="display:none">
		</section>
        </div>
      </div>
    </div>
  </div>
<script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
<script type="text/javascript">
  var myApp = new Framework7({
          fastClicks: false,
    });
  var mainView = myApp.addView('.view');
  var $$ = Dom7;
  //右下角菜单弹框
  $$('#fbtn-more').on('click', function () {
    var clickedLink = this;
    myApp.popover('#fbtn-more-con', clickedLink);
    myApp.closeModal('#fbtn-more-list a')
  });

	$(document).ready(function(){
		var optionLen = $('#activity option').length;
		if(optionLen == 2){
			$('#activity option:eq(1)').attr('selected','selected');			
		}
		hiddenEnd();
	});

	//设置span中的值
	function setSpanHtml(obj,selectVal){
	   	if(!selectVal){
	   		selectVal = $(obj).find("option:selected").text();
	   	}
		$(obj).parent().find('div>p').html(selectVal);
		hiddenEnd();
	}

	function hiddenEnd(){
		if($('#activity').val() =='' || $('#activity').val() =='-2' || $('#activity').val() =='-100'){
			$('#person').hide();
		}else{
			$('#person').show();
		}
		<c:if test="${not empty docXml}">
			<x:parse xml="${docXml}" var="doc"/>
			<x:forEach select="$doc//activity" var="n" >
				if('<x:out select="$n/activityId/text()"/>' == $('#activity').val()){
					if('<x:out select="$n/scopeType/text()"/>' == 'default_users'){
						$('#userId').val('<x:out select="$n/scopeId/text()"/>');
						$('#userName').val('<x:out select="$n/scopeName/text()"/>,');
						$('#scopeId').val('<x:out select="$n/scopeId/text()"/>');
					}else if( '<x:out select="$n/scopeType/text()"/>' == 'scopes_user' ){
						var scopeName = '<x:out select="$n/scopeName/text()"/>';
						var scopeId_ = '<x:out select="$n/scopeId/text()"/>'
						if(scopeName.split(',').length == 1 && scopeName !=''){
						    if(scopeId_.indexOf('*0*')> -1){
						    	$('#userId').val('');
	          	 				$('#userName').val('');
						    }else{
								$('#userId').val('<x:out select="$n/scopeId/text()"/>');
								$('#userName').val('<x:out select="$n/scopeName/text()"/>,');
							}
						}else{
							$('#userId').val('');
	          	 			$('#userName').val('');
						}
          	 			$('#scopeId').val('<x:out select="$n/scopeId/text()"/>');
					}else{
						$('#userId').val('');
						$('#userName').val('');
						$('#scopeId').val('<x:out select="$n/scopeId/text()"/>');
					}
				}
			</x:forEach>
		</c:if>
	}
	var backFlag='0';
	function send(){
		if(backFlag=='1'){
			return;
		}
		backFlag='1';
		if($('#activity').val() ==''){
			myApp.alert("请选择下一节点!");
			backFlag='0';
			return false;
		}
		if($('#userName') != null && $('#userName').val() == ''){
			myApp.alert('办理人不能为空');
			backFlag='0';
			return false;
		}
		var openUrl ='/defaultroot/dealfile/list.controller';
		var fd = $('#frommodule').val();
		var menuId = $('#menuId').val();
		var menuName = $('#menuName').val();
		if(fd.indexOf("datalist")>-1){
			openUrl ='/defaultroot/custmenu/custData.controller?menuId='+menuId+'&menuName='+encodeURI(menuName);
		}else if(fd.indexOf("menulist")>-1){
			openUrl ='/defaultroot/custmenu/custMenu.controller?menuId='+menuId+'&menuName='+encodeURI(menuName);
		}
		myApp.showPreloader('正在发送...');
		//发送流程
		$.ajax({
			url : '/defaultroot/workflow/sendprocess.controller',
			type : 'post',
			data : $('#sendForm').serialize(),
			success : function(data){
				myApp.hidePreloader();
				if(data){
					var jsonData = eval('('+data+')');
					if(jsonData.result = 'success'){
						myApp.alert('发送成功！');
						window.history.go(-2);
					}
				}else{
					backFlag='0';
					myApp.alert('发送失败！');
				}
			},
			error : function(){
				backFlag='0';
				myApp.alert('发送异常！');
			}
		});
	}
	
	//选人选组织代码-----开始
	function hiddenContent(flag){
		if(flag==0){
			$("#mainContent").css("display","none");
			$("#footerButton").css("display","none");
			$("#selectContent").css("display","block");
		}else if(flag==1){
			$("#selectContent").css("display","none");
			$("#mainContent").css("display","block");
			$("#footerButton").css("display","block");
			$("#selectContent").empty();
		}
	}
		
	//打开选择人员页面
	function selectUser(selectType,selectName,selectId,range){ 
		var selectIdVal = $('#'+selectId).val();
		if(selectIdVal.indexOf('$') != -1){
			var selectIdArray = selectIdVal.split('$');
			if(selectIdArray){
				selectIdVal = '';
				for(var i=0,length=selectIdArray.length;i<length;i++){
					if(selectIdArray[i]){
						selectIdVal += selectIdArray[i] + ',';
					}
				}
			}
		}
		myApp.showPreloader('页面加载中...');
		$.ajax({
			url : '/defaultroot/newperson/personList.controller',
			type : 'post',
			data : {'selectType':selectType,'selectName':selectName,'selectId':selectId,
					'selectNameVal':$('#'+selectName).val(),'selectIdVal':selectIdVal,'range':range},
			success : function(data){
				$('#selectContent').append(data);
				hiddenContent(0);
				myApp.hidePreloader();
			}
		});
	}
</script>
</body>