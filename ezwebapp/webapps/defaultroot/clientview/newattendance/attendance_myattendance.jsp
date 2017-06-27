<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp"%>

<!DOCTYPE html>
<html>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>签到记录</title>
  <%@ include file="../common/headerInit.jsp" %>
</head>

<body class="grey-bg">
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page" data-page="page-webapp-signin-note">
          <section class="pull-to-refresh-content wh-section wh-section-bottomfixed" data-ptr-distance="40">
           <c:if test="${not empty docXml}">
			<x:parse xml="${docXml}" var="doc"/>
            <div class="pull-to-refresh-layer">
              <div class="preloader"></div>
              <div class="pull-to-refresh-arrow"></div>
            </div>
            <div class="webapp-sigin webapp-sigin-a">
              <div class="top-a clearfix">
                  <span class="w-f fl">${param.year }年${param.month }月：签到${recordCount }天</span>
                
                  <input class="edit-ipt-r fr edit-ipt-arrow" id="picker-date" type="text" name="scroller" placeholder="选择日期" />
                </div>
              <div class="signin-note-list">
                <div class="list-block">
                  <ul class="webapp-list">
                  	<x:forEach select="$doc//list/attendanceList" var="alt" >
                  		<c:set var="id"><x:out select="$alt/id/text()"/></c:set>
	                    <c:set var="presentTime"><x:out select="$alt/presentTime/text()"/></c:set>
	                    <li class="swipeout" onclick="openDetail('${id}','${presentTime }');">
	                      <a href="#" class="swipeout-content item-content">
	                        <div>
	                          <i class="fa fa-sign"></i>
	                          <span><x:out select="$alt/presentTime/text()"/></span>
	                          <em>打卡<x:out select="$alt/record/text()"/>次</em>
	                        </div>
	                        <div class="item-after"><i class="fa fa-angle-right"></i></div>
	                      </a>
	                    </li>
                    </x:forEach>
                  </ul>
                </div>
              </div>
            </div>
            </c:if>
          </section>
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
  <script type="text/javascript">
  var myApp = new Framework7();
  var $$ = Dom7;
  // 数据列表
  var dates = ['2016-10-9', '2016-10-10', '2016-10-11'];
  var signintimes = ['10', '11', '12'];
  // 下拉刷新页面
  var ptrContent = $$('.pull-to-refresh-content');

  // 添加'refresh'监听器
  ptrContent.on('refresh', function(e) {
    // 模拟2s的加载过程
    setTimeout(function() {
    	var nowDate = new Date();
      loadMyAttendanceList(nowDate.getFullYear(),(nowDate.getMonth()+1))
      // 加载完毕需要重置
      myApp.pullToRefreshDone();
    }, 2000);
  });


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
        var todayArr = [today.getFullYear(), today.getMonth(), today.getDate(), today.getHours(), (today.getMinutes() < 10 ? '0' + today.getMinutes() : today.getMinutes())];
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
        return values[0] + '-' + values[1] ;
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
        },
       
      
    ]
});


function getSelDate() {
	var selDate = $("#picker-date").val();
	loadMyAttendanceList(selDate.split("-")[0],selDate.split("-")[1]); 
}

 function loadMyAttendanceList(year,month){
	var url = '/defaultroot/attendance/nextGetMyKqByMon.controller?year='+year+'&month='+month;
	  $$.ajax({
		  type: "post",
		  url: url,
		  dataType: "text",
		  success: function(data) {
			var jsonData = eval("("+data+")");
			var html ='';
			var maxItems = jsonData.data2;
			if(jsonData.data0.length>0){
				for(var i = 0; i < jsonData.data0.length; i++){
					html +='<li class="swipeout" onclick="openDetail('+jsonData.data0[i].id+','+jsonData.data0[i].presentTime+')";>'+
						  '<a href="#" class="swipeout-content item-content">'+
							'<div>'+
							  '<i class="fa fa-sign"></i>'+
							  '<span>'+jsonData.data0[i].presentTime+'</span>'+
							  '<em>打卡'+jsonData.data0[i].record+'次</em>'+
							'</div>'+
							'<div class="item-after"><i class="fa fa-angle-right"></i></div>'+
						  '</a>'+
						'</li>';
				}
				$('.webapp-list').html(html);
			}else{
				$$('.wh-load-md').hide();
				$$('.webapp-list').html('<li style="padding: 1rem;" class="swipeout">系统未查询到相关记录 !</li>');
			}
			myApp.hidePreloader();
		  },error: function(xhr, status) {
			$$('.webapp-list').append('<li style="padding: 1rem;" class="swipeout">系统未查询到相关记录 !</li>');
			$$('.wh-load-tap').hide();
			$$('.wh-load-md').hide();
			myApp.hidePreloader();
		  }
	  });
    }

	function openDetail(id,presentTime) {
		window.location = "/defaultroot/attendance/myKqDetail.controller?id="+id+"&presentTime="+presentTime;
	}

  </script>
</body>
</html>