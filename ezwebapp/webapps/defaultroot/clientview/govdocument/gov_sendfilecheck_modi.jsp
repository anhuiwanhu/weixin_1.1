<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%
String workId = request.getParameter("workId");
String orgId = session.getAttribute("orgId").toString();
String userName = session.getAttribute("userName")==null?"":session.getAttribute("userName").toString();
%>
<!DOCTYPE html>
<html>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>文件办理</title>
  <%@ include file="/clientview/common/headerInit.jsp"%>
  <link rel="stylesheet" href="/defaultroot/clientview/template115/css/alert/template.alert.css" />
 </head>
<body class="grey-bg">
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page" data-page="page-webapp-form">
          <section class="page-content wh-section wh-section-bottomfixed">
            <div class="webapp-form">
              <div class="app-tabheader-line clearfix">
                <div class="clearfix">
                  <a href="#tab11" class="tab-link active" style="width:50%">
                    <span>流程表单</span>
                  </a>
                  <a href="#tab13" onclick="openWorkFlowGetLog();" class="tab-link tab-link-rw" style="width:50%">
                    <span>流程记录</span>
                  </a>
                </div>
              </div>
              <div class="tabs">
                <!-- 流程表单 -->
				<c:if test="${not empty docXml}">
				<x:parse xml="${docXml}" var="doc"/>
				<c:set var="hasbackbutton"><x:out select="$doc//workInfo/havebackbutton/text()"/></c:set>
				<c:set var="modibutton"><x:out select="$doc//workInfo/modibutton/text()"/></c:set>
				<c:set var="wfworkId"><x:out select="$doc//wf_work_id/text()"/></c:set>
				<c:set var="workcurstep"><x:out select="$doc//workInfo/workcurstep/text()"/></c:set>
				<c:set var="worktitle"><x:out select="$doc//workInfo/worktitle/text()"/></c:set>
				<c:set var="worksubmittime"><x:out select="$doc//workInfo/worksubmittime/text()"/></c:set>
				<c:set var="commentmustnonull_isTrue"><x:out select="$doc//workInfo/commentmustnonull/text()"/></c:set>
				<c:set var="wfsmsRight"><x:out select="$doc//smsRight/text()"/></c:set>
				<c:set var="EmpLivingPhoto"><x:out select="$doc//workInfo/empLivingPhoto/text()"/></c:set>
				<c:set var="trantype"><x:out select="$doc//workInfo/trantype/text()"/></c:set>
				<c:set var="flowgraphurl"><x:out select="$doc//workInfo/flowgraphurl/text()"/></c:set>
				<c:set var="dealTipsContent" ><x:out select="$doc//dealTipsContent/text()" escapeXml="false" /></c:set>
				<c:set var="wfcommentType" ><x:out select="$doc//commentType/text()" escapeXml="false" /></c:set>
				<c:set var="commentFieldShowSignature"><x:out select="$doc//workInfo/commentFieldShowSignature/text()"/></c:set>
				<c:set var="isDossier"><x:out select="$doc//workInfo/isDossier/text()"/></c:set>
				<div id="dealTipsContent" style="display:none">${dealTipsContent}</div>
                <div id="tab11" class="tab active">
                  <div class="form-table">
					<form id="sendForm" action="/defaultroot/workflow/sendnew.controller?modibutton=<%=(String)pageContext.getAttribute("modibutton") %>&isDossier=<%=(String)pageContext.getAttribute("isDossier") %>" method="post">						
							<table style="border-collapse:separate;border-spacing: 0 10px;">
								<%
									List govDocFormList = new ArrayList();
									govDocFormList  = (List)request.getAttribute("govDocFormList");
									for(int i=0;i<govDocFormList.size();i++){
										Map _map = (Map) govDocFormList.get(i);
										//if(_map.get("text")!=null){ 
											if("field1".equals(_map.get("keyId"))){
												if("13".equals(_map.get("fieldDisplayType"))){
								%>
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="appName"><%=_map.get("text")%></c:set>
														<c:set var="filename"><%=_map.get("text")%>.doc</c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appName}" />
															<jsp:param name="saveFileNames" value="${filename}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>
								<%
												}
												if("14".equals(_map.get("fieldDisplayType"))){
								%>	
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="appName"><%=_map.get("text")%></c:set>
														<c:set var="filename"><%=_map.get("text")%>.xls</c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appName}" />
															<jsp:param name="saveFileNames" value="${filename}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>	
										
								<%				}
												if("17".equals(_map.get("fieldDisplayType"))){
								%>					
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="sc_fujian"><%=_map.get("text")%></c:set>
											<%
														String fujian_value=(String)pageContext.getAttribute("sc_fujian");
														String[] fujian_array=fujian_value.split(",");
			            					%>
														<c:set var="appNames"><%=fujian_array[0] %></c:set>
														<c:set var="filenames"><%=fujian_array[1] %></c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appNames}" />
															<jsp:param name="saveFileNames" value="${filenames}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>	
										
								<%				}else{
								%>					<tr>
														<td><span>查看正文</span></td>
														<td><p>
														<c:set var="appName"><%=_map.get("text")%>.doc</c:set>
														<c:set var="filename"><%=_map.get("text")%>.doc</c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="正文.doc" />
															<jsp:param name="saveFileNames" value="${filename}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
													</tr>	
								<%				}
											}else if("field2".equals(_map.get("keyId"))){
												if("13".equals(_map.get("fieldDisplayType"))){
								%>
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="appName"><%=_map.get("text")%></c:set>
														<c:set var="filename"><%=_map.get("text")%>.doc</c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appName}" />
															<jsp:param name="saveFileNames" value="${filename}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>
								<%
												}
												if("14".equals(_map.get("fieldDisplayType"))){
								%>	
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="appName"><%=_map.get("text")%></c:set>
														<c:set var="filename"><%=_map.get("text")%>.xls</c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appName}" />
															<jsp:param name="saveFileNames" value="${filename}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>	
										
								<%				}
												if("17".equals(_map.get("fieldDisplayType"))){
								%>					
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="sc_fujian"><%=_map.get("text")%></c:set>
											<%
														String fujian_value=(String)pageContext.getAttribute("sc_fujian");
														String[] fujian_array=fujian_value.split(",");
			            					%>
														<c:set var="appNames"><%=fujian_array[0] %></c:set>
														<c:set var="filenames"><%=fujian_array[1] %></c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appNames}" />
															<jsp:param name="saveFileNames" value="${filenames}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>	
										
								<%				}else{
								%>					<tr>
														<td><span><%=_map.get("name")%></span></td>
														<td><p><%=_map.get("text")==null?"":_map.get("text")%></p></td>
													</tr>	
								<%				}	
											}else if("field3".equals(_map.get("keyId"))){
												if("13".equals(_map.get("fieldDisplayType"))){
								%>
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="appName"><%=_map.get("text")%></c:set>
														<c:set var="filename"><%=_map.get("text")%>.doc</c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appName}" />
															<jsp:param name="saveFileNames" value="${filename}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>
								<%
												}
												if("14".equals(_map.get("fieldDisplayType"))){
								%>	
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="appName"><%=_map.get("text")%></c:set>
														<c:set var="filename"><%=_map.get("text")%>.xls</c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appName}" />
															<jsp:param name="saveFileNames" value="${filename}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>	
										
								<%				}
												if("17".equals(_map.get("fieldDisplayType"))){
								%>					
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="sc_fujian"><%=_map.get("text")%></c:set>
											<%
														String fujian_value=(String)pageContext.getAttribute("sc_fujian");
														String[] fujian_array=fujian_value.split(",");
			            					%>
														<c:set var="appNames"><%=fujian_array[0] %></c:set>
														<c:set var="filenames"><%=fujian_array[1] %></c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appNames}" />
															<jsp:param name="saveFileNames" value="${filenames}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>	
										
								<%				}else{
								%>					<tr>
														<td><span><%=_map.get("name")%></span></td>
														<td><p><%=_map.get("text")==null?"":_map.get("text")%></p></td>
													</tr>	
								<%				}
											}else if("field5".equals(_map.get("keyId"))){
								if("13".equals(_map.get("fieldDisplayType"))){
								%>
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="appName"><%=_map.get("text")%></c:set>
														<c:set var="filename"><%=_map.get("text")%>.doc</c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appName}" />
															<jsp:param name="saveFileNames" value="${filename}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>
								<%
												}
												if("14".equals(_map.get("fieldDisplayType"))){
								%>	
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="appName"><%=_map.get("text")%></c:set>
														<c:set var="filename"><%=_map.get("text")%>.xls</c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appName}" />
															<jsp:param name="saveFileNames" value="${filename}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>	
										
								<%				}
												if("17".equals(_map.get("fieldDisplayType"))){
								%>					
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="sc_fujian"><%=_map.get("text")%></c:set>
											<%
														String fujian_value=(String)pageContext.getAttribute("sc_fujian");
														String[] fujian_array=fujian_value.split(",");
			            					%>
														<c:set var="appNames"><%=fujian_array[0] %></c:set>
														<c:set var="filenames"><%=fujian_array[1] %></c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appNames}" />
															<jsp:param name="saveFileNames" value="${filenames}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>	
										
								<%				}else{
								%>					<tr>
														<td><span><%=_map.get("name")%></span></td>
														<td><p><%=_map.get("text")==null?"":_map.get("text")%></p></td>
													</tr>	
								<%				}	
											}else if("field6".equals(_map.get("keyId"))){
												if("13".equals(_map.get("fieldDisplayType"))){
								%>
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="appName"><%=_map.get("text")%></c:set>
														<c:set var="filename"><%=_map.get("text")%>.doc</c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appName}" />
															<jsp:param name="saveFileNames" value="${filename}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>
								<%
												}
												if("14".equals(_map.get("fieldDisplayType"))){
								%>	
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="appName"><%=_map.get("text")%></c:set>
														<c:set var="filename"><%=_map.get("text")%>.xls</c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appName}" />
															<jsp:param name="saveFileNames" value="${filename}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>	
										
								<%				}
												if("17".equals(_map.get("fieldDisplayType"))){
								%>					
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="sc_fujian"><%=_map.get("text")%></c:set>
											<%
														String fujian_value=(String)pageContext.getAttribute("sc_fujian");
														String[] fujian_array=fujian_value.split(",");
			            					%>
														<c:set var="appNames"><%=fujian_array[0] %></c:set>
														<c:set var="filenames"><%=fujian_array[1] %></c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appNames}" />
															<jsp:param name="saveFileNames" value="${filenames}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>	
										
								<%				}else{
								%>					<tr>
														<td><span><%=_map.get("name")%></span></td>
														<td><p><%=_map.get("text")==null?"":_map.get("text")%></p></td>
													</tr>	
								<%				}	
											}else if("field7".equals(_map.get("keyId"))){
								if("13".equals(_map.get("fieldDisplayType"))){
								%>
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="appName"><%=_map.get("text")%></c:set>
														<c:set var="filename"><%=_map.get("text")%>.doc</c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appName}" />
															<jsp:param name="saveFileNames" value="${filename}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>
								<%
												}
												if("14".equals(_map.get("fieldDisplayType"))){
								%>	
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="appName"><%=_map.get("text")%></c:set>
														<c:set var="filename"><%=_map.get("text")%>.xls</c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appName}" />
															<jsp:param name="saveFileNames" value="${filename}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>	
										
								<%				}
												if("17".equals(_map.get("fieldDisplayType"))){
								%>					
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="sc_fujian"><%=_map.get("text")%></c:set>
											<%
														String fujian_value=(String)pageContext.getAttribute("sc_fujian");
														String[] fujian_array=fujian_value.split(",");
			            					%>
														<c:set var="appNames"><%=fujian_array[0] %></c:set>
														<c:set var="filenames"><%=fujian_array[1] %></c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appNames}" />
															<jsp:param name="saveFileNames" value="${filenames}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>	
										
								<%				}else{
								%>					<tr>
														<td><span><%=_map.get("name")%></span></td>
														<td><p><%=_map.get("text")==null?"":_map.get("text")%></p></td>
													</tr>	
								<%				}
											}else if("field8".equals(_map.get("keyId"))){
												if("13".equals(_map.get("fieldDisplayType"))){
								%>
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="appName"><%=_map.get("text")%></c:set>
														<c:set var="filename"><%=_map.get("text")%>.doc</c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appName}" />
															<jsp:param name="saveFileNames" value="${filename}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>
								<%
												}
												if("14".equals(_map.get("fieldDisplayType"))){
								%>	
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="appName"><%=_map.get("text")%></c:set>
														<c:set var="filename"><%=_map.get("text")%>.xls</c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appName}" />
															<jsp:param name="saveFileNames" value="${filename}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>	
										
								<%				}
												if("17".equals(_map.get("fieldDisplayType"))){
								%>					
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="sc_fujian"><%=_map.get("text")%></c:set>
											<%
														String fujian_value=(String)pageContext.getAttribute("sc_fujian");
														String[] fujian_array=fujian_value.split(",");
			            					%>
														<c:set var="appNames"><%=fujian_array[0] %></c:set>
														<c:set var="filenames"><%=fujian_array[1] %></c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appNames}" />
															<jsp:param name="saveFileNames" value="${filenames}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>	
										
								<%				}else{
								%>					<tr>
														<td><span><%=_map.get("name")%></span></td>
														<td><p><%=_map.get("text")==null?"":_map.get("text")%></p></td>
													</tr>	
								<%				}	
											}else if("field9".equals(_map.get("keyId"))){
												if("13".equals(_map.get("fieldDisplayType"))){
								%>
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="appName"><%=_map.get("text")%></c:set>
														<c:set var="filename"><%=_map.get("text")%>.doc</c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appName}" />
															<jsp:param name="saveFileNames" value="${filename}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>
								<%
												}
												if("14".equals(_map.get("fieldDisplayType"))){
								%>	
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="appName"><%=_map.get("text")%></c:set>
														<c:set var="filename"><%=_map.get("text")%>.xls</c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appName}" />
															<jsp:param name="saveFileNames" value="${filename}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>	
										
								<%				}
												if("17".equals(_map.get("fieldDisplayType"))){
								%>					
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="sc_fujian"><%=_map.get("text")%></c:set>
											<%
														String fujian_value=(String)pageContext.getAttribute("sc_fujian");
														String[] fujian_array=fujian_value.split(",");
			            					%>
														<c:set var="appNames"><%=fujian_array[0] %></c:set>
														<c:set var="filenames"><%=fujian_array[1] %></c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appNames}" />
															<jsp:param name="saveFileNames" value="${filenames}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>	
										
								<%				}else{
								%>					<tr>
														<td><span><%=_map.get("name")%></span></td>
														<td><p><%=_map.get("text")==null?"":_map.get("text")%></p></td>
													</tr>	
								<%				}	
											}else if("field10".equals(_map.get("keyId"))){
												if("13".equals(_map.get("fieldDisplayType"))){
								%>
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="appName"><%=_map.get("text")%></c:set>
														<c:set var="filename"><%=_map.get("text")%>.doc</c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appName}" />
															<jsp:param name="saveFileNames" value="${filename}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>
								<%
												}
												if("14".equals(_map.get("fieldDisplayType"))){
								%>	
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="appName"><%=_map.get("text")%></c:set>
														<c:set var="filename"><%=_map.get("text")%>.xls</c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appName}" />
															<jsp:param name="saveFileNames" value="${filename}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>	
										
								<%				}
												if("17".equals(_map.get("fieldDisplayType"))){
								%>					
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p>
														<c:set var="sc_fujian"><%=_map.get("text")%></c:set>
											<%
														String fujian_value=(String)pageContext.getAttribute("sc_fujian");
														String[] fujian_array=fujian_value.split(",");
			            					%>
														<c:set var="appNames"><%=fujian_array[0] %></c:set>
														<c:set var="filenames"><%=fujian_array[1] %></c:set>
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appNames}" />
															<jsp:param name="saveFileNames" value="${filenames}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													</p></td>
												</tr>	
								<%				}else{
								%>					<tr>
														<td><span><%=_map.get("name")%></span></td>
														<td><p><%=_map.get("text")==null?"":_map.get("text")%></p></td>
													</tr>	
								<%				}
											}else{
												if("custemFieldList".equals(_map.get("keyId"))){
												}else{
								%>				
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p><%=_map.get("text")==null?"":_map.get("text")%></p></td>
												</tr>
								<%				
												}
											}
									//	}
									}
								%>
								
								<c:if test="${not empty govDocXml}">
								<x:parse xml="${govDocXml}" var="govDoc"/>
								<c:set var="goldGridId"><x:out select="$govDoc//goldGridId/text()"/></c:set>
								<c:set var="wordType"><x:out select="$govDoc//wordType/text()"/></c:set>
								<x:forEach select="$govDoc//baseData" var="bd" >
									<x:if select="$bd/custemFieldList">
										<x:forEach select="$bd/custemFieldList/custemField" var="cf" >
											<c:set var="custemFieldtype"><x:out select="$cf/displayType/text()" /></c:set>
											<c:if test="${custemFieldtype =='110'}">
												<tr>
													<td colspan="2" style="background-color: #f9f9f9;">
														<span><x:out select="$cf/name/text()"/></span>
													</td>
												</tr>
												<tr>
													<td colspan="2">
														<div class="wh-article-atta">
															<textarea class="edit-txta edit-txta-l" maxlength="166" rows="4" readonly="readonly"><x:if select="$cf/content/text() != 'null'"><x:out select="$cf/content/text()"/></x:if></textarea>
														</div>
													</td>
												</tr>
											</c:if>
											<c:if test="${custemFieldtype !='110'}">
												<tr>
													<td>
														<span><x:out select="$cf/name/text()"/></span>
													</td>
													<td><p>
														<c:choose>
															<c:when test="${custemFieldtype eq '116' || custemFieldtype eq '118'}">
															<x:if select="$cf/content/text() != 'null'">
																<c:set var="appName"><x:out select="$cf/content/text()" /></c:set>
																<c:set var="filename"><x:out select="$cf/content/text()" />.doc</c:set>
																 <c:if test="${not empty filename}"> 
																	<jsp:include page="../common/include_download.jsp" flush="true">
																		<jsp:param name="realFileNames"	value="${appName}" />
																		<jsp:param name="saveFileNames" value="${filename}" />
																		<jsp:param name="moduleName" value="govdocumentmanager" />
																	</jsp:include>          			
																 </c:if>
																 </x:if>	
															</c:when>
															<c:when test="${custemFieldtype eq '117' }">
															<x:if select="$cf/content/text() != 'null'">
																<c:set var="appName"><x:out select="$cf/content/text()" /></c:set>
																<c:set var="filename"><x:out select="$cf/content/text()" />.xls</c:set>
																 <c:if test="${not empty filename}"> 
																	<jsp:include page="../common/include_download.jsp" flush="true">
																		<jsp:param name="realFileNames"	value="${appName}" />
																		<jsp:param name="saveFileNames" value="${filename}" />
																		<jsp:param name="moduleName" value="govdocumentmanager" />
																	</jsp:include>          			
																 </c:if>	
																 </x:if>
															</c:when>
															<c:when test="${custemFieldtype eq '115' }">
															<x:if select="$cf/content/text() != 'null'">
																<c:set var="sc_fujian"><x:out select="$cf/content/text()" /></c:set>
																	<%
																		String fujian_value=(String)pageContext.getAttribute("sc_fujian");
																		fujian_value = fujian_value.replace(",","");
																		String[] fujian_array=fujian_value.split(";");
																	%>
																	<c:set var="appNames"><%=fujian_array[0] %></c:set>
																	<c:set var="filenames"><%=fujian_array[1] %></c:set>
																	<c:if test="${not empty filenames}">
																		<jsp:include page="../common/include_download.jsp" flush="true">
																			<jsp:param name="realFileNames"	value="${filenames}" />
																			<jsp:param name="saveFileNames" value="${appNames}" />
																			<jsp:param name="moduleName" value="customform" />
																		</jsp:include>
																	</c:if>
																	</x:if>
															</c:when>
															<c:otherwise>
																<c:set var="fileContent1"><x:out select="$cf/content/text()" /></c:set>
																	<c:if test="${fileContent1!= 'null'}">
																		<c:set var="fileContent2">${fn:substringBefore(fileContent1, ";")}</c:set>
																	<%
																		String fileContent2=(String)pageContext.getAttribute("fileContent2");
																		if("".equals(fileContent2)){
																	%>
																		${fn:replace(fileContent1, ";", "")}
																	<% 
																		}else{
																	%>
																		${fileContent2}
																	<% 		
																		}
																	%>
																	</c:if>
															</c:otherwise>
														</c:choose></p>
													</td>
												</tr>
											</c:if>
										</x:forEach>
									</x:if>
								</x:forEach>
								<x:if select="$govDoc//docSaveFile">
									<tr>
										<td><span>查看正文</span></td>
										<td><p>
											<%
											StringBuilder docSaveFiles = new StringBuilder();
											StringBuilder docRealFiles = new StringBuilder();
											%>
											<x:forEach select="$govDoc//docSaveFile/file" var="file" >
												<c:set var="saveFile" ><x:out select="$file/text()" /></c:set>
												<%
												docSaveFiles.append(pageContext.getAttribute("saveFile").toString()).append("|");
												%>
											</x:forEach>
											<x:forEach select="$govDoc//docRealFile/file" var="file" >
												<c:set var="realFile" ><x:out select="$file/text()" /></c:set>
												<%
												docRealFiles.append(pageContext.getAttribute("realFile").toString()).append("|");
												%>
											</x:forEach>
											<c:if test="${saveFile!='' &&  saveFile != null}">
											<jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="<%=docRealFiles.toString() %>" />
												<jsp:param name="saveFileNames" value="<%=docSaveFiles.toString() %>" />
												<jsp:param name="realtime" value="1" />
												<jsp:param name="moduleName" value="govdocumentmanager" />
											</jsp:include>
											</c:if>
											</p>
										</td>
									</tr>
								</x:if>
								<x:if select="$govDoc//realFile">
									<tr>
										<td><span>附件</span></td>
										<td><p>
											<%
											StringBuilder saveFiles = new StringBuilder();
											StringBuilder realFiles = new StringBuilder();
											%>
											<x:forEach select="$govDoc//saveFile/file" var="file" >
												<c:set var="saveFile" ><x:out select="$file/text()" /></c:set>
												<%
												saveFiles.append(pageContext.getAttribute("saveFile").toString()).append("|");
												%>
											</x:forEach>
											<x:forEach select="$govDoc//realFile/file" var="file" >
												<c:set var="realFile" ><x:out select="$file/text()" /></c:set>
												<%
												realFiles.append(pageContext.getAttribute("realFile").toString()).append("|");
												%>
											</x:forEach>
											<c:if test="${saveFile!='' &&  saveFile != null}">
											<jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="<%=realFiles.toString() %>" />
												<jsp:param name="saveFileNames" value="<%=saveFiles.toString() %>" />
												<jsp:param name="moduleName" value="govdocumentmanager" />
											</jsp:include>
											</c:if>
											</p>
										</td>
									</tr>
								</x:if>
								
								<!-- 批示意见内容 -->
								<c:set var="commentField"><x:out select="$doc//workInfo/commentField/text()"/></c:set>
								<c:set var="commentFieldName"><x:out select="$doc//workInfo/commentFieldName/text()"/></c:set>
								<c:set var="g_step"></c:set>
								<c:set var="g_content"></c:set>
								<x:forEach select="$doc//commentList/comment" var="ct" >
									<c:set var="commentType"><x:out select="$ct//type/text()"/></c:set>
									<c:set var="commentContent"><x:out select="$ct//content/text()"/></c:set>
									<c:set var="commentstatus"><x:out select="$ct//commentstatus/text()"/></c:set>
									<c:set var="commentstep"><x:out select="$ct//step/text()"/></c:set>
									<c:if test="${commentstatus =='1'}">
									<tr>
										<td>
											<span><x:out select="$ct//step/text()"/></span>
										</td>
										<td><p>					
											<c:if test="${commentType =='0'}">
												<c:set var="commentDate"><x:out select="$ct//date/text()"/></c:set>
												<x:out select="$ct//content/text()"/>&nbsp;&nbsp;<x:out select="$ct//person/text()"/><c:if test="${not empty commentDate}">(${fn:substring(commentDate,0,16)})</c:if></br>	
											</c:if>	
											<c:if test="${commentType =='1'}">
												<c:set var="commentDate"><x:out select="$ct//date/text()"/></c:set>
												<img  width="100%" class="lazy lazy-fadeIn" id="${commentContent}" ><x:out select="$ct//person/text()"/><c:if test="${not empty commentDate}">(${fn:substring(commentDate,0,16)})</c:if><br/>
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
											</p>										
										</td>
									</tr>
									</c:if>
									<c:if test="${commentstatus =='0'}">
										<% 
										pageContext.setAttribute("g_step",pageContext.getAttribute("commentstep").toString());
										pageContext.setAttribute("g_content",pageContext.getAttribute("commentContent").toString());
										%>
									</c:if>
								</x:forEach>
								<c:choose>
									<c:when test="${not empty commentFieldName && not empty commentField && '-1' ne commentField && 'nullCommentField' ne commentField && param.workStatus ne '102' && param.workStatus ne '101'}">
										<tr>
											<td>
												<span>${commentFieldName}</span>
											</td>
											<td>
												<c:if test="${wfcommentType == '1'}">
													暂不支持手写，如您需要手写请于PC端处理！
												</c:if>
												<c:if test="${wfcommentType == '0'}">
													<c:if test="${commentFieldShowSignature !='true' && commentFieldShowSignature !=true}">
														<div class="edit-direct2" style="text-align:right;">
															<textarea  placeholder="请输入文字" name="comment_input" rows="4" id="comment_input" maxlength="1000"></textarea>					
															<div class="edit-direct">
																<div class="edit-sel-show">
																	<span style="color: #ccc;">请选择常用语：&nbsp;&nbsp;&nbsp;</span>
																</div>
																<select onchange="selectComment(this);" class="btn-bottom-pop"  prompt="">
																	<option value="0">请选择常用语：&nbsp;&nbsp;&nbsp;&nbsp;</option> 
																	<x:forEach select="$doc//officelist" var="selectvalue" >
																		<option value='<x:out select="$selectvalue/text()"/>'><x:out select="$selectvalue/text()"/></option>
																	</x:forEach>
																</select>
															</div>
														</div>
													</c:if>
													<c:if test="${commentFieldShowSignature =='true' || commentFieldShowSignature ==true}">										
													</c:if>
												</c:if>
												<!-- 直接显示批示意见 -->
												<div class="edit-direct2" style="text-align:right;">
														<c:if test="${g_step == commentFieldName}">
															<textarea  placeholder="请输入文字" name="comment_input" rows="4" id="comment_input" maxlength="1000" >${g_content}</textarea>
														</c:if>
														<c:if test="${g_step != commentFieldName}">
															<textarea  placeholder="请输入文字" name="comment_input" rows="4" id="comment_input" maxlength="1000"></textarea>
														</c:if>
														<div class="edit-direct edit-direct-none">
															<div class="edit-sel-show">
																<span style="color: #ccc;">请选择常用语：&nbsp;&nbsp;&nbsp;</span>
															</div>
															<select onchange="selectComment(this);" class="btn-bottom-pop"  prompt="">
																<option value="0">请选择常用语：&nbsp;&nbsp;&nbsp;&nbsp;</option> 
																<x:forEach select="$doc//officelist" var="selectvalue" >
																	<option value='<x:out select="$selectvalue/text()"/>'><x:out select="$selectvalue/text()"/></option>
																</x:forEach>
															</select>
														</div>
														
												</div>
											</td>
										</tr>
									</c:when>
									<c:when test="${empty commentFieldName && not empty workcurstep && not empty commentField && '-1' ne commentField && 'nullCommentField' ne commentField && param.workStatus ne '102' && param.workStatus ne '101'}">
										<tr>
											<td>
												<span>${workcurstep}</span>
											</td>
											<td>
												<c:if test="${wfcommentType == '1'}">
													暂不支持手写，如您需要手写请于PC端处理！
												</c:if>
												<c:if test="${wfcommentType == '0'}">
													<c:if test="${commentFieldShowSignature !='true' && commentFieldShowSignature !=true}">
														<div class="edit-direct2" style="text-align:right;">
															<textarea  placeholder="请输入文字" name="comment_input" rows="4" id="comment_input" maxlength="1000"></textarea>					
															<div class="edit-direct">
																<div class="edit-sel-show">
																	<span style="color: #ccc;">请选择常用语：&nbsp;&nbsp;&nbsp;</span>
																</div>
																<select onchange="selectComment(this);" class="btn-bottom-pop"  prompt="">
																	<option value="0">请选择常用语：&nbsp;&nbsp;&nbsp;&nbsp;</option> 
																	<x:forEach select="$doc//officelist" var="selectvalue" >
																		<option value='<x:out select="$selectvalue/text()"/>'><x:out select="$selectvalue/text()"/></option>
																	</x:forEach>
																</select>
															</div>
														</div>
													</c:if>
													<c:if test="${commentFieldShowSignature =='true' || commentFieldShowSignature ==true}">										
													</c:if>
												</c:if>
												<!-- 直接显示批示意见 -->
												<div class="edit-direct2" style="text-align:right;">
														<c:if test="${g_step == commentFieldName}">
															<textarea  placeholder="请输入文字" name="comment_input" rows="4" id="comment_input" maxlength="1000" >${g_content}</textarea>
														</c:if>
														<c:if test="${g_step != commentFieldName}">
															<textarea  placeholder="请输入文字" name="comment_input" rows="4" id="comment_input" maxlength="1000"></textarea>
														</c:if>
														<div class="edit-direct edit-direct-none">
															<div class="edit-sel-show">
																<span style="color: #ccc;">请选择常用语：&nbsp;&nbsp;&nbsp;</span>
															</div>
															<select onchange="selectComment(this);" class="btn-bottom-pop"  prompt="">
																<option value="0">请选择常用语：&nbsp;&nbsp;&nbsp;&nbsp;</option> 
																<x:forEach select="$doc//officelist" var="selectvalue" >
																	<option value='<x:out select="$selectvalue/text()"/>'><x:out select="$selectvalue/text()"/></option>
																</x:forEach>
															</select>
														</div>
														
												</div>
											</td>
										</tr>
									</c:when>
									<c:when test="${param.workStatus == '2'}">
										<c:set var="passRoundCommField" ><x:out select="$doc//workInfo/passRoundCommField/text()"/></c:set>
										<c:set var="passRoundCommFieldType" ><x:out select="$doc//workInfo/passRoundCommFieldType/text()"/></c:set>
										<c:if test="${passRoundCommField == 'autoCommentField'}">
										<tr>
											<td>审批意见：
											</td>
											<td>
												<div class="edit-direct2" style="text-align:right;">
														<textarea  placeholder="请输入文字" name="comment_input" id="comment_input" rows="4" maxlength="1000"></textarea>
												</div>
						                    </td>
										</tr>
										</c:if>
									</c:when>
								</c:choose>	
								
								<!--<c:if test="${param.flag !='ed'}">
									 <c:set var="commentFieldName"><x:out select="$doc//workInfo/commentFieldName/text()"/></c:set>
									 <c:if test="${commentFieldName !='' }">
										<tr>
											<td>
												<span>${commentFieldName }</span>
											</td>
											<td>
												<div class="edit-direct2" style="text-align:right;">
													<textarea  placeholder="请输入文字" name="comment_input" id="comment_input" maxlength="50"></textarea>					
													<div class="edit-direct">
														<div class="edit-sel-show">
															<span style="color: #ccc;">常用审批语&nbsp;&nbsp;&nbsp;</span>
														</div>
														<select onchange="selectComment(this);" class="btn-bottom-pop"  prompt="">
															<option value="0">常用审批语&nbsp;&nbsp;&nbsp;&nbsp;</option> 
															<x:forEach select="$doc//officelist" var="selectvalue" >
																<option value='<x:out select="$selectvalue/text()"/>'><x:out select="$selectvalue/text()"/></option>
															</x:forEach>
														</select>
													</div>
												</div>
											</td>
										</tr>
										</c:if>
									</c:if>-->
									<!--  
									<x:if select="$govDoc//comment/sendFileCheckWriterComment">
										<tr>
											<td><span><x:out select="$govDoc//comment/sendFileCheckWriterComment/@name"/></span></td>
											<td><p>
												<c:set var="sendFileCheckWriterComment"><x:out select="$govDoc//comment/sendFileCheckWriterComment/text()" escapeXml="false"/></c:set> 
												${fn:replace(sendFileCheckWriterComment,'.0', '')}</p>
											</td>
										</tr>
									</x:if>
									<x:if select="$govDoc//comment/sendFileCheckFinishDate">
										<tr>
											<td><span><x:out select="$govDoc//comment/sendFileCheckFinishDate/@name"/></span></td>
											<td><p>
												<c:set var="sendFileCheckFinishDate"><x:out select="$govDoc//comment/sendFileCheckFinishDate/text()" escapeXml="false"/></c:set>
												${fn:replace(sendFileCheckFinishDate,'.0', '')}</p>
											</td>
										</tr>
									</x:if>
									<x:if select="$govDoc//comment/sendFileCheckLeaderComment">
										<tr>
											<td><span><x:out select="$govDoc//comment/sendFileCheckLeaderComment/@name"/></td></span>
											<td><p>
												<c:set var="sendFileCheckLeaderComment"><x:out select="$govDoc//comment/sendFileCheckLeaderComment/text()" escapeXml="false"/></c:set>
												${fn:replace(sendFileCheckLeaderComment,'.0', '')}</p>
											</td>
										</tr>
									</x:if>
									-->
									<!--退回意见begin-->
							 	<x:if select="$doc//backComment/text() != ''" >
							 		<c:set var="content" ><x:out select="$doc//backComment/text()" /></c:set>
							 		<c:if test="${content!= 'back'}" >
									<tr>
										<td>
											<span>退回意见</span>
										</td>
										<td><p>
											<%
											   String aContent =(String)pageContext.getAttribute("content");
											   aContent = org.apache.commons.lang.StringEscapeUtils.unescapeXml(aContent);
											   aContent = StringUtils.replace(aContent,"<br>&nbsp;&nbsp;&nbsp;&nbsp;","\n<br/>    ");
											   aContent = StringUtils.replace(aContent,"&nbsp;&nbsp;&nbsp;&nbsp;","\n<br/>    ");
											   String newcontent = aContent;
												newcontent = StringUtils.replace(newcontent,"<br>","<br/>");
												newcontent = StringUtils.replace(newcontent,"<br/>","\n<br/>");
												newcontent = StringUtils.replace(newcontent,"&nbsp;"," ");
												int blankpos = newcontent.lastIndexOf("    ");
												if(blankpos > 0){
													newcontent = newcontent.substring(0,blankpos)+"\n<br/>"+newcontent.substring(blankpos+4);
												}
											  %>   
											<c:set var="uname" value="<%=newcontent%>" /> 
											${uname }</p>
									   </td>
									</tr>
									</c:if>
								 </x:if>   
									<!--退回意见end-->
							</table>
						</c:if>
						<input type="hidden" name="tableId" value="<%=workId%>" />
						<input type="hidden" name="recordId" value="<x:out select="$doc//workInfo/workrecord_id/text()"/>" />
						<input type="hidden" name="activityId" value="<x:out select="$doc//workInfo/initactivity/text()"/>" />
						<input type="hidden" name="workId" value="<x:out select="$doc//workInfo/wf_work_id/text()"/>" />
						<input type="hidden" name="stepCount" value="<x:out select="$doc//workInfo/workstepcount/text()"/>" />
						<input type="hidden" name="isForkTask" value="<x:out select="$doc//isForkTask/text()"/>" />
						<input type="hidden" name="forkStepCount" value="<x:out select="$doc//forkStepCount/text()"/>" />
						<input type="hidden" name="forkId" value="<x:out select="$doc//forkId/text()"/>" />
						<input type="hidden" name="activityclass" value="<x:out select="$doc//activityClass/text()"/>" />
						<input type="hidden" name="commentType" value="0" />
						<input type="hidden" name="pass_title" value=""  />
						<input type="hidden" name="pass_time" value="" />
						<input type="hidden" name="pass_person" value="" />
						<input type="hidden" name="__sys_operateType" value="2" />
						<input type="hidden" name="__sys_infoId" value='<x:out select="$doc//paramList/workrecord_id/text()"/>' />
						<input type="hidden" name="__sys_pageId" value='<x:out select="$doc//paramList/worktable_id/text()"/>' />
						<input type="hidden" name="__sys_formType" value='<x:out select="$doc//paramList/formType/text()"/>' />	
						<input type="hidden" name="__main_tableName" value='<x:out select="$doc//fieldList/tableName/text()"/>' />	
						<input type="hidden" name="actiCommFieldType" value='<x:out select="$doc//workInfo/actiCommFieldType/text()"/>' />
						<input type="hidden" name="curCommField" value='<x:out select="$doc//workInfo/commentField/text()"/>' />
						<input type="hidden" name="trantype" value='<x:out select="$doc//workInfo/trantype/text()"/>' />
						<x:if select="$doc//workInfo/commentmustnonull" var="commentmustnonull">
							<input type="hidden" name="commentmustnonull" value='<x:out select="$doc//workInfo/commentmustnonull/text()"/>' />
						</x:if>
						<x:if select="$doc//workInfo/backnocomment" var="backnocomment">
							<input type="hidden" name="backnocomment" value='<x:out select="$doc//workInfo/backnocomment/text()"/>' />
						</x:if>
						<x:if select="$doc//workInfo/backMailRange" var="backMailRange">
							<input type="hidden" name="backMailRange" value='<x:out select="$doc//workInfo/backMailRange/text()"/>' />
						</x:if>
						<x:if select="$doc//workInfo/smsRight" var="smsRight">
							<input type="hidden" name="smsRight" value='<x:out select="$doc//workInfo/smsRight/text()"/>' />
						</x:if>
						<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
						<input type="hidden" name="worktitle" value="${worktitle}">
						<input type="hidden" name="workcurstep" value="${workcurstep}">
						<input type="hidden" name="worksubmittime" value="${worksubmittime}">
						<input type="hidden" name="workStatus" value="0">
					</form>
                  </div>
                </div>
				<form id="sendFormAgain" action="/defaultroot/dealfile/pressInfo.controller?workId=${wfworkId}&amp;smsRight=${wfsmsRight }" method="post">
					<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
					<input type="hidden" name="worktitle" value="${worktitle}">
					<input type="hidden" name="workcurstep" value="${workcurstep}">
					<input type="hidden" name="worksubmittime" value="${worksubmittime}">
					<input type="hidden" name="workStatus" value="1100">
				</form>
				<form id="backForm" action="/defaultroot/workflow/back.controller" method="post">
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
				</form>
                </c:if>
				<!-- 流程图加载 -->
                <div id="tab12" class="tab">  
                  <p><img id="lct"  width="100%" class="lazy lazy-fadeIn"></p> 
                </div>
                <!-- 流程图记录 -->
                <div id="tab13" class="tab">
                  <div class="form-table-record">
                    <table style="border-collapse:separate;border-spacing: 0 10px;" id="flowRecord">
                      
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </section>
          <c:if test="${param.workStatus ne '102'}">
			<c:choose>
				<c:when test="${param.workStatus eq '0'}">
					<footer class="wh-footer wh-footer-forum">
						<div class="wh-container">
						  <div class="wh-footer-btn row">
							<div class="webapp-footer-linebtn">
							  <div class="fl clearfix">
								<c:choose>
									<c:when test="${hasbackbutton == 'true' }">
										<a href="javascript:subBackForm();" class="panel-return-a">退回</a>
										<a href="javascript:subForm();" class="panel-send-a">发送</a>
									</c:when>
									<c:otherwise>
										<a href="javascript:subForm();" class="panel-send-a">发送</a>
									</c:otherwise>
								</c:choose>
							  </div>
							  	<c:if test="${fn:indexOf(modibutton,'Tran') >0 || fn:indexOf(modibutton,'AddSign') >0 || fn:indexOf(modibutton,'Selfsend') >0}">
									<a id="fbtn-form-more" data-popover=".popover-links" class="fr fbtn-more link open-popover "><span>更多</span></a>
								</c:if>
							</div>
						  </div>
						</div>
					</footer>
				</c:when>
				<c:when test="${param.workStatus eq '2'}">
					<footer class="wh-footer wh-footer-forum">
						<div class="wh-container">
						  <div class="wh-footer-btn row">
							<div class="webapp-footer-linebtn">
							  <div class="fl clearfix">
								<a href="javascript:workfolwSend('${wfworkId}');" class="panel-send-a"> 发送</a>
							  </div>
							</div>
						  </div>
						</div>
					</footer>
				</c:when>
				<c:when test="${param.workStatus eq '101'}">
					<c:if test="${fn:indexOf(workcurstep,'办理完毕') == '-1'}">
						<footer class="wh-footer wh-footer-forum">
							<div class="wh-container">
							  <div class="wh-footer-btn row">
								<div class="webapp-footer-linebtn">
								  <div class="fl clearfix">
									<c:choose>
										<c:when test="${fn:indexOf(modibutton,'Undo') >0 && fn:indexOf(modibutton,'Wait') >0}">
											<a href="javascript:workfolwUndo('${wfworkId}');" class="panel-press-a close-popover">撤办</a>
											<a href="javascript:document.getElementById('sendFormAgain').submit();" class="panel-press-a close-popover">催办</a>
										</c:when>
										<c:when test="${fn:indexOf(modibutton,'Undo') >0 && fn:indexOf(modibutton,'Wait') <=0}">
											<a href="javascript:workfolwUndo('${wfworkId}');" class="panel-press-a close-popover">撤办</a>
										</c:when>
										<c:when test="${fn:indexOf(modibutton,'Undo') <=0 && fn:indexOf(modibutton,'Wait') >0}">
											<a href="javascript:document.getElementById('sendFormAgain').submit();" class="panel-press-a close-popover">催办</a>
										</c:when>
									</c:choose>
								  </div>
								</div>
							  </div>
							</div>
						</footer>
					</c:if>
				</c:when>
				<c:when test="${param.workStatus eq '1100'}">
					<c:if test="${fn:indexOf(modibutton,'Wait') >0}">
						<footer class="wh-footer wh-footer-forum">
							<div class="wh-container">
							  <div class="wh-footer-btn row">
								<div class="webapp-footer-linebtn">
								  <div class="fl clearfix">
									<a href="javascript:document.getElementById('sendFormAgain').submit();" class="panel-press-a close-popover">催办</a>
								  </div>
								</div>
							  </div>
							</div>
						</footer>
					</c:if>
				</c:when>
			</c:choose>
		  </c:if>
        </div>
      </div>
    </div>
  </div>
  <c:if test="${param.workStatus ne '102'}">
	<c:choose>
		<c:when test="${param.workStatus eq '0'}">
			<div class="fbtn-more-nav popover popover-links" id="fbtn-more-con">
				<div class="fbtn-more-nav-inner" id="fbtn-more-list">
					<c:if test="${fn:indexOf(modibutton,'Tran') >0}">
						<a href="javascript:$('#tranInfoForm').submit();" class="panel-turn-a close-popover">转办</a>
					</c:if>
					<c:if test="${fn:indexOf(modibutton,'AddSign') >0}">
						<a href="javascript:$('#addSignForm').submit();" class="panel-add-a close-popover">加签</a>
					</c:if>
					<c:if test="${fn:indexOf(modibutton,'Selfsend') >0}">
						<a href="javascript:$('#selfsendForm').submit();" class="panel-read-a close-popover">阅件</a>
					</c:if>
				</div>
			</div>
		</c:when>
		<c:when test="${param.workStatus eq '2'}">
		</c:when>
		<c:when test="${param.workStatus eq '101'}">
			<c:if test="${fn:indexOf(workcurstep,'办理完毕') == '-1'}">
				<div class="fbtn-more-nav popover popover-links" id="fbtn-more-con">
					<div class="fbtn-more-nav-inner" id="fbtn-more-list">
						
					</div>
				</div>
			</c:if>
		</c:when>
		<c:when test="${param.workStatus eq '1100'}">
		
		</c:when>
	</c:choose>
  </c:if>
  <!----------阅件开始---------->
<form id="selfsendForm" class="dialog" action="/defaultroot/dealfile/selfSend.controller?workId=${wfworkId}" method="post">
	<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
	<input type="hidden" name="worktitle" value="${worktitle}">
	<input type="hidden" name="workcurstep" value="${workcurstep}">
	<input type="hidden" name="worksubmittime" value="${worksubmittime}">
	<input type="hidden" name="workStatus" value="0">
</form>
<!----------阅件结束---------->
<!----------转办开始---------->
<form id="tranInfoForm" class="dialog" action="/defaultroot/dealfile/tranInfo.controller?workId=${wfworkId}" method="post">
	<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
	<input type="hidden" name="worktitle" value="${worktitle}">
	<input type="hidden" name="workcurstep" value="${workcurstep}">
	<input type="hidden" name="worksubmittime" value="${worksubmittime}">
	<input type="hidden" name="trantype" value="${trantype}">
	<input type="hidden" name="workStatus" value="0">
</form>
<!----------转办结束---------->
<!----------加签开始---------->
<form id="addSignForm" class="dialog" action="/defaultroot/dealfile/addSign.controller?workId=${wfworkId}" method="post">
	<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
	<input type="hidden" name="worktitle" value="${worktitle}">
	<input type="hidden" name="workcurstep" value="${workcurstep}">
	<input type="hidden" name="worksubmittime" value="${worksubmittime}">
	<input type="hidden" name="workStatus" value="0">
</form>
<!----------加签结束---------->
<script type="text/javascript" src="<%=rootPath%>/clientview/js/subClick.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/template115/js/alert/zepto.alert.js"></script>
  <script type="text/javascript">
  	//Export DOM7 to local variable to make it easy accessable
	 var myApp = new Framework7({
	       fastClicks: false,
	 });
	 var $$ = Dom7;

  //解决input输入框的问题
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
 	
 	  function judgeAppCanDo(){
    	var modibutton = '${modibutton}';
		if(modibutton==null||modibutton==undefined){
			
		}else{
			var tipValue = "";
			if(modibutton.indexOf('cmdSendclose')>-1){
			   //  myApp.alert("该办理环节含有不支持移动端处理的功能“归档”，请于PC端处理！");
			   tipValue += "该办理环节含有不支持移动端处理的功能“分发”，请于PC端处理！";
			}
			if(modibutton.indexOf('cmdSavefile')>-1){
			   //  myApp.alert("该办理环节含有不支持移动端处理的功能“归档”，请于PC端处理！");
			   tipValue += "该办理环节含有不支持移动端处理的功能“生成正式文件”，请于PC端处理！";
			}
			if(modibutton.indexOf('cmdCode')>-1){
			   //  myApp.alert("该办理环节含有不支持移动端处理的功能“归档”，请于PC端处理！");
			   tipValue += "该办理环节含有不支持移动端处理的功能“编号”，请于PC端处理！";
			}
			if(modibutton.indexOf('cmdToreceive')>-1){
			   //  myApp.alert("该办理环节含有不支持移动端处理的功能“归档”，请于PC端处理！");
			   tipValue += "该办理环节含有不支持移动端处理的功能“转收文”，请于PC端处理！";
			}
			if(modibutton.indexOf('cmdGUIDANG')>-1){
			  //   myApp.alert("该办理环节含有不支持移动端处理的功能“归档”，请于PC端处理！");
			   tipValue += "该办理环节含有不支持移动端处理的功能“归档”，请于PC端处理！";
			}
		//	if(modibutton.indexOf('cmdAutoGUIDANG')){
			   //  myApp.alert("该办理环节含有不支持移动端处理的功能“归档”，请于PC端处理！");
		//	   tipValue += "该办理环节含有不支持移动端处理的功能“自动归档”，请于PC端处理！";
		//	}
			return tipValue;
		}
    }

 	 $(document).ready(function(){
    	 var dealTipsContent = $("#dealTipsContent").html();
         if(dealTipsContent != ''&&dealTipsContent!=null&&dealTipsContent!=undefined){ 
        	 myApp.alert(dealTipsContent);
         }
	  });
 	
  	var dialog = null;
    var flag = 1;//防止重复提交
    var backFlag = 1;//防止退回重复提交
    var workfolwSendFlag = 1;
    function subForm(){
    	var tipValue = judgeAppCanDo(); 
    	if(tipValue!=""){
			myApp.alert(tipValue);
			return;
		}
    	var commentmustnonull = "${commentmustnonull_isTrue}";
    	if(commentmustnonull == 'true'){
	       	if($('comment_input'!= null)&&$('#comment_input').length>0){
	            var comment = $('#comment_input').val();
	            if(comment == ''||comment==null||comment==undefined){ 
	            	myApp.alert('批示意见不能为空！')
	            	return;
	            }else if(comment.length>1000){
	            	myApp.alert('批示意见最大长度为1000个字！')
	            	return;
		         }
	        }
        }
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
    function pageLoading(){
        dialog = $.dialog({
            content:"页面加载中...",
            title: 'load'
        });
    }
    var flowgraphurl = '${flowgraphurl}';
    $(function(){
		if(flowgraphurl!='' && flowgraphurl!=undefined){
 			//loadFlowImg(flowgraphurl);
 		}else{
 			$("#12tab").hide();
 			$(".clearfix>a").css("width","50%");
 			$(".clearfix>a").addClass("tab-link-rw");
 			$("#tab12").hide();
 	 	}
    });

    var getFlowImgflag = '0';
	function workFlowGraph(){
		if(flowgraphurl!='' && flowgraphurl!=undefined  && getFlowImgflag =='0'){
			loadFlowImg(flowgraphurl);
		}
	}
	
	//加载图片
	function loadFlowImg(flowgraphurl){
		myApp.showPreloader(' ');
		$.ajax({
			 type: 'post',
			 url: "<%=rootPath%>/download/downloadImg.controller",
			 dataType:'text',
			 data : {"fileName": flowgraphurl,"name": flowgraphurl,"path":"workflow_acc"},
			 success: function(data){
				$('#lct').attr("src", "<%=rootPath%>"+data);
				getFlowImgflag = '1';
				myApp.hidePreloader();
			 },error: function(xhr, type){
				 alert('数据查询异常！');
			 }
		
		});
	}
    
	function workfolwSend(workId){
		if(workfolwSendFlag == 0){
    		return;
    	}
		workfolwSendFlag = 0;
		//发送流程
		$.ajax({
			url : '/defaultroot/workflow/readover.controller',
			type : 'post',
			data : $('#sendForm').serialize(),
			success : function(data){
				if(data){
					var jsonData = eval('('+data+')');
					console.info(jsonData.result);
					if(jsonData.result = 'success'){
						alert('发送成功！');
						window.location = '/defaultroot/dealfile/list.controller?workStatus=0';
					}
				}else{
					alert('发送失败！');
				}
			},
			error : function(){
				alert('发送异常！');
			}
		});
	}
	
	var workfolwUndoFlag =1;
	function workfolwUndo(workId){
		if(workfolwUndoFlag == 0){
    		return;
    	}
		myApp.confirm('是否撤回该流程到您的待办文件中重新办理？', function () {
			workfolwUndoFlag=0;
			var url ='/defaultroot/workflow/workfolwUndo.controller?workId='+workId;
			var openUrl ='/defaultroot/dealfile/list.controller?workStatus=101';
			myApp.showPreloader('正在撤办...');
			$.ajax({
				type:'POST',
				url: url,
				async: true,
				dataType: 'text',
				success: function(data){
					var json = eval("("+data+")");
					myApp.hidePreloader();
					if(json!=null){
						if(json.result == 'success'){
							myApp.alert("撤办成功！");
							window.history.go(-1);
						}else{
							myApp.alert("撤办失败！");
							workfolwUndoFlag = '0';
						}
					}
				},
				error: function(){
					myApp.alert("异常！");
					workfolwUndoFlag = '0';
				}
			});
	    },function () {
	    	workfolwUndoFlag = '1';
	     });		
	}
	
	//选择常用语
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
	
	var getlogFlag = 0;
	function openWorkFlowGetLog() {
		if(getlogFlag == 0){
			loadFlowRecord();
		}
	}
	
	//加载流程记录页面数据
	function loadFlowRecord(){	
		myApp.showPreloader(' ');
		var workId= '${workId}';
		var url ='/defaultroot/doc/getFlowRecord.controller?workId='+workId;
		$.ajax({
			type:'POST',
			url: url,
			async: true,
			dataType: 'text',
			success: function(data){
				var jsonData = eval("("+data+")");
				var html ='<tr>'+
							'<td>'+
							  '<div class="step-username">'+
								'<p>发起人</p>'+
								'<em>发送时间</em>'+
							  '</div>'+
							'</td>'+
							'<td>'+
							  '<div class="step-name">'+
								'<em class="skyblue">环节名称</em>'+
							  '</div>'+
							'</td>'+
							'<td>'+
							  '<div class="step-recive">'+
								'<p>接收人</p>'+
							  '</div>'+
							'</td>'+
						'</tr>';
				if(jsonData.data0.length>0){
					for(var i = 0; i < jsonData.data0.length; i++){
						html += '<tr>'+
									'<td>'+
									  '<div class="step-username">'+
										'<p>'+jsonData.data0[i].logUserName+'</p>'+
										'<em>'+jsonData.data0[i].logTime.substring(2)+'</em>'+
									  '</div>'+
									'</td>'+
									'<td>'+
									  '<div class="step-name">'+
										'<em class="skyblue">'+jsonData.data0[i].logAction+'</em>'+
									  '</div>'+
									'</td>'+
									'<td>'+
									  '<div class="step-recive">'+
										'<p>'+jsonData.data0[i].logReceive+'</p>'+
									  '</div>'+
									'</td>'+
								'</tr>';
					}
					$$('#flowRecord').html(html);
				}
				getlogFlag = 1;
                myApp.hidePreloader();	
			},
			error: function(){
				alert("异常！");
			}
		});  
	}

	$(function(){
		setTimeout(loadImg(),'500');
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
  </script>
</body>
