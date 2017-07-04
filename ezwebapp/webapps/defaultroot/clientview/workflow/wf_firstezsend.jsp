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
				<input id="frommodule" type="hidden" name="frommodule" value="${param.frommodule}" />
				<input id="menuId" type="hidden" name="menuId" value="${param.menuId}" />
				<input id="menuName" type="hidden" name="menuName" value="${param.menuName}" />
		     	<input type="hidden" id="scopeId" name="scopeId" value=""/>
			 	<input type="hidden" id="activityName" name="activityName" value=""/>
			 	<input type="hidden" id="activityType" name="activityType" value=""/>
		     	<input type="hidden" id="businessId" name="businessId" value="${businessId}"/>
			 	<input type="hidden" id="processId" name="processId" value="${param.processId}"/>
			 	<c:set var="mainLinkFile">${param.mainLinkFile}</c:set>
			 	<c:choose>
			 		<c:when test="${not empty mainLinkFile}">
			 			<input type="hidden" id="mainLinkFile" name="mainLinkFile" value="${param.mainLinkFile}"/>
			 		</c:when>
			 		<c:otherwise>
			 			<input type="hidden" id="mainLinkFile" name="mainLinkFile" value=""/>
			 		</c:otherwise>
			 	</c:choose>
			 	<c:if test="${not empty docXml}">
				<x:parse xml="${docXml}" var="doc"/>
					<input type="hidden" id="gateNum" name="gateNum" value="<x:out select="$doc//gateNum/text()"/>"/>
				</c:if>
				<input type="hidden"  name="docTitle" value="${docTitle }"/>
				<c:set var="docTitle" value="${docTitle }"></c:set>
				<c:set var="gateType"><x:out select="$doc//gateType/text()"/></c:set>
				<input type="hidden" id="gateType" name="gateType" value="${gateType}"/>
				<c:choose>
					<c:when test="${gateType == 'XX'}">
						<x:forEach select="$doc//activityList/activity" var="n" varStatus="statusc">
							<c:set var="activityId"><x:out select="$n//activityId/text()"/></c:set>
							<c:set var="scopeType"><x:out select="$n/scopeType/text()"/></c:set>
							<%--处理办理人只有一个人的情况--%>
							<%
							int scopeIdLength =0;
							%>
							<c:set var="scopeId"><x:out select="$n/scopeId/text()"/></c:set>
							<c:if test="${scopeId !=null && scopeId !=''}">
							<%
							String scopeId =(String)pageContext.getAttribute("scopeId");
							if(scopeId.indexOf("*") <0 && scopeId.indexOf("@") <0){
								scopeId =scopeId.replaceAll("\\$",",");
								scopeId =scopeId.replaceAll(",,",",");
								scopeId =scopeId.substring(scopeId.indexOf(",")+1, scopeId.lastIndexOf(","));
								String[] scopeIds =scopeId.split(",");
								if(scopeIds !=null && scopeIds.length >0){
									scopeIdLength =scopeIds.length;
								}
							}
							%>
							</c:if>
							<c:set var="scopeIdLength" value="<%=scopeIdLength %>"></c:set>
							<%--处理办理人只有一个人的情况--%>
							<div class="panel-con">
				                <p class="panel-title-p">下一办理环节：</p>
				                <div class="panel-direct2" style="background-color: #fff;">
				                  <ul class="edit-radio">
				                    <li>
				                      <label class="label-checkbox item-content">
				                        <input type="checkbox" name="activity" id='activity<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/activityId/text()"/>' checked="true">
					                    <span class="edit-radio-l"><x:out select="$n/activityName/text()"/></span>
				                      </label>
				                       <input type="hidden" id='activityName<x:out select="$n/activityId/text()"/>' name='activityName<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/activityName/text()"/>'/>
			            			   <input type="hidden" id='activityType<x:out select="$n/activityId/text()"/>' name='activityType<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/activityType/text()"/>'/>
				                    </li>
				                  </ul>
				                </div>
				            </div>
				            <div class="panel-con" <c:if test="${activityId eq '-2'}">style="display : none;"</c:if>>
				                <p class="panel-title-p">下一办理人：</p>
				                <div class="panel-direct">
				                	<x:if select="$n/scopeType/text() = 'default_users' ">
										<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
										<input type="hidden" id='userId<x:out select="$n/activityId/text()"/>' name='userId<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/scopeId/text()"/>'/>
										<span class="panel-span" onclick="$(this).next('input').click()"><x:out select="$n/scopeName/text()"/></span>
										<input placeholder="请选择" type="hidden"   id='userName<x:out select="$n/activityId/text()"/>' name='userName<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/scopeName/text()"/>' class="edit-ipt-r"  readonly="readonly" onclickb='selectUser("1","userName<x:out select="$n/activityId/text()"/>","userId<x:out select="$n/activityId/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
									</x:if>
									<x:if select="$n/scopeType/text() = 'scopes_user' ">
										<c:if test="${scopeId !=null && scopeId !=''}">
											<c:if test="${scopeIdLength =='1'}">
												<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
												<input type="hidden" id='userId<x:out select="$n/activityId/text()"/>' name='userId<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/scopeId/text()"/>'/>
												<input type="text" id='userName<x:out select="$n/activityId/text()"/>' name='userName<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/scopeName/text()"/>' class="edit-ipt-r" readonly="readonly"/>
											</c:if>
											<c:if test="${scopeIdLength !='1'}">
												<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
												<input type="hidden" id='userId<x:out select="$n/activityId/text()"/>' name='userId<x:out select="$n/activityId/text()"/>' value=""/>
												<input placeholder="请选择" type="text" id='userName<x:out select="$n/activityId/text()"/>' name='userName<x:out select="$n/activityId/text()"/>' value="" class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName<x:out select="$n/activityId/text()"/>","userId<x:out select="$n/activityId/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
											</c:if>
										</c:if>
										<c:if test="${scopeId ==null || scopeId ==''}">
											<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
											<input type="hidden" id='userId<x:out select="$n/activityId/text()"/>' name='userId<x:out select="$n/activityId/text()"/>' value=""/>
											<input placeholder="请选择" type="text" id='userName<x:out select="$n/activityId/text()"/>' name='userName<x:out select="$n/activityId/text()"/>' value="" class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName<x:out select="$n/activityId/text()"/>","userId<x:out select="$n/activityId/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
										</c:if>
									</x:if>
									<c:if test="${scopeType != 'scopes_user' && scopeType != 'default_users' }">
									    <c:if test="${scopeIdLength =='1'}">
											<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
											<input type="hidden" id='userId<x:out select="$n/activityId/text()"/>' name='userId<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/scopeId/text()"/>'/>
											<input type="text" id='userName<x:out select="$n/activityId/text()"/>' name='userName<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/scopeName/text()"/>' class="edit-ipt-r" readonly="readonly"/>
										</c:if>
										<c:if test="${scopeIdLength !='1'}">
											<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
											<input type="hidden" id='userId<x:out select="$n/activityId/text()"/>' name='userId<x:out select="$n/activityId/text()"/>' value=""/>
											<input placeholder="请选择" type="text" id='userName<x:out select="$n/activityId/text()"/>' name='userName<x:out select="$n/activityId/text()"/>' value="" class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName<x:out select="$n/activityId/text()"/>","userId<x:out select="$n/activityId/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
										</c:if>
									</c:if>
				                </div>
				            </div>
						</x:forEach>
					</c:when>
					<c:when test="${gateType == 'XAND'}">
						<x:forEach select="$doc//activityList/activity" var="n" varStatus="statusc">
							<c:set var="activityId"><x:out select="$n//activityId/text()"/></c:set>
							<c:set var="scopeType"><x:out select="$n/scopeType/text()"/></c:set>
							<%--处理办理人只有一个人的情况--%>
							<%
							int scopeIdLength =0;
							%>
							<c:set var="scopeId"><x:out select="$n/scopeId/text()"/></c:set>
							<c:if test="${scopeId !=null && scopeId !=''}">
							<%
							String scopeId =(String)pageContext.getAttribute("scopeId");
							if(scopeId.indexOf("*") <0 && scopeId.indexOf("@") <0){
								scopeId =scopeId.replaceAll("\\$",",");
								scopeId =scopeId.replaceAll(",,",",");
								scopeId =scopeId.substring(scopeId.indexOf(",")+1, scopeId.lastIndexOf(","));
								String[] scopeIds =scopeId.split(",");
								if(scopeIds !=null && scopeIds.length >0){
									scopeIdLength =scopeIds.length;
								}
							}
							%>
							</c:if>
							<c:set var="scopeIdLength" value="<%=scopeIdLength %>"></c:set>
							<%--处理办理人只有一个人的情况--%>
							<div class="panel-con">
				                <p class="panel-title-p">下一办理环节：</p>
				                <div class="panel-direct2" style="background-color: #fff;">
				                  <ul class="edit-radio">
				                    <li>
				                      <label class="label-checkbox item-content">
				                        <input onclick="return false;" type="checkbox" name="activity" id='activity<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/activityId/text()"/>' checked="true">
					                    <span class="edit-radio-l"><x:out select="$n/activityName/text()"/></span>
				                      </label>
				                        <input type="hidden" id='activityName<x:out select="$n/activityId/text()"/>' name='activityName<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/activityName/text()"/>'/>
			            				<input type="hidden" id='activityType<x:out select="$n/activityId/text()"/>' name='activityType<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/activityType/text()"/>'/>
				                    </li>
				                  </ul>
				                </div>
				            </div>
				            <div class="panel-con" <c:if test="${activityId eq '-2'}">style="display : none;"</c:if>>
				                <p class="panel-title-p">下一办理人：</p>
				                <div class="panel-direct">
				                	<x:if select="$n/scopeType/text() = 'default_users' ">
										<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
										<input type="hidden" id='userId<x:out select="$n/activityId/text()"/>' name='userId<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/scopeId/text()"/>'/>
										<span class="panel-span" onclick="$(this).next('input').click()"><x:out select="$n/scopeName/text()"/></span>
										<input type="hidden" placeholder="请选择" id='userName<x:out select="$n/activityId/text()"/>' name='userName<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/scopeName/text()"/>' class="edit-ipt-r"  readonly="readonly" onclickd='selectUser("1","userName<x:out select="$n/activityId/text()"/>","userId<x:out select="$n/activityId/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
									</x:if>
									<x:if select="$n/scopeType/text() = 'scopes_user' ">
										<c:if test="${scopeId !=null && scopeId !=''}">
											<c:if test="${scopeIdLength =='1'}">
												<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
												<input type="hidden" id='userId<x:out select="$n/activityId/text()"/>' name='userId<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/scopeId/text()"/>'/>
												<input type="text" id='userName<x:out select="$n/activityId/text()"/>' name='userName<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/scopeName/text()"/>' class="edit-ipt-r" readonly="readonly"/>
											</c:if>
											<c:if test="${scopeIdLength !='1'}">
												<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
												<input type="hidden" id='userId<x:out select="$n/activityId/text()"/>' name='userId<x:out select="$n/activityId/text()"/>' value=""/>
												<input placeholder="请选择" type="text" id='userName<x:out select="$n/activityId/text()"/>' name='userName<x:out select="$n/activityId/text()"/>' value="" class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName<x:out select="$n/activityId/text()"/>","userId<x:out select="$n/activityId/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
											</c:if>
										</c:if>
										<c:if test="${scopeId ==null || scopeId ==''}">
											<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
											<input type="hidden" id='userId<x:out select="$n/activityId/text()"/>' name='userId<x:out select="$n/activityId/text()"/>' value=""/>
											<input placeholder="请选择" type="text" id='userName<x:out select="$n/activityId/text()"/>' name='userName<x:out select="$n/activityId/text()"/>' value="" class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName<x:out select="$n/activityId/text()"/>","userId<x:out select="$n/activityId/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
										</c:if>
									</x:if>
									<c:if test="${scopeType != 'scopes_user' && scopeType != 'default_users' }">
									    <c:if test="${scopeIdLength =='1'}">
											<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
											<input type="hidden" id='userId<x:out select="$n/activityId/text()"/>' name='userId<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/scopeId/text()"/>'/>
											<input type="text" id='userName<x:out select="$n/activityId/text()"/>' name='userName<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/scopeName/text()"/>' class="edit-ipt-r" readonly="readonly"/>
										</c:if>
										<c:if test="${scopeIdLength !='1'}">
											<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
											<input type="hidden" id='userId<x:out select="$n/activityId/text()"/>' name='userId<x:out select="$n/activityId/text()"/>' value=""/>
											<input placeholder="请选择" type="text" id='userName<x:out select="$n/activityId/text()"/>' name='userName<x:out select="$n/activityId/text()"/>' value="" class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName<x:out select="$n/activityId/text()"/>","userId<x:out select="$n/activityId/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
                                        </c:if>
									</c:if>
				                </div>
				            </div>
						</x:forEach>
					</c:when>
					<c:otherwise>
						<c:set var="isdefaultusers" value="0"/>
						<div class="panel-con">
			                <p class="panel-title-p">下一办理环节：</p>
			                <div class="panel-direct" style="position:relative;">
			                   <c:if test="${not empty docXml}">
									<x:parse xml="${docXml}" var="doc"/>
									<c:set var="nextActivityListNum" value="0"/>
									<x:forEach select="$doc//activityList/activity" var="n" varStatus="statusc">
										<c:set var="nextActivityListNum" value="${nextActivityListNum+1}"/>
										<c:set var="activitys"><x:out select="$n/activityId/text()"/></c:set>
										<c:set var="activityName1"><x:out select="$n/activityName/text()"/></c:set>
										<x:if select="$n/scopeType/text() = 'default_users' ">
											<c:set var="isdefaultusers" value="1"/>
										</x:if>
									</x:forEach>
									<c:if test="${nextActivityListNum == 1}">
										<div class="edit-sel-show">
											<p>${activityName1}</p>
										</div>
										<select onchange="setSpanHtml(this);" class="btn-bottom-pop" name="activity"  id="activity" prompt="请选择下一办理环节">
											<option selected="true" value="${activitys}">${activityName1}</option>
										 </select> 
									</c:if>
									<c:if test="${nextActivityListNum != 1}">
										<div class="edit-sel-show">
											<p>请选择</p>
										</div>
										<select onchange="setSpanHtml(this);" class="btn-bottom-pop" name="activity"  id="activity" prompt="请选择下一办理环节">
										 	<option value="">请选择</option>
										 	<x:forEach select="$doc//activityList/activity" var="n" varStatus="statusc">
												<c:set var="activityclass"><x:out select="$doc//activityClass/text()"/></c:set>
												<option value='<x:out select="$n/activityId/text()"/>'><x:out select="$n/activityName/text()"/></option>
												<x:if select="$n/scopeType/text() = 'default_users' ">
													<x:if select="$n/isDefaultActivity/text() = '1' ">
														<c:set var="isdefaultusers" value="1"/>
													</x:if>
												</x:if>
											</x:forEach>
										 </select> 
									</c:if>		
								</c:if>
				             </div>
			            </div>
			            <div class="panel-con" id="person">
			                <p class="panel-title-p">下一办理人：</p>
			                <div class="panel-direct">
			                	<input type="hidden" id='scopeId' name='scopeId' value='' />
								<input type="hidden" id="userId"  name="userId"  value=""/>
								<!--<span class="panel-span" onclick="$(this).next('input').click()"></span>
		           				--><input type="text" placeholder="请选择" id='userName' name='userName' value='' class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName","userId",$("#scopeId").val());'/>
			                </div>
			            </div>
					</c:otherwise>
				</c:choose>
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
		<c:if test="${not empty docXml}">
			<x:parse xml="${docXml}" var="doc"/>
			if($('#activity')==null || $('#activity').val() == undefined){
				return;
			}
			if($('#activity').val() =='' || $('#activity').val() =='-2' || $('#activity').val() =='-100'){
				$('#person').hide();
			}else{
				$('#person').show();
			}

			<x:forEach select="$doc//activityList/activity" var="n" >
				$('#activityName').val('<x:out select="$n/activityName/text()"/>');
				$('#activityType').val('<x:out select="$n/activityType/text()"/>');
				if('<x:out select="$n/activityId/text()"/>' == $('#activity').val()){
					if('<x:out select="$n/scopeType/text()"/>' == 'default_users'){
						$('#userId').val('<x:out select="$n/scopeId/text()"/>');
						$('#userName').val('<x:out select="$n/scopeName/text()"/>');
          	 			$('#scopeId').val('<x:out select="$n/scopeId/text()"/>');
					}else if('<x:out select="$n/scopeType/text()"/>' == 'scopes_user'){
						$('#userName').show();
						<%
						int scopeIdLength =0;
						%>
						<c:set var="scopeId"><x:out select="$n/scopeId/text()"/></c:set>
						<c:if test="${scopeId !=null && scopeId !=''}">
						<%
						String scopeId =(String)pageContext.getAttribute("scopeId");
						if(scopeId.indexOf("*") <0 && scopeId.indexOf("@") <0){
							scopeId =scopeId.replaceAll("\\$",",");
							scopeId =scopeId.replaceAll(",,",",");
							scopeId =scopeId.substring(scopeId.indexOf(",")+1, scopeId.lastIndexOf(","));
							String[] scopeIds =scopeId.split(",");
							if(scopeIds !=null && scopeIds.length >0){
								scopeIdLength =scopeIds.length;
							}
						}
						%>
						</c:if>
						<c:set var="scopeIdLength" value="<%=scopeIdLength %>"></c:set>
						<c:if test="${scopeId !=null && scopeId !=''}">
							<c:if test="${scopeIdLength =='1'}">
								$('#userId').val('<x:out select="$n/scopeId/text()"/>');
								$('#userName').val('<x:out select="$n/scopeName/text()"/>');
							</c:if>
							<c:if test="${scopeIdLength !='1'}">
								$('#userId').val('');
								$('#userName').val('');
							</c:if>
						</c:if>
						<c:if test="${scopeId ==null || scopeId ==''}">
							$('#userId').val('');
							$('#userName').val('');
						</c:if>
						$('#scopeId').val('<x:out select="$n/scopeId/text()"/>');
					}else{
						$('#userId').val('');
          	 			$('#userName').val('');
          	 			$('#scopeId').val('<x:out select="$n/scopeId/text()"/>');
          	 			$('#userName').css("display","");
					}
				}
			</x:forEach>
		</c:if>
	}
	function send(){
		var url ='/defaultroot/workflow/sendezflowprocess.controller';
		<c:if test="${not empty docXml}">
			<x:parse xml="${docXml}" var="doc"/>
			<c:set var="gateType"><x:out select="$doc//gateType/text()"/></c:set>
			<c:if test="${gateType == 'XAND'}">
				<x:forEach select="$doc//activityList/activity" var="n" varStatus="statusc"> 
					<c:set var="id"><x:out select="$n//activityId/text()"/></c:set>
					<c:set var="scopeType"><x:out select="$n/scopeType/text()"/></c:set>
					if('<x:out select="$n/activityId/text()"/>' != '-100' && '<x:out select="$n/activityId/text()"/>' != '-2' && document.getElementById('userId<x:out select="$n/activityId/text()"/>').value == ''){
						myApp.alert('<x:out select="$n/activityName/text()"/>办理人不能为空');
						return false;
					}
				</x:forEach>
				ajaxSend(url);
				return;
			</c:if>
			
			<c:if test="${gateType == 'XX'}">
				var selected = false;
				<x:forEach select="$doc//activityList/activity" var="n" varStatus="statusc">
					<c:set var="id"><x:out select="$n//activityId/text()"/></c:set>
					<c:set var="scopeType"><x:out select="$n/scopeType/text()"/></c:set>
					if(document.getElementById('activity<x:out select="$n/activityId/text()"/>').checked){
						selected = true;
						if('<x:out select="$n/activityId/text()"/>' != '-100' && '<x:out select="$n/activityId/text()"/>' != '-2' && document.getElementById('userId<x:out select="$n/activityId/text()"/>').value == ''){
							myApp.alert('<x:out select="$n/activityName/text()"/>办理人不能为空');
							return false;
						}
					}
				</x:forEach>
				if(!selected){
					myApp.alert('请至少选择一个节点！');
					return false;
				}
				ajaxSend(url);
				return;
			</c:if>
			if(($('#activity') ==null || $('#activity').val() =='')){
				myApp.alert("请选择下一节点!");
			}else{
				if($('#activity').val() !='' && $('#activity').val() !='-2' && $('#activity').val() !='-100'){
					if($('#userName') != null && $('#userName').val() == ''){
						myApp.alert('办理人不能为空');
						return false;
					}
				}
				ajaxSend(url);
			}
		</c:if>
	}
	var backFlag='0';
	function ajaxSend(url){
		if(backFlag=='1'){
			return;
		}
		backFlag='1';
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
		$.ajax({
			type: 'POST',
			url: url,
			data: $('#sendForm').serialize(),
			async: true,
			dataType: 'text',
			success: function(data){
				var json = eval("("+data+")");
				myApp.hidePreloader();
				if(json!=null){
					if(json.result == 'success'){
						myApp.alert("发送成功！");
						window.history.go(-2);
					}else{
						backFlag='0';
						myApp.alert("发送失败！");
					}
				}
			},
			error: function(){
				backFlag='0';
				myApp.alert("异常！");
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