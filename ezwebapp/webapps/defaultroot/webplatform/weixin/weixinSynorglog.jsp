<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <%@ include file="/webplatform/include/headerInit.jsp"%>

</head>

<body>
  
    <!-- 手动同步弹出层 -->

  <div id="info-hand" class="info-app" >
    
      <div class="hand-dd-tabs" style="margin-top:0px;">
        <ul>
          <li id="usersynlog" onclick="userSynLog();"> <i class="fa fa-tips"></i>用户同步日志</li>
          <li id="orgsynlog" onclick="orgSynLog();" class="active"><i class="fa fa-tips"></i>组织同步日志</li>
        </ul>
      </div>
	
      <div class="check-treetable">
        <div class="datetimepick">
		  <form name="submitForm" id="submitForm" action="" method="post">
          <div class="has-feedback">
            <label class="control-label" for=" ">&nbsp;时间：</label>
            <input id="data-bsday" name="dateBegin" type="text" class="form-control"> <i class="fa fa-calendar form-control-feedback"></i>
          </div>
          <div class="has-feedback">
            <label class="control-label" for=" ">至</label>
            <input id="data-bsday2" name="dateEnd" type="text" class="form-control"> <i class="fa fa-calendar form-control-feedback"></i>
          </div>
          <div class="has-feedback1">
            <input type="button" name="selectUserLog" onclick="getUserLog()" value="立即查找">      
            <input type="button" name="clear" onclick="clearform()" value="清除">
		  </div>
		  </form>
		 </div>
        <div class="putout-info">
          <input type="button" name="export" id="export" onclick="exportData()" value="导出">
        </div>
        <table>
          <thead>
            <td style="width:4%"><input type="checkbox" name="items" onclick="setCheckBoxState(this.checked);"></td>
            <td style="width:24%">时间</td>
            <td style="width:12%">组织</td>
           
            <td style="width:8%">事件</td>
            <td style="width:24%">结果</td>
          </thead>
          
		  <tbody id="dingUserDataList">
            
          </tbody>
        </table>
          <!-- pagenition -->
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="Pagebar">
			  <tbody>
				<tr>
				  <td>
					<div class="page" style="display: none;">
					  <div id="pager_desc">第&nbsp;
						<font color="red">
							<span id="curpage"></span>
						</font>/<span id="pageCount"></span>&nbsp;页&nbsp;&nbsp;&nbsp;共&nbsp;
						<span id="recordCount"></span>&nbsp;条记录&nbsp;
					   </div>
					  <div id="pagerSize">
						<select name="pageSize" id="page_size" onchange="pageClick(1);" class="pageSize">
						  <option value="15">15</option>
						  <option value="30">30</option>
						  <option value="45">45</option>
						  <option value="60">60</option>
						</select>
					  </div>
					  <div id="pager">
					  	<a id="first" class="jp-previous jp-disabled" onclick="goPage('-1');">前页</a>
					  	<span id="did"></span>
					  	<a id="next" class="jp-next" onclick="goPage('1');">后页</a>
					  </div>
					  <div id="pagebtn">
						<input id="go_start_pager" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
						<input type="button" onclick="go();" value=" Go ">
					  </div>
					</div>
				  </td>
				</tr>
			  </tbody>
			</table>
      </div>
      
  </div>
  <script type="text/javascript" src="<%=realpath%>/webplatform/scripts/plugins/jquery/jquery.min.js"></script>
  <script type="text/javascript" src="<%=realpath%>/webplatform/scripts/plugins/laydate/laydate.js"></script>
  <script type="text/javascript">

	var startPage = 1;
	var pageCount1 = 1;

	$(document).ready(function(){
		//每页的显示数。根据下拉选择框而定。
		var pageSize = $("#page_size option:selected").val();
		var url = "<%=realpath%>/weixinplatform/loadWeiXinSynuserlogData.controller?pageSize="+pageSize+"&userorgflag=1";
		loadViewDataList(url);
		
	});
	
	//加载主页信息列表
	function loadViewDataList(url){
		$.ajax({
			url : url,
			type : 'POST',
			dataType : 'json',
			data : $( '#submitForm').serialize(),
			success : function(data){
				var pageSize = data.pageSize;
				var currentPage = data.currentPage;
				var pageCount = data.pageCount;
				var recordCount = data.recordCount;
				var custDataList = data.custDataList;
				
				startPage = currentPage;
                pageCount1 = pageCount;
				var h1 = "";
				if(custDataList.length>0){
					$(".page").css("display","block");

					$('#curpage').html(currentPage);
					$('#pageCount').html(pageCount);
					$('#recordCount').html(recordCount);

					//拼接单独显示页数
					var pg = "";
					if(pageCount > 5){
						for(var i = 1;i <= 5;i++){
							if(currentPage == i){
				 				pg += "<a href='javascript:void(0);' onclick='pageClick("+i+");' class='jp-current'>"+i+"</a>";
				 			}else{
				 				pg += "<a href='javascript:void(0);' onclick='pageClick("+i+");' class=''>"+i+"</a>";
				 			}
						}
						pg += "  ...  ";
						if(currentPage == pageCount){
							pg += "<a href='javascript:void(0);' onclick='pageClick("+ pageCount +");' class='jp-current'>"+pageCount+"</a>";
						}else{
							pg += "<a href='javascript:void(0);' onclick='pageClick("+ pageCount +");' class=''>"+pageCount+"</a>";
						}
						$('#did').html(pg);
					}else{
						for(var i = 1;i <= pageCount;i++){
							if(currentPage == i){
				 				pg += "<a href='javascript:void(0);' onclick='pageClick("+i+");' class='jp-current'>"+i+"</a>";
				 			}else{
				 				pg += "<a href='javascript:void(0);' onclick='pageClick("+i+");' class=''>"+i+"</a>";
				 			}
						}
						$('#did').html(pg);
					}
				
					//控制 前页 的class属性
					if(currentPage > 1){
						$('#first').removeClass("jp-previous jp-disabled");
						$('#first').addClass("jp-previous");
					}else{
						$('#first').removeClass("jp-previous");
						$('#first').addClass("jp-previous jp-disabled");
					}
					//控制 后页 的class属性
					if(currentPage >= pageCount){
						$('#next').removeClass("jp-next");
						$('#next').addClass("jp-next jp-disabled");
					}else{
						$('#next').removeClass("jp-next jp-disabled");
						$('#next').addClass("jp-next");
					}

					for(var i=0;i<custDataList.length;i++){
						var custdata = custDataList[i];
						var id = custdata[0];
                        
						var createDate = custdata[1];
						
						var orgName = custdata[2];
						if(orgName == 'null' || orgName == null){
							orgName = '';
						}
						var userName = custdata[3];
						var phoneNum = custdata[4];
						var event = custdata[5];
						var result = custdata[6];
						
					    h1 += "<tr>";
						h1 += "<td><input class='checkbox-dx' type='checkbox' name='chm'></td>";
						h1 += "<td>" + createDate + "</td>";
						h1 += "<td>" + orgName + "</td>";
						//h1 += "<td>" + userName + "</td>";
						//h1 += "<td>" + phoneNum + "</td>";
						h1 += "<td>" + event + "</td>";
						h1 += "<td>" + result.errmsg + "</td>";
						h1 += "<tr>";
					}
				}else{
					//alert(222222);
					h1 += "<tr><td colspan='4'>未查询到相关数据！</td></tr>";
					$(".page").css("display","none");
				}
                $('#dingUserDataList').html(h1);
			},
			error : function(data) {
				whir_alert1("提示信息","数据获取失败!","确定");
			}
		});
	}


	//翻页操作
	function goPage(p){
		var page = eval(p)+eval(startPage);
		if(page == 0 || page > pageCount1){
			return;
		}
		//每页的显示数。根据下拉选择框而定。
		var pageSize = $("#page_size option:selected").val();
		var url = "<%=realpath%>/weixinplatform/loadWeiXinSynuserlogData.controller?startPage="+page+"&pageSize="+pageSize+"&userorgflag=1";
		loadViewDataList(url);
	}


	//下拉框控制的页面数据显示和单独拼接的页数控制
	function pageClick(curpage){
		//默认当前页为1
		//每页的显示数。根据下拉选择框而定。
		var pageSize = $("#page_size option:selected").val();
		var url ="<%=realpath%>/weixinplatform/loadWeiXinSynuserlogData.controller?pageSize="+pageSize+"&startPage="+curpage+"&userorgflag=1";
		loadViewDataList(url);
	}

	//点击go触发
	function go(){
  		//获取文本框中的当前页
  		var page = $('#go_start_pager').val();
		//获取总页数
		var pageCount = $('#pageCount').html();
  		if(eval(page) >= eval(pageCount)){
			page = pageCount;
		}
  		//每页的显示数。根据下拉选择框而定。
		var pageSize = $("#page_size option:selected").val();
		var url = "<%=realpath%>/weixinplatform/loadWeiXinSynuserlogData.controller?startPage="+page+"&pageSize="+pageSize+"&userorgflag=1";
		loadViewDataList(url);
		if(eval(page) >= eval(pageCount)){
			$('#go_start_pager').val(pageCount);
		}
	}

	//点击进入同步用户页面
	function userSynLog(){
		//$('#usersynlog').addClass('active');
		//S('#orgsynlog').removeClass();
		window.location.href = "/defaultroot/webplatform/weixin/weixinSynuserlog.jsp";
	}
	//点击进入同步组织页面
	function orgSynLog(){
		//$('#usersynlog').removeClass();
		//S('#orgsynlog').addClass('active');
		window.location.href = "/defaultroot/webplatform/weixin/weixinSynorglog.jsp";
	}


	//立即查找
	function getUserLog(){
		//var d = $('#data-bsday').val();
		var pageSize = $("#page_size option:selected").val();
		var url = "<%=realpath%>/weixinplatform/loadWeiXinSynuserlogData.controller?pageSize="+pageSize+"&userorgflag=1";
		$.ajax({
			url : url,
		 	type : "POST",    
		 	dataType:"json",
		 	data : $( '#submitForm').serialize(),    
		 	success : function(data) {
				var pageSize = data.pageSize;
				var currentPage = data.currentPage;
				var pageCount = data.pageCount;
				var recordCount = data.recordCount;
				var custDataList = data.custDataList;
				
				startPage = currentPage;
                pageCount1 = pageCount;
				var h1 = "";
				if(custDataList.length>0){
					//alert(1111111111);
					$('#curpage').html(currentPage);
					$('#pageCount').html(pageCount);
					$('#recordCount').html(recordCount);

					//拼接单独显示页数
					var pg = "";
					if(pageCount > 5){
						for(var i = 1;i <= 5;i++){
							if(currentPage == i){
				 				pg += "<a href='javascript:void(0);' onclick='pageClick("+i+");' class='jp-current'>"+i+"</a>";
				 			}else{
				 				pg += "<a href='javascript:void(0);' onclick='pageClick("+i+");' class=''>"+i+"</a>";
				 			}
						}
						pg += "  ...  ";
						if(currentPage == pageCount){
							pg += "<a href='javascript:void(0);' onclick='pageClick("+ pageCount +");' class='jp-current'>"+pageCount+"</a>";
						}else{
							pg += "<a href='javascript:void(0);' onclick='pageClick("+ pageCount +");' class=''>"+pageCount+"</a>";
						}
						$('#did').html(pg);
					}else{
						for(var i = 1;i <= pageCount;i++){
							if(currentPage == i){
				 				pg += "<a href='javascript:void(0);' onclick='pageClick("+i+");' class='jp-current'>"+i+"</a>";
				 			}else{
				 				pg += "<a href='javascript:void(0);' onclick='pageClick("+i+");' class=''>"+i+"</a>";
				 			}
						}
						$('#did').html(pg);
					}
				
					//控制 前页 的class属性
					if(currentPage > 1){
						$('#first').removeClass("jp-previous jp-disabled");
						$('#first').addClass("jp-previous");
					}else{
						$('#first').removeClass("jp-previous");
						$('#first').addClass("jp-previous jp-disabled");
					}
					//控制 后页 的class属性
					if(currentPage >= pageCount){
						$('#next').removeClass("jp-next");
						$('#next').addClass("jp-next jp-disabled");
					}else{
						$('#next').removeClass("jp-next jp-disabled");
						$('#next').addClass("jp-next");
					}

					for(var i=0;i<custDataList.length;i++){
						var custdata = custDataList[i];
						var id = custdata[0];
                        
						var createDate = custdata[1];
						var orgName = custdata[2];
						var userName = custdata[3];
						var phoneNum = custdata[4];
						var event = custdata[5];
						var result = custdata[6];
					    h1 += "<tr>";
						h1 += "<td><input class='checkbox-dx' type='checkbox' name='chm' value='1'></td>";
						h1 += "<td>" + createDate + "</td>";
						h1 += "<td>" + orgName + "</td>";
						//h1 += "<td>" + userName + "</td>";
						//h1 += "<td>" + phoneNum + "</td>";
						h1 += "<td>" + event + "</td>";
						h1 += "<td>" + result + "</td>";
						h1 += "<tr>";
					}
				}else{
					//alert(222222);
					h1 += "<tr><td colspan='7'>未查询到相关数据！</td></tr>";
					$(".page").css("display","none");
				}
                $('#dingUserDataList').html(h1);
			},
			error : function(data) {
				whir_alert1("提示信息","数据获取失败!","确定");
			}
		});
	}
	
	
	//清除
	function clearform(){
		$('#data-bsday').val('');
		$('#data-bsday2').val('');
		$('#go_start_pager').val('');

		//每页的显示数。根据下拉选择框而定。
		var pageSize = $("#page_size option:selected").val();
		var url = "<%=realpath%>/weixinplatform/loadWeiXinSynuserlogData.controller?pageSize="+pageSize+"&userorgflag=1";
		loadViewDataList(url);
	}


	//全选，取消全选
	function setCheckBoxState(flag){
		//alert(flag);
		if(flag){
			//alert(111111);
			$("[name='chm']").prop("checked",true);
			//$("[name='chm']:checkbox").each(function(){
				//$(this).prop("checked",true);
			//});
		}else{
			//alert(222222);
			$("[name='chm']").prop("checked",false);
			//$("[name='chm']:checkbox").each(function(){
				//$(this).prop("checked",false);
			//});
		}
	}


	function exportData(){
		var db = $('#data-bsday').val();
		var de = $('#data-bsday2').val();
		var url = "<%=realpath%>/weixinplatform/exportData.controller?dateBegin="+db+"&dateEnd="+de+"&userorgflag=1";
		window.location = url;
	}
	

		var start = {
			elem: '#data-bsday',
			format: 'YYYY-MM-DD hh:mm:ss',
			//min: laydate.now(), //设定最小日期为当前日期
			min: '2010-12-21 12:21:21',
			max: '2099-06-16 23:59:59', //最大日期
			istime: true,
			istoday: false,
			choose: function(datas){
				end.min = datas; //开始日选好后，重置结束日的最小日期
				end.start = datas //将结束日的初始值设定为开始日
			}
		};

		var end = {
			elem: '#data-bsday2',
			format: 'YYYY-MM-DD hh:mm:ss',
			//min: laydate.now(),
			min: '2010-12-21 12:21:21',
			max: '2099-06-16 23:59:59',
			istime: true,
			istoday: false,
			choose: function(datas){
				start.max = datas; //结束日选好后，重置开始日的最大日期
			}
		};

		laydate(start);
		laydate(end);
	
  </script>
</body>

</html>
