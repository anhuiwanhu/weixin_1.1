<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ include file="../common/taglibs.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String pageId = request.getParameter("pageId");
String processId = request.getParameter("processId");
String process_type = request.getParameter("process_type");
String orgId = session.getAttribute("orgId")==null?"":session.getAttribute("orgId").toString();
String userName = session.getAttribute("userName")==null?"":session.getAttribute("userName").toString();
String orgName = session.getAttribute("orgName")==null?"":session.getAttribute("orgName").toString();
Date ndate = new Date();
SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
String nowDate = df.format(ndate).toString();
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>会议室流程申请</title>
	<%@ include file="../common/headerInit.jsp" %>
    
	
    <link rel="stylesheet" type="text/css" href="/defaultroot/clientview/template115/css/mobiscroll/mobiscroll.icons.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/clientview/template115/css/mobiscroll/mobiscroll.scroller.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/clientview/template115/css/mobiscroll/mobiscroll.scroller.ios7.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/clientview/template115/css/mobiscroll/mobiscroll.animation.css"/>
	
	
    <script type="text/javascript" src="/defaultroot/clientview/template115/js/mobiscroll/mobiscroll.zepto.js"></script>
    <script type="text/javascript" src="/defaultroot/clientview/template115/js/mobiscroll/mobiscroll.core.js"></script>
    <script type="text/javascript" src="/defaultroot/clientview/template115/js/mobiscroll/mobiscroll.scroller.js"></script>
    <script type="text/javascript" src="/defaultroot/clientview/template115/js/mobiscroll/mobiscroll.datetime.js"></script>
    <script type="text/javascript" src="/defaultroot/clientview/template115/js/mobiscroll/mobiscroll.select.js"></script>
</head>

<body class="grey-bg">
<!-- 选人界面的div开始 -->
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
<!-- 选人界面的div结束 -->
<div class="views">
    <div class="view">
      <div class="pages">
        <div class="page" data-page="page-webapp-mail-edit">
<input type="hidden" name="meetRoomId" value="${meetRoomId}">
<section class="wh-section wh-section-bottomfixed" id="mainContent">
	<form id="sendForm" class="dialog" action="/defaultroot/meeting/ezSendMeeting.controller" method="post">
    <article class="wh-edit wh-edit-forum">
        <div class="mail-edit">
		    <c:if test="${not empty docXml}">
			<x:parse xml="${docXml}" var="doc"/>
            <table class="wh-table-edit" style="border-collapse:separate;border-spacing: 0 1px;width:100%;" >
			<input type="hidden"  id="isVideo" name="isVideo" value="${isVideo}" />
			<input type="hidden"  id="processId" name="processId" value="${processId}" />
			<input type="hidden"  id="pageId" name="pageId" value="${pageId}" />
			<c:set var="attendNum">${personNum}</c:set>
			<x:forEach select="$doc//fieldList/field" var="fd" >
			    <c:set var="boardroomName"><x:out select="$fd/boardroomName/text()"/></c:set>
				<c:set var="addr"><x:out select="$fd/addr/text()"/></c:set>
				<c:set var="personNum"><x:out select="$fd/personNum/text()"/></c:set>
				<c:set var="motif"><x:out select="$fd/motif/text()"/></c:set>
				<c:set var="emceeName"><x:out select="$fd/emceeName/text()"/></c:set>               
				<c:set var="destineDate"><x:out select="$fd/meetingTimeList/destineDate/text()"/></c:set>
				<c:set var="startMinute"><x:out select="$fd/meetingTimeList/startMinute/text()"/></c:set>				
				<c:set var="endMinute"><x:out select="$fd/meetingTimeList/endMinute/text()"/></c:set>						
				<c:set var="depict"><x:out select="$fd/depict/text()"/></c:set>
				<c:set var="mustfilled"><x:out select="$fd/mustfilled/text()"/></c:set>
				<!-- 会议室 -->
				<c:if test="${boardroomName != 'null' && boardroomName !=''}">
                <tr>				
                    <th><c:if test="${mustfilled == 1}"><em class="red-em">*</em></c:if>${boardroomName}：</th>
                    <td>	
                    	<div class="panel-direct" style="position:relative;">
	                   		<div class="edit-sel-show">
									<span>${meetRoomName}</span>
								</div>
								<c:set var="meetRoomId">${meetRoomId}</c:set>
								<select  class="btn-bottom-pop" name="boardRoomName" onchange="setSpanHtml(this);changeAddr(this);">
									<option value="-1">请选择</option>								
									<c:if test="${not empty docXml1}">
										<x:parse xml="${docXml1}" var="doc1"/>								
										<x:forEach select="$doc1//boardroom" var="bd">
								    		<c:set var="boardroomId"><x:out select="$bd/boardroomId/text()"/></c:set>
											<c:set var="boardroomName"><x:out select="$bd/boardroomName/text()"/></c:set>
                                    		<c:set var="isVideo"><x:out select="$bd/isVideo/text()"/></c:set>									
												<option value="${boardroomId}|${boardroomName}|${isVideo}" <c:if test="${boardroomId == meetRoomId}">selected="true"</c:if>>${boardroomName}</option>
                                		</x:forEach>
									</c:if>
								</select>
	                	</div>				
                    </td>
                </tr>
				</c:if>
				<!-- 地点 -->
				<c:if test="${addr != 'null' && addr !=''}">
                <tr id="addrTr">				
                    <th><c:if test="${mustfilled == 1}"><em class="red-em">*</em></c:if>${addr}：</th>
                    <td>					
                        <div class="edit-ipt-a-arrow edit-ipt-r">
                            <input class="edit-ipt-r" style="overflow-x: scroll;" type="text" id="addr" name="addr"  placeholder="请输入" />                         
                        </div>
                    </td>
                </tr>
				<tr id="pointNumTr">				
                    <th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>点数：</th>
                    <td>					
                        <div class="edit-ipt-a-arrow edit-ipt-r">
                            <input class="edit-ipt-r" type="text" id="pointNum" name="pointNum"  placeholder="请输入" />                         
                        </div>
                    </td>
                </tr>
				</c:if>
				<!-- 出席人数 -->
				<c:if test="${personNum != 'null' && personNum !=''}">
                <tr>				
                    <th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${personNum}：</th>
                    <td>					
                        <div class="edit-ipt-a-arrow edit-ipt-r">
                            <input class="edit-ipt-r" type="text" name="personNum" value="${attendNum}" placeholder="请输入" readonly/>                           
                        </div>
                    </td>
                </tr>
				</c:if>
				<!-- 会议主题 -->
				<c:if test="${motif != 'null' && motif !=''}">
                <tr>				
                    <th><c:if test="${mustfilled == 1}"><em class="red-em">*</em></c:if>${motif}：</th>
                    <td>					
                        <div class="edit-ipt-a-arrow edit-ipt-r">
                            <input class="edit-ipt-r" style="overflow-x: scroll;" type="text" name="motif" id="motif" placeholder="请输入" /> 
                        </div>
                    </td>
                </tr>
				</c:if>
				<!-- 主持人 -->
				<c:if test="${emceeName != 'null' && emceeName !=''}">
                <tr>				
                    <th><c:if test="${mustfilled == 1}"><em class="red-em">*</em></c:if>${emceeName}：</th>
                    <!--<td>					
                        <div class="edit-ipt-a-arrow">
                            <input type="hidden" readonly="readonly" id="empId" name="empId"  />
			           		<input type="text" style="overflow-x: scroll;"   readonly="readonly" id="emceeName" name="emceeName"  class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","emceeName","empId","*0*","user")' placeholder="请选择"/>
						    <label class="edit-ipt-label" for="scroller"></label>
                        </div>
                    </td>-->
					<td>
						<input type="hidden" readonly="readonly" id="empId" name="empId"  />
						<input style="width:80%" class="edit-ipt-r edit-ipt-arrow" type="text" placeholder="请选择" id="emceeName" name="emceeName" readonly="readonly" onclick='selectUser("1","emceeName","empId","*0*","user")'>
                        <span class="document-span">&#xf005;</span>
                    </td>
                </tr>
				</c:if>
				<c:if test="${destineDate != 'null' && destineDate !=''}">
				<tr class="trdiv" id="timeDiv">
					<td colspan="2">
				       <c:set var="startTime">${startTime}</c:set>
					   <c:set var="startMint">${startMin}</c:set>
					   <c:set var="endMint">${endMin}</c:set>
					  <!--日期-->
					  <div class="timetr clearfix">
						<span id="td1" style="display:block"><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${destineDate}：</span> 
						<div class="edit-ipt-a-arrow time-r" style="float: right;position: relative;">
							<input data-datetype="date" class="edit-ipt-r edit-ipt-arrow" type="text" name="destineDate" placeholder="" value="${startTime}"/>
							<label class="edit-ipt-label" for="scroller"></label>
							<span class="document-span" style="position: absolute;right: 0;top: 3px;">&#xf005;</span>
						</div> 
					  </div>
					  <!--开始时间-->
					  <div class="timetr clearfix">
						<span id="td2" style="display:block"><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${fn:replace(startMinute,"分钟", "时分")}：</span>
						  <div class="edit-ipt-a-arrow time-r" style="float: right;position: relative;">
							 <input data-datetype="time" class="edit-ipt-r edit-ipt-arrow" type="text" name="startMinutes" placeholder="" value="${startMint}"/>   
							 <label class="edit-ipt-label" for="scroller"></label>
							 <span class="document-span" style="position: absolute;right: 0;top: 3px;">&#xf005;</span>
						  </div>
						
					  </div>
					   <!--结束时间-->
					  <div class="timetr timetr-over clearfix">
						<span id="td3" style="display:block"><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${fn:replace(endMinute,"分钟", "时分")}：</span>
						
						<div class="edit-ipt-a-arrow time-r" style="float: right;position: relative;">
							<input data-datetype="time" class="edit-ipt-r edit-ipt-arrow" type="text" name="endMinutes" placeholder="" value="${endMint}" />  
							<label class="edit-ipt-label" for="scroller"></label>
							<span class="document-span" style="position: absolute;right: 0;top: 3px;">&#xf005;</span>
						</div>
						
					  </div>
					</td> 
				</tr>
				</c:if>
				<c:if test="${endMinute != 'null' && endMinute !=''}">
				<tr class="timeadd" id="timeadd" >
					<th colspan="2">
						<p style="text-align: center;"><i class="fa fa-plus-circle" style="color:#3eaeff;"></i><span onclick="addDate()" style="color:#3eaeff;">添加新日期</span></p>
					</th>
				</tr> 
				</c:if>
				<!-- 会议内容 -->
				<c:if test="${depict != 'null' && depict !=''}">
                <tr>				
                    <th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${depict}：</th>
                    <td>		                     
						<textarea name="depict"  class="edit-txta edit-txta-l" maxlength="300" placeholder="请输入"></textarea>
                    </td>
                </tr>
				</c:if>
              </x:forEach>  
            </table>
            <!--隐藏的-->
			<table class="wh-table-edit" id="tt" style="display:table; border-top:1px solid #efefef">
			<x:forEach select="$doc//fieldList/field" var="fd" >
			    <c:set var="boardroomCode"><x:out select="$fd/boardroomCode/text()"/></c:set>
				<c:set var="boardroomApplyType"><x:out select="$fd/boardroomApplyType/text()"/></c:set>
				<c:set var="attendeeLeader"><x:out select="$fd/attendeeLeader/text()"/></c:set>
				<c:set var="notePersonName"><x:out select="$fd/notePersonName/text()"/></c:set>
				<c:set var="attendee"><x:out select="$fd/attendee/text()"/></c:set>
				<c:set var="otherAttendeePerson"><x:out select="$fd/otherAttendeePerson/text()"/></c:set>
				<c:set var="applyEmpName"><x:out select="$fd/applyEmpName/text()"/></c:set>
				<c:set var="applyOrgName"><x:out select="$fd/applyOrgName/text()"/></c:set>
				<c:set var="applyDate"><x:out select="$fd/applyDate/text()"/></c:set>
				<c:set var="linkTelephone"><x:out select="$fd/linkTelephone/text()"/></c:set>
				<c:set var="remind_im"><x:out select="$fd/remind_im/text()"/></c:set>
				<c:set var="seatcard"><x:out select="$fd/seatcard/text()"/></c:set>
				<c:set var="remark"><x:out select="$fd/remark/text()"/></c:set>
				<c:set var="boardroomSaveName"><x:out select="$fd/boardroomFileList/boardroomSaveName/text()"/></c:set>
				<!-- 会议室编号 -->
				<c:if test="${boardroomCode != 'null' && boardroomCode !=''}">
                <tr>				
                    <th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${boardroomCode}：</th>
                    <td>					
                        <div class="edit-ipt-a-arrow edit-ipt-r">
                            <input class="edit-ipt-r edit-ipt-arrow" type="text" name="boardroomCode" placeholder="请输入" />                    
                        </div>
                    </td>
                </tr>
				</c:if>
				<!-- 会议类型 -->
				<c:if test="${boardroomApplyType != 'null' && boardroomApplyType !=''}">
                <tr>				
                    <th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${boardroomApplyType}：</th>
                    <td>
                    	<div class="panel-direct" style="position:relative;">
	                   		<div class="edit-sel-show">
									<span>请选择</span>
								</div>
								<select  class="btn-bottom-pop" name="boardroomApplyType" onchange="setSpanHtml(this)">
									<x:forEach select="$fd/dataList/val" var="vl">
                                    <c:set var="showv"><x:out select="$vl/showval/text()"/></c:set>
									<c:set var="hiddenv"><x:out select="$vl/hiddenval/text()"/></c:set>
									<option value="${hiddenv}">${showv}</option>
								    </x:forEach>
								</select>
								<span class="document-span" style="position: absolute;right: 0;top: 3px;">&#xf005;</span>
	                	</div>						
                    </td>
                </tr>
                <!--  <tr>
                	<th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${boardroomApplyType}：</th>
                    <td>
                    	<input class="edit-ipt-r edit-ipt-arrow" type="text" placeholder="请选择" id="picker-auto" readonly="">
                        <span class="document-span" style="position: absolute;right: 0;top: 3px;">&#xf005;</span>
                    </td>
                </tr>-->
				</c:if>
				<!-- 出席领导 -->
				<c:if test="${attendeeLeader != 'null' && attendeeLeader !=''}">
                <tr>				
                    <th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${attendeeLeader}：</th>
                    <td>					
                        <div class="edit-ipt-a-arrow" style="position: relative;">
                            <input type="hidden" readonly="readonly" id="attendeeLeaderId" name="attendeeLeaderId"  />
			           		<input type="text" style="overflow-x: scroll;"   readonly="readonly" id="attendeeLeader" name="attendeeLeader"  class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","attendeeLeader","attendeeLeaderId","*0*","user")' placeholder="请选择"/>
						    <label class="edit-ipt-label" for="scroller"></label>
							<span class="document-span" style="position: absolute;right: 0;top: 3px;">&#xf005;</span>
                        </div>
                    </td>
                </tr>
				</c:if>
				<!-- 会议记录人 -->
				<c:if test="${notePersonName != 'null' && notePersonName !=''}">
                <tr>				
                    <th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${notePersonName}：</th>
                    <td>					
                       <div class="edit-ipt-a-arrow" style="position: relative;">
                            <input type="hidden" readonly="readonly" id="noteEmpId" name="noteEmpId"  />
			           		<input type="text" style="overflow-x: scroll;"   readonly="readonly" id="notePersonName" name="notePersonName"  class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","notePersonName","noteEmpId","*0*","user")' placeholder="请选择"/>
						    <label class="edit-ipt-label" for="scroller"></label>
							<span class="document-span" style="position: absolute;right: 0;top: 3px;">&#xf005;</span>
                        </div>
                    </td>
                </tr>
				</c:if>
				<!-- 会议出席人 -->
				<c:if test="${attendee != 'null' && attendee !=''}">
                <tr>				
                    <th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${attendee}：</th>
                    <td>					
                        <div class="edit-ipt-a-arrow" style="position: relative;">
                            <input type="hidden" readonly="readonly" id="attendeeEmpId" name="attendeeEmpId"  />
			           		<input type="text" style="overflow-x: scroll;"   readonly="readonly" id="attendeePersonName" name="attendeePersonName"  class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","attendeePersonName","attendeeEmpId","*0*","user")' placeholder="请选择"/>
						    <label class="edit-ipt-label" for="scroller"></label>
							<span class="document-span" style="position: absolute;right: 0;top: 3px;">&#xf005;</span>
                        </div>
                    </td>
                </tr>
				</c:if>
				<!-- 其它参会人 -->
				<c:if test="${otherAttendeePerson != 'null' && otherAttendeePerson !=''}">
                <tr>				
                    <th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${otherAttendeePerson}：</th>
                    <td>					
                        <textarea class="edit-txta edit-txta-l" name="otherAttendeePerson" maxlength="300"></textarea>
                    </td>
                </tr>
				</c:if>
				<!-- 预定者 -->
				<c:if test="${applyEmpName != 'null' && applyEmpName !=''}">
                <tr>				
                    <th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${applyEmpName}：</th>
                    <td>					
                        <div class="edit-ipt-a-arrow edit-ipt-r">
                            <input class="edit-ipt-r edit-ipt-arrow" style="overflow-x: scroll;" type="text" name="applyEmpName" placeholder="" value="<%=userName%>"  readonly="readonly"/>                        
                        </div>
                    </td>
                </tr>
				</c:if>
				<!-- 预定部门 -->
				<c:if test="${applyOrgName != 'null' && applyOrgName !=''}">
                <tr>				
                    <th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${applyOrgName}：</th>
                    <td>					
                        <div style="height:6rem;overflow:hidden">
                                                 <textarea class="edit-txta edit-txta-l" readonly="readonly" style="color: #d1d1d1;font-size:1.7rem"><%=orgName%></textarea>
                        </div>
                    </td>
                </tr>
				</c:if>
				<!-- 预定日期 -->
				<c:if test="${applyDate != 'null' && applyDate !=''}">
                <tr>				
                    <th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${applyDate}：</th>
                    <td>					
                        <div class="edit-ipt-a-arrow edit-ipt-r">
                            <input  class="edit-ipt-r edit-ipt-arrow" type="text" name="applyDate" value="<%=nowDate%>" placeholder="" /> 
                        </div>
                    </td>
                </tr>
				</c:if>
				<!-- 联系电话 -->
				<c:if test="${linkTelephone != 'null' && linkTelephone !=''}">
                <tr>				
                    <th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${linkTelephone}：</th>
                    <td>					
                        <div class="edit-ipt-a-arrow edit-ipt-r">
                            <input class="edit-ipt-r edit-ipt-arrow" type="text" name="linkTelephone" placeholder="请输入" />                          
                        </div>
                    </td>
                </tr>
				</c:if>
				<!-- 席卡 -->
				<c:if test="${seatcard != 'null' && seatcard !=''}">
                <tr>				
                    <th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${seatcard}：</th>
                    <td>					
                        <textarea name="seatcard"  class="edit-txta edit-txta-l" maxlength="300" placeholder="请输入"></textarea>
                    </td>
                </tr>
				</c:if>
				<!-- 备注 -->
				<c:if test="${remark != 'null' && remark !=''}">
                <tr>				
                    <th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${remark}：</th>
                    <td>					
                         <textarea name="remark"  class="edit-txta edit-txta-l" maxlength="300" placeholder="请输入"></textarea>
                    </td>
                </tr>
				</c:if>
              </x:forEach>  
				 <tr>
				     <th>附件：</th>
				     <td>
						 <ul class="edit-upload">
							<li class="edit-upload-in" onclick="addImg('meeting');"><span><i class="fa fa-plus"></i></span></li>
						 </ul>
					 </td>
				 </tr>
            </table>
            </c:if>
            <div class="meeting-other" style="text-align: center;color: #ccc;font-size: 1rem;margin-bottom:1rem">
                <p onclick="showfeild()" id="show">展开填写非必填项</p>
                <span class="span-arrow-down" id="arr"></span>
            </div>
        </div>
    </article>
	</form>
</section>


		<footer id="footerButton" class="wh-footer wh-footer-forum" style="height:6rem;">
            <div class="wh-container">
              <div class="wh-footer-btn row">
                <div class="webapp-footer-linebtn">
                  <div class="fl clearfix">
					<a href="javascript:formCheck()" class="panel-return-a">发起审批</a>
                </div>
              </div>
            </div>
          </footer>
<section id="selectContent" style="display:none">
</section>
	<jsp:include page="../common/include_workflow_subTable.jsp" flush="true">
		<jsp:param name="docXml" value="${docXml}" />
		<jsp:param name="orgId" value="<%=orgId %>" />
	</jsp:include>
     </div>
      </div>
    </div>
  </div>
</body>
<script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
<script type="text/javascript" src="/defaultroot/scripts/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/template115/js/zepto.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/template115/js/touch.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/template115/js/swiper/swiper.min.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/template115/js/selector.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/template115/js/alert/zepto.alert.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/template115/js/mobiscroll/mobiscroll.zepto.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/template115/js/mobiscroll/mobiscroll.core.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/template115/js/mobiscroll/mobiscroll.scroller.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/template115/js/mobiscroll/mobiscroll.datetime.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/template115/js/mobiscroll/mobiscroll.select.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/template115/js/followskip/followskip.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/js/uploadPreview.min.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/js/common.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/js/subClick.js"></script>

<script type="text/javascript">

	var myApp = new Framework7({
		fastClicks: false,
	});
  	var $$ = Dom7;



  	//普通仿原生下拉选单，根据需要设置选项文字是否居中
	//var pickerAuto = myApp.picker({
	//    input: '#picker-auto',
	//    cols: [
	 //       {   textAlign: 'center',
	 //   <c:if test="${not empty docXml}">
		//	<x:parse xml="${docXml}" var="doc"/>
		//	<x:forEach select="$doc//fieldList/field" var="fd" >
		//		<c:set var="boardroomApplyType"><x:out select="$fd/boardroomApplyType/text()"/></c:set>
		//			<x:forEach select="$fd/dataList/val" var="vl">
         //   			<c:set var="showv"><x:out select="$vl/showval/text()"/></c:set>
		//				<c:set var="hiddenv"><x:out select="$vl/hiddenval/text()"/></c:set>
          //  				values: ['打电话', '发短信', '发一封邮件', '发送RTX消息']
         //   	</x:forEach>	
	     //   </x:forEach>
	    //    }
	  // </c:if>
	    //]
	//})

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
    
    
    var flag = '0';
	$(document).ready(function(){
		flag = '1';
		$("#tt").hide();
		if($("#isVideo").val() == '1'){
			$("#addrTr").hide();
			$("#addr").val("0");
		}else{
			$("#pointNumTr").hide();
			$("#pointNum").val("0");
		}
	});

	function showfeild(){
		if(flag == '1'){
			$("#tt").show();
			flag = '0';
            $("#show").text("收起非必填项");
			$("#arr").removeClass().addClass("span-arrow-up");
		}else{
			$("#tt").hide();
			flag = '1';
			$("#show").text("打开非必填项");
			$("#arr").removeClass().addClass("span-arrow-down");
		}		
	}
    
	
	 //打开选择人员页面
	function selectUser(selectType,selectName,selectId,range,listType){ 
		myApp.showPreloader('正在加载...');
		var selectIdVal = $('input[id="'+selectId+'"]').val();
		if( selectIdVal.indexOf(";") > 0 ){
			var selectIdArray = selectIdVal.split(';');
			selectIdVal = selectIdArray[1];
		}
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
		var postUrl = '/defaultroot/newperson/personList.controller';
		//if(listType == 'org'){
		//	postUrl = '/defaultroot/person/searchOrg.controller?flag=org';
		//}else if(listType=='user'){
		//	postUrl = '/defaultroot/person/newsearch.controller?flag=user';
		//}

		$.ajax({
			url : postUrl,
			type : "post",
			data : {'selectType':selectType,'selectName':selectName,'selectId':selectId,
					'selectNameVal':$('input[id="'+selectName+'"]').val(),'selectIdVal':selectIdVal,'range':range},
			success : function(data){
				$("#selectContent").append(data);
				hiddenContent(0);
				myApp.hidePreloader();
			}
		});
	}
    	
	//选人选组织代码-----开始
	function hiddenContent(flag){
		if(flag == 0){
			if($('#mainContent').is(':hidden')){
				$('[id="subHeader_'+subTableName+'"]').hide();
				$('[id="subSection_'+subTableName+'"]').hide();
				$('[id="subFooter_'+subTableName+'"]').hide();
				$('[id="subHeader_'+subTableName+'"]').data('hide','1');
			}else{
				$("#mainContent").css("display","none");
				$("#footerButton").css("display","none");
			}
			$("#selectContent").css("display","block");
		}else if(flag == 1){
			if($('[id="subHeader_'+subTableName+'"]') && $('[id="subSection_'+subTableName+'"]').is(':hidden') 
					&& $('[id="subHeader_'+subTableName+'"]').data('hide') == '1'){
				$('[id="subHeader_'+subTableName+'"]').data('hide','0');
				$('#selectContent').hide();
				$('[id="subHeader_'+subTableName+'"]').show();
				$('[id="subSection_'+subTableName+'"]').show();
				$('[id="subFooter_'+subTableName+'"]').show();
			}else{
				$("#selectContent").css("display","none");
				$("#mainContent").css("display","block");
				$("#footerButton").css("display","block");
			}
			$("#selectContent").empty();
		}else if(flag==2){//显示子表 
			$("#mainContent").css("display","none");
			$("#footerButton").css("display","none");
			$("#subtableContent").css("display","block");
		}else if(flag==3){
			$("#subtableContent").css("display","none");
			$("#mainContent").css("display","block");
			$("#footerButton").css("display","block");
			$("#subtableContent").empty();
		}
	}
    //添加时间
	var boardDateIndex = 0; 
	function addDate(){
        var html1 = $("#td1").html();
		var html2 = $("#td2").html();
		var html3 = $("#td3").html();
		$("#timeadd").before(
		'<tr class="trdiv" id="timeDiv'+boardDateIndex+'">'
		+'<td colspan="2">'
		+'  <div class="timetr clearfix">'
		+'	<span><i class="fa fa-minus-circle" onclick="delDate('+boardDateIndex+')"></i>'+html1+'</span>' 
		+'	<div class="edit-ipt-a-arrow time-r">'
		+'		<input data-datetype="date" class="edit-ipt-r edit-ipt-arrow" type="text" name="destineDate" placeholder="" />'
		+'		<label class="edit-ipt-label" for="scroller"></label>'
		+'	</div>'
		+'  </div>'
		 +' <div class="timetr clearfix">'
		+'	<span>'+html2+'</span>'
	 
		+'	  <div class="edit-ipt-a-arrow time-r">'
		+'		 <input data-datetype="time" class="edit-ipt-r edit-ipt-arrow" type="text" name="startMinutes" placeholder="" />'   
		+'		 <label class="edit-ipt-label" for="scroller"></label>'
		+'	  </div>'
			
		+'  </div>'
		+'  <div class="timetr timetr-over clearfix">'
		+'	<span>'+html3+'</span>'			
		+'	<div class="edit-ipt-a-arrow time-r">'
		+'		<input data-datetype="time" class="edit-ipt-r edit-ipt-arrow" type="text" name="endMinutes" placeholder=""  />'  
		+'		<label class="edit-ipt-label" for="scroller"></label>'
		+'	</div>'
			
		+'  </div>'
		+'</td>'
	    +'</tr>'	
 		
		);
		selectDateTime();
		boardDateIndex++;
	}
    //删除时间
	function delDate(val){
		$("#timeDiv"+val).remove();
	}
    
	$(function(){
        selectDateTime();
    });
	 //日期空间初始化参数
    var opt = {
		'date': {
			preset: 'date', //日期，可选：date\datetime\time\tree_list\image_text\select
            theme: 'ios7', //皮肤样式，可选：default\android\android-ics light\android-ics\ios\jqm\sense-ui\wp light\wp
            display: 'bottom', //显示方式 ，可选：modal\inline\bubble\top\bottom
            mode: 'scroller', //日期选择模式，可选：scroller\clickpick\mixed
            lang:'zh',
            dateFormat: 'yy-mm-dd', // 日期格式
            setText: '确定', //确认按钮名称
            cancelText: '取消',//取消按钮名籍我
            dateOrder: 'yymmdd', //面板中日期排列格式
            dayText: '日',
            monthText: '月',
            yearText: '年',
            showNow: false,
            endYear:2099
		},
		'datetime': {
	  	 	preset: 'datetime', //日期，可选：date\datetime\time\tree_list\image_text\select
            theme: 'ios7', //皮肤样式，可选：default\android\android-ics light\android-ics\ios\jqm\sense-ui\wp light\wp
            display: 'bottom', //显示方式 ，可选：modal\inline\bubble\top\bottom
            mode: 'scroller', //日期选择模式，可选：scroller\clickpick\mixed
            lang:'zh',
            dateFormat: 'yy-mm-dd', // 日期格式
            timeFormat: 'HH:ii',
            timeWheels:'HHii',
            setText: '确定', //确认按钮名称
            cancelText: '取消',//取消按钮名籍我
            dateOrder: 'yymmdd', //面板中日期排列格式
            dayText: '日',
            monthText: '月',
            yearText: '年',
            hourText:'时',
            minuteText:'分',
            showNow: false,
            endYear:2099
		},
		'time': {
	  	 	preset: 'time', //日期，可选：date\datetime\time\tree_list\image_text\select
            theme: 'ios7', //皮肤样式，可选：default\android\android-ics light\android-ics\ios\jqm\sense-ui\wp light\wp
            display: 'bottom', //显示方式 ，可选：modal\inline\bubble\top\bottom
            mode: 'scroller', //日期选择模式，可选：scroller\clickpick\mixed
            lang:'zh',
            timeFormat: 'HH:ii',
            setText: '确定', //确认按钮名称
            cancelText: '取消',//取消按钮名籍我
            hourText:'时',
            minuteText:'分',
            amText:'上午',
            pmText:'下午',
            showNow: false,
            endYear:2099
		}
	}
    
    //选择日期时间
    function selectDateTime(){
    	var dateType = '';
    	$('input[data-datetype=date],[data-datetype=datetime],[data-datetype=time]').each(function(){
    		dateType = $(this).data('datetype');
    		if(dateType){
				$(this).mobiscroll(opt[dateType]);
    		}
    	});
    }

	  //图片数标记
    var index = 0;
   
    //添加图片
    function addImg(name){
	   $(".edit-upload-in").before(       
		   '<li class="edit-upload-ed" id="imgli_'+index+'" style="display:none">'+
		       '<span>'+
		       	   '<img src="" id="imgShow_'+index+'"/>'+
			       '<em>'+
			       	 '<i onclick="removeImg('+index+');" class="fa fa-minus-circle"></i>'+
			       '</em>'+
		       '</span>'+
		       '<input type="file" id="up_img_'+index+'" style="display:none" name="imgFile"/>'+
		       '<input type="hidden" id="img_name_'+index+'" name="_mainfile_'+name+'"/>'+
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
		var fileShowName = $("#"+upImgId).val();
		$.ajaxFileUpload({
			url: '/defaultroot/upload/fileUpload.controller?modelName=customform', //用于文件上传的服务器端请求地址
			secureuri:false,
			fileElementId: upImgId, //文件上传域的ID
			dataType: 'json', //返回值类型 一般设置为json
			success: function (msg, status){  //服务器成功响应处理函数---获取上传图片保存名
				$("#img_name_"+(index-1)).val(msg.data+"|"+fileShowName);
				$("#"+imgliId).show();
				myApp.hidePreloader();
			},
			error: function (data, status, e){//服务器响应失败处理函数
				myApp.alert("文件上传失败！");
			}
		});
	}
    var checkMeetingFlag = 0;
	//表单必填项验证
    function formCheck(){
		var addr = $('#addr').val();
		var motif = $('#motif').val();
		var emceeName = $('#emceeName').val();
		if(checkMeetingFlag == 1){
			myApp.alert("暂无可用的会议申请ezFlow流程，请重新选择会议室！");
			return;
		}
		if(!addr){
			myApp.alert('请输入地点！');
			return;
		}
		if(!motif){
    		myApp.alert('请输入主题！');
			return;
    	}
		if(/[\\\/?#&'"]+/g.test($('#motif').val())){
			myApp.alert('标题不可以包含特殊字符！');
			return;
		}
		if(!emceeName){
    		myApp.alert('请输入主持人！');
			return;
    	}
		if(confirmForm()){
			var checkOk = '';
			var checkUrl = '/defaultroot/meeting/checkMeetingRoom.controller';
			$.ajax({
				url : checkUrl,
				type : "post",
				data : $('#sendForm').serialize(),
				success : function(isConflict){
					if(isConflict=='-1'){
						alert("您申请的会议室在此时间段已被占用！");
					}else{
						sendFlow();
					}
				}
			});
		}
    }
	//提交表单
	var sendFlag = 1;
	function sendFlow(){
		//防止重复提交
		if(sendFlag == 0){
    		return;
    	}
    	sendFlag = 0;
		var url = '/defaultroot/meeting/ezSendMeeting.controller';
		$.ajax({
			url : url,
			type : "post",
			data : $('#sendForm').serialize(),
			success : function(infoId){
				openNextPage(infoId);
			}
		});
	}

	//流程开始
	function openNextPage(infoId){
		var processId = $('#processId').val();
		var openUrl='/defaultroot/meeting/sendEzSendMeeting.controller?infoId='+infoId+'&processId='+processId;		
		window.location = openUrl;
	}
   /* function sendFlow(){
		if(confirmForm()){
		  $('#sendForm').submit();
		}
	}*/


	
	
	function setSpanHtml(obj,selectVal){
    	if(!selectVal){
    		selectVal = $(obj).find("option:selected").text();
    	}
		$(obj).parent().find('div>span').html(selectVal);
	}    

	function changeAddr(obj,selectVal){
		var val =$(obj).find("option:selected").val();
		var arr = val.split("|");
		checkMeetRoom(arr[0]);
		if(arr[2] == '1'){
			$("#addrTr").hide();
			$("#addr").val("0");//给必填项一个默认值
			$("#pointNum").val("");
			$("#pointNumTr").show();
		}else{
			$("#pointNumTr").hide();
			$("#pointNum").val("0");
			$("#addr").val("");
			$("#addrTr").show();
		}
	}
	
	function checkMeetRoom(meetRoomId){
		var url = '/defaultroot/meeting/checkMeetRoom.controller';
		$.ajax({
			 type: 'post',
			 url: 	url,
			 dataType:'text',
			 data : {"meetRoomId": meetRoomId},
			 success: function(data){
			 	if(data == '1'){
			 		checkMeetingFlag = 1;
			 		myApp.alert("暂无可用的会议申请ezFlow流程，请重新选择会议室！");
			 	}else{
			 		checkMeetingFlag = 0;
			 	}
			 },error: function(xhr, type){
				 //alert('数据查询异常！');
			 }
		});
	}     
</script>
</html>