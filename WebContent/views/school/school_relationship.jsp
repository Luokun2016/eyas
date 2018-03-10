<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld"%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld"%>
<cqu:right>
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
			<a href="${base}school/schoolManage">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">基础管理</a></li>
			<li><a href="#">学校管理</a></li>
			<li><a href="#">关联学校</a></li>			
		</ul>
	</div>


	<div class="rightinfo">
		<form action="${base}school/setSchoolRelationshipView"
			method="post" class="search-form form-inline">
			<div class="formbody">
				<div class="row">
					<div class="col-md-3 margin5">						
						<input type="hidden" name="schoolId" class="form-control input-sm"
							value="${schoolId}" />
						<div class="input-group">
							<span class="input-group-addon input-sm">高校名称</span>
							<input type="text" name="schoolName" class="form-control input-sm"
								value="${schoolName}" readonly />
						</div>
					</div>
					<div class="col-md-3 margin5">
						<div class="input-group">
							<span class="input-group-addon input-sm">中学名称</span> 
							<input type="text" name="school_name" class="form-control input-sm"
								value="${school_name}" />
						</div>
					</div>
					<div class="col-md-4 margin5 ">
						<button type="submit" class="btn btn-default btn-sm">
							<span class="glyphicon glyphicon-search"></span>查询
						</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a pm="JCGL_XXGL_VIEWRELATION_ADDINIT"
							href="${base}school/addSchoolRelationshipView?schoolId=${schoolId}"
							class="btn btn-default btn-sm"><span
							class="glyphicon glyphicon-plus"></span>新增关联学校</a>
					</div>

				</div>
			</div>
		</form>

		<div class="formtitle">
			<span>关联中学信息</span>
		</div>

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
							<a pm="JCGL_XXGL_VIEWRELATION_DEL" href="${base}school/txDeleteSchoolRelationship?schoolId=${schoolId}&&associateSchoolId=${data.school_id}&&schoolName=${schoolName}"
								class="tablelink confirm">删除</a> </td>
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