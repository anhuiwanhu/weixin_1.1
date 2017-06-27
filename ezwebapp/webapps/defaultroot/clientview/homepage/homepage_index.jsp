<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<%
  String photoName = session.getAttribute("photoName")+"";
  String userName = session.getAttribute("userName")+"";
  String orgName = session.getAttribute("orgName")+"";
  String orgShortName = session.getAttribute("orgShortName")+"";

%>
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>应用主页</title>
  <%@ include file="/clientview/common/headerInit.jsp"%>
 </head>

<body class="grey-bg">
  
  <div class="views">
    <div class="view">
      <div class="pages">

        <div class="page" data-page="webapp-home">
          <section class="wh-section wh-section-home">
            <div class="wh-main-top">
              <div class="wh-main-img">
                <div class="wh-appimgcon">
                  <div class="wh-container">
                    <h2>万户移动办公系统</h2>
                    <%if("".equals(photoName)||"null".equals(photoName)){%>
					  <img src="<%=rootPath%>/clientview/images/desk_person.png" />
					<%}else{%>
                      <img src="<%=rootPath%>/upload/peopleinfo/<%=photoName%>" />
					<%}%>
                    <strong>欢迎您，<%=userName%></strong>
                    <span><%=orgShortName%></span>
                  </div>
                </div>
              </div>
            </div>
            <div class="wh-appcontainer">
              <div class="index-table">
                <table id="tab_index" style="border-collapse:collapse; border-spacing:0;">
                  
                </table>
              </div>
            </div>
          </section>
        </div>

      </div>
    </div>
  </div>

  <form id="indexForm" name="indexForm" action="" method="post">
  </form>
  <script>
      $(document).ready(function(){
		 $.ajax({
			 url : "<%=rootPath%>/homePage/getAllMenuData.controller",    
			 type : "POST",    
			 dataType:"json",
			 data : $('#indexForm').serialize(),    
			 success : function(data) {
				 var menuList = data.menuList;
				 var htmlstr = "";
				 if(menuList){
					htmlstr += "<tr>";
				    for(var i=0;i<menuList.length;i++){
					   var menumap = menuList[i];
					   if(i!=0 && i%4==0){
					      htmlstr += "</tr><tr>";
					   }
					   var code = menumap.code;
					   var cssstr = "";
					   if(code=="workflow"){
					      cssstr = "fa fa-share-alt";
					   }else if(code=="information"){
						  cssstr = "fa fa-short-mes";
					   }else if(code=="documentmanager"){
						  cssstr = "fa fa-briefcase";
					   }else if(code=="innermail"){
						  cssstr = "fa fa-envelope";
					   }else if(code=="workmanager_worklog"){
						  cssstr = "fa fa-log";
					   }else if(code=="meetingassistant"){
						  cssstr = "fa fa-share-alt";
					   }else if(code=="mobilelocation"){
						  cssstr = "fa fa-map-marker";
					   }else if(code=="questionnaire"){
						  cssstr = "fa fa-contract-mana";
					   }else if(code=="forum"){
						  cssstr = "fa fa-essence-inf";
					   }else if(code=='leaderevent'){
                          cssstr = "fa fa-calendar";
					   }else{
					      cssstr = "fa fa-bar-chart";
					   }
					   htmlstr += "<td width=\"25%\"><a href=\"javascript:void(0)\" onclick=\"goIndexPage('"+menumap.code+"','"+menumap.issystem+"','"+menumap.cusmenuId+"','"+menumap.displayname+"');\"><i id=\"i_"+menumap.code+"\" class=\""+cssstr+"\"></i><p>"+menumap.displayname+"</p></a></td>";
					   
					}
                    htmlstr += "</tr>";
				 }
				 $('#tab_index').html(htmlstr);

				 var remindInfo = data.remindInfo;
				 if(remindInfo){
				    var result = remindInfo.message.result;
					if(result=='1'){
					   var remindInfoData = remindInfo.data;
					   if(remindInfoData){
						   if($('#i_workflow')){
                               $('#em_workflow').remove(); 
							   if(remindInfoData.waitFile!='0'){
							      $('#i_workflow').append("<em id='em_workflow'>"+remindInfoData.waitFile+"</em>");
							   }
						   }
						   if($('#i_innermail')){
							   $('#em_innermail').remove();
							   if(remindInfoData.newMail!='0'){
						          $('#i_innermail').append("<em id='em_innermail'>"+remindInfoData.newMail+"</em>");
							   }
						   }
						   if($('#i_documentmanager')){
							   $('#em_documentmanager').remove();
							   if(remindInfoData.newInnerSendFile!='0'){
						          $('#i_documentmanager').append("<em id='em_documentmanager'>"+remindInfoData.newInnerSendFile+"</em>");
							   }
						   }
						   if($('#i_questionnaire')){
							   $('#em_questionnaire').remove();
							   if(remindInfoData.newLookInto!='0'){
						         $('#i_questionnaire').append("<em id='em_questionnaire'>"+remindInfoData.newLookInto+"</em>");
							   }
						   }
					   }
					}
				 }


			 },    
			 error : function(data) {
			 }    
		 });
	  });

	  setInterval ("flushRemindInfo()", 5000);
	  function flushRemindInfo(){

		   $.ajax({
			 url : "<%=rootPath%>/homePage/getRemindData.controller",    
			 type : "POST",    
			 dataType:"json",
			 data : $('#indexForm').serialize(),    
			 success : function(data) {

				 var remindInfo = data.remindInfo;
				 if(remindInfo){
				    var result = remindInfo.message.result;
					if(result=='1'){
					   var remindInfoData = remindInfo.data;
					   if(remindInfoData){
						   if($('#i_workflow')){
                               $('#em_workflow').remove(); 
							   if(remindInfoData.waitFile!='0'){
							      $('#i_workflow').append("<em id='em_workflow'>"+remindInfoData.waitFile+"</em>");
							   }
						   }
						   if($('#i_innermail')){
							   $('#em_innermail').remove();
							   if(remindInfoData.newMail!='0'){
						          $('#i_innermail').append("<em id='em_innermail'>"+remindInfoData.newMail+"</em>");
							   }
						   }
						   if($('#i_documentmanager')){
							   $('#em_documentmanager').remove();
							   if(remindInfoData.newInnerSendFile!='0'){
						          $('#i_documentmanager').append("<em id='em_documentmanager'>"+remindInfoData.newInnerSendFile+"</em>");
							   }
						   }
						   if($('#i_questionnaire')){
							   $('#em_questionnaire').remove();
							   if(remindInfoData.newLookInto!='0'){
						         $('#i_questionnaire').append("<em id='em_questionnaire'>"+remindInfoData.newLookInto+"</em>");
							   }
						   }
					   }
					}
				 }

			 },    
			 error : function(data) {
			 }    
		 });

	  }

	  function goIndexPage(code,issystem,cusmenuId,cusmenuName){
	     if(issystem=='1'){
			if(code=='workflow'){
			    window.location = "<%=rootPath%>/dealfile/list.controller";
			}else if(code=='innermail'){
				window.location = "<%=rootPath%>/mail/mailBox.controller";
			}else if(code=='information'){
                window.location = "<%=rootPath%>/information/index.controller";
			}else if(code=='documentmanager'){
                window.location = "<%=rootPath%>/doc/getAllReceiveFile.controller";
			}else if(code=='forum'){
                window.location = "<%=rootPath%>/post/index.controller";
			}else if(code=='workmanager_worklog'){
                window.location = "<%=rootPath%>/worklog/getWorkLogList.controller";
			}else if(code=='meetingassistant'){
                window.location = "<%=rootPath%>/meeting/meetingNoticeList.controller";
			}else if(code=='mobilelocation'){
                window.location = "<%=rootPath%>/attendance/loadWxLocation.controller";
			}else if(code=='questionnaire'){
			    window.location = "<%=rootPath%>/naire/getAnswerQuestionnaireList.controller";
			}else if(code=='leaderevent'){
			    window.location = "<%=rootPath%>/leaderEvent/leaderEvent_day.controller";
			}else if(code=='report'){
			    window.location = "<%=rootPath%>/report/index.controller";
			}
		    
		 }else{
		    window.location = "<%=rootPath%>/custmenu/custMenu.controller?menuId="+cusmenuId+"&menuName="+encodeURI(cusmenuName);
		 }
	  }
  </script>
</body>

</html>
