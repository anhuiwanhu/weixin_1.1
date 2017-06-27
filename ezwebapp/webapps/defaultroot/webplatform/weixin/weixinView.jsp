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
   String Token_def = "企业号后台-应用中心-创建应用后-回调模式-回调URL及密钥";
   String EncodingAESKey_def = "企业号后台-应用中心-创建应用后-回调模式-回调URL及密钥";
   WeixinBasePO basepo = (WeixinBasePO)request.getAttribute("basepo");
   String CorpID_value = CorpID_def;
   String CorpSecret_value = CorpSecret_def;
   String Token_value = Token_def;
   String EncodingAESKey_value = EncodingAESKey_def;

   String hasfirst_value = "";
   String relationId_value = "";
   String homepageid_def="主页应用ID";

   String homepageid_value=homepageid_def;
   if(basepo!=null){
     if(basepo.getCorpId()!=null&&!"".equals(basepo.getCorpId())){CorpID_value = basepo.getCorpId();}
     if(basepo.getCorpsecret()!=null&&!"".equals(basepo.getCorpsecret())){CorpSecret_value = basepo.getCorpsecret();}
     if(basepo.getToken()!=null&&!"".equals(basepo.getToken())){Token_value = basepo.getToken();}
	 if(basepo.getEncodingaeskey()!=null&&!"".equals(basepo.getEncodingaeskey())){EncodingAESKey_value = basepo.getEncodingaeskey();}

	 if(basepo.getHasfirst()!=null&&!"".equals(basepo.getHasfirst())){hasfirst_value = basepo.getHasfirst();}
	 if(basepo.getRelactionId()!=null&&!"".equals(basepo.getRelactionId())){relationId_value = basepo.getRelactionId();}
	 if(basepo.getHomepageId()!=null&&!"".equals(basepo.getHomepageId())){homepageid_value = basepo.getHomepageId();}
   }
    
   String AppId_def = "应用ID";
   
   WeiXinPlatformBD weixBd = new WeiXinPlatformBD();
%>
<body>
  <%@ include file="/webplatform/include/include_base_module.jsp"%>
  <div class="wh-mobile-container">
    <%@ include file="/webplatform/include/include_base_menu.jsp"%>
    <div class="wh-webapp-content">
	  <form id="baseForm" name="baseForm" action="" method="post">
      <div class="wh-webapp-DING wh-webapp-weixin">
        <div class="ding-title">
          <span class="t-checked"><input type="radio" name="firstding" value="0" checked/>&nbsp;首次使用企业号</span>
          <span><input type="radio" name="firstding" value="1"/>&nbsp;企业号已有组织用户</span>
        </div>
        <div class="ding-con ding-con1 clearfix">
          <div class="con-tip">
            <em>1</em>
            <span>关联ID </span>：
          </div>
          <div class="con-con check-id" style="margin-left: 9px;">
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
              <input type="text" name="CorpID" id="CorpID" value="<%=CorpID_value%>" onclick="if(this.value=='<%=CorpID_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=CorpID_def%>';}" style="margin-left:10px"/>
            </div>
            <div class="con-con-div">
              <label>CorpSecret：</label>
			  <input type="text" name="CorpSecret" id="CorpSecret" value="<%=CorpSecret_value%>" onclick="if(this.value=='<%=CorpSecret_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=CorpSecret_def%>';}" style="margin-left:10px"/>
            </div>
            <div class="con-con-div">
              <label>Token：</label>
              <input type="text" name="Token" id="Token" value="<%=Token_value%>" onclick="if(this.value=='<%=Token_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=Token_def%>';}" style="margin-left:10px"/>
            </div>
            
            <div class="con-con-div">
              <label>EncodingAESKey：</label>
              <input type="text" name="EncodingAESKey" id="EncodingAESKey" value="<%=EncodingAESKey_value%>" onclick="if(this.value=='<%=EncodingAESKey_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=EncodingAESKey_def%>';}" style="margin-left:10px"/>
            </div>
            <a onclick="saveWeixinBase();" href="javascript:void(0)" class="mobile-btn-line-circle">同步参数</a>
          </div>
        </div>
		</form>
		<form id="syncForm" name="syncForm" action="" method="post">
        <div class="ding-con ding-con3">
          <div class="con-tip">
            <em>3</em>
            <span>同步组织用户</span>：
          </div>
          <div class="con-con">
            <dl>
              <dt> </dt>
              <dd>
                <a href="javascript:void(0)" onclick="syncOrgAndUsers();" class="mobile-btn-line-circle">手动同步</a>
                <a href="javascript:void(0)" class="alink" onclick="SynFailLog();">同步失败日志</a>
                <%
                	 //流程
				     WeixinMenuPO syspo = weixBd.loadWeixinMenuPO("sysOrgUser_appid");
				     String sysSecret = "";
					 if(syspo!=null){
					 	sysSecret = syspo.getCorpsecret();
					 }
                 %>
                &nbsp;&nbsp;<label>Secret：</label>
                <input name="sysSecret" id="sysSecret" value="<%=sysSecret %>"  type="text" />
              </dd>
            </dl>
          </div>
        </div>
		</form>
        <div class="ding-con weixin-con4">
          <div class="con-tip">
            <em>4</em>
            <span>同步应用</span>：
          </div>
		  <form id="syncMenuForm" name="syncMenuForm" action="" method="post">
          <div class="con-con" id="menuDiv">
            <div class="btndiv clearfix">
              <a href="javascript:void(0)" class="mobile-btn-suqare">主页型应用</a>
			  <input type="text" name="homePageId" id="homePageId" value="<%=homepageid_value%>"  onclick="if(this.value=='<%=homepageid_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=homepageid_def%>';}"/>
            </div>
			<div class="btndiv clearfix">
              <a href="javascript:void(0)" class="mobile-btn-suqare">消息型应用</a>
            </div>
            <ul class="clearfix">
              <li>
                <label>
                  <input type="checkbox" name="chekApp" id="chekApp" value="<%=WeiXinResource.getWorkflowappid()%>" /><%=WeiXinResource.getWorkflowappname()%></label>
                <input type="text" name="AgentId<%=WeiXinResource.getWorkflowappid()%>" id="AgentId<%=WeiXinResource.getWorkflowappid()%>" value="<%=AppId_def%>" onclick="if(this.value=='<%=AppId_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=AppId_def%>';}"/>
              </li>
              <li>
              	<label>Secret：</label>
                <input type="text" id="Secret<%=WeiXinResource.getWorkflowappid()%>" name="Secret<%=WeiXinResource.getWorkflowappid()%>"/>
              </li>
            </ul>
            <ul class="clearfix">
              <li>
                <label>
                  <input type="checkbox" name="chekApp" id="chekApp" value="<%=WeiXinResource.getGovdocumentappid()%>" /><%=WeiXinResource.getGovdocumentappname()%></label>
                <input type="text" name="AgentId<%=WeiXinResource.getGovdocumentappid()%>" id="AgentId<%=WeiXinResource.getGovdocumentappid()%>" value="<%=AppId_def%>" onclick="if(this.value=='<%=AppId_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=AppId_def%>';}"/>
              </li>
              <li>
              	<label>Secret：</label>
                <input name="Secret<%=WeiXinResource.getGovdocumentappid()%>" id="Secret<%=WeiXinResource.getGovdocumentappid()%>"  type="text" />
              </li>
            </ul>
            <ul class="clearfix">
              <li>
                <label>
                  <input type="checkbox" name="chekApp" id="chekApp" value="<%=WeiXinResource.getInformationappid()%>" /><%=WeiXinResource.getInformationappname()%></label>
                <input type="text" name="AgentId<%=WeiXinResource.getInformationappid()%>" id="AgentId<%=WeiXinResource.getInformationappid()%>" value="<%=AppId_def%>" onclick="if(this.value=='<%=AppId_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=AppId_def%>';}"/>
              </li>
              <li>
              	<label>Secret：</label>
                <input name="Secret<%=WeiXinResource.getInformationappid()%>" id="Secret<%=WeiXinResource.getInformationappid()%>"  type="text" />
              </li>
            </ul>
            <ul class="clearfix">
              <li>
                <label>
                  <input type="checkbox" name="chekApp" id="chekApp" value="<%=WeiXinResource.getForumappid()%>" /><%=WeiXinResource.getForumappname()%></label>
                <input type="text" name="AgentId<%=WeiXinResource.getForumappid()%>" id="AgentId<%=WeiXinResource.getForumappid()%>" value="<%=AppId_def%>" onclick="if(this.value=='<%=AppId_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=AppId_def%>';}"/>
              </li>
              <li>
              	<label>Secret：</label>
                <input name="Secret<%=WeiXinResource.getForumappid()%>" id="Secret<%=WeiXinResource.getForumappid()%>"  type="text" />
              </li>
            </ul>
            
            <ul class="clearfix">
              <li>
                <label>
                  <input type="checkbox" name="chekApp" id="chekApp" value="<%=WeiXinResource.getMeetappid()%>" /><%=WeiXinResource.getMeetappname()%></label>
                <input type="text" name="AgentId<%=WeiXinResource.getMeetappid()%>" id="AgentId<%=WeiXinResource.getMeetappid()%>" value="<%=AppId_def%>" onclick="if(this.value=='<%=AppId_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=AppId_def%>';}"/>
              </li>
              <li>
              	<label>Secret：</label>
                <input name="Secret<%=WeiXinResource.getMeetappid()%>" id="Secret<%=WeiXinResource.getMeetappid()%>"  type="text" />
              </li>
            </ul>
            <ul class="clearfix">
              <li>
                <label>
                  <input type="checkbox" name="chekApp" id="chekApp" value="<%=WeiXinResource.getWeixinkqappid()%>" /><%=WeiXinResource.getWeixinkqappname()%></label>
                <input type="text" name="AgentId<%=WeiXinResource.getWeixinkqappid()%>" id="AgentId<%=WeiXinResource.getWeixinkqappid()%>" value="<%=AppId_def%>" onclick="if(this.value=='<%=AppId_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=AppId_def%>';}"/>
              </li>
              <li>
              	<label>Secret：</label>
                <input name="Secret<%=WeiXinResource.getWeixinkqappid()%>" id="Secret<%=WeiXinResource.getWeixinkqappid()%>" type="text" />
              </li>
            </ul>
            <ul class="clearfix">
              <li>
                <label>
                  <input type="checkbox" name="chekApp" id="chekApp" value="<%=WeiXinResource.getWorkdailyappid()%>" /><%=WeiXinResource.getWorkdailyappname()%></label>
                <input type="text" name="AgentId<%=WeiXinResource.getWorkdailyappid()%>" id="AgentId<%=WeiXinResource.getWorkdailyappid()%>" value="<%=AppId_def%>" onclick="if(this.value=='<%=AppId_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=AppId_def%>';}"/>
              </li>
			  <li>
              	<label>Secret：</label>
                <input name="Secret<%=WeiXinResource.getWorkdailyappid()%>" id="Secret<%=WeiXinResource.getWorkdailyappid()%>"  type="text" />
              </li>
            </ul>
            <ul class="clearfix">
			  <li>
                <label>
                  <input type="checkbox" name="chekApp" id="chekApp" value="<%=WeiXinResource.getQuestionnaireappid()%>" /><%=WeiXinResource.getQuestionnaireappname()%></label>
                <input type="text" name="AgentId<%=WeiXinResource.getQuestionnaireappid()%>" id="AgentId<%=WeiXinResource.getQuestionnaireappid()%>" value="<%=AppId_def%>" onclick="if(this.value=='<%=AppId_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=AppId_def%>';}"/>
              </li>
              <li>
              	<label>Secret：</label>
                <input name="Secret<%=WeiXinResource.getQuestionnaireappid()%>" id="Secret<%=WeiXinResource.getQuestionnaireappid()%>" type="text" />
              </li>
            </ul>
			<ul class="clearfix" >
              <li>
                <label>
                  <input type="checkbox" name="chekApp" id="chekApp" value="<%=WeiXinResource.getMailappid()%>" /><%=WeiXinResource.getMailappname()%></label>
                <input type="text" name="AgentId<%=WeiXinResource.getMailappid()%>" id="AgentId<%=WeiXinResource.getMailappid()%>" value="<%=AppId_def%>" onclick="if(this.value=='<%=AppId_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=AppId_def%>';}"/>
              </li>
              <li>
              	<label>Secret：</label>
                <input name="Secret<%=WeiXinResource.getMailappid()%>" id="Secret<%=WeiXinResource.getMailappid()%>" type="text" />
              </li>
            </ul>
          </div>

		  <%
		   List custmenulist = weixBd.getOACustmenu();
		  if(custmenulist!=null&&custmenulist.size()>1){
			 //int n=custmenulist.size()-1;
			 //n = n%2;
			 for(int i=1;i<custmenulist.size();i++){
				   Map menumap1 = (Map) custmenulist.get(i);
                   String name1 = menumap1.get("name")+"";
				   String menuId1 = menumap1.get("custmenuId")+"";

				%>
					<ul class="clearfix">
					  <li>
						<label>
						  <input type="checkbox" name="chekApp" id="chekApp" value="<%=menuId1%>" /><%=name1%></label>
						<input type="text" name="AgentId<%=menuId1%>" id="AgentId<%=menuId1%>" value="<%=AppId_def%>" onclick="if(this.value=='<%=AppId_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=AppId_def%>';}"/>
					  </li>
					  <li>
		              	<label>Secret：</label>
		                <input name="Secret<%=menuId1%>" id="Secret<%=menuId1%>" type="text" />
		              </li>
					</ul>
				<%
			 }

			 if(custmenulist.size()==1){
			    Map menumap = (Map) custmenulist.get(custmenulist.size()-1);
			%>

                 <ul class="clearfix">
				  <li>
					<label>
					  <input type="checkbox" name="chekApp" id="chekApp" value="<%=menumap.get("custmenuId")%>" /><%=menumap.get("name")%></label>
					<input type="text" name="AgentId<%=menumap.get("custmenuId")%>" id="AgentId<%=menumap.get("custmenuId")%>" value="<%=AppId_def%>" onclick="if(this.value=='<%=AppId_def%>'){this.value='';}" onblur="if(this.value==''){this.value='<%=AppId_def%>';}"/>
				  </li>
				   <li>
	              	<label>Secret：</label>
	                <input name="Secret<%=menumap.get("custmenuId")%>" id="Secret<%=menumap.get("custmenuId")%>"  type="text" />
	              </li>
				</ul>

			 <%
			 }
		   }

	      %>
          <input name="menuJson" id="menuJson" type="hidden">
        </div>
        <div class="footer-btn">
		  <a href="javascript:void(0)" class="mobile-btn-line-circle" onclick="saveWeixinMenu();">同步应用</a>
        </div>
		</form>
      </div>
    </div>
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
		 //流程
	     WeixinMenuPO workflowmenupo = weixBd.loadWeixinMenuPO(WeiXinResource.getWorkflowappid());
		 if(workflowmenupo!=null){
	  %>
         $("input[type=checkbox][name=chekApp][value=<%=WeiXinResource.getWorkflowappid()%>]").attr("checked",'checked');
	     $('#AgentId<%=WeiXinResource.getWorkflowappid()%>').val('<%=workflowmenupo.getCorpId()%>');
	     $('#Secret<%=WeiXinResource.getWorkflowappid()%>').val('<%=workflowmenupo.getCorpsecret()%>');
	  <%
		 }
	     //公文
	     WeixinMenuPO govdocumentmenupo = weixBd.loadWeixinMenuPO(WeiXinResource.getGovdocumentappid());
		 if(govdocumentmenupo!=null){
	  %>
         $("input[type=checkbox][name=chekApp][value=<%=WeiXinResource.getGovdocumentappid()%>]").attr("checked",'checked');
	     $('#AgentId<%=WeiXinResource.getGovdocumentappid()%>').val('<%=govdocumentmenupo.getCorpId()%>');
	     $('#Secret<%=WeiXinResource.getGovdocumentappid()%>').val('<%=govdocumentmenupo.getCorpsecret()%>');
	  <%
		 }
	     //信息
	     WeixinMenuPO Infomenupo = weixBd.loadWeixinMenuPO(WeiXinResource.getInformationappid());
		 if(Infomenupo!=null){
	  %>
         $("input[type=checkbox][name=chekApp][value=<%=WeiXinResource.getInformationappid()%>]").attr("checked",'checked');
	     $('#AgentId<%=WeiXinResource.getInformationappid()%>').val('<%=Infomenupo.getCorpId()%>');
	     $('#Secret<%=WeiXinResource.getInformationappid()%>').val('<%=Infomenupo.getCorpsecret()%>');
	  <%
		 }
	     //论坛
	     WeixinMenuPO Forummenupo = weixBd.loadWeixinMenuPO(WeiXinResource.getForumappid());
		 if(Forummenupo!=null){
	  %>
         $("input[type=checkbox][name=chekApp][value=<%=WeiXinResource.getForumappid()%>]").attr("checked",'checked');
	     $('#AgentId<%=WeiXinResource.getForumappid()%>').val('<%=Forummenupo.getCorpId()%>');
	     $('#Secret<%=WeiXinResource.getForumappid()%>').val('<%=Forummenupo.getCorpsecret()%>');
	  <%
		 }
	     //会议助手
	     WeixinMenuPO Meetmenupo = weixBd.loadWeixinMenuPO(WeiXinResource.getMeetappid());
		 if(Meetmenupo!=null){
	  %>
         $("input[type=checkbox][name=chekApp][value=<%=WeiXinResource.getMeetappid()%>]").attr("checked",'checked');
	     $('#AgentId<%=WeiXinResource.getMeetappid()%>').val('<%=Meetmenupo.getCorpId()%>');
	     $('#Secret<%=WeiXinResource.getMeetappid()%>').val('<%=Meetmenupo.getCorpsecret()%>');
	  <%
		 }
	     //考勤
	     WeixinMenuPO Weixinkqpo = weixBd.loadWeixinMenuPO(WeiXinResource.getWeixinkqappid());
		 if(Weixinkqpo!=null){
	  %>
         $("input[type=checkbox][name=chekApp][value=<%=WeiXinResource.getWeixinkqappid()%>]").attr("checked",'checked');
	     $('#AgentId<%=WeiXinResource.getWeixinkqappid()%>').val('<%=Weixinkqpo.getCorpId()%>');
	     $('#Secret<%=WeiXinResource.getWeixinkqappid()%>').val('<%=Weixinkqpo.getCorpsecret()%>');
	  <%
		 }
	     //日志
	     WeixinMenuPO Workdailypo = weixBd.loadWeixinMenuPO(WeiXinResource.getWorkdailyappid());
		 if(Workdailypo!=null){
	  %>
         $("input[type=checkbox][name=chekApp][value=<%=WeiXinResource.getWorkdailyappid()%>]").attr("checked",'checked');
	     $('#AgentId<%=WeiXinResource.getWorkdailyappid()%>').val('<%=Workdailypo.getCorpId()%>');
	     $('#Secret<%=WeiXinResource.getWorkdailyappid()%>').val('<%=Workdailypo.getCorpsecret()%>');
	  <%
		 }
	     //问卷调查
	     WeixinMenuPO Questionpo = weixBd.loadWeixinMenuPO(WeiXinResource.getQuestionnaireappid());
		 if(Questionpo!=null){
	  %>
         $("input[type=checkbox][name=chekApp][value=<%=WeiXinResource.getQuestionnaireappid()%>]").attr("checked",'checked');
	     $('#AgentId<%=WeiXinResource.getQuestionnaireappid()%>').val('<%=Questionpo.getCorpId()%>');
	      $('#Secret<%=WeiXinResource.getQuestionnaireappid()%>').val('<%=Questionpo.getCorpsecret()%>');
	  <%
		 }
	     //邮件
	     WeixinMenuPO mailpo = weixBd.loadWeixinMenuPO(WeiXinResource.getMailappid());
		 if(mailpo!=null){
	  %>
         $("input[type=checkbox][name=chekApp][value=<%=WeiXinResource.getMailappid()%>]").attr("checked",'checked');
	     $('#AgentId<%=WeiXinResource.getMailappid()%>').val('<%=mailpo.getCorpId()%>');
	     $('#Secret<%=WeiXinResource.getMailappid()%>').val('<%=mailpo.getCorpsecret()%>');
	  <%
		 }
	  %>
      
	  <%//自定义模块
		  if(custmenulist!=null&&custmenulist.size()>0){
			 for(int i=0;i<custmenulist.size();i++){
				   Map menumap = (Map) custmenulist.get(i);
				   WeixinMenuPO custpo = weixBd.loadWeixinMenuPO(menumap.get("custmenuId")+"");
				   if(custpo!=null){
	  %>

		  $("input[type=checkbox][name=chekApp][value=<%=menumap.get("custmenuId")%>]").attr("checked",'checked');
	      $('#AgentId<%=menumap.get("custmenuId")%>').val('<%=custpo.getCorpId()%>');
		  $('#Secret<%=menumap.get("custmenuId")%>').val('<%=custpo.getCorpsecret()%>');
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

  function selectRelationId(){
       
	   var relaId = $('input[name="relationId"]:checked').val();
	   if(relaId==null||relaId==""){
	      whir_alert1("提示信息","请选择关联ID","确定");
		  return;
	   }
	   $.ajax({
			 url : "/defaultroot/weixinplatform/saveWeixinRelationId.controller",    
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

  function saveWeixinBase(){

	  whir_alert2("确认信息","确定要同步参数吗？","取消","确认",
		  
	      function(){return;},
		  
	      function(){

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
			   /**
			   var Token = $('#Token').val();
			   if(Token==''||Token=='<%=Token_def%>'){
				   whir_alert1("提示信息","请输入Token！","确定");
				   return;
			   }
			   var EncodingAESKey = $('#EncodingAESKey').val();
			   if(EncodingAESKey==''||EncodingAESKey=='<%=EncodingAESKey_def%>'){
				   whir_alert1("提示信息","请输入EncodingAESKey！","确定");
				   return;
			   }
			   **/
			   $.ajax({
					 url : "/defaultroot/weixinplatform/saveWeixinBase.controller",    
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

      });
       
	   

  }

  $(".ding-title span").on("click", function() {
    $(this).addClass("t-checked").siblings().removeClass("t-checked");
  })

  $(".ding-title span").eq(1).on("click", function() {

	whir_alert1("提示信息","请查看【企业号后台】-【通讯录】-【用户列表】-【账号字段】，保持与关联ID中的字段一致后，勾选。如账号字段与关联ID均无法匹配请联系管理员。","知道了");
  })


  function saveWeixinMenu(){

        whir_alert2("确认信息","确定要同步应用吗？","取消","确定",
		    function(){return;},
			function(){

                    var obj=document.getElementsByName('chekApp');
					var jsonMenu = "{";
					for(var i=0; i<obj.length; i++){
					   if(obj[i].checked){
						   var thisValue = document.getElementById('AgentId'+obj[i].value).value;
						   var thisText = obj[i].nextSibling.nodeValue;
						   var thisSecret = document.getElementById('Secret'+obj[i].value).value;
						   jsonMenu += "\""+obj[i].value+"\":\""+thisValue+","+thisText+","+thisSecret+"\",";
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

				   $.ajax({
						 url : "/defaultroot/weixinplatform/saveWeixinNemu.controller",    
						 type : "POST",    
						 dataType:"json",
						 data : $( '#syncMenuForm').serialize(),    
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
			 url : "/defaultroot/weixinplatform/syncOrgUser.controller",    
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

	 var openUrl = "<%=realpath%>/weixinplatform/weixinSynfaillog.controller";
	 window.open(openUrl, "newwindow","height="+iHeight+", width="+iWidth+", top="+iTop+", left="+iLeft+',resizable=yes,scrollbars=yes'); 

  }
  
  </script>
</body>

</html>
