<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/clientview/common/taglibs.jsp"%>
<% 
	String ip = com.whir.util.IPUtil.getIpAddr(request);
%>
<!DOCTYPE html>
<html>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>签到</title>
  <%@ include file="../common/headerInit.jsp" %>
</head>

<body class="">
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page" data-page="page-webapp-signin">
          <!-- 签到 -->
          <section class="section-signin wh-section wh-section-bottomfixed show">
          <c:if test="${not empty docXml}">
          	<x:parse xml="${docXml}" var="doc" />
          	<c:set var="recordCount"><x:out select="$doc//recordCount/text()" /></c:set>
            <div class="webapp-sigin">
              <header class="wh-clock-header">
                <div class="wh-clock-info">
                  <c:choose>
                  	<c:when test="${recordCount != 0 }">
                  		<p><span id="toDay"></span>&nbsp;&nbsp;您本日已签到<span>${recordCount }</span>次</p>
                  	</c:when>
                  	<c:otherwise>
                  		<p><span id="toDay"></span>&nbsp;&nbsp;您本日尚未签到！</p>
                  	</c:otherwise>
                  </c:choose>
                  
                </div>
              </header>
              <%
				String AppType = new com.whir.aop.WebAppAuth().getAppType(request);
				%>
              <c:set var="AppType"><%=AppType %></c:set>
              <div class="location">
                <ul>
                  <x:forEach select="$doc//list/detailList" var="n" varStatus="status">
	          		<c:set var="presentTime"><x:out select="$n//presentTime/text()" /></c:set>
					<c:set var="address"><x:out select="$n//address/text()" /></c:set>
                  <li>
                    <a href="">
                      <i class="fa fa-check-circle"></i><span class="time">${presentTime }</span><span>${address }</span>
                    </a>
                  </li>
                  </x:forEach>
                </ul>
              </div>
              <form id="sendForm" method="post" action="/defaultroot/worklog/saveWorkLog.controller" onsubmit="return false">
              <ul class="edit-upload clearfix">
                <li class="edit-upload-in" onclick="addImg();"><span class=""><i class="fa fa-plus"></i></span></li>
              </ul>
              <article class="signin-remark">
                <div contenteditable="true"><input class="input-alone" type="text" placeholder="签到备注" name="remark" id="remark"></div>
              </article>
              <div class="singin-qd">
                <a href="javascript:checkInfo();" class="btn">
                  <span>签到</span>
                  <span id="currentDate"></span>
                  <img src="<%=rootPath%>/clientview/images/refresh.png">
                </a>
                <p id="addressId">获取当前位置中...</p>
                <p class="sign-again" onclick="resetLocation();">重新定位</p>
                <input type="hidden" name="longitude"  id="longitude" />
				<input type="hidden" name="latitude"  id="latitude" />
				<input type="hidden" name="presentAddress" id="presentAddress"  />
				<input type="hidden" name="moveKq" id="moveKq" value="1"/>
				<input type="hidden" name="ipstr" id="ipstr" />
				<input type="hidden" name="attendancesource" id="attendancesource" />
              </div>
              </form>
            </div>
            </c:if>
          </section>
          <!-- 签到记录 -->
          <section class="section-signin wh-section wh-section-bottomfixed show">
            <div class="webapp-sigin">
              <header class="wh-clock-header">
                <div class="wh-clock-info">
                  <p id="nowhtml"  class="center"><span>2017年2月</span></p>
                </div>
              </header>
              <div class="week" >
                <div class="tab-week clearfix">
                  <a href="##" id="last-week" class="fl week-a">上一周</a>
                  <a href="##" id="next-week" class="fl week-b">下一周</a>
                  <a href="javascript:attDetail();" class="fr">考勤明细</a>
                  <input type="hidden" name="beginDate" id="beginDate" />
                  <input type="hidden" name="endDate" id="endDate" />
                </div>
                <div class="week-look">
                  <table id="monitor">
                    <tr>
                      <td>
                      </td>
                      <td>
                      </td>
                      <td>
                      </td>
                      <td>
                      </td>
                      <td>
                      </td>
                      <td>
                      </td>
                      <td>
                      </td>
                    </tr>
                  </table>
                </div>
              </div>
              <div class="month">
                <div class="head clearfix">
                  <p id="htmlTile" class="month-look"><span>2017年2月</span></p>
                  <div class="take-month" style="overflow:hidden;float:right">
	                   <input class="edit-ipt-r edit-ipt-arrow" id="picker-date" type="text" name="scroller" placeholder="选择日期" />
                                            <span class="document-span">&#xf005;</span>
                  </div>
                </div>
                <div class="month-state">
                  <table id="tjTable">
                    
                  </table>
                </div>
              </div>
            </div>
          </section>
          <!-- 底部导航 -->
          <footer id="footer-hb"  class="wh-footer wh-footer-forum">
            <div class="wh-wrapper">
              <div class="wh-container">
                <div class="footer-signin wh-footer-btn row no-gutter">
                  <a href="##" class="fbtn-matter col-50">
                    <div><i class="fa fa-map-marker"></i></div><span>定位签到</span></a>
                  <a href="javascript:nowWeek();" href="#tab2" class="fbtn-cancle col-50">
                    <div><i class="fa fa-sign-log"></i></div><span>签到统计</span></a>
                </div>
              </div>
            </div>
          </footer>
        </div>
      </div>
    </div>
  </div>
  <%@ include file="../js/jinitdd.jsp" %>
  <script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp&libraries=convertor"></script>
  <script type="text/javascript" src="<%=rootPath%>/clientview/template/js/template.min.js"></script>
  <script type="text/javascript" src="<%=rootPath%>/clientview/template/js/plugin/zepto.js"></script>
  <script type="text/javascript" src="<%=rootPath%>/clientview/js/ajaxfileupload.js"></script>
  <script type="text/javascript" src="/defaultroot/clientview/js/uploadPreview.min.js"></script>
  <script type="text/javascript">
   var myApp = new Framework7({
          fastClicks: false,
    });
  var $$ = Dom7;
	
  //普通仿原生下拉选单，根据需要设置选项文字是否居中
var pickerAuto = myApp.picker({
    input: '#picker-auto',
    cols: [
        {            textAlign: 'center',
            values: ['打电话', '发短信', '发一封邮件', '发送RTX消息']
        }
    ]
})

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
document.write( '<style>#footer-hb{visibility:hidden}@media(min-height:' + ($( window ).height() - 10) + 'px){#footer-hb{visibility:visible}}</style>' );
//日期选择器
var today = new Date();
var pickerDate = myApp.picker({
    input: '#picker-date',
    toolbarTemplate:
        '<div class="toolbar">' +
            '<div class="toolbar-inner">' +
                '<div class="left">' +
                    '<a href="#" class="link reset-picker">重设</a>'+
                '</div>'+
                '<div onclick="getSelDate();" class="right">' +
                    '<a href="#" class="link close-picker">完成</a>' +
                '</div>' +
            '</div>' +
        '</div>',

    //当触发的时候
    onOpen: function(picker, values, displayValues){
    	var dateTime = $('#picker-date').val();
    	var year = today.getFullYear();
    	var month = (today.getMonth())+1;
    	if(dateTime !='1990-1' && dateTime !=''){
    		year = dateTime.split(",")[0]; 
    		month =  dateTime.split(",")[1]; 
    	}
        var todayArr = [year, month, today.getDate(), today.getHours(), (today.getMinutes() < 10 ? '0' + today.getMinutes() : today.getMinutes())];
        picker.setValue(todayArr);
        picker.container.find('.reset-picker').on('click', function (){
            picker.setValue(todayArr);
        })
    },
    onChange: function (picker, values, displayValues) {
        //获取当前月份的总天数
        var daysInMonth = new Date(picker.value[0], picker.value[1]*1, 0).getDate();
        //如果设置月数大于当前月的总天数，设置天数为总天数
        if (values[2] > daysInMonth) {
            picker.cols[2].setValue(daysInMonth);
        }
    },
    //返回给input的格式，“-” 可以换成“年月日”
    formatValue: function (p, values, displayValues) {
        return values[0] + '-' + values[1];
    },
    //返回 value数组
    cols: [
        // 年
        {
            values: (function () {
                var arr = [];
                for (var i = 1990; i <= 2030; i++) { arr.push(i); }
                return arr;
            })(),
        },
        // 月
        {
            values: [1,2,3,4,5,6,7,8,9,10,11,12],
        }
    ]
});

function getSelDate() {
	$('#htmlTile').html((($("#picker-date").val()).replace('-','年'))+'月');
	getKqStatusByMonth($("#picker-date").val()); 
}

/*function setSelDate() {
	var setSDate = new Date();
	var year = setSDate.getFullYear();
    var month = (setSDate.getMonth()+1);
	$('#htmlTile').html(year+'年'+month+'月');
	$("#picker-date").val('')
	getKqStatusByMonth(year+'-'+month); 
}*/
  //底部切换
  $$(".footer-signin>a").click(function() {
    var _this = $$(this);
    var index = _this.index();
    $$(".footer-signin>a").removeClass("fbtn-matter").addClass("fbtn-cancle");
    _this.removeClass("fbtn-cancle").addClass("fbtn-matter");
    $$(".section-signin").hide().eq(index).show();
  });
  var ip = "<%=ip%>";
  var apptype = '${AppType}';	
  var fileIndex=1;
  $(function(){
  	 getIp();
     var date = new Date();
	 var toDay = date.getFullYear()+'年'+(date.getMonth()+1)+'月'+date.getDate()+'日';
	 $('#nowhtml').html(date.getFullYear()+'年'+(date.getMonth()+1)+'月');
	 $('#htmlTile').html(date.getFullYear()+'年'+(date.getMonth()+1)+'月');
     $('#toDay').html(toDay);
     getCurrentDate();
     
    //微信
    if ("micromessenger"==apptype) {
    	//获取当前位置经纬度
      $('#attendancesource').val("1");
  	  wx.ready(function(){
  		getMyLocationByWx();
  	  });
	//飞舸
	}else if("did"==apptype){
		$('#attendancesource').val("2");
		setTimeout('getMyLocationByApp()',6500);
	}else if("dingtalk"==apptype){
		$('#attendancesource').val("3");
		dd.ready(function(){
		    getMyLocationByDD();
		});
	}else{
		getMyLocationByH();
	}
  });
  
  //当前时间动态显示
  function getCurrentDate(){
    var obj = new Date();
    var d = obj.getDate();
    var h = obj.getHours();
    var i = obj.getMinutes();
    var s = obj.getSeconds();
    if(h < 10) h = "0" + h;
    if(i < 10) i = "0" + i;
    var time = h+':'+i;
    $("#currentDate").html(time);
    setTimeout(getCurrentDate,6000);
}

  //图片数标记
    var index = 0;
    var fileNum = 1;
    //添加图片
     function addImg(){
	  	if(fileNum>3){
	  		myApp.alert('最多允许上传3张图片！');
	  		return;
	  	}
	   $(".edit-upload-in").before(       
		   '<li class="edit-upload-ed" id="imgli_'+index+'" style="display:none">'+
		       '<span>'+
		       	   '<img src="" id="imgShow_'+index+'"/>'+
			       '<em>'+
			       	 '<i onclick="removeImg('+index+');" class="fa fa-minus-circle"></i>'+
			       '</em>'+
		       '</span>'+
		       '<input type="file" id="up_img_'+index+'" style="display:none" name="imgFile"/>'+
		       '<input type="hidden" id="img_name_'+index+'" name="imgName"/>'+
		       '<input type="hidden" id="img_save_name_'+index+'" name="imgSaveName" data-filesize="0"/>'+
       	   '</li>');
	   var img_li_id = "imgli_"+index;
	   var up_img_id = "up_img_"+index;
	   new uploadPreview({ UpBtn: up_img_id, DivShow: img_li_id, ImgShow: "imgShow_"+index, callback : function(){callBackFun(up_img_id,img_li_id)} });
	   $("#up_img_"+index).click();
	   index++;
	   fileNum++;
    }
	
	//删除缩略图
    function removeImg(index){
	   $("#imgli_"+index).remove(); 
	   $("#up_img_"+index).remove();
	   $("#img_save_name_"+(index-1)).val('');
	   fileNum--;
    }
	
	    //回调函数上传图片
	function callBackFun(upImgId,imgliId){
		myApp.showPreloader('正在上传...');
		$("#img_name_"+(index-1)).val($("#"+upImgId).val());
		var fileShowName = $("#"+upImgId).val();
		$.ajaxFileUpload({
			url: '/defaultroot/upload/fileUpload.controller?modelName=phonekq', //用于文件上传的服务器端请求地址
			secureuri:false,
			fileElementId: upImgId, //文件上传域的ID
			dataType: 'json', //返回值类型 一般设置为json
			success: function (msg, status){  //服务器成功响应处理函数---获取上传图片保存名
				$("#img_save_name_"+(index-1)).val(msg.data);
				$("#img_save_name_"+(index-1)).data("filesize",msg.fileSize);
				$("#img_name_"+(index-1)).val(fileShowName);
				$("#"+imgliId).show();
				myApp.hidePreloader();
			},
			error: function (data, status, e){//服务器响应失败处理函数
				//alert(2);
				alert("文件上传失败！");
			}
		});
	}
	
	var comflag = 1;
	//签到打卡
	function getclock(){
	   	if(/[@#\$%\^&\*]+/g.test($('#remark').val())){
			myApp.alert('备注内容不能包含特殊字符！');
			return false;
		}
	    var presentAddress = $("#presentAddress").val();
	  	if(presentAddress == ''){
	  		myApp.alert('没有地址信息请重新定位');
	  		return;
	  	}
	  	if(comflag == 0){
	   		return;
	   	}
	   	comflag = 0;
	  	$.ajax({
		    type: "post",
		    url: "/defaultroot/attendance/saveWxLocation.controller",
		    data:$('#sendForm').serialize(),
		    success: function(data) {
		    	var jsonData = eval("("+data+")");
		    	var commentFlag = jsonData.data0;
		    	if(commentFlag=='1'){
						myApp.showPreloader('本日已成功签到！');
						$$(".btn").removeClass("sing-load");
					    setTimeout(function(){
					        myApp.hidePreloader();
					        window.history.back();
					        window.location.reload(); 
						    //$$(".footer-signin>a").removeClass("fbtn-matter").addClass("fbtn-cancle");
							//$$(".footer-signin>a").next().removeClass("fbtn-cancle").addClass("fbtn-matter");
							//$$(".section-signin").hide().eq(1).show();
							//loadMyAttendanceList(1,'0');
					    },2000);
		    	}else{
		    		myApp.alert('保存失败！');
		    	}
		    	comflag = 1;
		    }
		});
		  
	  }
	  
	  //获取位置信息(通过微信)
	 function getMyLocationByWx() {
		wx.getLocation({
			type: 'gcj02', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
			success: function (res) {
				var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
				var longitude = res.longitude ; // 经度，浮点数，范围为180 ~ -180。
				//var speed = res.speed; // 速度，以米/每秒计
				//var accuracy = res.accuracy; // 位置精度
				myLocation(latitude,longitude);
			}
		});
		
	 }
	//获取位置信息(通过客户端)
	 function getMyLocationByApp(){
		 emp.getLocation({
				type: 'wgs84',  // 默认为wgs84
			    success: function(res){
			 		var accuracy = res.accuracy; //为准确度
			 		var latitude = res.latitude; //为纬度
			 		var longitude = res.longitude; //为经度
			 		myLocation(latitude,longitude);
			    }
			});
	 }
	 
	 //获取位置信息(通过钉钉)
	 function getMyLocationByDD() {
		dd.device.geolocation.get({
		    targetAccuracy : 200,
		    coordinate : 1,
		    withReGeocode : true,
		    onSuccess : function(result) {
		    	myLocation(result.latitude,result.longitude);
		        /* 高德坐标 result 结构
		        {
		            longitude : Number,
		            latitude : Number,
		            accuracy : Number,
		            address : String,
		            province : String,
		            city : String,
		            district : String,
		            road : String,
		            netType : String,
		            operatorType : String,
		            errorMessage : String,
		            errorCode : Number,
		            isWifiEnabled : Boolean,
		            isGpsEnabled : Boolean,
		            isFromMock : Boolean,
		            provider : wifi|lbs|gps,
		            accuracy : Number,
		            isMobileEnabled : Boolean
		        }
		        */
		    },
		    onFail : function(err) {
		    	alert(2);
		    }
		});
		
	 }

	//获取位置信息(通过h5)
	 function getMyLocationByH(){
		//判断是否支持 获取本地位置
		  if (navigator.geolocation){
		    	navigator.geolocation.getCurrentPosition(showPosition);
		  }else{
			  x.innerHTML="浏览器不支持定位.";
		  }
	 }
	 
	  function showPosition(position){
			var latitude=position.coords.latitude; 
			var longitude=position.coords.longitude;
			//alert("纬度-->"+latitude+"经度-->"+longitude);
			myLocation(latitude,longitude);
	 }
	 
	 //根据坐标返回当前具体地址
	 function myLocation(latitude,longitude) {
		var geocoder = null;
		geocoder = new qq.maps.Geocoder({
		    complete:function(result){
		    	var list = result.detail.nearPois;
		        $('.wh-load-circlemax').hide();
		        $('.wh-load-circlemin').hide();
		        $('.fa-check-circle').show();
		        $('#latitude').val(latitude);
		        $('#longitude').val(longitude);
		        //var myAddress = result.detail.address.replace("中国", "");
		        var myAddress =list[3].address;
		        $('#presentAddress').val(myAddress);
		        $('#addressId').html('当前位置：'+myAddress);
		    }
		});
		var coord=new qq.maps.LatLng(latitude,longitude);
		geocoder.getAddress(coord);
 	}
 	
 	//重新定位
	function resetLocation() {
		$('#addressId').html('获取当前位置中...');
		//微信
	    if ("micromessenger"==apptype) {
			getMyLocationByWx();
		//飞舸
		}else if("did"==apptype){
			getMyLocationByApp();
		//H5
		}else if("dingtalk"==apptype){
			getMyLocationByDD();
		}else{
			getMyLocationByH();
		}
	}
	
	function checkInfo() {
		$.ajax({
		    type: "post",
		    url: "/defaultroot/attendance/isKqUser.controller",
		    data:$('#sendForm').serialize(),
		    success: function(data) {
		    	var jsonData = eval("("+data+")");
		    	var dataList = jsonData.data;
		    	if(dataList.hasData == '0'){
		    		myApp.alert('当前无权限，请联系管理员！');
		    		return false;
		    	}else{
		    		checkInfoCl();
		    	}	
		    }
		});
	}
	
	//校验签到信息
	function checkInfoCl(){
		getIp();
		$$(".btn").addClass("sing-load");
		$.ajax({
		    type: "post",
		    url: "/defaultroot/attendance/checkInfo.controller",
		    success: function(data) {
		    	if(data == '' || data =='null'){
		    		myApp.alert('您当前不在考勤策略中，请联系单位考勤管理员设置后再打卡！');
		    		return false;
		    	}
		    	var jsonData = eval("("+data+")");
				var dataList = jsonData.data;
				if(dataList.hasData==0){
					myApp.alert('您当前不在考勤策略中，请联系单位考勤管理员设置后再打卡！');
		    		return false;
				}
				var ruleType = dataList.detail.ruleType;
				
				if(ruleType == '2'){
					var ruleIpStr = dataList.detail.ruleIpStr;
					
					var ruleException = dataList.detail.ruleException;
					if(ruleException =='1' && ruleIpStr.indexOf(ip) == -1){
						myApp.modal({
							title: '<h3 style="">您未在指定WIFI环境下签到，本次签到仍然有效，是否继续签到？</h3>',
							buttons: [
							  {
								text: '否',
								onClick: function() {
									$$(".btn").removeClass("sing-load");
									return false;
								 }
							  },
							  {
								text: '是',
								onClick: function() {
									$$(".btn").removeClass("sing-load");
									$('#moveKq').val('2');
									getclock();
									return;
								 }
							  },
							]
						  })
					}
					if(ruleIpStr.indexOf(ip) == -1 && ruleException =='2' ){
						$$(".btn").removeClass("sing-load");
						myApp.alert('请在指定的WIFI环境下进行签到！');
						return false;
					}
					if(ruleIpStr.indexOf(ip) != -1){
						$$(".btn").removeClass("sing-load");
						$('#moveKq').val('1');
						getclock();
						return false;
					}
					
				}else if(ruleType == '1'){
					var latitude = dataList.detail.ruleLatitude;
					var longitude = dataList.detail.ruleLongitude;
					var ruleScope = dataList.detail.ruleScope;
					var ruleAddress = '请在'+dataList.detail.ruleAddress+'附近'+ruleScope+'米范围内签到！';
					var ruleException = dataList.detail.ruleException;
					qq.maps.convertor.translate(new qq.maps.LatLng(latitude,longitude), 3, function(res){
				        latlng = res[0];
				        latitude = (latlng+'').split(",")[0]; 
				        longitude = (latlng+'').split(",")[1];
				    });
				    setTimeout(function() {
						var center=new qq.maps.LatLng(latitude,longitude);
						var circle=new qq.maps.Circle({
					        center:center,
					        radius:parseFloat(ruleScope)
					    });
					     var lat = $('#latitude').val();
			      		 var long = $('#longitude').val();
			      		 
					    if(!(circle.getBounds().contains(new qq.maps.LatLng(parseFloat(lat),parseFloat(long)))) && ruleException =='1'){
					    	myApp.modal({
								title: '<h3 style="">您未在指定位置内签到，本次签到仍然有效，是否继续签到？</h3>',
								buttons: [
								  {
									text: '否',
									onClick: function() {
										$$(".btn").removeClass("sing-load");
										return false;
									 }
								  },
								  {
									text: '是',
									onClick: function() {
										$$(".btn").removeClass("sing-load");
										$('#moveKq').val('2');
										getclock();
										return;
									 }
								  },
								]
							  })
					    		
					    	$$(".btn").removeClass("sing-load");
							return;
					    }
					    if(!(circle.getBounds().contains(new qq.maps.LatLng(parseFloat(lat),parseFloat(long)))) && ruleException !='1'){
					    	myApp.alert(ruleAddress);
					    	$$(".btn").removeClass("sing-load");
							return;
					    }
					    if((circle.getBounds().contains(new qq.maps.LatLng(parseFloat(lat),parseFloat(long))))){
					    	$$(".btn").removeClass("sing-load");
					    	$('#moveKq').val('1');
					    	getclock();
					    }
					    return false;
					}, 1500);
				   
				}
		    }
		});
	}
	
	
	//统计视图
	function nowWeek() {
			$('#picker-date').val('');
			var nowDate = new Date();
			$('#htmlTile').html(nowDate.getFullYear()+'年'+(nowDate.getMonth()+1)+'月');
			$('#nowhtml').html(nowDate.getFullYear()+'年'+(nowDate.getMonth()+1)+'月');
			var nowDate1 = nowDate.getFullYear() + '-' +(nowDate.getMonth()+1);
		    getKqStatusByMonth(nowDate1);
			var cells = document.getElementById('monitor').getElementsByTagName('td');
            var clen = cells.length;
            var currentFirstDate;
            var currentFirstDate1;
            
            var formatDate = function(date){             
                var year = date.getFullYear();
                var month = (date.getMonth()+1);
                if((month+'').length == 1){
                	month = '0'+month;
                }
                var day = date.getDate();
                var day1 = date.getDate();
                if((day1+'').length == 1){
                	day1 = '0'+day1;
                }
                var week = '('+['周日','周一','周二','周三','周四','周五','周六'][date.getDay()]+')';  
                var htmlDate = year +'-'+month+'-'+day1;
                var htmlWeek = '<p>'+week+'</p><p class="nub">'+day+'</p><em  id='+htmlDate+' ></em><p  id='+(htmlDate.replace("-","")).replace("-", "")+' >未签</p>|'+htmlDate;
                return htmlWeek;
            };
            
            var addDate= function(date,n){       
                date.setDate(date.getDate()+n);        
                return date;
            };
             
            var setDate = function(date){             
                var week = date.getDay()-1;
                date = addDate(date,week*-1);
                currentFirstDate = new Date(date);
				var nowData = new Date();
				var nowMonth = nowData.getMonth()+1;
				var nowDay = nowData.getDate();
				
	 			if((nowMonth+'').length == 1){
                	nowMonth = '0'+nowMonth;
                }
                if((nowDay+'').length == 1){
                	nowDay = '0'+nowDay;
                }
                var nowDayFlag = nowData.getFullYear()+'-'+nowMonth+'-'+nowDay;
                for(var i = 0;i<clen;i++){
                	var str = formatDate(i==0 ? date : addDate(date,1));
                	var html = str.split("|")[0];
                	var htmlDate = str.split("|")[1];
                	if(nowDayFlag == htmlDate){
                		//cells[i].css("color-border");
                		cells[i].id='tdId';
                		$('#tdId').css("border","2px solid #3eaeff"); 
                		//$("#monitor tr").find("td:eq('"+i+"')").addClass("color-border");
                	}
                	if(i == 0){
                		$('#beginDate').val(htmlDate);
                	}
                	if(i==clen-1){
                		var now1Data = new Date();
                		$('#endDate').val(htmlDate);
                	}
                    cells[i].innerHTML = html;
                } 
                           
            }; 
            
            document.getElementById('last-week').onclick = function(){
            	$('#tdId').css("border","");
                setDate(addDate(currentFirstDate,-7));
                $('#nowhtml').html(currentFirstDate.getFullYear()+'年'+(currentFirstDate.getMonth()+1)+'月');
                getKqStatusByTime();
            };             
            document.getElementById('next-week').onclick = function(){  
            	$('#tdId').css("border",""); 
                setDate(addDate(currentFirstDate,7));
                $('#nowhtml').html(currentFirstDate.getFullYear()+'年'+(currentFirstDate.getMonth()+1)+'月');
                getKqStatusByTime();
            };     
            setDate(new Date());
            getKqStatusByTime();
	}
	
	function getKqStatusByTime() {
		$.ajax({
		    type: "post",
		    url: "/defaultroot/attendance/getKqStatusByTime.controller",
		    data : {"beginDate" : $('#beginDate').val(), "endDate" : $('#endDate').val()},
		    success: function(data) {
		    	var jsonData = eval("("+data+")");
				var dataList = jsonData.data.dataList;
				if(Array.isArray(dataList)){
					if(dataList.length>0){
						for(var i = 0; i < dataList.length; i++){
							var kqDate = (dataList[i].kqDate).substring(0,10);
							
							var kqStatus = dataList[i].kqStatus;
							var status = '';
							var color = '';
							if(kqStatus == '0'){
								status ='正常';
								color = 'green';
							}else if(kqStatus == '1'){
								status ='迟到';
								color = 'red';
							}else if(kqStatus == '2'){
								status ='旷工半天';
								color = 'orange';
							}else if(kqStatus == '3'){
								status ='旷工一天';
								color = 'orange';
							}else if(kqStatus == '4'){
								status ='请假';
								color = 'blue';
							}else if(kqStatus == '5'){
								status ='加时';
								color = 'green';
							}else if(kqStatus == '6'){
								status ='早退';
								color = 'orange';
							}else if(kqStatus == '7'){
								status ='出差';
								color = 'blue';
							}else if(kqStatus == '8'){
								status ='调休';
								color = 'orange';
							}else{
								status ='其他';
							}
							$("#"+kqDate).addClass(color);
							$("#"+(kqDate.replace("-","")).replace("-","")).html(status);
						}
					}
				}else if(dataList != undefined && dataList != ''){
					var kqDate = (dataList.detail.kqDate).substring(0,10);
					var kqStatus = dataList.detail.kqStatus;
					var status = '';
					var color = '';
					if(kqStatus == '0'){
						status ='正常';
						color = 'green';
					}else if(kqStatus == '1'){
						status ='迟到';
						color = 'red';
					}else if(kqStatus == '2'){
						status ='旷工半天';
						color = 'orange';
					}else if(kqStatus == '3'){
						status ='旷工一天';
						color = 'orange';
					}else if(kqStatus == '4'){
						status ='请假';
						color = 'blue';
					}else if(kqStatus == '5'){
						status ='加时';
						color = 'green';
					}else if(kqStatus == '6'){
						status ='早退';
						color = 'orange';
					}else if(kqStatus == '7'){
						status ='出差';
						color = 'blue';
					}else if(kqStatus == '8'){
						status ='调休';
						color = 'orange';
					}else{
						status ='其他';
					}
					$("#"+kqDate).addClass(color);
					$("#"+(kqDate.replace("-","")).replace("-","")).html(status);
				}
				//alert(dataList.kqDate);
				//alert(dataList.kqStatus);
		    }
		});
	}
	
	function getKqStatusByMonth(data) {
        var nowYear = data.split("-")[0];
        var nowMonth = data.split("-")[1];
		$.ajax({
		    type: "post",
		    url: "/defaultroot/attendance/getKqStatusByMonth.controller",
		    data : {"year" : nowYear, "month" : nowMonth},
		    success: function(data) {
		    	var jsonData = eval("("+data+")");
				var dataList = jsonData.data;
				var html = '';
				if(dataList.hasData == 0){
					html = '<tr><td><p class="fl"><em class="green"></em><span>正常</span></p><p class="fr">0次</p></td>' +
						'<td><p class="fl"><em class="red"></em><span>迟到</span></p><p class="fr">0次</p></td></tr>'+
						
						'<tr><td><p class="fl"><em class="orange"></em><span>旷工</span></p><p class="fr">0次</p></td>' +
						'<td><p class="fl"><em class="orange"></em><span>早退</span></p><p class="fr">0次</p></td></tr>'+
						
						'<tr><td><p class="fl"><em class="blue"></em><span>请假</span></p><p class="fr">0次</p></td>' +
						'<td><p class="fl"><em class="green"></em><span>加时</span></p><p class="fr">0次</p></td></tr>'+
						
						'<tr><td><p class="fl"><em class="green"></em><span>调休</span></p><p class="fr">0次</p></td>' +
						'<td><p class="fl"><em class="blue"></em><span>出差</span></p><p class="fr">0次</p></td></tr>'+
						
						'<tr><td><p class="fl"><em class="orange"></em><span>年休</span></p><p class="fr">0次</p></td>' +
						'<td><p class="fl"><em></em><span>其他</span></p><p class="fr">0次</p></td></tr>';
				}else{
					html = '<tr><td><p class="fl"><em class="green"></em><span>正常</span></p><p class="fr">'+parseFloat(dataList.detail.attendance)+'次</p></td>' +
						'<td><p class="fl"><em class="red"></em><span>迟到</span></p><p class="fr">'+parseFloat(dataList.detail.late)+'次</p></td></tr>'+
						
						'<tr><td><p class="fl"><em class="orange"></em><span>旷工</span></p><p class="fr">'+parseFloat(dataList.detail.absenteeism)+'次</p></td>' +
						'<td><p class="fl"><em class="orange"></em><span>早退</span></p><p class="fr">'+parseFloat(dataList.detail.leave_early)+'次</p></td></tr>'+
						
						'<tr><td><p class="fl"><em class="blue"></em><span>请假</span></p><p class="fr">'+parseFloat(dataList.detail.leave)+'次</p></td>' +
						'<td><p class="fl"><em class="green"></em><span>加时</span></p><p class="fr">'+parseFloat(dataList.detail.overtime)+'次</p></td></tr>'+
						
						'<tr><td><p class="fl"><em class="green"></em><span>调休</span></p><p class="fr">'+parseFloat(dataList.detail.rest)+'次</p></td>' +
						'<td><p class="fl"><em class="blue"></em><span>出差</span></p><p class="fr">'+parseFloat(dataList.detail.travel)+'次</p></td></tr>'+
						
						'<tr><td><p class="fl"><em class="orange"></em><span>年休</span></p><p class="fr">'+parseFloat(dataList.detail.annualLeave)+'次</p></td>' +
						'<td><p class="fl"><em></em><span>其他</span></p><p class="fr">'+parseFloat(dataList.detail.other)+'次</p></td></tr>';
				}
						
				$('#tjTable').html(html);
						
		    }
		});
	}
	
	//获取ip
	function getIp() {
		var userAgent = navigator.userAgent.toLowerCase();
		if(!((userAgent.indexOf("android") != -1) || (
			(userAgent.indexOf("linux") != -1) && (((userAgent.indexOf("chrome") != -1) || (userAgent.indexOf("safari") != -1)))))){
			//查询网络iPURL
		    var url = 'http://chaxun.1616.net/s.php?type=ip&output=json&callback=?&_='+Math.random(); 
		  	 $.getJSON(url, function(data){
				ip = data.Ip;
				$('#ipstr').val(ip);
			 });
		}else{
			ip = '<%=ip%>';
			$('#ipstr').val('<%=ip%>');
		}		
			
	}
	
	function attDetail() {
		//打开详情页
		var nowDate = new Date();
		window.location="/defaultroot/attendance/getMyKqByMon.controller?year="+nowDate.getFullYear()+"&month="+(nowDate.getMonth()+1);
	}

  </script>
</body>
</html>