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
<title>欢迎登录雏鹰计划信息管理系统</title>
<link href="${base}assets/css/style2.css" rel="stylesheet"
	type="text/css" />
<script language="JavaScript"
	src="${base}assets/jq/jquery-1.10.2.min.js"></script>
<script src="${base}assets/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${base}assets/js/common.js"></script>
</head>

<body onload="${base}index/createCode"
	style="background-color: #1c77ac; background-repeat: no-repeat; background-position: center top;">

	<div class="logintop">
		<span style="font-size: 16px;">欢迎登录雏鹰计划信息管理系统</span>
		<ul>
			<li><a href="${base}index/login" style="font-size: 13px;">返回登录</a></li>
		</ul>
	</div>
	<div class="loginbody">
		<div class="row">
			<form action="#" method="post"
				class="search-form form-inline">
				<div class="col-lg-12">
					<div class="newsdetail" style="margin-top: 15px;">
						<div class="newsdetailtitle">
							<span class="title">${news.title}</span>
						</div>
						<c:if test="${news.content!=null}">
						<div class="newsdetailtime">
							<span>日期：<fmt:formatDate
									value="${news.publish_time}" pattern="yyyy-MM-dd HH:mm" /></span>
						</div>
						</c:if>
						<div class="newsdetailcontent">${news.content}</div>
						<div style="padding:0px 30px 20px 30px;"><span style="font-size: 14px;">附件:</span><c:forEach items="${fileList}" var="data" varStatus="i">
						<li style="font-size: 14px;margin-left: 35px;margin-top: 10px;"><a style="font-size: 14px; color:rgba(5, 43, 58, 0.82);" href="${base}index/downLoad?attach_file=${data.file_path}">${data.file_name}</a></li>
						</c:forEach></div>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>