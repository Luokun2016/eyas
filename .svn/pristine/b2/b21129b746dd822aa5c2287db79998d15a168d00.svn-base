<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld"%>
<%@ taglib uri="/WEB-INF/tld/fmt.tld" prefix="fmt"%>
<cqu:right>
	<!DOCTYPE html>
	<html>
<head>
<jsp:include page="../common/common.jsp"></jsp:include>
</head>
<body>
	<div class="place">
		<div class="pull-right backbtn">
			<a href="${base}${urlBack}">返回首页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">首页</a></li>
			<li><a href="#">新闻详情</a></li>
		</ul>
	</div>

	<div class="rightinfo">

		<div class="col-lg-12" style="text-align: center;margin-top: 20px;">
			<span style="font-size: 16px;">${news.title}</span>
		</div>
		<div class="col-lg-12" style="text-align: center;margin-top: 15px;">
			<span style="font-size: 14px;">日期：<fmt:formatDate value="${news.publish_time}"
					pattern="yyyy-MM-dd HH:mm" /></span>
		</div>
		<div class="col-lg-12" style="margin-top: 20px;padding-left: 15px;padding-right: 15px;">
			${news.content}
		</div>
		<div class="col-lg-12" style="margin-top: 20px;padding-left: 15px;padding-right: 15px;">
			<span style="font-size: 14px;">附件:</span><c:forEach items="${fileList}" var="data" varStatus="i">
						<li style="font-size: 14px;margin-left: 35px;margin-top: 10px;"><a style="font-size: 14px; color:#4782b2;" href="${base}index/downLoad?attach_file=${data.file_path}">${data.file_name}</a></li>
						</c:forEach>
		</div>
	</div>
</body>
	</html>
</cqu:right>