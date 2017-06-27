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
  <link rel="stylesheet" href="/defaultroot/clientview/template/css/template.style.ios.min.css" />
  <link rel="stylesheet" href="/defaultroot/clientview/template/css/template.webapp-style.min.css" />
</head>
<%
	String worktitle = request.getParameter("worktitle")==null?"":request.getParameter("worktitle");
	String workcurstep = request.getParameter("workcurstep")==null?"":request.getParameter("workcurstep");
	String worksubmittime = request.getParameter("worksubmittime")==null?"":request.getParameter("worksubmittime");
	String workStatus = request.getParameter("workStatus")==null?"":request.getParameter("workStatus");
	String userId = session.getAttribute("userId").toString();
%>
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
              <c:if test="${not empty docXml}">
				<x:parse xml="${docXml}" var="doc"/>
				<form id="sendForm" class="dialog" action="/defaultroot/workflow/updateprocess2.controller" method="post">
			            <input type="hidden" name="workId" id="workId" value="${param.workId}" />
						<input type="hidden" name="comment" id="comment" value="${param.comment_input}" />
						<input type="hidden" name="commentAttitudeType" id="commentAttitudeType" value="${param.commentAttitudeType}" />
						<input type="hidden" name="commentType" id="commentType" value="${commentType}" />
						<input type="hidden" id="docTitle" name="docTitle" value="${docTitle }"/>
						<input type="hidden" id="commentField" name="commentField" value="${param.curCommField}"/>
						<input type="hidden" id="activityclassId" value="${param.activityclass}" name="activityclassId"></input>
						<input type="hidden" id="afterInsertTaskIds" name="afterInsertTaskIds" value='<x:out select="$doc//afterInsertTaskIds/text()"/>' />
						<input type="hidden" id="beginForkActivityId" name="beginForkActivityId" value='<x:out select="$doc//beginForkActivityId/text()"/>' />
						<input type="hidden" id="beginForkActivityName" name="beginForkActivityName" value='<x:out select="$doc//beginForkActivityName/text()"/>' />
						<input type="hidden" id="toJoinActivityId" name="toJoinActivityId" value='<x:out select="$doc//toJoinActivityId/text()"/>' />
						<input type="hidden" name="_mainfile_commentacc" id="_mainfile_commentacc" value="${commentAcc}" />
						<input type="hidden" id="fromFlag" name="fromFlag"  value="${param.fromFlag}" />
		
						<!--gateType  XOR或者空时：多个活动选一个  XAND：多个活动都选  XX：多个活动选择多个-->
						<c:set var="gateType"><x:out select="$doc//gateType/text()"/></c:set>
						<input type="hidden" id="gateType" name="gateType" value="${gateType}"/>
						<c:set var="workType">${workType}</c:set>
						<input type="hidden" id="workType" name="workType" value="${workType}"/>
						<c:set var="comment_input">${comment_input}</c:set>
						<input type="hidden" id="comment_input" name="comment_input" value="${comment_input}"/>
			            <c:choose>
							<c:when test="${gateType == 'XX'}">
								<x:forEach select="$doc//nextActivityList" var="n" varStatus="statusc">
									<c:set var="id"><x:out select="$n//id/text()"/></c:set>
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
						                        <input type="checkbox" name="activity" id='activity<x:out select="$n/id/text()"/>' value='<x:out select="$n/id/text()"/>' <c:if test="${id != '-2'}">checked="true"</c:if> />
							                    <span class="edit-radio-l"><x:out select="$n/name/text()"/></span>
						                      </label>
						                    </li>
						                  </ul>
						                </div>
						            </div>
						            <div class="panel-con" <c:if test="${id eq '-2'}">style="display : none;"</c:if>>
						                <p class="panel-title-p">下一办理人：</p>
						                <div class="panel-direct">
						                   <x:if select="$n/scopeType/text() = 'default_users' ">
												<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
												<input type="hidden" id='userId<x:out select="$n/id/text()"/>' name='userId<x:out select="$n/id/text()"/>' value='<x:out select="$n/scopeId/text()"/>'/>
												<span class="panel-span" onclick="$(this).next('input').click()"><x:out select="$n/scopeName/text()"/></span>
												<input placeholder="请选择" type="hidden"   id='userName<x:out select="$n/id/text()"/>' name='userName<x:out select="$n/id/text()"/>' value='<x:out select="$n/scopeName/text()"/>' class="edit-ipt-r"  readonly="readonly" onclickb='selectUser("1","userName<x:out select="$n/id/text()"/>","userId<x:out select="$n/id/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
											</x:if>
											<x:if select="$n/scopeType/text() = 'scopes_user' ">
												<c:if test="${scopeId !=null && scopeId !=''}">
													<c:if test="${scopeIdLength =='1'}">
														<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
														<input type="hidden" id='userId<x:out select="$n/id/text()"/>' name='userId<x:out select="$n/id/text()"/>' value='<x:out select="$n/scopeId/text()"/>'/>
														<input type="text" id='userName<x:out select="$n/id/text()"/>' name='userName<x:out select="$n/id/text()"/>' value='<x:out select="$n/scopeName/text()"/>' class="edit-ipt-r" readonly="readonly"/>
													</c:if>
													<c:if test="${scopeIdLength !='1'}">
														<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
														<input type="hidden" id='userId<x:out select="$n/id/text()"/>' name='userId<x:out select="$n/id/text()"/>' value=""/>
														<input placeholder="请选择" type="text" id='userName<x:out select="$n/id/text()"/>' name='userName<x:out select="$n/id/text()"/>' value="" class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName<x:out select="$n/id/text()"/>","userId<x:out select="$n/id/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
													</c:if>
												</c:if>
												<c:if test="${scopeId ==null || scopeId ==''}">
													<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
													<input type="hidden" id='userId<x:out select="$n/id/text()"/>' name='userId<x:out select="$n/id/text()"/>' value=""/>
													<input placeholder="请选择" type="text" id='userName<x:out select="$n/id/text()"/>' name='userName<x:out select="$n/id/text()"/>' value="" class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName<x:out select="$n/id/text()"/>","userId<x:out select="$n/id/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
												</c:if>
											</x:if>
											<c:if test="${scopeType != 'scopes_user' && scopeType != 'default_users' }">
											  <c:if test="${scopeIdLength =='1'}">
													<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
													<input type="hidden" id='userId<x:out select="$n/id/text()"/>' name='userId<x:out select="$n/id/text()"/>' value='<x:out select="$n/scopeId/text()"/>'/>
													<input type="text" id='userName<x:out select="$n/id/text()"/>' name='userName<x:out select="$n/id/text()"/>' value='<x:out select="$n/scopeName/text()"/>' class="edit-ipt-r" readonly="readonly"/>
												</c:if>
												<c:if test="${scopeIdLength !='1'}">
													<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
													<input type="hidden" id='userId<x:out select="$n/id/text()"/>' name='userId<x:out select="$n/id/text()"/>' value=""/>
													<input placeholder="请选择" type="text" id='userName<x:out select="$n/id/text()"/>' name='userName<x:out select="$n/id/text()"/>' value="" class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName<x:out select="$n/id/text()"/>","userId<x:out select="$n/id/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
												</c:if>
											</c:if>
						                </div>
						            </div>
								</x:forEach>
							</c:when>
							<c:when test="${gateType == 'XAND'}">
								<x:forEach select="$doc//nextActivityList" var="n" varStatus="statusc">
									<c:set var="id"><x:out select="$n//id/text()"/></c:set>
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
						                        <input onclick="return false;" type="checkbox" name="activity" id='activity<x:out select="$n/id/text()"/>' value='<x:out select="$n/id/text()"/>' <c:if test="${id != '-2'}">checked="true"</c:if> />
							                    <span class="edit-radio-l"><x:out select="$n/name/text()"/></span>
						                      </label>
						                    </li>
						                  </ul>
						                </div>
						            </div>
						            <div class="panel-con" <c:if test="${id eq '-2'}">style="display : none;"</c:if>>
						                <p class="panel-title-p">下一办理人：</p>
						                <div class="panel-direct">
						                   <x:if select="$n/scopeType/text() = 'default_users' ">
												<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
												<input type="hidden" id='userId<x:out select="$n/id/text()"/>' name='userId<x:out select="$n/id/text()"/>' value='<x:out select="$n/scopeId/text()"/>'/>
												<span class="panel-span" onclick="$(this).next('input').click()"><x:out select="$n/scopeName/text()"/></span>
												<input type="hidden" placeholder="请选择" id='userName<x:out select="$n/id/text()"/>' name='userName<x:out select="$n/id/text()"/>' value='<x:out select="$n/scopeName/text()"/>' class="edit-ipt-r"  readonly="readonly" onclickd='selectUser("1","userName<x:out select="$n/id/text()"/>","userId<x:out select="$n/id/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
											</x:if>
											<x:if select="$n/scopeType/text() = 'scopes_user' ">
												<c:if test="${scopeId !=null && scopeId !=''}">
													<c:if test="${scopeIdLength =='1'}">
														<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
														<input type="hidden" id='userId<x:out select="$n/id/text()"/>' name='userId<x:out select="$n/id/text()"/>' value='<x:out select="$n/scopeId/text()"/>'/>
														<input type="text" id='userName<x:out select="$n/id/text()"/>' name='userName<x:out select="$n/id/text()"/>' value='<x:out select="$n/scopeName/text()"/>' class="edit-ipt-r" readonly="readonly"/>
													</c:if>
													<c:if test="${scopeIdLength !='1'}">
														<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
														<input type="hidden" id='userId<x:out select="$n/id/text()"/>' name='userId<x:out select="$n/id/text()"/>' value=""/>
														<input placeholder="请选择" type="text" id='userName<x:out select="$n/id/text()"/>' name='userName<x:out select="$n/id/text()"/>' value="" class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName<x:out select="$n/id/text()"/>","userId<x:out select="$n/id/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
													</c:if>
												</c:if>
												<c:if test="${scopeId ==null || scopeId ==''}">
													<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
													<input type="hidden" id='userId<x:out select="$n/id/text()"/>' name='userId<x:out select="$n/id/text()"/>' value=""/>
													<input placeholder="请选择" type="text" id='userName<x:out select="$n/id/text()"/>' name='userName<x:out select="$n/id/text()"/>' value="" class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName<x:out select="$n/id/text()"/>","userId<x:out select="$n/id/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
												</c:if>
											</x:if>
											<c:if test="${scopeType != 'scopes_user' && scopeType != 'default_users' }">
                                                <c:if test="${scopeIdLength =='1'}">
													<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
													<input type="hidden" id='userId<x:out select="$n/id/text()"/>' name='userId<x:out select="$n/id/text()"/>' value='<x:out select="$n/scopeId/text()"/>'/>
													<input type="text" id='userName<x:out select="$n/id/text()"/>' name='userName<x:out select="$n/id/text()"/>' value='<x:out select="$n/scopeName/text()"/>' class="edit-ipt-r" readonly="readonly"/>
												</c:if>
												<c:if test="${scopeIdLength !='1'}">
													<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
													<input type="hidden" id='userId<x:out select="$n/id/text()"/>' name='userId<x:out select="$n/id/text()"/>' value=""/>
													<input placeholder="请选择" type="text" id='userName<x:out select="$n/id/text()"/>' name='userName<x:out select="$n/id/text()"/>' value="" class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName<x:out select="$n/id/text()"/>","userId<x:out select="$n/id/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
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
					                <div class="panel-direct2" style="background-color: #fff;">
					                  <input type="hidden" id="activity" name="activity" value=""/>
					                  <ul class="edit-radio" id="activityLi">
						                    <c:set var="nextActivityListNum" value="0"/>
											 <x:forEach select="$doc//nextActivityList" var="n" varStatus="statusc">
												<c:set var="nextActivityListNum" value="${nextActivityListNum+1}"/>
											</x:forEach>
											<c:if test="${nextActivityListNum == 1}">
												<x:forEach select="$doc//nextActivityList" var="n" varStatus="statusc">
													<x:if select="$n/scopeType/text() = 'default_users' ">
														<c:set var="isdefaultusers" value="1"/>
													</x:if>
													<c:set var="activitys"><x:out select="$n/id/text()"/></c:set>
													<li onclick="hiddenEnd('<x:out select="$n/id/text()"/>')">
								                      <label class="label-radio item-content">
								                        <input type="radio" name="my-radio" id='activity<x:out select="$n/id/text()"/>' checked="checked" value="<x:out select="$n/id/text()"/>">
								                        <span class="edit-radio-l"><x:out select="$n/name/text()"/></span>
								                      </label>
								                    </li>
												</x:forEach>
											</c:if>
											<c:if test="${nextActivityListNum != 1}">
												<x:forEach select="$doc//nextActivityList" var="n" varStatus="statusc">
													<li onclick="hiddenEnd('<x:out select="$n/id/text()"/>')">
								                      <label class="label-radio item-content">
								                        <input type="radio" name="my-radio" id='activity<x:out select="$n/id/text()"/>' <c:if test="${param.activityclass == '3'}">checked="checked"</c:if> <x:if select="$n/isDefaultActivity/text() = '1'">checked="checked"</x:if>  value="<x:out select="$n/id/text()"/>">
								                        <span class="edit-radio-l"><x:out select="$n/name/text()"/></span>
								                      </label>
								                    </li>
													<x:if select="$n/scopeType/text() = 'default_users' ">
														<x:if select="$n/isDefaultActivity/text() = '1' ">
															<c:set var="isdefaultusers" value="1"/>
														</x:if>
													</x:if>
												</x:forEach>
											</c:if>
					                  </ul>
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
						<c:if test="${workType == '0'}">
							<x:forEach select="$doc//nextActivityList" var="n" varStatus="statusc">
								<c:set var="id"><x:out select="$n//id/text()"/></c:set>
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
								<div class="panel-con" id="person">
					                <p class="panel-title-p">下一办理人：</p>
					                <div class="panel-direct">
					                    <c:set var="scopeType"><x:out select="$n//scopeType/text()"/></c:set>
									<x:if select="$n//scopeType/text() = 'default_users' ">
										<input type="hidden" id='chooseUserId' name='chooseUserId' value='<x:out select="$n//scopeId/text()"/>' />
										<input type="text"   readonly="readonly" id='chooseUserName' name='chooseUserName' value='<x:out select="$n//scopeName/text()"/>' class="edit-ipt-r" />
									</x:if>
									<x:if select="$n//scopeType/text() = 'scopes_user' ">
										<input type="hidden" id='chooseUserId' name='chooseUserId' value='' />
										<input placeholder="请选择" type="text"   readonly="readonly" id='chooseUserName' name='chooseUserName' value='' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","chooseUserName","chooseUserId","<x:out select="$n//scopeId/text()"/>");'/>
									</x:if>
									<c:if test="${scopeType != 'scopes_user' && scopeType != 'default_users' }">
										<input type="hidden" id='chooseUserId' name='chooseUserId' value='' />
										<input placeholder="请选择" type="text"   readonly="readonly" id='chooseUserName' name='chooseUserName' value='' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","chooseUserName","chooseUserId","<x:out select="$n//scopeId/text()"/>");'/>
									</c:if>
					                </div>
					            </div>
							</x:forEach>
						</c:if>
					</div>
				</form>
			  </c:if>
            </div>
          </div>
        </section>
        <c:if test="${workType != '0'}">
            <div class="panel-btn" id="footerButton">
	           <div class="panel-btn-div">
	              <a href="javascript:onSubmit();" class="panel-btn-a panel-close">发送</a>
	           </div>
	        </div>
		</c:if>
		<c:if test="${workType == '0'}">
            <div class="panel-btn panel-btn2" id="footerButton">
	          <div class="panel-btn-div">
	             <a href="javascript:send();" class="panel-btn-a panel-close">发送</a>
			     <a href="javascript:onSubmit();" class="panel-btn-a panel-close">结束流程</a>
	          </div>
	        </div> 
		</c:if>
       <section id="selectContent" style="display:none">
		</section>
        </div>
      </div>
    </div>
  </div>
<script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
<script type="text/javascript"><!--
  var myApp = new Framework7();
  var mainView = myApp.addView('.view');
  var $$ = Dom7;
  //右下角菜单弹框
  $$('#fbtn-more').on('click', function () {
    var clickedLink = this;
    myApp.popover('#fbtn-more-con', clickedLink);
    myApp.closeModal('#fbtn-more-list a')
  });
 $(document).ready(function(){
	var optionLen = $('#activityLi li').length;
	if(optionLen > 0){
		var cbUserId ="";
		$('input[name="my-radio"]:checked').each(function(){ 
			cbUserId =$(this).val();
		});
		hiddenEnd(cbUserId);
	}else{
		hiddenEnd();
	}

    //如果是并行下一活动办理完毕 在保存表单时候自动办理流程
	var url ='/defaultroot/workflow/updateprocess2.controller';
	<c:if test="${not empty docXml}">
	<x:parse xml="${docXml}" var="doc"/>
		<x:forEach select="$doc//nextActivityList" var="n" varStatus="statusc"> 
			<c:set var="id"><x:out select="$n//id/text()"/></c:set>
			if('<x:out select="$n/id/text()"/>' == '-100'){
				ajaxSend(url);
			}
		</x:forEach>
	</c:if>
 });

	//设置span中的值
	function setSpanHtml(obj,selectVal){
	   	if(!selectVal){
	   		selectVal = $(obj).find("option:selected").text();
	   	}
		$(obj).parent().find('div>p').html(selectVal);
		hiddenEnd();
	}

	function hiddenEnd(activityId){
		$('#activity').val(activityId);
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
	
			<x:forEach select="$doc//nextActivityList" var="n" >
				if('<x:out select="$n/id/text()"/>' == $('#activity').val()){
					if('<x:out select="$n/scopeType/text()"/>' == 'default_users'){
						$('#userId').val('<x:out select="$n/scopeId/text()"/>');
						var str = '<x:out select="$n/scopeName/text()"/>';
						if(str.substring((str.length -1),str.length) == ","){
							$('#userName').val('<x:out select="$n/scopeName/text()"/>');
						}else{
							$('#userName').val('<x:out select="$n/scopeName/text()"/>,');
						}
						$('#userName').css("display",""); 
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
								var str1 = '<x:out select="$n/scopeName/text()"/>';
								if(str1.substring((str1.length -1),str1.length) == ","){
									$('#userName').val('<x:out select="$n/scopeName/text()"/>');
								}else{
									$('#userName').val('<x:out select="$n/scopeName/text()"/>,');
								}
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

function onSubmit(){
	var url ='/defaultroot/workflow/updateprocess2.controller';
	<c:if test="${not empty docXml}">
		var selected = false;
		<x:parse xml="${docXml}" var="doc"/>
		<c:set var="gateType"><x:out select="$doc//gateType/text()"/></c:set>
		<c:if test="${gateType == 'XAND'}">
			<x:forEach select="$doc//nextActivityList" var="n" varStatus="statusc"> 
				<c:set var="id"><x:out select="$n//id/text()"/></c:set>
				<c:set var="scopeType"><x:out select="$n/scopeType/text()"/></c:set>
		        if(document.getElementById('activity<x:out select="$n/id/text()"/>').checked){
			        selected = true;
					if('<x:out select="$n/id/text()"/>' != '-100' && '<x:out select="$n/id/text()"/>' != '-2' && document.getElementById('userId<x:out select="$n/id/text()"/>').value == ''){
						myApp.alert('<x:out select="$n/name/text()"/>办理人不能为空');
						return false;
					}else if('<x:out select="$n/id/text()"/>' == '-2'){
						if('${isDossier}'){
							myApp.alert('该流程需要归档，请于PC端办理完毕！');
							return false;
						}
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
		
		<c:if test="${gateType == 'XX'}">
			var selected = false;
			<x:forEach select="$doc//nextActivityList" var="n" varStatus="statusc">
				<c:set var="id"><x:out select="$n//id/text()"/></c:set>
				<c:set var="scopeType"><x:out select="$n/scopeType/text()"/></c:set>
				if(document.getElementById('activity<x:out select="$n/id/text()"/>').checked){
					selected = true;
					if('<x:out select="$n/id/text()"/>' != '-100' && '<x:out select="$n/id/text()"/>' != '-2' && document.getElementById('userId<x:out select="$n/id/text()"/>').value == ''){
						myApp.alert('<x:out select="$n/name/text()"/>办理人不能为空');
						return false;
					}else if('<x:out select="$n/id/text()"/>' == '-2'){
						if('${isDossier}'){
							myApp.alert('该流程需要归档，请于PC端办理完毕！');
							return false;
						}
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
		<c:if test="${gateType != 'XX' && gateType != 'XAND'}">
			<x:forEach select="$doc//nextActivityList" var="n" varStatus="statusc">
				<c:set var="id"><x:out select="$n//id/text()"/></c:set>
				<c:set var="scopeType"><x:out select="$n/scopeType/text()"/></c:set>
				if(document.getElementById('activity<x:out select="$n/id/text()"/>').checked){
					if('<x:out select="$n/id/text()"/>' != '-100' && '<x:out select="$n/id/text()"/>' != '-2' && document.getElementById('userId').value == ''){
						myApp.alert('<x:out select="$n/name/text()"/>办理人不能为空');
						return false;
					}else if('<x:out select="$n/id/text()"/>' == '-2'){
						if('${isDossier}'){
							myApp.alert('该流程需要归档，请于PC端办理完毕！');
							return false;
						}
					}
				}
			</x:forEach>
			ajaxSend(url);
			return;			
		</c:if>
		<c:if test="${param.trantype == '1'}"> 
			ajaxSend(url);
			return;
		</c:if>
		if(($('#activity') ==null || $('#activity').val() =='') && $('#activityclassId').val() != '3'){
			myApp.alert("请选择下一节点!");
		}else{
			if($('#activityclassId').val() != '3'){
				if($('#activity').val() !='' && $('#activity').val() !='-2' && $('#activity').val() !='-100'){
					if($('#userName') != null && $('#userName').val() == ''){
						myApp.alert('办理人不能为空');
						return false;
					}
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
	var openUrl ='/defaultroot/dealfile/list.controller?workStatus=<%=workStatus%>';
	myApp.showPreloader('正在发送...');
	$.ajax({
		type: 'POST',
		url: url,
		data: $('#sendForm').serialize(),
		async: true,
		dataType: 'text',
		success: function(data){
			myApp.hidePreloader();
			var json = eval("("+data+")");
			if(json!=null){
				if(json.result == 'success'){
					myApp.alert("发送成功！");
					var fromFlag = $("#fromFlag").val();
					if(fromFlag == '1'){
						window.history.go(-2);
					}else{
						WeixinJSBridge.call('closeWindow');
					}
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

//打开选择人员页面
function selectUser(selectType,selectName,selectId,range){ 
	var selectIdVal = $('input[name="'+selectId+'"]').val();
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
		type : "post",
		data : {'selectType':selectType,'selectName':selectName,'selectId':selectId,
				'selectNameVal':$('input[name="'+selectName+'"]').val(),'selectIdVal':selectIdVal,'range':range},
		success : function(data){
			$("#selectContent").append(data);
			hiddenContent(0);
			myApp.hidePreloader();
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

//随机流程发送
	var sendFlag='0';
	function send(){ 
	    if(sendFlag=='1'){
	    	return;
	    }
	    sendFlag='1';
	    var userId = '<%=userId%>';
	    var isMustBack='${isMustBack}';
		var cbUserId =$("#chooseUserId").val();
		if(cbUserId == ""){
			myApp.alert("办理人不能为空！");
			sendFlag='0';
			return false;
		}
		if(cbUserId.indexOf(userId+',')>-1){
			myApp.alert('办理人中不能包含自己！');
			sendFlag='0';
			return false;
		}
		loadPage();
		var url ='/defaultroot/workflow/workflowTran.controller';
		var openUrl ='/defaultroot/dealfile/list.controller?workStatus=<%=workStatus%>';
		$.ajax({
			type: 'POST',
			url: url,
			data: $('#sendForm').serialize(),
			async: true,
			dataType: 'text',
			success: function(data){
				if(dialog){
					dialog.close();
				}
				var json = eval("("+data+")");
				if(json!=null){
					if(json.result == 'success'){
						myApp.alert("发送成功！");
						var fromFlag = $("#fromFlag").val();
						if(fromFlag == '1'){
							window.history.go(-2);
						}else{
							WeixinJSBridge.call('closeWindow');
						}
					}else{
						sendFlag='0';
						myApp.alert("发送失败！");
					}
				}
			},
			error: function(){
				sendFlag='0';
				myApp.alert("异常！");
			}
		});
	}
</script>
</body>