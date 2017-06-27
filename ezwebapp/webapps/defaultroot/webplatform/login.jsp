<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<script type="text/javascript" src="/defaultroot/webplatform/scripts/plugins/security/security.js"></script>
    <%@ include file="/webplatform/include/logonHeaderInit.jsp"%>
</head>
<body>
<div class="wh-wrapper">
    <div class="wh-pg-login">
        <div class="wh-main"> 
            <div class="wh-login-cons wh-lg-no-button"> 
                <div class="wh-lg-loIn-bg"></div>
                
                <div class="wh-lg-logoIn" >
                    <div class="wh-lg-logoIn-top" > 
                        <form id="loginForm" name="loginForm" action="" method="post">
                            <div class="vali-username">
                                <i class="fa fa-user"></i>
                                <input type="text" name="userAccounts" id="userAccounts" value="" class="info" />
                            </div>
                            <div class="vali-pass">
                                <i class="fa fa-lock"></i>
                                <input type="password" name="userpassword" id="userpassword" value="" class="info" onkeypress="chgPwd()"/>
								<input type="hidden" name="timestr" id="timestr"/>
								<input type="hidden" name="track" id="track" value="0086dd23d3e1fb5660e83468945e851c666d63512b799c4e29694bf54dc7877f1e9787531161c5bad76a16e497f8273136b6336d4919f8d7786e023b4a8b23d1f80a9a524210acfd2b504b4a02043c9d68f51a22ec4c111e2890f185955197301e8089f9bfe047e0e1a84d81d3b1c3f19cf43633264681a0cc60d2812bcd441001"/>
                            </div> 
                            <div class="vali-submit" onclick="logon();" style="cursor:pointer">
                                <a>登录</a>
                            </div> 
                        </form> 
                    </div>  
                </div> 
            </div> 
        </div>
        <!-- 登录背景切换 -->
        <div class="wh-lg-slider">  
            <div class="wh-lg-flexslider-bg">
                <div class="flexslider">
                    <ul class="slides">
                        <li style="background-image:url('/defaultroot/webplatform/images/ver113/login/bg_login_sd.jpg')"></li> 
                    </ul>
                </div>
            </div>        
            <div class="wh-lg-copy">
                版权所有：北京万户网络  © 1998-2017 whir.All Rights Reserved.
            </div>
        </div>
    </div>
</div>
<!-- <div class="wh-pg-login-bg" style="background-image: url(../images/ver113/login/bg_login_sd.jpg)"></div> -->
<!-- <div class="wh-pg-login-bg-out" style="background-image: url(../images/ver113/login/bg_login_sd.jpg)"></div> -->
<!-- <div class="wh-iewarning">
    <div class="wh-iewarn-box" style="display:none">
        <h2 class="clearfix"><strong>温馨提示</strong><a class="close" href="javascript:void(0)"></a></h2>
        <table>
            <tr>
                <td>
                    <i class="wh-iewarn-notice"></i>
                    <em>很抱歉，您当前的浏览器版本过低，请升级您的浏览器获得最佳使用体验！</em>
                </td>
            </tr>
            <tr>
                <td>
                    <p><a class="wh-iewarn-btn" href="####" target="_blank">升级到IE8</a></p>
                    <p><a href="#">谷歌浏览器</a><a href="#">火狐浏览器</a></p>
                </td>
            </tr>
        </table>
    </div>
    <div class="wh-iewarn-box" style="display:block">
        <h2 class="clearfix"><strong>温馨提示</strong><a class="close" href="javascript:void(0)"></a></h2>
        <table>
            <tr>
                <td>
                    <i class="wh-iewarn-notice"></i>
                    <em>很抱歉，您当前的浏览器版本过低，请升级您的浏览器获得最佳使用体验！</em>
                </td>
            </tr>
            <tr>
                <td>
                    <p><a class="wh-iewarn-btn wh-iewarn-btn-disable" href="####" target="_blank">暂不升级</a><a class="wh-iewarn-btn" href="####" target="_blank">升级到IE9</a></p>
                    <p><a href="#">谷歌浏览器</a><a href="#">火狐浏览器</a></p>
                </td>
            </tr>
        </table>
    </div>
    <div class="wh-iewarn-wrap"></div>
</div> -->

<script type="text/javascript">
    $(function(){
        //动态赋高
        function scrh(obj){
            var scrHeight=document.body.scrollHeight;
            //var srcHeight = $(window).height;
            obj.css({'height':scrHeight});
        }

        $(function(){

			var userAccounts = $('#userAccounts');
	        userAccounts.focus();
            var scrH=$(".wh-pg-login,.wh-lg-slider");
            scrh(scrH);

            var resizeTimer;
            function resizeFunction() {
                scrh(scrH);
            };

            $(window).resize(function() {
                clearTimeout(resizeTimer);
                resizeTimer = setTimeout(resizeFunction, 300);
            });            
            resizeFunction()

            $(".flex-next").text('');
            $(".flex-prev").text('');
            //click language selection
            var sele_bd = $(".sele-list-div");
            var sele_list = $(".sele-list");
            var wh_llnav = $(".wh-lg-logoIn-nav li");
            var wh_lltop = $(".wh-lg-logoIn-top");

            $(".sele-show").click(function () {
                sele_bd.show();
                sele_list.show(200);
                return false;
            });

            sele_list.find("li").click(function(){
                sele_list.hide();
                sele_bd.hide();
                return false;
            });

            $("body").click(function () {
                sele_bd.hide();
                sele_list.hide();
            });

            $(".info").focus(function(){
                $(this).parent().css("border-color","#0c89e1");
            });
            $(".info").blur(function(){
                $(this).parent().css("border-color","#666");
            });
            $(".info").hover(function(){
                $(this).parent().css("border-color","#0c89e1");
            },function(){
                $(this).parent().css("border-color","#666");
            });
            $(".image").hover(function(){
                $(this).css("border-color","#0c89e1");
            },function(){
                $(this).css("border-color","#666");
            });

            wh_llnav.on("click",function(){
                var $this = $(this);
                var index = $this.index();
                $this.addClass("current").siblings().removeClass("current");
                wh_lltop.hide().eq(index).show();
                if(index == 1){
                    $('.flexslider1').flexslider({
                        animation: "slide",
                        directionNav: true,
                        controlNav: false,
                        slideshowSpeed: 700000
                    });
                }
            });
        });

        //轮播
        $('.flexslider').flexslider({
            directionNav: false,
            controlNav: true
        });

        //获取Logo图片高度
        var picHeight = parseInt($("#loginPic").data('pich')+"px");
        var picMarginTop = "-"+parseInt($("#loginPic").data('pich'))/2+"px";
        $("#loginPic").height(picHeight);
        $("#loginPic").css({"height":picHeight, "margin-top":picMarginTop});
    });
	//加密后的密码
    var hasMd5_pwd = "0";
	function chgPwd(){
	   hasMd5_pwd = "0";
	}
	
	function logon(){
		$.ajax({
			 url : "/defaultroot/webplatform/getDateTime.controller",    
			 type : "POST",    
			 dataType:"text",   
			 success : function(data) {
				 //alert(data);
				 logon1(data)
			 },    
			 error : function(data) {
			 }    
		});

		
		

	}

	function logon1(timestr){

		var userAccounts = $('#userAccounts').val().replace(/(^\s*)|(\s*$)/g, "");
		var userpassword = $('#userpassword').val().replace(/(^\s*)|(\s*$)/g, "");
		$('#userAccounts').val(userAccounts);
		$('#userpassword').val(userpassword);
		if(userAccounts==""){
		   whir_alert1("提示信息","请输入帐号！","确定");
		   $('#userAccounts').focus();
		   return ;
		}
		if(userpassword==""){
		   whir_alert1("提示信息","请输入密码！","确定");
		   $('#userpassword').focus();
		   return ;
		}

		if(hasMd5_pwd=="0"){
           var pwd = hex_md5(userpassword)+"&567432187"+timestr;
		   var key = RSAUtils.getKeyPair("010001", "", $('#track').val());
		   var data = RSAUtils.encryptedString(key, pwd);
		   $('#userpassword').val(data);
		   hasMd5_pwd = "1";
		}
	
	   $.ajax({
			 url : "/defaultroot/webplatform/logon.controller",    
			 type : "POST",    
			 dataType:"json",
			 data : $( '#loginForm').serialize(),    
			 success : function(data) {
				 var loginsuccess = data.loginsuccess;

				 if(loginsuccess=="1"){
					window.location="/defaultroot/weixinplatform/weixinplatformview.controller";
				 }else{
					whir_alert1("提示信息",data.loginsuccess,"确定");
				 }
			 },    
			 error : function(data) {
				 whir_alert1("提示信息","登陆出错!","确定");
			 }    
		});  
	
	}

	document.onkeydown=function(e){
		 var keycode=document.all?event.keyCode:e.which;
		 if(keycode==13){logon();};
	}
</script>
</body>
</html>