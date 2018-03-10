<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="me" uri="/WEB-INF/tld/cqu.tld"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="renderer" content="webkit" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="${base}assets/css/bootstrap.css"
	media="screen" />
<script type="text/ecmascript" src="${base}assets/js/md5.js"></script>
<title>欢迎登录雏鹰计划信息管理系统</title>
<link href="${base}assets/css/style2.css" rel="stylesheet"
	type="text/css" />
<script language="JavaScript"
	src="${base}assets/jq/jquery-1.10.2.min.js"></script>
<script src="${base}assets/js/bootstrap.min.js"></script>
<script src="${base}assets/js/cloud.js" type="text/javascript"></script>
<script type="text/javascript"
	src="${base}assets/js/Validform_v5.3.2.js"></script>
<script type="text/javascript"
	src="${base}assets/lhgdialog/lhgdialog.min.js?skin=blue"></script>
<script type="text/javascript" src="${base}assets/js/common.js"></script>
<link href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css"
	rel="stylesheet"></link>
<script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<style type="text/css">
.code {
	background: url(code_bg.jpg);
	font-family: Arial;
	font-style: italic;
	color: blue;
	font-size: 30px;
	border: 0;
	padding: 2px 3px;
	letter-spacing: 3px;
	font-weight: bolder;
	float: left;
	cursor: pointer;
	width: 150px;
	height: 60px;
	line-height: 60px;
	text-align: center;
	vertical-align: middle;
}

a {
	text-decoration: none;
	font-size: 12px;
	color: #288bc4;
}

a:hover {
	text-decoration: underline;
}

.loginvrfc {
	float: left;
}

#imgWrap {
	float: left;
	height: 48px;
	line-height: 48px;
	padding-left: 20px;
	padding-top: 7px;
}

#changePic {
	display: inline-block;
	height: 16px;
	margin-top: 25px;
	margin-left: 10px;
}

.clearfix {
	content: "";
	display: block;
	height: 0px;
	border: none;
	clear: both;
}
</style>
<script language="javascript">
	if (window.top == window.self) {

	} else {
		window.top.location.href = window.self;
	}
	var ERROR_MSG = "${PAGE_ERROR}";
	$(function() {
		$('#bodymain').css({
			'margin-top' : ($(window).height() - 428) / 2-97
		});
	});

	
	function refresh() {
		var myData = new Date(); 
		$.ajax({
			type:"post",
			url:"${base}index/img?time="+myData.getTime(),
			data:"",
			success:function(data){
				$("#checkCode").attr("src","${base}index/img?time="+myData.getTime());
			}
		})
	}
	//弹出提示框
	function title_ts(msg) {
		$.dialog({
			lock : false,
			title : '提示信息',
			width : 220, /*必须指定一个像素宽度值或者百分比，否则浏览器窗口改变可能导致lhgDialog收缩 */
			content : msg,
			min : false,
			max : false,
			opacity : 0.1,
			ok : function() {
			}
		});
	}
	function check() {
		//检查账号和密码和验证码是否为空
		var inputCode = document.forms[0].inputCode;
		var account = document.forms[0].username;
		if (account.value.length == 0) {
			title_ts("请填写账号！");
			account.focus();
			return false;
		}
		var password = document.forms[0].password;
		if (password.value.length == 0) {
			title_ts("请输入密码！");
			password.focus();
			return false;
		}
		if (inputCode.value.length == 0) {
			title_ts("请输入验证码！");
			inputCode.focus();
			return false;
		}
		return true;
	}
	//对密码进行MD5加密
	function md5() {
		var pw = $("#password").val();
		if (pw.length > 0) {
			$("#password").val(hex_md5(pw));
		}
	}
</script>
</head>

<body onload="${base}index/createCode"
	style="background-color: #1c77ac; background-repeat: no-repeat; background-position: center top; overflow: hidden;">
	<div id="mainBody">
		<div id="cloud1" class="cloud"></div>
		<div id="cloud2" class="cloud"></div>
	</div>
	<div class="logintop">
		<span style="font-size: 16px;">欢迎登录雏鹰计划信息管理系统</span>
		<ul>
			<li><a href="${base}index/studentRegiste"
				style="font-size: 13px;">中学生注册</a></li>
			<li><a href="${base}index/midTeacherRegiste"
				style="font-size: 13px;">中学教师注册</a></li>
			<li><a href="${base}index/collegeTeacherRegiste"
				style="font-size: 13px;">大学教师注册</a></li>
		</ul> 
	</div>
	<div class="loginbody">
		<div class="systemlogo" style="text-align: center;"></div>
		<div class="row" id="bodymain">
			<div class="col-lg-6">
				<div class="loginnews">
					<div class="newstitle">
					<span>新闻</span>
					<a href="${base}index/getNewsList">更多</a>
					</div>
					<div class="newscontent">
					<ul>
						<c:forEach items="${listNews}" var="data" varStatus="i">
						<li><span><fmt:formatDate value="${data.publish_time}"
								pattern="yyyy-MM-dd" /></span><a href="${base}index/getNews?news_id=${data.news_id}" title="${data.title}">${data.title}</a></li>
						</c:forEach>
					</ul>
					</div>
				</div>
				<div class="loginnews" style="margin-top: 18px;">
					<div class="newstitle">
					<span>政策</span>
					<a href="${base}index/getPolicyList">更多</a>
					</div>
					<div class="newscontent">
					<ul>
						<c:forEach items="${listPolicy}" var="data" varStatus="i">
						<li><span><fmt:formatDate value="${data.publish_time}"
								pattern="yyyy-MM-dd" /></span><a href="${base}index/getNews?news_id=${data.news_id}" title="${data.title}">${data.title}</a></li>
						</c:forEach>
					</ul>
					</div>
				</div>
			</div>
			<!-- /.col-lg-6 -->
			<div class="col-lg-6 loginbox">
				<form onsubmit="return check();" action="${base}index/login"
					method="post">
					<ul>
						<li><input name="username" type="text" class="loginuser"
							id="user_name" autocomplete="off" value="${user_name }" /></li>
						<li><input name="password" id="password" type="password"
							autocomplete="off" onchange="md5();" class="loginpwd"
							value="${password}" /></li>
						<li><input name="inputCode" type="text" autocomplete="off"
							class="loginvrfc" />
							<div id="imgWrap">
								<img class="vcode" id="checkCode" src="${base}index/img" />
							</div> <a href="javascript:;" ondragstart="return false"
							onclick="refresh();" id="changePic">看不清？换一张</a>
							<div class="clearfix"></div></li>
						<li><input type="submit" class="loginbtn" value="登录" />&nbsp;&nbsp;&nbsp;
							<input type="reset" class="loginbtn" value="重置" />&nbsp;&nbsp;&nbsp;&nbsp;</li>
					</ul>
				</form>
			</div>
		</div>
	</div>
	<div class="loginbm">
		&copy; 版权所有 2016 <a ondragstart="return false" href="#">重庆大学软件学院</a>
	</div>
</body>
</html>