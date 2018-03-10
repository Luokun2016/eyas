<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld"%>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld"%>
<cqu:right>
<html>
<head>
<jsp:include page="../common/common.jsp"></jsp:include>
</head>
<body>
	<div class="place">
		<div class="pull-right backbtn">
			<a href="${base}study/index">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">培养计划制定</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<form action="${base}study/planView" method="post"
			class="search-form form-inline">
			<input type="hidden" name="project_id" value="${project_id}" />
		</form>

	<div class="formtitle">
		<span>项目学生列表</span>
	</div>

	<table class="tablelist">
		<thead>
			<tr>
				<th>姓名</th>
				<th>性别</th>
				<th>所在中学</th>
				<th>年级</th>
				<th>班级</th>
				<th>中学导师</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:set value="0" var="index" />
			<c:forEach items="${pagination.list}" var="data" varStatus="i">
				<c:set value="1" var="index"></c:set>
				<tr>
					<td>${data.name}</td>
					<td><c:if test="${data.sex=='1'}">男</c:if> <c:if
							test="${data.sex=='0'}">女</c:if></td>
					<td>${data.school_name}</td>
					<td>${data.grade_name}</td>
					<td>${data.class_name}</td>
					<td>${data.tname}</td>
					<td width="150"><a pm="XXGL_SZPYJH_PYJH_VIEWZDJH"
						href="${base}study/setStudyPlan?user_id=${data.user_id}&&plan_id=${plan_id}&&project_id=${project_id}"
						class="tablelink">制定计划</a></td>
				</tr>
			</c:forEach>
			<c:if test="${index==0}">
				<tr>
					<td colspan="100">没有找到数据！</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="../common/paginate.jsp"></jsp:include>
	</div>

</body>
</html>
</cqu:right>