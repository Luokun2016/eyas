<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld" %>
<cqu:right>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="renderer" content="webkit" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>雏鹰计划信息管理系统</title>
<link href="${base}assets/css/style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="${base}assets/jq/jquery-1.10.2.min.js"></script>
<script type="text/javascript">
$(function(){	
	//顶部导航切换
	$(".nav li a").click(function(){
		$(".nav li a.selected").removeClass("selected");
		$(this).addClass("selected");
	});
});
</script>
<style type="text/css" >
.nav{margin-left: 50px;}
.nav img{width:40px;height:40px;overflow:hidden;}
.nav h2{margin-top:5px;}
.helpimg{margin-top:-2px;}
</style>
</head>
<body style="background:url(${base}assets/img/topbg.gif) repeat-x;">
    <div class="topleft">
    	<%-- <embed src="${base}assets/img/logo.swf" wmode="transparent" quality="high" width="100" height="60" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer">
    	 --%><img src="${base}assets/img/logo-1.png" width="380" height="80" title="系统首页" />
    </div>
        
    <ul class="nav">
    <li pm="JCGL"><a href="${base}index/menu?f=base" target="leftFrame"><img src="${base}assets/menu/home.png" /><h2>基础管理</h2></a></li>
    <li pm="XMGL"><a href="${base}index/menu?f=project" target="leftFrame"><img src="${base}assets/menu/home.png" /><h2>项目管理</h2></a></li>
    <li pm="XXGL"><a href="${base}index/menu?f=study" target="leftFrame"><img src="${base}assets/menu/home.png" /><h2>学习管理</h2></a></li>
    <li pm="TYGL"><a href="${base}index/menu?f=recommend"  target="leftFrame"><img src="${base}assets/menu/home.png" /><h2>推优管理</h2></a></li>
    <li pm="XTGL"><a href="${base}index/menu?f=system"  target="leftFrame"><img src="${base}assets/menu/system.png" /><h2>系统管理</h2></a></li>
    </ul>
            
    <div class="topright">
		<ul>
			<li><a href="${base}index/body" target="rightFrame">首页</a></li>
			<li><a href="${base}index/userEdit" target="rightFrame">个人信息</a></li>
			<li><a href="${base}index/txEditPwd" target="rightFrame">修改密码</a></li>
			<li><a href="${base}index/logout"  onclick="return confirm('确定退出本系统?')" target="_parent">退出</a></li>
		</ul>
		<div class="user">
			<span>${username}</span><i>[ ${name} ]</i>
		</div>
	</div>
</body>
</html>
</cqu:right>