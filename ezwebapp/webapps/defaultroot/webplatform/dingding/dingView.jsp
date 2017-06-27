<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.whir.webplatform.manage.po.*"%>
<%@ page import="com.whir.webplatform.manage.bd.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.whir.webplatform.manage.utils.WeiXinResource"%>
<!DOCTYPE html>
<html lang="zh-cn">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <%@ include file="/webplatform/include/headerInit.jsp"%>
   
</head>

<%
   String CorpID_def = "企业号后台-设置-企业号信息-账号信息";
   String CorpSecret_def = "企业号后台-设置-权限管理-新建管理组后可见";
   String SSOSSecret_def = "企业号后台-应用中心-创建应用后-回调模式-回调URL及密钥";
   DingBasePO basepo = (DingBasePO)request.getAttribute("basepo");
   String corpID_value = CorpID_def;
   String CorpSecret_value = CorpSecret_def;
   String SSOSSecret_value = SSOSSecret_def;

   String hasfirst_value = "";
   String relationId_value = "";
   if(basepo!=null){
     if(basepo.getCorpID()!=null&&!"".equals(basepo.getCorpID())){corpID_value = basepo.getCorpID();}
     if(basepo.getCorpSecret()!=null&&!"".equals(basepo.getCorpSecret())){CorpSecret_value = basepo.getCorpSecret();}
     if(basepo.getSSOSSecret()!=null&&!"".equals(basepo.getSSOSSecret())){SSOSSecret_value = basepo.getSSOSSecret();}

	 if(basepo.getHasfirst()!=null&&!"".equals(basepo.getHasfirst())){hasfirst_value = basepo.getHasfirst();}
	 if(basepo.getRelationId()!=null&&!"".equals(basepo.getRelationId())){relationId_value = basepo.getRelationId();}
   }


   String AppId_def = "应用ID";
%>

<body>
  <%@ include file="/webplatform/include/include_base_module.jsp"%>
  <div class="wh-mobile-container">
    <%@ include file="/webplatform/include/include_base_menu.jsp"%>
    <div class="wh-webapp-content">
	  <form id="baseForm" name="baseForm" action="" method="post">
      <div class="wh-webapp-DING wh-webapp-weixin">
        <div class="ding-title">
          <span class="t-checked"><input type="radio" name="firstding" value="0" checked/>&nbsp;首次使用钉钉</span>
          <span style="margin-left: 5px;"><input type="radio" name="firstding" value="1"/>&nbsp;钉钉已有组织用户</span>
        </div>
        <div class="ding-con ding-con1 clearfix">
          <div class="con-tip">
            <em>1</em>
            <span>关联ID</span>：
          </div>
          <div class="con-con check-id">
            <label>
              <input type="radio" name="relationId" value="empId" />empID
            </label>
            <label>
              <input type="radio" name="relationId" value="userAccount" checked/>OA账号（非中文）
            </label>
            <label>
              <input type="radio" name="relationId" value="userSimpleName"/>用户简码
            </label>
            <label>
              <input type="radio" name="relationId" value="empIdCard"/>身份证号
            </label>
          </div>
        </div>
        <div class="ding-con ding-con2">
          <div class="con-tip">
            <em>2</em>
            <span>填写参数：</span>
          </div>
          <div class="con-con">
            <div class="con-con-div">
              <label>CorpID：</label>
              <input type="text" name="CorpID" id="CorpID" value="<%=corpID_value%>" onclick="if(this.value=='<%=CorpID_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=CorpID_def%>';}"/>
            </div>
            <div class="con-con-div">
              <label>CorpSecret：</label>
              <input type="text" name="CorpSecret" id="CorpSecret" value="<%=CorpSecret_value%>" onclick="if(this.value=='<%=CorpSecret_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=CorpSecret_def%>';}"/>
            </div>
            <div class="con-con-div">
              <label>SSOSSecret：</label>
              <input type="text" name="SSOSSecret" id="SSOSSecret" value="<%=SSOSSecret_value%>" onclick="if(this.value=='<%=SSOSSecret_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=SSOSSecret_def%>';}"/>
            </div>
            <a onclick="saveDingBase();" href="javascript:void(0)" class="mobile-btn-line-circle">同步参数</a>
          </div>
        </div>
        </form>
		<form id="syncForm" name="syncForm" action="" method="post">
        <div class="ding-con ding-con3">
          <div class="con-tip">
            <em>3</em>
            <span>同步组织用户</span>: 
          </div>
          <div class="con-con">
            <a href="javascript:void(0)" onclick="syncOrgAndUsers();" class="mobile-btn-line-circle">手动同步</a>
            <a href="javascript:void(0)" class="alink" onclick="SynFailLog();">同步失败日志</a>
          </div>
        </div>
		</form>

        <div class="ding-con weixin-con4">
          <div class="con-tip">
            <em>4</em>
            <span>同步应用</span>：
          </div>
		  <form id="menuForm" name="menuForm" action="" method="post">
          <div class="con-con" id="menuDiv">
			<div class="btndiv clearfix">
              <a href="javascript:void(0)" class="mobile-btn-suqare">应用模块</a>
            </div>
			<ul class="clearfix">
              <li style="width:580px">
                <label>
                  <input type="checkbox" name="chekApp" id="chekApp" value="homePageId" />应用主页</label>
                <input type="text" name="AgentIdhomePageId" id="AgentIdhomePageId" value="<%=AppId_def%>" onclick="if(this.value=='<%=AppId_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=AppId_def%>';}" style="width:459px"/>
              </li>
            </ul>
            <ul class="clearfix">
              <li>
                <label>
                  <input type="checkbox" name="chekApp" id="chekApp" value="<%=WeiXinResource.getWorkflowappid()%>" /><%=WeiXinResource.getWorkflowappname()%></label>
                <input type="text" name="AgentId<%=WeiXinResource.getWorkflowappid()%>" id="AgentId<%=WeiXinResource.getWorkflowappid()%>" value="<%=AppId_def%>" onclick="if(this.value=='<%=AppId_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=AppId_def%>';}"/>
              </li>
              <li>
                <label>
                  <input type="checkbox" name="chekApp" id="chekApp" value="<%=WeiXinResource.getGovdocumentappid()%>" /><%=WeiXinResource.getGovdocumentappname()%></label>
                <input type="text" name="AgentId<%=WeiXinResource.getGovdocumentappid()%>" id="AgentId<%=WeiXinResource.getGovdocumentappid()%>" value="<%=AppId_def%>" onclick="if(this.value=='<%=AppId_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=AppId_def%>';}"/>
              </li>
            </ul>
            <ul class="clearfix">
              <li>
                <label>
                  <input type="checkbox" name="chekApp" id="chekApp" value="<%=WeiXinResource.getInformationappid()%>" /><%=WeiXinResource.getInformationappname()%></label>
                <input type="text" name="AgentId<%=WeiXinResource.getInformationappid()%>" id="AgentId<%=WeiXinResource.getInformationappid()%>" value="<%=AppId_def%>" onclick="if(this.value=='<%=AppId_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=AppId_def%>';}"/>
              </li>
              <li>
                <label>
                  <input type="checkbox" name="chekApp" id="chekApp" value="<%=WeiXinResource.getForumappid()%>" /><%=WeiXinResource.getForumappname()%></label>
                <input type="text" name="AgentId<%=WeiXinResource.getForumappid()%>" id="AgentId<%=WeiXinResource.getForumappid()%>" value="<%=AppId_def%>" onclick="if(this.value=='<%=AppId_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=AppId_def%>';}"/>
              </li>
            </ul>
            <ul class="clearfix">
              <li>
                <label>
                  <input type="checkbox" name="chekApp" id="chekApp" value="<%=WeiXinResource.getMeetappid()%>" /><%=WeiXinResource.getMeetappname()%></label>
                <input type="text" name="AgentId<%=WeiXinResource.getMeetappid()%>" id="AgentId<%=WeiXinResource.getMeetappid()%>" value="<%=AppId_def%>" onclick="if(this.value=='<%=AppId_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=AppId_def%>';}"/>
              </li>
              <li>
                <label>
                  <input type="checkbox" name="chekApp" id="chekApp" value="<%=WeiXinResource.getWeixinkqappid()%>" /><%=WeiXinResource.getWeixinkqappname()%></label>
                <input type="text" name="AgentId<%=WeiXinResource.getWeixinkqappid()%>" id="AgentId<%=WeiXinResource.getWeixinkqappid()%>" value="<%=AppId_def%>" onclick="if(this.value=='<%=AppId_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=AppId_def%>';}"/>
              </li>
            </ul>
            <ul class="clearfix">
              <li>
                <label>
                  <input type="checkbox" name="chekApp" id="chekApp" value="<%=WeiXinResource.getWorkdailyappid()%>" /><%=WeiXinResource.getWorkdailyappname()%></label>
                <input type="text" name="AgentId<%=WeiXinResource.getWorkdailyappid()%>" id="AgentId<%=WeiXinResource.getWorkdailyappid()%>" value="<%=AppId_def%>" onclick="if(this.value=='<%=AppId_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=AppId_def%>';}"/>
              </li>
			  <li>
                <label>
                  <input type="checkbox" name="chekApp" id="chekApp" value="<%=WeiXinResource.getQuestionnaireappid()%>" /><%=WeiXinResource.getQuestionnaireappname()%></label>
                <input type="text" name="AgentId<%=WeiXinResource.getQuestionnaireappid()%>" id="AgentId<%=WeiXinResource.getQuestionnaireappid()%>" value="<%=AppId_def%>" onclick="if(this.value=='<%=AppId_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=AppId_def%>';}"/>
              </li>
            </ul>
			<ul class="clearfix" >
              <li>
                <label>
                  <input type="checkbox" name="chekApp" id="chekApp" value="<%=WeiXinResource.getMailappid()%>" /><%=WeiXinResource.getMailappname()%></label>
                <input type="text" name="AgentId<%=WeiXinResource.getMailappid()%>" id="AgentId<%=WeiXinResource.getMailappid()%>" value="<%=AppId_def%>" onclick="if(this.value=='<%=AppId_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=AppId_def%>';}"/>
              </li>
             <li>
                <label>
                  <input type="checkbox" name="chekApp" id="chekApp" value="<%=WeiXinResource.getReportappid()%>" /><%=WeiXinResource.getReportappname()%></label>
                <input type="text" name="AgentId<%=WeiXinResource.getReportappid()%>" id="AgentId<%=WeiXinResource.getReportappid()%>" value="<%=AppId_def%>" onclick="if(this.value=='<%=AppId_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=AppId_def%>';}"/>
              </li>
            </ul>
          </div>

		  <%
		  WeiXinPlatformBD weixBd = new WeiXinPlatformBD();
		  List custmenulist = weixBd.getOACustmenu();
		  if(custmenulist!=null&&custmenulist.size()>1){
			 int n=custmenulist.size();
			 n = n%2;
			 for(int i=0;i<custmenulist.size()-n;i++,i++){
				   Map menumap1 = (Map) custmenulist.get(i);
                   String name1 = menumap1.get("name")+"";
				   String menuId1 = menumap1.get("custmenuId")+"";

				   Map menumap2 = (Map) custmenulist.get(i+1);
                   String name2 = menumap2.get("name")+"";
				   String menuId2 = menumap2.get("custmenuId")+"";
				%>
					<ul class="clearfix">
					  <li>
						<label>
						  <input type="checkbox" name="chekApp" id="chekApp" value="<%=menuId1%>" /><%=name1%></label>
						<input type="text" name="AgentId<%=menuId1%>" id="AgentId<%=menuId1%>" value="<%=AppId_def%>" onclick="if(this.value=='<%=AppId_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=AppId_def%>';}"/>
					  </li>
					  <li>
						<label>
						  <input type="checkbox" name="chekApp" id="chekApp" value="<%=menuId2%>" /><%=name2%></label>
						<input type="text" name="AgentId<%=menuId2%>" id="AgentId<%=menuId2%>" value="<%=AppId_def%>" onclick="if(this.value=='<%=AppId_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=AppId_def%>';}"/>
					  </li>
					</ul>
				<%
			 }

			 if(n==1){
			    Map menumap = (Map) custmenulist.get(custmenulist.size()-1);
			%>

                 <ul class="clearfix">
				  <li>
					<label>
					  <input type="checkbox" name="chekApp" id="chekApp" value="<%=menumap.get("custmenuId")%>" /><%=menumap.get("name")%></label>
					<input type="text" name="AgentId<%=menumap.get("custmenuId")%>" id="AgentId<%=menumap.get("custmenuId")%>" value="<%=AppId_def%>" onclick="if(this.value=='<%=AppId_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=AppId_def%>';}"/>
				  </li>
				  
				</ul>

			 <%
			 }
		   }

	      %>

		 
          <input name="menuJson" id="menuJson" type="hidden">
        </div>
        <div class="footer-btn">
		  <a href="javascript:void(0)" class="mobile-btn-line-circle" onclick="saveDingMenu();">同步应用</a>
        </div>
		</form>
      </div>

    </div>
  </div>
  <div id="pic-view" class="layer-modal pic-view">
    <img id="imgLogo_hide" src="<%=realpath%>/webplatform/images/ver113/webapp/pic-preview.jpg" />
  </div>
  
  
  <script type="text/javascript">
  $(document).ready(function(){
      
      <%if(hasfirst_value!=null&&!"".equals(hasfirst_value)){%>
	     $("input[type=radio][name=firstding][value=<%=hasfirst_value%>]").attr("checked",'checked')
	  <%}%>
      <%if(relationId_value!=null&&!"".equals(relationId_value)){%>
	     $("input[type=radio][name=relationId][value=<%=relationId_value%>]").attr("checked",'checked');
	  <%}%>
      
	  <%
		 DingPlatformBD dingbd = new DingPlatformBD();
		 //应用主页
		 DingMenuPO menupo = dingbd.loadDingMenuPO("homePageId");
		 if(menupo!=null){
	  %>
         $("input[type=checkbox][name=chekApp][value=<%=WeiXinResource.getWorkflowappid()%>]").attr("checked",'checked');
	     $('#AgentIdhomePageId').val('<%=menupo.getAgentID()%>');
	  <%
		 }
		 //流程
		 menupo = dingbd.loadDingMenuPO(WeiXinResource.getWorkflowappid());
		 if(menupo!=null){
	  %>
         $("input[type=checkbox][name=chekApp][value=<%=WeiXinResource.getWorkflowappid()%>]").attr("checked",'checked');
	     $('#AgentId<%=WeiXinResource.getWorkflowappid()%>').val('<%=menupo.getAgentID()%>');
	  <%
		 }
	     //公文
		 menupo = dingbd.loadDingMenuPO(WeiXinResource.getGovdocumentappid());
		 if(menupo!=null){
	  %>
         $("input[type=checkbox][name=chekApp][value=<%=WeiXinResource.getGovdocumentappid()%>]").attr("checked",'checked');
	     $('#AgentId<%=WeiXinResource.getGovdocumentappid()%>').val('<%=menupo.getAgentID()%>');
	  <%
		 }
	     //信息
		 menupo = dingbd.loadDingMenuPO(WeiXinResource.getInformationappid());
		 if(menupo!=null){
	  %>
         $("input[type=checkbox][name=chekApp][value=<%=WeiXinResource.getInformationappid()%>]").attr("checked",'checked');
	     $('#AgentId<%=WeiXinResource.getInformationappid()%>').val('<%=menupo.getAgentID()%>');
	  <%
		 }
	     //论坛
		 menupo = dingbd.loadDingMenuPO(WeiXinResource.getForumappid());
		 if(menupo!=null){
	  %>
         $("input[type=checkbox][name=chekApp][value=<%=WeiXinResource.getForumappid()%>]").attr("checked",'checked');
	     $('#AgentId<%=WeiXinResource.getForumappid()%>').val('<%=menupo.getAgentID()%>');
	  <%
		 }
	     //会议助手
		 menupo = dingbd.loadDingMenuPO(WeiXinResource.getMeetappid());
		 if(menupo!=null){
	  %>
         $("input[type=checkbox][name=chekApp][value=<%=WeiXinResource.getMeetappid()%>]").attr("checked",'checked');
	     $('#AgentId<%=WeiXinResource.getMeetappid()%>').val('<%=menupo.getAgentID()%>');
	  <%
		 }
	     //考勤
		 menupo = dingbd.loadDingMenuPO(WeiXinResource.getWeixinkqappid());
		 if(menupo!=null){
	  %>
         $("input[type=checkbox][name=chekApp][value=<%=WeiXinResource.getWeixinkqappid()%>]").attr("checked",'checked');
	     $('#AgentId<%=WeiXinResource.getWeixinkqappid()%>').val('<%=menupo.getAgentID()%>');
	  <%
		 }
	     //日志
		 menupo = dingbd.loadDingMenuPO(WeiXinResource.getWorkdailyappid());
		 if(menupo!=null){
	  %>
         $("input[type=checkbox][name=chekApp][value=<%=WeiXinResource.getWorkdailyappid()%>]").attr("checked",'checked');
	     $('#AgentId<%=WeiXinResource.getWorkdailyappid()%>').val('<%=menupo.getAgentID()%>');
	  <%
		 }
	     //问卷调查
		 menupo = dingbd.loadDingMenuPO(WeiXinResource.getQuestionnaireappid());
		 if(menupo!=null){
	  %>
         $("input[type=checkbox][name=chekApp][value=<%=WeiXinResource.getQuestionnaireappid()%>]").attr("checked",'checked');
	     $('#AgentId<%=WeiXinResource.getQuestionnaireappid()%>').val('<%=menupo.getAgentID()%>');
	  <%
		 }
	     //邮件
		 menupo = dingbd.loadDingMenuPO(WeiXinResource.getMailappid());
		 if(menupo!=null){
	  %>
         $("input[type=checkbox][name=chekApp][value=<%=WeiXinResource.getMailappid()%>]").attr("checked",'checked');
	     $('#AgentId<%=WeiXinResource.getMailappid()%>').val('<%=menupo.getAgentID()%>');
	  <%
		 }
		 //工作汇报
		 menupo = dingbd.loadDingMenuPO(WeiXinResource.getReportappid());
		 if(menupo!=null){
	  %>
	  	 $("input[type=checkbox][name=chekApp][value=<%=WeiXinResource.getReportappid()%>]").attr("checked",'checked');
	     $('#AgentId<%=WeiXinResource.getReportappid()%>').val('<%=menupo.getAgentID()%>');
	  <%
	  	}
	  %>
      
	  <%//自定义模块
		  if(custmenulist!=null&&custmenulist.size()>0){
			 for(int i=0;i<custmenulist.size();i++){
				   Map menumap = (Map) custmenulist.get(i);
				   menupo = dingbd.loadDingMenuPO(menumap.get("custmenuId")+"");
				   if(menupo!=null){
	  %>

		  $("input[type=checkbox][name=chekApp][value=<%=menumap.get("custmenuId")%>]").attr("checked",'checked');
	      $('#AgentId<%=menumap.get("custmenuId")%>').val('<%=menupo.getAgentID()%>');

	  <%
				   }
			 }
					 
		  }
	  %>

   });

  $(".check-id label").on("click", function(argument) {
    var $this = $(this);

	whir_alert2("确认信息","已确认勾选的关联ID与企业号后台账号一致，并执行操作！","取消","立即执行",function(){$this.children('input').prop('checked', false);},selectRelationId);
  })

  function showIMG(json){
    var obj =  eval("("+json+")");
	$('#saveImgName').val(obj.save_name);
	$('#realImgName').val(obj.file_name);
	$('#realFilePath').val(obj.sourcePath);
	
	var imgFilePath = obj.relative_path;
	//alert(imgFilePath);

	$('#imgLogo').attr("src", imgFilePath).load(function() {
		$('#imgLogo_hide').attr("src", imgFilePath)
        var fileOffsetWidth = this.width;
        var fileOffsetHeight = this.height;
        $('#div_logoImg').show();

    });
	
  }
  function clearImg(){
	    
		whir_alert2("确认信息","确定要删除吗？","取消","确定",
		   function(){return;},
		   function(){

              $('#div_logoImg').hide();
			  $('#saveImgName').val('');
			  $('#saveImgName').val(''); 
			  $('#realFilePath').val('');
        });
		
  }

  function selectRelationId(){
       
	   var relaId = $('input[name="relationId"]:checked').val();
	   if(relaId==null||relaId==""){
	      whir_alert1("提示信息","请选择关联ID","确定");
		  return;
	   }
	   $.ajax({
			 url : "/defaultroot/dingplatform/saveDingRelationId.controller",    
			 type : "POST",    
			 dataType:"json",
			 data : $( '#baseForm').serialize(),    
			 success : function(data) {
				 var success = data.success;
				 whir_alert1("提示信息",success,"确定");
			 },    
			 error : function(data) {
				 whir_alert1("提示信息","保存出错!","确定");
			 }    
		});  
  }

  function saveDingBase(){
       
	   var relaId = $('input[name="relationId"]:checked').val();
	   if(relaId==null||relaId==""){
	      whir_alert1("提示信息","请选择关联ID","确定");
		  return;
	   }
	   var CorpID = $('#CorpID').val();
       if(CorpID==''||CorpID=='<%=CorpID_def%>'){
	       whir_alert1("提示信息","请输入CorpID！","确定");
		   return;
	   }
	   var CorpSecret = $('#CorpSecret').val();
       if(CorpSecret==''||CorpSecret=='<%=CorpSecret_def%>'){
	       whir_alert1("提示信息","请输入CorpSecret！","确定");
		   return;
	   }
	   var SSOSSecret = $('#SSOSSecret').val();
       if(SSOSSecret==''||SSOSSecret=='<%=SSOSSecret_def%>'){
	       whir_alert1("提示信息","请输入SSOSSecret！","确定");
		   return;
	   }
	   $.ajax({
			 url : "/defaultroot/dingplatform/saveDingBase.controller",    
			 type : "POST",    
			 dataType:"json",
			 data : $( '#baseForm').serialize(),    
			 success : function(data) {
				 var success = data.success;
				 whir_alert1("提示信息",success,"确定");
			 },    
			 error : function(data) {
				 whir_alert1("提示信息","保存出错!","确定");
			 }    
		}); 

  }

  $(".ding-title span").on("click", function() {
    $(this).addClass("t-checked").siblings().removeClass("t-checked");
  })

  $(".ding-title span").eq(1).on("click", function() {
	whir_alert1("提示信息","请查看【企业号后台】-【通讯录】-【用户列表】-【账号字段】，保持与关联ID中的字段一致后，勾选。如账号字段与关联ID均无法匹配请联系管理员。","知道了");
  })

  //图片预览
  $(".pic-preview>a").on("click", function() {
    layer.open({
      type: 1,
      title: false,
      closeBtn: 0,
      area: '516px', 
      shade: 0.1,
      shadeClose: true,
      content: $('#pic-view')
    });
  })

  function saveDingMenu(){

        whir_alert2("确认信息","确定要同步应用吗？","取消","确定",
		    function(){return;},
			function(){

                    var obj=document.getElementsByName('chekApp');
					var jsonMenu = "{";
					for(var i=0; i<obj.length; i++){
					   if(obj[i].checked){
						   var thisValue = document.getElementById('AgentId'+obj[i].value).value;
						   var thisText = obj[i].nextSibling.nodeValue;
						   jsonMenu += "\""+obj[i].value+"\":\""+thisValue+","+thisText+"\",";
						   if(thisValue==''||thisValue=='<%=AppId_def%>'){
							  whir_alert1("提示信息","请输入<%=AppId_def%>！","知道了");
							  return;
						   }
					   }
					}
					if(jsonMenu!='{'){
					  jsonMenu = jsonMenu.substring(0,jsonMenu.length-1);
					}
					jsonMenu += "}";
					$('#menuJson').val(jsonMenu);
					//alert(jsonMenu);

				   $.ajax({
						 url : "/defaultroot/dingplatform/saveDingMenu.controller",    
						 type : "POST",    
						 dataType:"json",
						 data : $( '#menuForm').serialize(),    
						 success : function(data) {
							 var success = data.success;
							 whir_alert1("提示信息",success,"确定");
						 },    
						 error : function(data) {
							 whir_alert1("提示信息","保存出错!","确定");
						 }    
					}); 

            });

		

  }

  function syncOrgAndUsers(){
       
	   whir_alert2("确认信息","确定要同步吗？","取消","立即执行",function(){return;},syncData);

  }
  var isSync = "0";
  function syncData(){
      <%if(basepo==null){%>
           whir_alert1("提示信息","请先保存参数信息！","确定");
		   return;
	   <%}%>
	   //正在执行
	   if(isSync=="1"){
          whir_alert1("提示信息","正在同步数据，不要重复点击！","确定");
	      return;
	   }
       isSync = "1";
	   $.ajax({
			 url : "/defaultroot/dingplatform/syncOrgUser.controller",    
			 type : "POST",    
			 dataType:"json",
			 data : $( '#syncForm').serialize(),    
			 success : function(data) {
				 var success = data.success;
				 whir_alert1("提示信息",success,"确定");
				 isSync = "0";
			 },    
			 error : function(data) {
				 whir_alert1("提示信息","同步出错!","确定");
				 isSync = "0";
			 }    
		}); 


  }

  function SynFailLog(){
	  var iWidth=900; //弹出窗口的宽度;
      var iHeight=600; //弹出窗口的高度;
      var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
      var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;

	 var openUrl = "<%=realpath%>/dingplatform/dingSynuserlog.controller";
	 window.open(openUrl, "newwindow","height="+iHeight+", width="+iWidth+", top="+iTop+", left="+iLeft+',resizable=yes'); 

  }

  </script>
</body>

</html>
