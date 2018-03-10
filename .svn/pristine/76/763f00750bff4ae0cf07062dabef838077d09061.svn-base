<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld"%>
<cqu:right>
	<!DOCTYPE html>
	<html>
<head>
<jsp:include page="../common/common.jsp"></jsp:include>
</head>
<body>
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">首页</a></li>
			<li><a href="#">系统管理</a></li>
			<li><a href="#">角色管理</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<div class="formtitle">
			<span>数据列表</span>
		</div>
		<table id="example" class="tablelist">
			<thead>
				<tr>
					<th width="150">角色名称</th>
					<th width="150">学校类别</th>
					<th width="300">描述</th>
					<th width="150">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:set value="0" var="index"></c:set>
				<c:forEach items="${pagination.list}" var="data" varStatus="i">
					<c:set value="1" var="index"></c:set>
					<tr>
						<td>${data.role_name}</td>
						<c:if test="${data.role_type==0}">
							<td>高校</td>
						</c:if>
						<c:if test="${data.role_type==1}">
							<td>中学</td>
						</c:if>
						<c:if test="${data.role_type==2}">
							<td>创新学院</td>
						</c:if>
						<td>${data.role_descript}</td>
						<td><a pm="XTGL_JSGL_USERINIT"
							href="${base}permission/getUserPermission?role_id=${data.role_id}"
							class="tablelink">用户</a> <a pm="XTGL_JSGL_PERMISSINIT"
							href="${base}permission/getPermission?role_id=${data.role_id}"
							class="tablelink">权限</a></td>
					</tr>
				</c:forEach>
				<c:if test="${index==0}">
					<tr>
						<td colspan="6">没有找到数据！</td>
					</tr>
				</c:if>
			</tbody>
		</table>
		<jsp:include page="../common/paginate.jsp"></jsp:include>
	</div>
</body>
	</html>
</cqu:right>