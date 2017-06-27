<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ include file="/clientview/common/headerInit.jsp" %>
<%
String workId = request.getParameter("workId");
String orgId = session.getAttribute("orgId").toString();
request.setAttribute("now",new java.util.Date());
String empLivingPhoto = request.getParameter("empLivingPhoto")==null?"":request.getParameter("empLivingPhoto");
String userName = session.getAttribute("userName")==null?"":session.getAttribute("userName").toString();
String fromFlag = request.getParameter("fromFlag");
%>
<!DOCTYPE html>
<html>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>表单页</title>
  <script type="text/javascript" src="<%=rootPath%>/clientview/custmenu/js/custmenu.js"></script>
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
    <div class="view">
      <div class="pages">
        <div class="page" data-page="page-webapp-form">
		<c:if test="${not empty docXml}">
		<x:parse xml="${docXml}" var="doc"/>
		<c:set var="hasbackbutton"><x:out select="$doc//workInfo/havebackbutton/text()"/></c:set>
		<c:set var="modibutton"><x:out select="$doc//workInfo/modibutton/text()"/></c:set>
		<c:set var="wfworkId"><x:out select="$doc//wf_work_id/text()"/></c:set>
		<c:set var="workcurstep"><x:out select="$doc//workInfo/workcurstep/text()"/></c:set>
		<c:set var="worktitle"><x:out select="$doc//workInfo/worktitle/text()"/></c:set>
		<c:set var="worksubmittime"><x:out select="$doc//workInfo/worksubmittime/text()"/></c:set>
		<c:set var="commentmustnonull"><x:out select="$doc//workInfo/commentmustnonull/text()"/></c:set>
		<c:set var="EmpLivingPhoto"><x:out select="$doc//workInfo/empLivingPhoto/text()"/></c:set>
		<c:set var="isEzFlow"><x:out select="$doc//workInfo/isEzFlow/text()"/></c:set>
		<c:set var="processCommentAcc"><x:out select="$doc//workInfo/processCommentAcc/text()"/></c:set>
		<c:set var="isDossier"><x:out select="$doc//workInfo/isDossier/text()"/></c:set>
		<c:set var="flowgraphurl"><x:out select="$doc//workInfo/flowgraphurl/text()"/></c:set>
		<c:set var="commentFieldShowSignature"><x:out select="$doc//workInfo/commentFieldShowSignature/text()"/></c:set>
		<c:set var="dealTipsContent" ><x:out select="$doc//dealTipsContent/text()" escapeXml="false" /></c:set>
		<c:set var="wfcommentType" ><x:out select="$doc//commentType/text()" escapeXml="false" /></c:set>
		<c:set var="ezflow_activityTip"><x:out select="$doc//workInfo/ezflow_activityTip/text()"/></c:set>
		<c:set var="ezflow_activityTipCotent"><x:out select="$doc//workInfo/ezflow_activityTipCotent/text()"/></c:set>
		<c:set var="ezflow_activityTipTitle"><x:out select="$doc//workInfo/ezflow_activityTipTitle/text()"/></c:set>
		<form id="sendForm" class="dialog" action="/defaultroot/workflow/sendnew.controller" method="post">
          <section class="page-content wh-section wh-section-bottomfixed" id="mainContent">
            <div class="webapp-form">
              <div class="app-tabheader-line clearfix">
                <div class="clearfix">
					<a href="#tab11" class="tab-link active" style="width:50%">
						<span>流程表单</span>
					</a>
					<a href="#tab13" class="tab-link tab-link-rw" style="width:50%">
						<span>流程记录</span>
					</a>
                </div>
              </div>
              <div class="tabs">
                <!-- 流程表单 -->
                <div id="tab11" class="tab active">
                  <div class="form-table">
				   <c:if test="${not empty docXml3}">
            		<x:parse xml="${docXml3}" var="doc3"/>
					<c:set var="EmpSignImg"><x:out select="$doc3//EmpSignImg/text()"/></c:set>
					<c:set var="newEmpSignImg"></c:set>
					<%
					String EmpSignImg =(String)pageContext.getAttribute("EmpSignImg");
					String[] arr = EmpSignImg.split("\\.");
					pageContext.setAttribute("newEmpSignImg",arr[0]);
					%>
                  </c:if>
				  <c:if test="${not empty docXml2}">
            		<x:parse xml="${docXml2}" var="doc2"/>
                    <table style="border-collapse:separate;border-spacing: 0 10px;" id="table_form">
					<x:forEach select="$doc2//fieldList/field" var="fd" >
						<c:set var="showtype"><x:out select="$fd/showtype/text()"/></c:set>
						<c:set var="readwrite"><x:out select="$fd/readwrite/text()"/></c:set>
						<c:set var="fieldtype"><x:out select="$fd/fieldtype/text()"/></c:set>
						<c:set var="mustfilled"><x:out select="$fd/mustfilled/text()"/></c:set>
						<c:set var="value"><x:out select="$fd/value/text()"/></c:set>
                      <tr>
                        <td>                
                          <span>	
						  <c:if test="${mustfilled == '1' && readwrite == '1'}">
						  <em>*</em>
						  </c:if>
						  <x:out select="$fd/name/text()"/>						
						  ：						  
						  </span>						 
                        </td>
                        <td>
                          <c:choose>
								<%--单行文本 101--%>
								<c:when test="${showtype =='101' && readwrite =='1'}">
									<div>
										<c:if test="${fieldtype == '1000000' }">
											<input placeholder="请输入" class="edit-ipt-r" type="number" maxlength="9" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
										</c:if>
										<c:if test="${fieldtype == '1000001' }">
											<input placeholder="请输入" class="edit-ipt-r" type="number" maxlength="18" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
										</c:if>
										<c:if test="${fieldtype != '1000000' && fieldtype != '1000001'  }">
											<input placeholder="请输入" class="edit-ipt-r" type="text" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
										</c:if>
									</div>
								</c:when>
								<%--密码输入 102--%>
								<c:when test="${showtype =='102' && readwrite =='1'}">
									<input placeholder="请输入" class="edit-ipt-r" type="password" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
								</c:when>
								<%--单选 103--%>
								<c:when test="${showtype =='103' && readwrite =='1'}">
									<c:set var="selectedvalue"><x:out select="$fd/hiddenval/text()"/></c:set>
									<div class="edit-direct">
										<div class="edit-sel-show">
											<span>请选择</span>
										</div>    
										<select onchange="setSpanHtml(this);" class="btn-bottom-pop" name='_main_<x:out select="$fd/sysname/text()"/>' prompt='<x:out select="$fd/value/text()"/>'>
											<option value="">请选择</option>
											<x:forEach select="$fd//dataList/val" var="selectvalue" >
												<c:set var="curvalue"><x:out select="$selectvalue/hiddenval/text()"/></c:set>
												<option value='<x:out select="$selectvalue/hiddenval/text()"/>' <c:if test="${selectedvalue == curvalue}">selected="true"</c:if>><x:out select="$selectvalue/showval/text()"/></option>
											</x:forEach>
										</select>
									</div>
								</c:when>
								<%--多选 104--%>
								<c:when test="${showtype =='104' && readwrite =='1'}">
									<c:set var="selectedvalue">,<x:out select="$fd/hiddenval/text()"/></c:set>
										<ul class="edit-radio">
											<x:forEach select="$fd//dataList/val" var="selectvalue" >
											<c:set var="curvalue">,<x:out select="$selectvalue/hiddenval/text()"/>,</c:set>
											<li class="">
												<label class="label-checkbox item-content" for='checkIput<x:out select="$fd/id/text()"/><x:out select="$selectvalue/hiddenval/text()"/>'>
													<input type="checkbox" name='_main_<x:out select="$fd/sysname/text()"/>' id='checkIput<x:out select="$fd/id/text()"/><x:out select="$selectvalue/hiddenval/text()"/>' value='<x:out select="$selectvalue/hiddenval/text()"/>,' <c:if test="${fn:indexOf(selectedvalue, curvalue) > -1}">checked="true"</c:if> />
													<span class="edit-radio-l"><x:out select="$selectvalue/showval/text()"/></span>
												</label>
											</li>
											</x:forEach>
										</ul>
								</c:when>
								<%--下拉框 105--%>
								<c:when test="${showtype =='105' && readwrite =='1'}">
									<c:set var="selectedvalue"><x:out select="$fd/hiddenval/text()"/></c:set>
									<div class="edit-direct">
										<div class="edit-sel-show">
											<span>请选择</span>
										</div>    
										<select onchange="setSpanHtml(this);" class="btn-bottom-pop" name='_main_<x:out select="$fd/sysname/text()"/>' prompt='<x:out select="$fd/value/text()"/>'>
											<option value="">请选择</option>
											<x:forEach select="$fd//dataList/val" var="selectvalue" >
												<c:set var="curvalue"><x:out select="$selectvalue/hiddenval/text()"/></c:set>
												<option value='<x:out select="$selectvalue/hiddenval/text()"/>' <c:if test="${selectedvalue == curvalue}">selected="true"</c:if>><x:out select="$selectvalue/showval/text()"/></option>
											</x:forEach>
										</select>
									</div>
								</c:when>
								
								<%--日期 107--%>
								<c:when test="${showtype =='107' && readwrite =='1'}">
									<div class="edit-ipt-a-arrow">
										<input placeholder="选择日期"  class="edit-ipt-r edit-ipt-arrow" type="text" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' onfocus="selectDateNew(this)" readonly/>
										<label class="edit-ipt-label" for="scroller"></label>
									</div>
								</c:when>
								<%--时间 108--%>
								<c:when test="${showtype =='108' && readwrite =='1'}">
									<div class="edit-ipt-a-arrow">
										<input placeholder="选择时间 "  class="edit-ipt-r edit-ipt-arrow" type="text" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' onfocus="selectTimeNew(this)" readonly/>
										<label class="edit-ipt-label" for="scroller"></label>
									</div>
								</c:when>
								<%--日期 时间 109--%>
								<c:when test="${showtype =='109' && readwrite =='1'}">
									<div class="edit-ipt-a-arrow">
										<input placeholder="选择日期 时间"  class="edit-ipt-r edit-ipt-arrow" type="text" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' onfocus="selectDateTimeNew(this)" readonly/>
										<label class="edit-ipt-label" for="scroller"></label>
									</div>								
								</c:when>
								<%--多行文本 110--%>
								<c:when test="${showtype =='110' && readwrite =='1'}">
									<div>
										<textarea name='_main_<x:out select="$fd/sysname/text()"/>' rows="4" onkeyup="$(this).next('.edit-txta-num').html($(this).attr('maxlength')-$(this).val().length );" class="edit-txta edit-txta-l" maxlength="500"><x:out select="$fd/value/text()"/></textarea>
										<span class="edit-form-num"><script>document.write(500-"<x:out select="$fd/value/text()"/>".length);</script></span>
									</div>
								</c:when>
								<%--多行文本 110--%>
								<c:when test="${showtype =='110' && readwrite !='1'}">
									<div>
										<textarea rows="4" onkeyup="$(this).next('.edit-txta-num').html($(this).attr('maxlength')-$(this).val().length );" class="edit-txta edit-txta-l" maxlength="500" readonly="readonly"><x:out select="$fd/value/text()"/></textarea>
										<span class="edit-form-num"><script>document.write(500-"<x:out select="$fd/value/text()"/>".length);</script></span>
									</div>
								</c:when>
								<%--自动编号 111--%>
								<c:when test="${showtype =='111' && readwrite =='1'}">
									<x:out select="$fd/value/text()"/>
									<input id='<x:out select="$fd/sysname/text()"/>' type="hidden" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
								</c:when>
								<%--html编辑 113--%>
								<c:when test="${showtype =='113' && readwrite =='1'}">
									<textarea name='_main_<x:out select="$fd/sysname/text()"/>' onkeyup="$(this).next('.edit-txta-num').html($(this).attr('maxlength')-$(this).val().length );" class="edit-txta edit-txta-l" maxlength="300"><x:out select="$fd/value/text()"/></textarea>
									<span class="edit-txta-num"><script>document.write(300-"<x:out select="$fd/value/text()"/>".length);</script></span>
								</c:when>
								<%--附件上传 115--%>
								<c:when test="${showtype =='115'}">
									<c:if test="${readwrite =='1'}">
										<ul class="edit-upload">
				                            <li class="edit-upload-in" onclick="addImg('<x:out select="$fd/sysname/text()"/>');"><span><i class="fa fa-plus"></i></span></li>
				                        </ul>
									</c:if>
									<c:set var="values"><x:out select="$fd/value/text()"/></c:set>
									<c:if test="${not empty values}">
										<%
										String realFileNames ="";
										String saveFileNames ="";
										String moduleName ="customform";
										String aValues =(String)pageContext.getAttribute("values");
										aValues = aValues.replaceAll("&amp;", "&");
										String[] aval  = aValues.split(";");
										String[] aval0=new String[0];
										String[] aval1=new String[0];
										if(aval[0] != null && aval[0].endsWith(",")) {
											saveFileNames =aval[0].substring(0, aval[0].length() -1);
											saveFileNames =saveFileNames.replaceAll(",","|");
										}
										if(aval[1] != null && aval[1].endsWith(",")) {
											realFileNames =aval[1].substring(0, aval[1].length() -1);
											realFileNames =realFileNames.replaceAll(",","|");
										}
										%>
										<jsp:include page="../common/include_download.jsp" flush="true">
											<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
											<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
											<jsp:param name="moduleName" value="<%=moduleName%>" />
										</jsp:include>
										<input name="fileNames<x:out select="$fd/sysname/text()"/>" value="${values}" type="hidden"/>
									</c:if>
								</c:when>
								<%--Word编辑 116--%>
								<c:when test="${showtype =='116'}">
									<c:set var="filename"><x:out select="$fd/value/text()"/></c:set>
									<c:if test="${not empty filename}">
										<%
										String realFileNames ="";
										String saveFileNames ="";
										String moduleName ="information";
										realFileNames ="查看正文.doc";
										saveFileNames =(String)pageContext.getAttribute("filename")+".doc";
										%>
										<jsp:include page="../common/include_download.jsp" flush="true">
											<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
											<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
											<jsp:param name="moduleName" value="<%=moduleName%>" />
										</jsp:include>
									</c:if>
									<c:if test="${empty filename && readwrite =='1'}">
										该字段暂不支持手机办理，请于电脑端操作。
									</c:if>
								</c:when>
								<%--Excel编辑 117--%>
								<c:when test="${showtype =='117'}">
									<c:set var="filename"><x:out select="$fd/value/text()"/></c:set>
									<c:if test="${not empty filename}">
										<%
										String realFileNames ="";
										String saveFileNames ="";
										String moduleName ="information";
										realFileNames =(String)pageContext.getAttribute("filename")+".xls";
										saveFileNames =(String)pageContext.getAttribute("filename")+".xls";
										%>
										<jsp:include page="../common/include_download.jsp" flush="true">
											<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
											<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
											<jsp:param name="moduleName" value="<%=moduleName%>" />
										</jsp:include>
									</c:if>
									<c:if test="${empty filename && readwrite =='1'}">
										该字段暂不支持手机办理，请于电脑端操作。
									</c:if>
								</c:when>
								<%--WPS编辑 118--%>
								<c:when test="${showtype =='118'}">
									<c:set var="filename"><x:out select="$fd/value/text()"/></c:set>
									<c:if test="${not empty filename}">
										<%
										String realFileNames ="";
										String saveFileNames ="";
										String moduleName ="information";
										realFileNames =(String)pageContext.getAttribute("filename")+".wps";
										saveFileNames =(String)pageContext.getAttribute("filename")+".wps";
										%>
										<jsp:include page="../common/include_download.jsp" flush="true">
											<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
											<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
											<jsp:param name="moduleName" value="<%=moduleName%>" />
										</jsp:include>
									</c:if>
									<c:if test="${empty filename && readwrite =='1'}">
										该字段暂不支持手机办理，请于电脑端操作。
									</c:if>
								</c:when>
								<%--登录人信息 --%>
								<c:when test="${( showtype =='213' || showtype =='215'|| showtype =='406'|| showtype =='601'|| showtype =='602'|| showtype =='603'|| showtype =='604'|| showtype =='605'|| showtype =='607'|| showtype =='701'|| showtype =='702'|| showtype =='201'|| showtype =='202' || showtype =='207'  ) && readwrite =='1'}">
								<c:set var="expressionval"><x:out select="$fd/expressionval/text()"/></c:set>
										<c:choose>
											 <%--当前登录人 --%>
											<c:when test="${showtype == '202'}">
												<%=userName%>
												<input id='<x:out select="$fd/sysname/text()"/>' type="hidden" name='_main_<x:out select="$fd/sysname/text()"/>'  value="<%=userName%>" />
											</c:when>
											<%--最末端组织 --%> 
											<c:when test="${expressionval == 'self'}">
												<%
													String valuestr = org.apache.commons.lang.StringEscapeUtils.unescapeXml((String)pageContext.getAttribute("value"));
													String[] values = valuestr.split("\\.");
													String valueSelf = values[values.length-1];
												%>
												<%=valueSelf %>
												<input id='<x:out select="$fd/sysname/text()"/>' type="hidden" name='_main_<x:out select="$fd/sysname/text()"/>'  value='<x:out select="$fd/value/text()"/>' />
											</c:when>
											<%--组织长信息 --%>
											<c:when test="${expressionval == 'full'}">
												<x:out select="$fd/value/text()"/>
												<input id='<x:out select="$fd/sysname/text()"/>' type="hidden" name='_main_<x:out select="$fd/sysname/text()"/>'  value='<x:out select="$fd/value/text()"/>' />
											</c:when>
											<%--从本单位开始至末端 --%>
											<c:when test="${expressionval == 'unit'}">
												<x:out select="$fd/value/text()"/>
												<input id='<x:out select="$fd/sysname/text()"/>' type="hidden" name='_main_<x:out select="$fd/sysname/text()"/>'  value='<x:out select="$fd/value/text()"/>' />
											</c:when>
											<%--最末端组织向上一级 --%>
											<c:when test="${expressionval == 'parent'}">
												<%
													String valuestr = org.apache.commons.lang.StringEscapeUtils.unescapeXml((String)pageContext.getAttribute("value"));
													String[] values = valuestr.split("\\.");
													String valueSelf = values[values.length-1];//最末端
													String valueSelfUp = values[values.length-2];//最末端向上一个

													String valueSelfUps = valueSelfUp + "." + valueSelf;
												%>
												<%=valueSelfUps %>
												<input id='<x:out select="$fd/sysname/text()"/>' type="hidden" name='_main_<x:out select="$fd/sysname/text()"/>'  value='<x:out select="$fd/value/text()"/>' />
											</c:when>
										</c:choose>
								</c:when>
								<%--单选人 全部 210--%>
								<c:when test="${showtype =='210' && readwrite =='1'}">
									<div>
									<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
		           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>' name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("0","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*0*","user")' placeholder="请选择"/>
		           					</div>
								</c:when>

								<%--多选人 全部 211--%>
								<c:when test="${showtype =='211' && readwrite =='1'}">
									<div>
									<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
		           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>'  name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*0*","user");' placeholder="请选择"/>
		           					</div>
								</c:when>

								<%--单选组织 212--%>
								<c:when test="${showtype =='212' && readwrite =='1'}">
									<div>
									<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
		           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>'  name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("0","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*0*","org");' placeholder="请选择"/>
		           					</div> 
								</c:when>

								<%--多选组织 214--%>
								<c:when test="${showtype =='214' && readwrite =='1'}">
									<div>
									<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
		           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>'  name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*0*","org");' placeholder="请选择"/>
		           					</div>
								</c:when>
                                
								<%--多选组织和人 216--%>
								<c:when test="${showtype =='216' && readwrite =='1'}">
									<div>
										<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
										<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>'  name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*0*","orguser");' placeholder="请选择"/>
									</div>
								</c:when>
								<%--多选组织和人 216--%>
								<c:when test="${showtype =='216' && readwrite !='1'}">
								    <c:set var="orgAndperson"><x:out select="$fd/value/text()"/></c:set>
								    <%
									String oap =(String)pageContext.getAttribute("orgAndperson");
									String newoap = oap.split(";")[0];
									pageContext.setAttribute("orgAndperson",newoap);
									%>
                                    ${orgAndperson}
								</c:when>
								<%--金额 301--%>
								<c:when test="${showtype =='301' && readwrite =='1'}">
									<c:if test="${fieldtype == '1000000' || fieldtype == '1000001'  }">
										<input class="edit-ipt-r" id='<x:out select="$fd/sysname/text()"/>' type="number" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
									</c:if>
									<c:if test="${fieldtype != '1000000' && fieldtype != '1000001'  }">
										<input class="edit-ipt-r" id='<x:out select="$fd/sysname/text()"/>' type="text" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
									</c:if>
								</c:when>
								<%--金额大写 302--%>
								<c:when test="${showtype =='302' && readwrite =='1'}">
									<input class="edit-ipt-r" type="text" readonly maxlength="18" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
								</c:when>
								<%--批示意见 401--%>
								<c:when test="${showtype =='401' }">
									<x:forEach select="$fd//dataList/comment" var="ct" >
									    <c:set var="commentType"><x:out select="$ct//type/text()"/></c:set>
										<c:set var="content"><x:out select="$ct//content/text()"/></c:set>
										<c:set var="person"><x:out select="$ct//person/text()"/></c:set>
										<c:set var="data"><x:out select="$ct//date/text()"/></c:set>
										<c:set var="commentstatus"><x:out select="$ct//commentstatus/text()"/></c:set>	
										<%
											String newData =(String)pageContext.getAttribute("data");
											if(newData !=null && newData !="" && newData !="null"){
												newData = newData.substring(0,16);
											}
										%>
										<c:if test="${commentType =='0'}">
											<c:if test="${commentstatus =='1'}">
												<x:out select="$ct//content/text()"/>&nbsp;&nbsp;<x:out select="$ct//person/text()"/>(<%=newData%>)<br/>
											</c:if>
										</c:if>
										<c:if test="${commentType =='1'}">
										<img  width="100%" class="lazy lazy-fadeIn" id="${content}" src="/defaultroot/upload/workflow_acc/loading.gif"><x:out select="$ct//person/text()"/>(<%=newData%>)<br/>
										<input type="hidden" name="imgNames" value="${content}" />
										</c:if>
									</x:forEach>									
									<c:if test="${readwrite =='1' && wfcommentType == '1'}">
										暂不支持手写，如您需要手写请于PC端处理！
									</c:if>									
									<c:if test="${readwrite =='1' && commentFieldShowSignature !='true' && commentFieldShowSignature !=true}">
										<c:set var="commentAttitudeType"><x:out select="$doc//commentAttitudeTypeSet/text()"/></c:set>
										<div class="edit-direct2" style="text-align:right;width:auto;">
											<textarea onfocus="changeFocus(this);" name="comment_input" id="comment_input" maxlength="1000"></textarea>					
												<c:if test="${commentAttitudeType =='1'}">
													<div class="edit-direct edit-direct2" style="display: inline-block;width: auto;">
														<div class="edit-sel-show" style="display: inline-block;">
															<span class="xin-tj">意见态度</span>
														</div>
														<select onchange="setSelect(this);"  name="commentAttitudeType" class="btn-bottom-pop"  prompt="">
															<option value="">意见态度</option> 
															<option value="1">同意</option> 
															<option value="2">不同意</option>
														</select>
													</div>
												</c:if>	
												<c:if test="${commentAttitudeType == '2'}">
													<div class="edit-direct edit-direct2" style="display: inline-block;width: auto;">
														<div class="edit-sel-show" style="display: inline-block;">
															<span class="xin-tj">意见态度</span>
														</div>
														<select onchange="setSelect(this);"  name="commentAttitudeType" class="btn-bottom-pop"  prompt="">
															<option value="">意见态度</option> 
															<option value="1">同意</option> 
															<option value="2">不同意</option>
															<option value="3">已阅</option> 
														</select>
													</div>
												</c:if>	
												<div class="edit-direct edit-direct2" style="display: inline-block;width: auto;">
													<div class="edit-sel-show" style="display: inline-block;">
														<span>常用语</span>
													</div>
													<select onchange="selectComment(this);" class="btn-bottom-pop"  prompt="">
														<option value="0">常用语</option> 
														<x:forEach select="$doc//officelist" var="selectvalue" >
															<option value='<x:out select="$selectvalue/text()"/>'><x:out select="$selectvalue/text()"/></option>
														</x:forEach>
													</select>
												</div>
										</div>
										<br/>
									</c:if>
									<c:if test="${readwrite =='1' && (commentFieldShowSignature =='true' || commentFieldShowSignature ==true)}">										
									</c:if>						
									<%
										StringBuilder saveNames = new StringBuilder();
										StringBuilder showNames = new StringBuilder();
									%>
									<c:set var="fileNum" value="0"/>
									<x:forEach select="$fd//dataList/comment/attachments/file" var="file">
										<c:set var="saveName" ><x:out select="$file/saveName/text()" /></c:set>
										<c:set var="showName" ><x:out select="$file/showName/text()" /></c:set>
										<c:set var="fileNum" value="${fileNum+1}"/>
										<%
										saveNames.append(pageContext.getAttribute("saveName").toString()).append("|");
										showNames.append(pageContext.getAttribute("showName").toString()).append("|");
										%>
									</x:forEach>
									<c:if test="${fileNum > 0}">
										<jsp:include page="../common/include_download.jsp" flush="true">
											<jsp:param name="realFileNames"	value="<%=showNames.toString() %>" />
											<jsp:param name="saveFileNames" value="<%=saveNames.toString() %>" />
											<jsp:param name="moduleName" value="workflow_acc" />
										</jsp:include>
									</c:if>
								</c:when>
								<%--合计字段 606--%>            
								<c:when test="${showtype =='606'}">
									<c:set var="expressionval"><x:out select="$fd/expressionval/text()"/></c:set>
									<%
									String exp =(String)pageContext.getAttribute("expressionval");
									String[] newexpArr = exp.split("\\.");
									String  newxp = newexpArr[2];
									String nexp = (String)newxp.substring(0,newxp.length()-1);
									//nexp = nexp.replace("$","");
									pageContext.setAttribute("expressionval",nexp);
									%>
									<c:if test="${readwrite == '1'}">
									<div>
										<input class="edit-ipt-r mainhj" mainsum="${expressionval}" placeholder="请输入" id='<x:out select="$fd/sysname/text()"/>' type="text" maxlength="9" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>'/>
									</div>
									</c:if>
									<c:if test="${readwrite != '1'}">
									<div>
										<input class="edit-ipt-r mainhj" placeholder="" mainsum="${expressionval}" id='<x:out select="$fd/sysname/text()"/>' type="text" maxlength="9" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' readonly="readonly"/>
									</div>
									</c:if>
								</c:when>
								<%--单选人 本组织 704--%>
								<c:when test="${showtype =='704' && readwrite =='1'}">
									<div>
										<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
										<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>' name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" placeholder="请选择" onclick='selectUser("0","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*<%=orgId%>*","user");'/>
									</div>
								</c:when>
								
								<%--多选人 本组织 705--%>
								<c:when test="${showtype =='705' && readwrite =='1'}">
									<div>
									<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
									<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>'  name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" placeholder="请选择" onclick='selectUser("1","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*<%=orgId%>*","user");'/>
									</div>
								</c:when>
								<%--流程发起人 708--%>
								<c:when test="${showtype =='708' && readwrite =='1'}">
									<div>
									<x:out select="$fd/value/text()"/><input id='<x:out select="$fd/sysname/text()"/>' type="hidden" name='_main_<x:out select="$fd/sysname/text()"/>'  value='<x:out select="$fd/value/text()"/>' />
									</div>
								</c:when>
								<%--日期时间计算 808--%>
								<c:when test="${showtype =='808' && readwrite =='1'}">
									该字段暂不支持手机办理，请于电脑端操作。
								</c:when>
								<%--计算字段 203--%>
								<c:when test="${showtype =='203' && readwrite =='1'}">
									<c:set var="expressionval"><x:out select="$fd/expressionval/text()"/></c:set>
									<div>
									<input class="edit-ipt-r mainmath" readonly="readonly" mainmathfun="${expressionval}" type="text" maxlength="18" id='<x:out select="$fd/sysname/text()"/>'  name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
									</div>
								</c:when>
								<c:otherwise>
									<x:out select="$fd/value/text()"/>
<%--									<input type="text" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>'  name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r"/>--%>
								</c:otherwise>
							</c:choose>
                        </td>
                      </tr>
                      </x:forEach>
					  <!--子表信息begin-->
						<x:forEach select="$doc2//subTableList/subTable" var="st">
							<c:set var="subTable"></c:set>
							<x:forEach select="$st/subFieldList" var="ct" varStatus="xh">
								<c:set var="subTable" >${xh.index+1}</c:set>
							</x:forEach>
							<c:set var="subName" ><x:out select="$st/name/text()"/></c:set>
							<c:set var="subTableName" ><x:out select="$st/tableName/text()"/></c:set>
							<input name="subTableName" value="${subTableName}" type="hidden" />
							<input name="subName" value="${subName}" type="hidden" />
							<tr>
								<td><span>子表（${subName}）填写：</span></td>
								<td>
								    <div class="edit-direct">
									<input id="subTableInput_${subTableName}" placeholder="添加子表" type="text" class="edit-ipt-r edit-ipt-arrow" 
									<c:if test="${not empty subTable}">value="${subTable}条子表数据"</c:if>
									 readonly="readonly" onclick="addSubTable('${subTableName}');"/>
									<div>
								</td>
							</tr>
						</x:forEach>
						<!--子表信息end-->
						<!--批示意见begin-->
						<c:set var="commentField" ><x:out select="$doc//workInfo/commentField/text()"/></c:set>
						<c:set var="actiCommFieldType" ><x:out select="$doc//workInfo/actiCommFieldType/text()"/></c:set>
						<c:if test="${actiCommFieldType != '-1' && (commentField == '-1' || commentField == 'nullCommentField' || commentField == 'autoCommentField' || commentField == 'null') }">
						<tr>
							<td><span>审批意见：</span>
								<c:if test="${commentmustnonull eq true}">
									<i class="fa fa-asterisk"></i>
								</c:if>
							</td>
							<td>
							<c:set var="commentAttitudeType"><x:out select="$doc//commentAttitudeTypeSet/text()"/></c:set>
							<div class="edit-direct2" style="text-align:right;width:auto;">
								<textarea onfocus="changeFocus(this);" name="comment_input" id="comment_input" maxlength="1000"></textarea>					
									<c:if test="${commentAttitudeType =='1'}">
										<div class="edit-direct edit-direct2" style="display:inline-block;width:auto;">
											<div class="edit-sel-show" style="display: inline-block;">
												<span class="xin-tj">意见态度</span>
											</div>
											<select onchange="setSelect(this);" name="commentAttitudeType" class="btn-bottom-pop"  prompt="">
												<option value="">意见态度</option> 
												<option value="1">同意</option> 
												<option value="2">不同意</option>
											</select>
										</div>
									</c:if>	
									<c:if test="${commentAttitudeType == '2'}">
										<div class="edit-direct edit-direct2" style="display: inline-block;width: auto;">
											<div class="edit-sel-show" style="display: inline-block;">
												<span class="xin-tj">意见态度</span>
											</div>
											<select onchange="setSelect(this);"  name="commentAttitudeType" class="btn-bottom-pop"  prompt="">
												<option value="">意见态度</option> 
												<option value="1">同意</option> 
												<option value="2">不同意</option>
												<option value="3">已阅</option> 
											</select>
										</div>
									</c:if>	
									<div class="edit-direct edit-direct2" style="display: inline-block;width: auto;">
										<div class="edit-sel-show" style="display: inline-block;">
											<span>常用语</span>
										</div>
										<select onchange="selectComment(this);" class="btn-bottom-pop"  prompt="">
											<option value="0">常用语</option> 
											<x:forEach select="$doc//officelist" var="selectvalue" >
												<option value='<x:out select="$selectvalue/text()"/>'><x:out select="$selectvalue/text()"/></option>
											</x:forEach>
										</select>
									</div>
							</div>

							<!--<div>
								<textarea class="edit-txta edit-txta-l" onfocus="changeFocus(this);" name="comment_input" id="comment_input" maxlength="50"></textarea>
								<span class="document-span">常用审批语</span>
								<select class="btn-bottom-pop" onchange="selectComment(this);">
									<option value="0">常用审批语</option> 
									<x:forEach select="$doc//officelist" var="selectvalue" >
										<option value='<x:out select="$selectvalue/text()"/>'><x:out select="$selectvalue/text()"/></option>
									</x:forEach>
								</select>	
								<span class="edit-form-num">50</span>
							</div>-->
		                    </td>
						</tr>
						</c:if>																																							
						<x:forEach select="$doc2//commentList/comment" var="ct" >
							<c:set var="commentType"><x:out select="$ct//type/text()"/></c:set>
							<c:set var="commentContent"><x:out select="$ct//content/text()"/></c:set>
							<c:set var="data"><x:out select="$ct//date/text()"/></c:set>
							<%
								String newData =(String)pageContext.getAttribute("data");
								if(newData !=null && newData !="" && newData !="null"){
									newData = newData.substring(0,16);
								}
							%>
							<tr>
								<td><x:out select="$ct//step/text()"/>：</td>
								<td>		
								    <c:if test="${commentType =='0'}">
									<x:out select="$ct//content/text()"/>&nbsp;&nbsp;<x:out select="$ct//person/text()"/>
									(<%=newData%>)<br/></c:if>
									<c:if test="${commentType =='1'}">
									<img  width="100%" class="lazy lazy-fadeIn" id="${commentContent}" src="/defaultroot/upload/workflow_acc/loading.gif"><x:out select="$ct//person/text()"/>(<%=newData%>)<br/>
									<input type="hidden" name="imgNames" value="${commentContent}" />
									</c:if>
									<%
										StringBuilder saveNames = new StringBuilder();
										StringBuilder showNames = new StringBuilder();
									%>
									<c:set var="fileNum" value="0"/>
									<x:forEach select="$ct/attachments/file" var="file">
										<c:set var="saveName" ><x:out select="$file/saveName/text()" /></c:set>
										<c:set var="showName" ><x:out select="$file/showName/text()" /></c:set>
										<c:set var="fileNum" value="${fileNum+1}"/>
										<%
										saveNames.append(pageContext.getAttribute("saveName").toString()).append("|");
										showNames.append(pageContext.getAttribute("showName").toString()).append("|");
										%>
									</x:forEach>
									<c:if test="${fileNum > 0}">
										<jsp:include page="../common/include_download.jsp" flush="true">
											<jsp:param name="realFileNames"	value="<%=showNames.toString() %>" />
											<jsp:param name="saveFileNames" value="<%=saveNames.toString() %>" />
											<jsp:param name="moduleName" value="workflow_acc" />
										</jsp:include>
									</c:if>
								</td>
							</tr>
						</x:forEach>
						<!--批示意见end-->
						<!--退回意见begin-->
						<c:set var="dealTipsContent" ><x:out select="$doc//dealTipsContent/text()" escapeXml="false" /></c:set>
						<c:if test="${not empty dealTipsContent}">
							<c:if test="${fn:indexOf(dealTipsContent,'加签提示') == -1 && fn:indexOf(dealTipsContent,'退回原因') != -1}">
								<tr>
									<td>退回意见：</td>
									<td id="dealTipsContent">${dealTipsContent}</td>
								</tr>
							</c:if>
						</c:if>
						<div id="dealTip" style="display:none">${dealTipsContent}</div>
						<!--退回意见end-->
                    </table>
					<input type="hidden" name="pass_title"  value="" />
					<input type="hidden" name="pass_time"   value="" />
					<input type="hidden" name="pass_person" value="" />
					<input type="hidden" name="__sys_operateType" value="2" />
					<input type="hidden" name="__sys_infoId"      value='<x:out select="$doc2//paramList/workrecord_id/text()"/>' />
					<input type="hidden" name="__sys_pageId"      value='<x:out select="$doc2//paramList/worktable_id/text()"/>' />
					<input type="hidden" name="__sys_formType"    value='<x:out select="$doc2//paramList/formType/text()"/>' />	
					<input type="hidden" name="__main_tableName"  value='<x:out select="$doc2//fieldList/tableName/text()"/>' />	
					<input type="hidden" name="tableId"           value='<x:out select="$doc//workInfo/worktable_id/text()"/>' />
					<input type="hidden" name="recordId"          value='<x:out select="$doc//workInfo/workrecord_id/text()"/>' />
					<input type="hidden" name="activityId"        value='<x:out select="$doc//workInfo/initactivity/text()"/>' />      
					<input type="hidden" name="workId"            value='<x:out select="$doc//workInfo/wf_work_id/text()"/>' />
					<input type="hidden" name="stepCount"         value='<x:out select="$doc//workInfo/workstepcount/text()"/>' />
					<input type="hidden" name="actiCommFieldType" value='<x:out select="$doc//workInfo/actiCommFieldType/text()"/>' />
					<%--新添加参数 2012/4/5 --%>
					<input type="hidden" name="isForkTask"    value='<x:out select="$doc//workInfo/isForkTask/text()"/>' />
					<input type="hidden" name="forkStepCount" value='<x:out select="$doc//workInfo/forkStepCount/text()"/>' />
					<input type="hidden" name="forkId"        value='<x:out select="$doc//workInfo/forkId/text()"/>' />
					<c:if test="${not empty docXml2}">
						<input type="hidden" name="activityclass" value='<x:out select="$doc2//paramList/activityclass/text()"/>' /> 
					</c:if>
					<input type="hidden" name="curCommField"  value='<x:out select="$doc//workInfo/commentField/text()"/>' />
					<input type="hidden" name="trantype"      value='<x:out select="$doc//workInfo/trantype/text()"/>' />
					<x:if select="$doc//workInfo/commentmustnonull" var="commentmustnonull">
						<input type="hidden" name="commentmustnonull" value='<x:out select="$doc//workInfo/commentmustnonull/text()"/>' />
					</x:if>
					<x:if select="$doc//workInfo/backnocomment" var="backnocomment">
						<input type="hidden" name="backnocomment"     value='<x:out select="$doc//workInfo/backnocomment/text()"/>' />
					</x:if>
					<x:if select="$doc//workInfo/backMailRange" var="backMailRange">
						<input type="hidden" name="backMailRange"     value='<x:out select="$doc//workInfo/backMailRange/text()"/>' />
					</x:if>
					<x:if select="$doc//workInfo/smsRight" var="smsRight">
						<input type="hidden" name="smsRight"          value='<x:out select="$doc//workInfo/smsRight/text()"/>' />
					</x:if>
					<input type="hidden" name="commentType"  value="0" />
					<input type="file" style="display:none;" value="" name="comment_input_shouxie" id="comment_input_shouxie"/>
					<input type="file" style="display:none;" value="" name="comment_input_yuyin" id="comment_input_yuyin"/>
					<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
					<input type="hidden" name="worktitle" value="${worktitle}">
					<input type="hidden" name="workcurstep" value="${workcurstep}">
					<input type="hidden" name="worksubmittime" value="${worksubmittime}">
					<input type="hidden" name="workStatus" value="0">
					<input type="hidden" name="fromFlag" value="<%=fromFlag%>">
					<input type="hidden" name="isDossier" value="${isDossier}">
					</c:if>
                  </div>
                </div>
                <!-- 流程图加载 -->
                <div id="tab12" class="tab">  
                  <p><img  width="100%" class="lazy lazy-fadeIn" id="wfImg"></p> 
                </div>
                <!-- 流程图记录 -->
                <div id="tab13" class="tab">
                  <div class="form-table-record">
                    <table style="border-collapse:separate;border-spacing: 0 10px;" id="workflowlog">
                      
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </section>
          <footer class="wh-footer wh-footer-forum" id="footerButton">
            <div class="wh-container">
              <div class="wh-footer-btn row">
                <div class="webapp-footer-linebtn">
                  <div class="fl clearfix">
					<c:choose>
	                <c:when test="${ hasbackbutton == 'true' }">
		               	<a href="javascript:subBackForm();" class="panel-return-a">退回</a>
		                <a href="javascript:if(formCheck()){subForm();}" class="panel-return-a">发送</a>
	                </c:when>
	                <c:otherwise>
		                <a href="javascript:subForm();" class="panel-return-a">发送</a>
	                </c:otherwise>
                  </c:choose>
                  </div> 
				  <c:if test="${fn:indexOf(modibutton,'AddSign') >0 || fn:indexOf(modibutton,'Tran') >0 || fn:indexOf(modibutton,'Selfsend') >0}">
					<a id="fbtn-more" onclick="" data-popover=".popover-links" class="fr fbtn-more"><span>更多</span></a> 
				  </c:if>
                </div>
              </div>
            </div>
          </footer>
		  <div class="new-popover" id="">
			<div class="new-pop" id="">
			 <c:if test="${fn:indexOf(modibutton,'AddSign') >0}">
				<a href="javascript:addSign();" class="fbtn-matter close-popover">加签</a>
				 </c:if>
				 <c:if test="${fn:indexOf(modibutton,'Tran') >0}">
				<a href="javascript:tranInfo();" class="fbtn-matter close-popover">转办</a>
				</c:if>
				 <c:if test="${fn:indexOf(modibutton,'Selfsend') >0}">
				<a href="javascript:selfsend();" class="fbtn-matter close-popover">阅件</a>
				</c:if>
			</div>
			<div class="new-sanjiao"></div>
		</div>
		<div class="gray-back"></div>
	    <jsp:include page="../common/include_workflow_subTable.jsp" flush="true">
			<jsp:param name="docXml" value="${docXml2}" />
			<jsp:param name="orgId" value="<%=orgId %>" />
		</jsp:include>
        </div>
        <section id="selectContent" style="display:none">
	</section>
      </div>
    </div>
  </div>
</form>
<%--<section id="subtableContent" style="display:none">--%>
<%--</section>--%>
<!----------退回开始---------->
<form id="backForm" class="dialog" action="/defaultroot/workflow/back.controller" method="post">
	<input type="hidden" name="workId" value="<%=workId%>">
	<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
	<input type="hidden" name="worktitle" value="${worktitle}">
	<input type="hidden" name="workcurstep" value="${workcurstep}">
	<input type="hidden" name="worksubmittime" value="${worksubmittime}">
	<input type="hidden" name="workStatus" value="0">
	<input type="hidden" name="tableId" value='<x:out select="$doc//workInfo/worktable_id/text()"/>'>
	<input type="hidden" name="recordId" value='<x:out select="$doc//workInfo/workrecord_id/text()"/>'>
	<input type="hidden" name="stepCount" value='<x:out select="$doc//workInfo/workstepcount/text()"/>'>
	<input type="hidden" name="forkId" value='<x:out select="$doc//workInfo/forkId/text()"/>'>
	<input type="hidden" name="forkStepCount" value='<x:out select="$doc//workInfo/forkStepCount/text()"/>'>
	<input type="hidden" name="isForkTask" value='<x:out select="$doc//workInfo/isForkTask/text()"/>'>
	<input type="hidden" name="curCommField" value='<x:out select="$doc//workInfo/commentField/text()"/>' />
	<input type="hidden" name="fromFlag" value="<%=fromFlag%>">
</form>
<!----------退回结束---------->
<!----------转办开始---------->
<form id="tranInfoForm" class="dialog" action="/defaultroot/dealfile/tranInfo.controller?workId=${wfworkId}" method="post">
	<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
	<input type="hidden" name="worktitle" value="${worktitle}">
	<input type="hidden" name="workcurstep" value="${workcurstep}">
	<input type="hidden" name="worksubmittime" value="${worksubmittime}">
	<input type="hidden" name="workStatus" value="0">
	<input type="hidden" name="fromFlag" value="<%=fromFlag%>">
</form>
<!----------转办结束---------->
<!----------加签开始---------->
<form id="addSignForm" class="dialog" action="/defaultroot/dealfile/addSign.controller?workId=${wfworkId}" method="post">
	<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
	<input type="hidden" name="worktitle" value="${worktitle}">
	<input type="hidden" name="workcurstep" value="${workcurstep}">
	<input type="hidden" name="worksubmittime" value="${worksubmittime}">
	<input type="hidden" name="workStatus" value="0">
	<input type="hidden" name="fromFlag" value="<%=fromFlag%>">
</form>
<!----------加签结束---------->
<!----------阅件开始---------->
<form id="selfsendForm" class="dialog" action="/defaultroot/dealfile/selfSend.controller?workId=${wfworkId}" method="post">
	<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
	<input type="hidden" name="worktitle" value="${worktitle}">
	<input type="hidden" name="workcurstep" value="${workcurstep}">
	<input type="hidden" name="worksubmittime" value="${worksubmittime}">
	<input type="hidden" name="workStatus" value="0">
</form>
<!----------阅件结束---------->
 </c:if>
	<script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
	<script type="text/javascript" src="/defaultroot/clientview/js/uploadPreview.min.js"></script>
	<script type="text/javascript" src="/defaultroot/clientview/js/subClick.js"></script>
	<script type="text/javascript" src="/defaultroot/clientview/js/common.js"></script>
	<script type="text/javascript" src="/defaultroot/clientview/js/ajaxfileupload.js"></script>
  <script type="text/javascript">
  //Export DOM7 to local variable to make it easy accessable
  var myApp = new Framework7({
       fastClicks: false,
  });
  var $$ = Dom7;

  //右下角菜单弹框
  $$('#fbtn-more').click(function () {
    // body...
	//alert(1);
    $$('.new-popover').css("display","block");
    $$('.gray-back').css("display","block");
  })
  $$('.gray-back').click(function () {
    // body...
    $$('.new-popover').css("display","none");
    $$('.gray-back').css("display","none");
  })

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

	 var dialog = null;
    var flag = 1;//防止重复提交
    var backFlag = 1//防止退回重复提交
    function subForm(){
    	if(flag == 0){
    		return;
    	}
    	flag = 0;
    	$('#sendForm').submit();
    }
    function subBackForm(){
    	if(backFlag == 0){
    		return;
    	}
    	backFlag = 0;
    	$('#backForm').submit();
    }    
    //加签防止重复提交
    var addsignFlag = '0';
    function addSign(){
    	if(addsignFlag=='1'){
    		return;
    	}
    	addsignFlag = '1';
    	$('#addSignForm').submit();
    }
    
    //转办防止重复提交
    var tranInfoFlag = '0';
    function tranInfo(){
    	if(tranInfoFlag=='1'){
    		return;
    	}
    	tranInfoFlag = '1';
    	$('#tranInfoForm').submit();
    }
    
    //阅件防止重复提交
    var selfsendFlag = '0';
    function selfsend(){
    	if(selfsendFlag=='1'){
    		return;
    	}
    	selfsendFlag = '1';
    	$('#selfsendForm').submit();
    }
    function pageLoading(){
        dialog = $.dialog({
            content:"页面加载中...",
            title: 'load'
        });
    }
    function pageLoaded(){
        if (document.readyState == "complete") {
            setTimeout(function(){
                dialog.close();
            },500);
        }
    }
    
	//解决input输入框的问题
	document.write( '<style>#footerButton{visibility:hidden}@media(min-height:' + ($( window ).height() - 10) + 'px){#footerButton{visibility:visible}}</style>' );
	if(/Android [4-6]/.test(navigator.appVersion)) {
		window.addEventListener("resize", function() {
			if(document.activeElement.tagName=="INPUT" || document.activeElement.tagName=="TEXTAREA") {
				window.setTimeout(function() {
					document.activeElement.scrollIntoViewIfNeeded();
				},0);
			}
		})
	}
	//解决input输入框的问题

	$(function(){
		
		$("textarea").each(function(){
			$(this).change(function(){ 
				$(this).next('.edit-txta-num').html($(this).attr('maxlength')-$(this).val().length );
			});
		});


		$('.active').mousedown(function(){
			$(this).css('background','#f5f5f5');
		})
		$('.active').mouseup(function(){
			$(this).css('background','');
		})

	})

    $(function(){
    	//设置单选、下拉框等初始化时的内容
    	setDefaultSpanHtml();
        //单选
        $$("ul.edit-radio li").click(function(){
		     if($$(this).hasClass("radio-active")){
		        $$(this).removeClass("radio-active");
		     }else{
		        $$(this).addClass("radio-active");
		     }
		  });
        //更多菜单展开
        var fbtnMore = $("#fbtnMore");
        var fbtnMoreCon = $(".fbtn-more-nav");
        if(fbtnMoreCon.is(':visible')){
            fbtnMoreCon.hide();
            $(".wh-section").click(function(){
                fbtnMoreCon.hide();
            })
        }
        fbtnMoreCon.hide();
        fbtnMore.click(function(){
            fbtnMoreCon.toggle();
        });
        //选择日期时间
        selectDateTime();
    });
    
    //表单必填项验证
    function formCheck(){
        //var commentmustnonull = ${commentmustnonull};
		return confirmForm();
    	var tipsName = '';
    	var checkOk = true;
    	$('#table_form tr td span em').each(function(){
    		var value = $(this).parent().parent().next('td').children().val();
    		if(value == '' && value != undefined){
	    		tipsName = $(this).parent().parent().text().replace('：','').replace('*','');
    			myApp.alert(tipsName.trim()+'不能为空！');
    			checkOk = false;
    			return false;
    		}
    	});    	
    	if(commentmustnonull == 'true'){
	       	if($('comment_input') != null){
	            var comment = $('comment_input').value;
	            if(comment == ''){ 
	            	myApp.alert('批示意见不能为空！')
	            	checkOk = false;
	            }
	        }
        }
    	return checkOk;
    }
    
    function changeFocus(obj){
    	 obj.selectionStart = obj.value.length;
    	 //alert("33");
    }
    
    function setSelect(obj){
    	var selectVal = $(obj).find("option:selected").text();
    	$(obj).parent().find('div>span').html(selectVal);
    }
    
    //选择批示意见
    function selectComment(obj){
    	var $selectObj = $(obj);
    	var selectVal = $selectObj.val();
    	if(selectVal == '0'){
        	selectVal = '';
        }
    	var $textarea = $selectObj.parent().siblings();
    	//setSpanHtml(obj,selectVal);
    	$textarea.val($textarea.val() + selectVal);
    	obj.options[0].selected = "selected";
		//--new--
		var newp = $(obj).parent();
		var newo = $(obj).clone();
		$(obj).remove();
		newp.append(newo);
    }
    
    //设置span中的值
	function setSpanHtml(obj,selectVal){
    	if(!selectVal){
    		selectVal = $(obj).find("option:selected").text();
    	}
		$(obj).parent().find('div>span').html(selectVal);
	}    
    
    //设置页面初始时的选项内容显示
    function setDefaultSpanHtml(){
    	var selectText = '';
    	var $currSelect;
    	$('select').each(function(){
    		$currSelect = $(this);
    		selectText = $currSelect.find("option:selected").text();
    		$currSelect.parent().find('div>span').html(selectText);
    	});
    }
    
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
    	var firstParam;
    	$('input').each(function(){
    		dateType = $(this).data('datetype');
    		if(dateType){
				$(this).mobiscroll(opt[dateType]);
    		}
    	});
    }
    
    //打开选择人员页面
	function selectUser(selectType,selectName,selectId,range,listType){ 
		myApp.showPreloader('页面加载中...');
		var selectIdVal = $('input[id="'+selectId+'"]').val();
        if(listType=='orguser'){
			if(selectIdVal.indexOf(";") > 0 ){
				var selectIdArray = selectIdVal.split(';');
				selectIdVal = selectIdArray[1];
			}
			
			if(selectIdVal){
				selectIdVal = selectIdVal.replace(/\\$\\$/g,'$,$').replace(/\*\*/g,'*,*').replace(/\*\\$/g,'*,$').replace(/\\$\*/g,'$,*');
			}
	    }else{
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
		}
		var postUrl = '';
		if(listType == 'org'){
			postUrl = '/defaultroot/newperson/orgList.controller';
		}else if(listType=='user'){
			postUrl = '/defaultroot/newperson/personList.controller';
		}else if(listType=='orguser'){
			postUrl = '/defaultroot/newperson/personOrgList.controller';
		}
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
		var loadingDialog = openTipsDialog('正在上传...');
		var fileShowName = $("#"+upImgId).val();
		$.ajaxFileUpload({
			url: '/defaultroot/upload/fileUpload.controller?modelName=customform', //用于文件上传的服务器端请求地址
			secureuri:false,
			fileElementId: upImgId, //文件上传域的ID
			dataType: 'json', //返回值类型 一般设置为json
			success: function (msg, status){  //服务器成功响应处理函数---获取上传图片保存名
				$("#img_name_"+(index-1)).val(msg.data+"|"+fileShowName);
				$("#"+imgliId).show();
				loadingDialog.close();
			},
			error: function (data, status, e){//服务器响应失败处理函数
				myApp.alert("文件上传失败！");
			}
		});
	}
    
    function selectCallBack(obj1,obj2){
    	if(obj1.val() && obj2.val()){
			obj2.val(obj1.val() + ";" + obj2.val());
    	}else{
    		obj2.val('');
    	}
	}

    //打开子表 
    /*function addSubTable(workId){
		pageLoading();
		var postUrl = '/defaultroot/dealfile/subprocess.controller?workId='+workId;
		$.ajax({
			url : postUrl,
			type : "post",
			data : {},
			success : function(data){
				$("#subtableContent").append(data);
				hiddenContent(2);
				if(dialog){
					dialog.close();
				}
			}
		});
		//window.open('/defaultroot/dealfile/subprocess.controller?workId='+workId);
	}*/
	var flowgraphurl = '${flowgraphurl}';
    $(document).ready(function(){
	 workFlowGetLog('/defaultroot/dealfile/workFlowGetLog.controller');
	 var modibutton = '${modibutton}';
	 var ezflow_activityTip = '${ezflow_activityTip}';
	 var ezflow_activityTipCotent = '${ezflow_activityTipCotent}';
	 var ezflow_activityTipTitle = '${ezflow_activityTipTitle}';
	 if(modibutton.indexOf('cmdGUIDANG')>-1){
	     myApp.alert("该办理环节含有不支持移动端处理的功能“归档”，请于PC端处理！");
	 }
	 if($("#dealTip").html()!='' && $("#dealTip").html()!=null){
		 myApp.alert($("#dealTip").html());
	 }
	 if(ezflow_activityTip=='1' && ezflow_activityTip=='1'){
		 myApp.alert(ezflow_activityTipTitle+" "+ezflow_activityTipCotent);
	 }
	});
    var imgflag = '0';
	function workFlowGraph(){
		if(flowgraphurl!='' && flowgraphurl!=undefined  && imgflag =='0'){
			openImg(flowgraphurl);
		}
	}

    //加载流程图
	function openImg(fileName) {
		myApp.showPreloader('正在加载...');
		$.ajax({
			 type: 'post',
			 url: "<%=rootPath%>/download/downloadImg.controller",
			 dataType:'text',
			 data : {"fileName": fileName,"name": fileName,"path":"workflow_acc","realtime":"1"},
			 success: function(data){
			 $('#wfImg').attr("src", "<%=rootPath%>"+data); 
			 imgflag = '1';
			 myApp.hidePreloader();
			 },error: function(xhr, type){
				 myApp.alert('数据查询异常！');
			 }
		
		});
	}

	//流程记录
    function workFlowGetLog(url){
		var val = '<%=workId%>';
        $.ajax({
            type: 'post',
            url: url,
            dataType: 'text',
            data : {'workId':val},
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
                	addDom +='<tr>'
                        +'<td width="33.2%">'
                        +'  <div class="step-username">'
                         +'   <p>'+listData[i].logUserName+' </p>'
                        +'    <em>'+(listData[i].logTime!=null?listData[i].logTime.substring(2,listData[i].logTime.length):"")+'</em>'
                       +'   </div>'
                       +' </td>'
                      +'  <td width="33.2%">'
                        +'  <div class="step-name">'
                       +'     <em class="skyblue">'+listData[i].logAction+'</em>'
                       +'   </div>'
                      +'  </td>'
                      +'  <td>'
                      +'    <div class="step-recive">'
                       +'     <p>'+listData[i].logReceive+'</p>'
                       +'   </div>'
                      +'  </td>'
                     +' </tr>';
                      
                }
                if(!addDom){
                	addDom = '<li><p><a>系统没有查询到任何记录！</a></p></li>';
                }
                $('#workflowlog').append(addDom);	
            },
            error: function(xhr, type){
                myApp.alert('数据查询异常！');
            }
        });
    }
    
	//主表计算字段
	function mainMath(obj){
		var id=obj.id;
		var objval =document.getElementById(id).value;
        if(isNaN(objval)){
			document.getElementById(id).value="";
			alert("请输入数字");
			return false;
		}
		var val = $('.edit-ipt-r.mainmath').attr("mainmathfun");//合计字段的公式
		var mathId = $('.edit-ipt-r.mainmath').attr("id");
		var str = val.replace(/\*/g, '|').replace(/\+/g, '|').replace(/\-/g, '|').replace(/\//g, '|').replace(/\(/g, '|').replace(/\)/g, '|');
		str = str.replace("||", "|");
		var strArr = str.split("|");
		var sa="";//公式id;
		var mval="";//公式id对应的值
		for(var i=0;i<strArr.length;i++){
			sa = strArr[i];
			if(sa !=null && sa!=''){
				mval = document.getElementById(sa).value;
				val=val.replace(sa,mval);
			}			
		}
        document.getElementById(mathId).value=eval(val);
	}

	$(function(){
		setTimeout(loadImg(),'500');
		signImg();
	});
	//加载手写签名自动追加
    	function loadImg(){
			$("input[name='imgNames']").each(
				function (){
					var filename = $(this).val();
					var filenamenew = 'rev'+filename+'.gif';
					if(filename != 'null'){
						$.ajax({
							type : 'post',
							url : '<%=rootPath%>/download/downloadImg.controller',
							dataType : 'text',
                            async: false,
							data : {"fileName":filenamenew,"name":filenamenew,"path":"workflow_acc","realtime":"1"},
							success : function(data){
								$('#'+filename).attr("src","<%=rootPath%>"+data);
							},
							error : function (xhr,type){
								alert('数据查询异常！');
							}
						});
					}
				}
			);
		}
     
	    //签名图片
    	function signImg(){
			$("input[name='signImg']").each(
				function (){
					var filename = $(this).val();
					var newfilename = filename.split(".")[0];
					if(filename != 'null'){
						$.ajax({
							type : 'post',
							url : '<%=rootPath%>/download/downloadImg.controller',
							dataType : 'text',
                            async: false,
							data : {"fileName":filename,"name":filename,"path":"peopleinfo"},
							success : function(data){
								//$('#'+newfilename).attr("src","<%=rootPath%>"+data);
							},
							error : function (xhr,type){
								alert('数据查询异常！');
							}
						});
					}
				}
			);
		}
  </script>
</body>
