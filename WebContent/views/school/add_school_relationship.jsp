<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld"%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld"%>
<html>
<head>
<jsp:include page="../common/common.jsp"></jsp:include>
<script type="text/javascript"
	src="${base}assets/uploadify/jquery.uploadify.min.js"></script>
<link href="${base}assets/uploadify/uploadify.css" rel="stylesheet"
	type="text/css" />
</head>
<body>
	<div class="place">
		<div class="pull-right backbtn">
			<a href="${base}school/setSchoolRelationshipView?schoolId=${schoolId}">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">基础管理</a></li>
			<li><a href="#">学校管理</a></li>
			<li><a href="#">关联学校</a></li>
			<li><a href="#">添加关联学校</a></li>			
		</ul>
	</div>

<form action="${base}school/addSchoolRelationshipView?schoolId=${schoolId}"	
	method="post" class="search-form form-inline">

</form>
	<div class="rightinfo">		

		<div class="formtitle">
			<span>中学信息</span>
		</div>
		<input type="hidden" name="schoolId" class="form-control input-sm"
				value="${schoolId}" />
		<input type="hidden" name="schoolName" class="form-control input-sm"
				value="${schoolName}" />
		<table class="tablelist">
			<thead>
				<tr>
					<th>中学名称</th>					
					<th>学校负责人</th>
					<th>学校地址</th>
					<th>联系电话</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>			
				<c:set value="0" var="index" />
				<c:forEach items="${pagination.list}" var="data" varStatus="i">
					<c:set value="1" var="index"></c:set>
					<input type="hidden" name="school_id" class="form-control input-sm"
							value="${data.school_id}"  />
					<tr>
						<td>${data.school_name}</td>						
						<td>${data.manager}</td>
						<td>${data.address}</td>
						<td>${data.phone}</td>
						<td>
							<a href="${base}school/txAddSchoolRelationship?schoolId=${schoolId}&&schoolName=${schoolName}&&associateSchoolId=${data.school_id}"	
							class="tablelink confirm">关联</a> </td>
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