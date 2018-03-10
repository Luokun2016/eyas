<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld" %>
<cqu:right>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>雏鹰计划信息管理系统</title>
<link href="${base}assets/css/style.css" rel="stylesheet"
	type="text/css" />
<script language="JavaScript"
	src="${base}assets/jq/jquery-1.10.2.min.js"></script>
<script type="text/javascript">
	$(function() {
		//导航切换
		$(".menuson li").click(function() {
			$(".menuson li.active").removeClass("active");
			$(this).addClass("active");
		});
		$('.title').click(function() {
			var $ul = $(this).next('ul');
			$('dd').find('ul').slideUp();
			if ($ul.is(':visible')) {
				$(this).next('ul').slideUp();
			} else {
				$(this).next('ul').slideDown();
			}
		});
		tick();
		parent.document.getElementById("rightFrame").src="${base}index/body";
	});
	function showLocale(objD){   
        var str,colorhead="",colorfoot;   
        var yy = objD.getYear();   
            if(yy<1900) yy = yy+1900;   
        var MM = objD.getMonth()+1;   
            if(MM<10) MM = '0' + MM;   
        var dd = objD.getDate();   
            if(dd<10) dd = '0' + dd;   
        var hh = objD.getHours();   
            if(hh<10) hh = '0' + hh;   
        var mm = objD.getMinutes();   
            if(mm<10) mm = '0' + mm;   
        var ww = objD.getDay();   
            if ( ww==0 ) colorhead="<font color=\"#FFF\">";   
            if ( ww > 0 && ww < 6 ) colorhead="<font color=\"#FFF\">";   
            if ( ww==6 ) colorhead="<font color=\"#FFF\">";   
            if (ww==0) ww="星期日";   
            if (ww==1) ww="星期一";   
            if (ww==2) ww="星期二";   
            if (ww==3) ww="星期三";   
            if (ww==4) ww="星期四";   
            if (ww==5) ww="星期五";   
            if (ww==6) ww="星期六";   
            colorfoot="</font>";
            str = colorhead + yy + "年" + MM + "月" + dd + "日" + hh + ":" + mm  + " " + ww + colorfoot;   
        return(str);   
    }   
	function tick()   
    {   
        var today;   
        today = new Date();   
        $("#localtime").html(showLocale(today));   
        window.setTimeout("tick()", 1000);   
    }   
</script>
</head>

<body style="background: #f0f9fd;">
	<div class="lefttop">
		&nbsp;<label id="localtime" style="color:#FFF;"></label>
	</div>

	<dl class="leftmenu">
		
		<c:if test='${m=="base"}'>
		<dd pm="JCGL">
			<div class="title">
				<span><img src="${base}assets/img/leftico01.png" /></span>基础管理
			</div>
			<ul class="menuson">
 				<li pm="JCGL_XXGL"><cite></cite><a href="${base}school/schoolManage" target="rightFrame">学校管理</a></li>

 				<li pm="JCGL_NJGL"><cite></cite><a href="${base}grade/gradeManage" target="rightFrame">年级管理</a></li>
 				<li pm="JCGL_YHGL"><cite></cite><a href="${base}user/" target="rightFrame">用户管理</a></li>
 				<li pm="JCGL_XKLBGL"><cite></cite><a href="${base}subject/subjectManage" target="rightFrame">学科类别管理</a></li>					
				<li pm="JCGL_XWLBGL"><cite></cite><a href="${base}news/newsType" target="rightFrame">新闻类别管理</a></li>
				<li pm="JCGL_XWGL"><cite></cite><a href="${base}news" target="rightFrame">新闻管理</a></li> 		
				<li pm="JCGL_XXJLLBGL"><cite></cite><a href="${base}recordtype/recordTypeManage" target="rightFrame">学习记录类别管理</a></li>		
			</ul>
		</dd>
		</c:if>
		<c:if test='${m=="project"}'>
		<dd pm="XMGL">
			<div class="title">
				<span><img src="${base}assets/img/leftico01.png" /></span>项目管理
			</div>
			<ul class="menuson">
				<li pm="XMGL_LXGL"><cite></cite><a href="${base}project" target="rightFrame">立项管理</a></li>
				<li pm="XMGL_XMSBGL"><cite></cite><a href="${base}project/apply" target="rightFrame">项目申报管理</a></li>
				<li pm="XMGL_XMSXGL"><cite></cite><a href="${base}project/choose" target="rightFrame">项目筛选与反馈</a></li>
				<li pm="XMGL_ZSFBGL"><cite></cite><a href="${base}project/release" target="rightFrame">正式发布项目</a></li>
				<li pm="XMGL_XSBMGL"><cite></cite><a href="${base}project/signup" target="rightFrame">学生报名</a></li>
				<li pm="XMGL_ZUBMGL"><cite></cite><a href="${base}project/team" target="rightFrame">组队报名</a></li>
				<li pm="XMGL_ZDSHGL"><cite></cite><a href="${base}project/teamCheck" target="rightFrame">组队审核</a></li>
			</ul>
		</dd>
		</c:if>
		<c:if test='${m=="study"}'>
		<dd pm="XXGL">
			<div class="title">
				<span><img src="${base}assets/img/leftico01.png" /></span>学习管理
			</div>
			<ul class="menuson">
				<li pm="XXGL_SZPYJHGL"><cite></cite><a href="${base}study" target="rightFrame">设置培养计划</a></li>
				<li pm="XXGL_PYJHCXGL"><cite></cite><a href="${base}study/queryProgramme" target="rightFrame">培养计划查询</a></li>
				<li pm="XXGL_XXJLWHGL"><cite></cite><a href="${base}record/maintain" target="rightFrame">学习记录维护</a></li>
				<li pm="XXGL_XXJLPYGL"><cite></cite><a href="${base}record/review" target="rightFrame">学习记录评阅</a></li>
				<li><cite></cite><a href="${base}record/queryProgramme" target="rightFrame">学习记录查询</a></li>
				<li pm="XXGL_XXBGWHGL"><cite></cite><a href="${base}report/" target="rightFrame">学习报告维护</a></li>
				<li pm="XXGL_XXBGSHGL"><cite></cite><a href="${base}report/check" target="rightFrame">学习报告审核</a></li>
				<li><cite></cite><a href="${base}report/select" target="rightFrame">学习报告查询</a></li>
				<li pm="XXGL_JSBGWHGL"><cite></cite><a href="${base}conclusion/manage" target="rightFrame">教师结题报告维护</a></li>
				<li pm="XXGL_JSBGSHGL"><cite></cite><a href="${base}conclusion/review" target="rightFrame">教师结题报告审核</a></li>
				<li><cite></cite><a href="${base}conclusion/select" target="rightFrame">教师结题报告查看</a></li>
			</ul>
		</dd>
		</c:if>
		
		<c:if test='${m=="recommend"}'>
		<dd pm="TYGL">
			<div class="title">
				<span><img src="${base}assets/img/leftico01.png" /></span>推优管理
			</div>
			<ul class="menuson">
				<li pm="TYGL_XMTYGL"><cite></cite><a href="${base}recommend/projectManage" target="rightFrame">项目推优</a></li>
				<li pm="TYGL_XSTYGL"><cite></cite><a href="${base}recommend/studentManage" target="rightFrame">学生推优</a></li>
				<li pm="TYGL_DSTYGL"><cite></cite><a href="${base}recommend/teacherManage" target="rightFrame">导师推优</a></li>
			</ul>
		</dd>
		</c:if>
		
		<c:if test='${m=="system"}'>
		<!-- 系统设置 -->
		<dd pm="XTGL">
			<div class="title">
				<span><img src="${base}assets/img/leftico01.png" /></span>系统管理
			</div>
			<ul class="menuson">
				<li pm="XTGL_JSGL"><cite></cite><a href="${base}permission" target="rightFrame">角色管理</a></li>
			</ul>
		</dd>
		</c:if>
		
	</dl>
</body>
</html>
</cqu:right>