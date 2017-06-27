//ios可预览的类型
var iosOpenFileType = ".doc.ppt.docx.pptx.jpg.png.gif.jpeg.pdf.txt.xls.xlsx";
var timeout = false;
//点击下载附件
function clickSubyz(url,obj,saveFileName,moduleName,smartInUse,encrypt,tmpurl,apptype,realtime,isYzOffice){
	var fileType = saveFileName.substr(saveFileName.lastIndexOf(".")).replace(/<[^>]+>/g,'').toLowerCase();
	if(fileType.toLowerCase() != '.xls' && fileType.toLowerCase() != '.xlsx'
			&& fileType.toLowerCase() != '.doc' && fileType.toLowerCase() != '.docx' 
			&& fileType.toLowerCase() != '.ppt' && fileType.toLowerCase() != '.pptx' 
			&& fileType.toLowerCase() != '.rtf' && fileType.toLowerCase() != '.eio'
			&& fileType.toLowerCase() != '.pdf' && fileType.toLowerCase() != '.xml'
			&& fileType.toLowerCase() != '.txt' && fileType.toLowerCase() != '.zip'
			&& fileType.toLowerCase() != '.rar' && fileType.toLowerCase() != '.jpg'
			&& fileType.toLowerCase() != '.png' && fileType.toLowerCase() != '.gif'
			&& fileType.toLowerCase() != '.jpeg' && fileType.toLowerCase() != '.bmp'){
		timeout = true;
		myApp.alert("该类型不支持预览，请于电脑端查看！");
		return;
		
	}
	
	if(isYzOffice == '0' && (fileType.toLowerCase() == '.rar' || fileType.toLowerCase() == '.zip' || fileType.toLowerCase() == '.xml')){
		timeout = true;
		myApp.alert("该类型不支持预览，请于电脑端查看！");
		return;
	}
	
	myApp.showPreloader('正在加载中');
	setTimeout(function() {
		time();
    }, 5000);
	
	if(fileType.toLowerCase() == '.jpg' || fileType.toLowerCase() == '.png' || fileType.toLowerCase() == '.gif' || 
			fileType.toLowerCase() == '.jpeg' || fileType.toLowerCase() == '.bmp'){
			openImgPath(saveFileName,moduleName);
			return;
	}
	
	if(isYzOffice == 1){
		file2htmlYz(saveFileName,moduleName,tmpurl,encrypt,realtime);
	}else{
		var userAgent = navigator.userAgent.toLowerCase();
		if(!((userAgent.indexOf("android") != -1) || (
			(userAgent.indexOf("linux") != -1) && (((userAgent.indexOf("chrome") != -1) || (userAgent.indexOf("safari") != -1))))) && fileType.toLowerCase() =='.pdf'){
			if(iosOpenFileType.indexOf(fileType) != -1){
				window.location.href=url;
				return;
			}
		}else{
			if(fileType.toLowerCase() == '.pdf' ){
				window.location.href='/defaultroot/clientview/common/ppt_img.jsp?saveFileName='+saveFileName+'&moduleName='+moduleName+'&encrypt='+encrypt+'&url='+tmpurl;
			}else{
				file2html(saveFileName,moduleName,tmpurl,encrypt,realtime);
			}
		}
	}
}

//打开永中服务转换html（收费版本）
function file2htmlYz(saveFileName,moduleName,tmpurl,encrypt,realtime) {
	$$.ajax({
		 type: 'post',
		 url: "/defaultroot/yzConvertFile/file2Html.controller",
		 dataType:'text',
		 data : {'saveFileName': saveFileName, 'moduleName' : moduleName,'url': tmpurl,'encrypt': encrypt,'realtime':realtime},
		 success: function(data){
		 	var jsonData = eval("("+data+")");
		 	flag = 0;
		 	timeout = true;
		 	if(jsonData.result == '0'){
		 		window.location = jsonData.data;
		 	}else if(jsonData.result == '3'){
		 		myApp.hidePreloader();
		 		myApp.alert("指定文件不存在！");
		 	}else{
		 		myApp.hidePreloader();
		 		myApp.alert(jsonData.message);
		 	}
		 },error: function(xhr, type){
			 timeout = true;
			 myApp.hidePreloader();
			 //alert('数据查询异常！');
		 }
	});
}

//附件转html
function file2html(saveFileName,moduleName,tmpurl,encrypt,realtime) {
	$$.ajax({
		 type: 'post',
		 url: "/defaultroot/yzConvertFile/fileView.controller",
		 dataType:'text',
		 data : {'saveFileName': saveFileName, 'moduleName' : moduleName,'url': tmpurl,'encrypt': encrypt,'realtime':realtime},
		 success: function(data){
			 myApp.hidePreloader();
			 var jsonData = eval("("+data+")");
			 window.location.href='/defaultroot'+jsonData.data;
		 },error: function(xhr, type){
			 timeout = true;
			 myApp.hidePreloader();
			 //alert('数据查询异常！');
		 }
	});
}

//打开图片附件
function openImgPath(fileName,moduleName) {
	$.ajax({
		 type: 'post',
		 url: "/defaultroot/download/downloadImg.controller",
		 dataType:'text',
		 data : {"fileName": fileName,"name": fileName,"path":moduleName},
		 success: function(data){
			timeout = true;
		 	myApp.hidePreloader();
		 	window.location= '/defaultroot'+data;
		 },error: function(xhr, type){
			 myApp.hidePreloader();
			 //alert('数据查询异常！');
		 }
	
	});
}

//判断五秒是否加载成功，未成功更改提示语
function time() {  
  if(timeout) return;  
  myApp.hidePreloader();
  myApp.showPreloader('文档较大正在努力加载中');
}  

